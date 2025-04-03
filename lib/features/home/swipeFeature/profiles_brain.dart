import 'temp_profile.dart';
import 'profile_service.dart';
import 'gemini_service.dart';
import 'match_insight.dart';
import 'package:flutter/material.dart';
import 'dart:developer';

class ProfilesBrain extends ChangeNotifier {
  int _currentProfileIndex = 0;
  List<Profile> _profiles = [];
  bool _isLoading = true;
  bool _noMoreProfiles = false;
  String? _errorMessage;
  MatchInsight _matchInsight = MatchInsight.empty();

  final ProfileService _profileService = ProfileService();
  final GeminiService _geminiService = GeminiService();

  ProfilesBrain() {
    _initialize();
  }

  // Initialize services and load profiles
  Future<void> _initialize() async {
    try {
      await _loadProfiles();
    } catch (e) {
      log('Error initializing ProfilesBrain: $e');
      _errorMessage = 'Failed to initialize: ${e.toString()}';
      _isLoading = false;
      notifyListeners();
    }
  }

  // Getters
  bool get isLoading => _isLoading;
  bool get noMoreProfiles => _noMoreProfiles;
  String? get errorMessage => _errorMessage;
  MatchInsight get matchInsight => _matchInsight;

  Profile? get currentProfile {
    if (_profiles.isEmpty) return null;
    if (_currentProfileIndex >= _profiles.length) return null;
    return _profiles[_currentProfileIndex];
  }

  // Load profiles from Firebase
  Future<void> _loadProfiles() async {
    try {
      _isLoading = true;
      _errorMessage = null;
      notifyListeners();

      final profilesData = await _profileService.getProfilesToSwipe();

      // Convert to Profile objects and filter already swiped profiles
      final List<Profile> newProfiles = [];

      for (final profileData in profilesData) {
        final String userId = profileData['id'] as String;

        // Check if user has already swiped on this profile
        final bool alreadySwiped =
            await _profileService.hasAlreadySwiped(userId);
        if (!alreadySwiped) {
          newProfiles.add(Profile.fromFirebase(profileData));
        }
      }

      _profiles = newProfiles;
      _currentProfileIndex = 0;
      _noMoreProfiles = _profiles.isEmpty;
      _isLoading = false;

      // Generate match insight for the first profile
      if (_profiles.isNotEmpty) {
        _generateMatchInsight();
      } else {
        _matchInsight = MatchInsight.empty();
      }

      notifyListeners();
    } catch (e) {
      _isLoading = false;
      _errorMessage = 'Failed to load profiles: ${e.toString()}';
      _matchInsight = MatchInsight.empty();
      notifyListeners();
    }
  }

  // Generate match insight for current profile
  Future<void> _generateMatchInsight() async {
    if (currentProfile == null) {
      _matchInsight = MatchInsight.empty();
      notifyListeners();
      return;
    }

    try {
      // Set loading state
      _matchInsight = MatchInsight.loading();
      notifyListeners();

      // Generate insight with retry mechanism
      String insightText = '';
      int retryCount = 0;
      const maxRetries = 2;

      while (retryCount <= maxRetries) {
        try {
          insightText =
              await _geminiService.generateMatchInsights(currentProfile!);

          // If we got a valid insight, break the retry loop
          if (!insightText.contains('Unable to generate') &&
              !insightText.contains('trouble generating') &&
              insightText.isNotEmpty) {
            break;
          }

          retryCount++;
          if (retryCount <= maxRetries) {
            // Short delay before retry
            await Future.delayed(const Duration(milliseconds: 500));
          }
        } catch (e) {
          log('Error in retry attempt $retryCount: $e');
          retryCount++;
          if (retryCount <= maxRetries) {
            await Future.delayed(const Duration(milliseconds: 500));
          }
        }
      }

      // Update with result
      if (insightText.isEmpty ||
          insightText.contains('Unable to generate') ||
          insightText.contains('trouble generating')) {
        _matchInsight = MatchInsight.empty();
      } else {
        _matchInsight = MatchInsight(content: insightText);
      }

      notifyListeners();
    } catch (e) {
      log('Error generating match insight: $e');
      _matchInsight = MatchInsight.empty();
      notifyListeners();
    }
  }

  // Swipe profile (like or dislike)
  Future<void> swipeProfile({required bool isLike}) async {
    if (_profiles.isEmpty || _currentProfileIndex >= _profiles.length) {
      _noMoreProfiles = true;
      notifyListeners();
      return;
    }

    try {
      // Get current profile before any potential errors
      final Profile currentProfile = _profiles[_currentProfileIndex];

      // Always increment the index FIRST before any potential errors
      _currentProfileIndex++;

      // Check if we've reached the end of available profiles
      if (_currentProfileIndex >= _profiles.length) {
        _noMoreProfiles = true;
        _matchInsight = MatchInsight.empty();
      } else {
        // Generate match insight for the next profile
        _generateMatchInsight();
      }

      // Notify UI of the change
      notifyListeners();

      // Record the swipe
      try {
        await _profileService.recordSwipe(
          targetUserId: currentProfile.getId(),
          isLike: isLike,
        );
      } catch (e) {
        // Just log the error and don't affect UI
        log('Error recording swipe: $e');
      }
    } catch (e) {
      // Something unexpected happened - log but don't show in UI
      log('Unexpected error in swipeProfile: $e');

      // Make sure we still advance to next profile
      if (_currentProfileIndex < _profiles.length) {
        _currentProfileIndex++;
      }

      if (_currentProfileIndex >= _profiles.length) {
        _noMoreProfiles = true;
        _matchInsight = MatchInsight.empty();
      } else {
        _generateMatchInsight();
      }

      notifyListeners();
    }
  }

  // Refresh profiles
  Future<void> refreshProfiles() async {
    _matchInsight = MatchInsight.empty();
    await _loadProfiles();
  }
}
