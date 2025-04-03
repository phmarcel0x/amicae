import 'temp_profile.dart';
import 'profile_service.dart';
import 'package:flutter/material.dart';
import 'dart:developer';

class ProfilesBrain extends ChangeNotifier {
  int _currentProfileIndex = 0;
  List<Profile> _profiles = [];
  bool _isLoading = true;
  bool _noMoreProfiles = false;
  String? _errorMessage;

  final ProfileService _profileService = ProfileService();

  ProfilesBrain() {
    _loadProfiles();
  }

  // Getters
  bool get isLoading => _isLoading;
  bool get noMoreProfiles => _noMoreProfiles;
  String? get errorMessage => _errorMessage;

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
      notifyListeners();
    } catch (e) {
      _isLoading = false;
      _errorMessage = 'Failed to load profiles: ${e.toString()}';
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
      }

      // Notify UI of the change before attempting Firebase operations
      notifyListeners();

      // Now try to record the swipe - this is done after UI update
      // so any errors won't affect the UI experience
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
      }

      notifyListeners();
    }
  }

  // Refresh profiles
  Future<void> refreshProfiles() async {
    await _loadProfiles();
  }
}
