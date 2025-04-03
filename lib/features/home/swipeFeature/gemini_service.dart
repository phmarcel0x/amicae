import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_database/firebase_database.dart';
import 'dart:developer';
import 'package:firebase_vertexai/firebase_vertexai.dart';
import 'temp_profile.dart';

class GeminiService {
  final FirebaseAuth _auth = FirebaseAuth.instance;
  final DatabaseReference _database = FirebaseDatabase.instance.ref();
  late final FirebaseVertexAI _vertexAi;
  late final GenerativeModel _model;

  // Cache for match insights to avoid redundant API calls
  final Map<String, String> _matchInsightsCache = {};

  // Initialize Vertex AI
  GeminiService() {
    _vertexAi = FirebaseVertexAI.instance;
    _model = _vertexAi.generativeModel(model: 'gemini-1.5-pro');
  }

  // Get the current user's profile from Firebase
  Future<Profile?> _getCurrentUserProfile() async {
    try {
      final userId = _auth.currentUser?.uid;
      if (userId == null) {
        log('No authenticated user found');
        return null;
      }

      final snapshot = await _database.child('user-profiles/$userId').get();
      if (!snapshot.exists) {
        log('User profile not found in database');
        return null;
      }

      final data = snapshot.value as Map<dynamic, dynamic>;
      data['id'] = userId;

      return Profile.fromFirebase(Map<String, dynamic>.from(data));
    } catch (e) {
      log('Error getting current user profile: $e');
      return null;
    }
  }

  // Generate cache key for a pair of profiles
  String _generateCacheKey(String profileId1, String profileId2) {
    // Sort IDs to ensure same key regardless of order
    final ids = [profileId1, profileId2]..sort();
    return '${ids[0]}_${ids[1]}';
  }

  // Generate match insights comparing the current user with another profile
  Future<String> generateMatchInsights(Profile otherProfile) async {
    try {
      // Get current user profile
      final currentProfile = await _getCurrentUserProfile();
      if (currentProfile == null) {
        log('Could not access current user profile');
        return 'Unable to generate match insights: Could not access your profile.';
      }

      // Check cache first
      final cacheKey =
          _generateCacheKey(currentProfile.getId(), otherProfile.getId());
      if (_matchInsightsCache.containsKey(cacheKey)) {
        log('Returning cached match insight for $cacheKey');
        return _matchInsightsCache[cacheKey]!;
      }

      // Format data for prompt
      final currentProfileData = {
        'name': currentProfile.getName(),
        'department': currentProfile.getDepartment(),
        'educationStatus': currentProfile.getEducationStatus(),
        'courses': currentProfile.getCourses(),
        'interests': currentProfile.getInterests(),
        'lookingFor': currentProfile.getLookingFor(),
        'bio': currentProfile.getBio(),
      };

      final otherProfileData = {
        'name': otherProfile.getName(),
        'department': otherProfile.getDepartment(),
        'educationStatus': otherProfile.getEducationStatus(),
        'courses': otherProfile.getCourses(),
        'interests': otherProfile.getInterests(),
        'lookingFor': otherProfile.getLookingFor(),
        'bio': otherProfile.getBio(),
      };

      // Create prompt for Gemini
      final prompt =
          _createMatchAnalysisPrompt(currentProfileData, otherProfileData);

      // Call Vertex AI using the Firebase package
      final response = await _callGeminiModel(prompt);

      // Store in cache
      _matchInsightsCache[cacheKey] = response;

      return response;
    } catch (e) {
      log('Error generating match insights: $e');
      return 'We\'re having trouble generating match insights right now. Try again later.';
    }
  }

  // Create a prompt for analyzing the match
  String _createMatchAnalysisPrompt(
      Map<String, dynamic> currentProfile, Map<String, dynamic> otherProfile) {
    return '''
    You are a university social matching assistant called Amicae. You need to analyze why two students might be a good match for friendship, study partners, or potential collaboration based on their profiles.

    Current User Profile:
    - Name: ${currentProfile['name']}
    - Department: ${currentProfile['department']}
    - Education Status: ${currentProfile['educationStatus']}
    - Bio: ${currentProfile['bio']}
    - Courses: ${_formatList(currentProfile['courses'])}
    - Interests: ${_formatList(currentProfile['interests'])}
    - Looking For: ${currentProfile['lookingFor']}

    Other User Profile:
    - Name: ${otherProfile['name']}
    - Department: ${otherProfile['department']}
    - Education Status: ${otherProfile['educationStatus']}
    - Bio: ${otherProfile['bio']}
    - Courses: ${_formatList(otherProfile['courses'])}
    - Interests: ${_formatList(otherProfile['interests'])}
    - Looking For: ${otherProfile['lookingFor']}

    Generate a SHORT, concise paragraph (max 2-3 sentences) explaining why these students might be a good match. Focus on:
    1. Common interests or complementary skills
    2. Shared courses or academic goals
    3. Department synergies or potential for collaboration
    4. Match between what one person is looking for and what the other offers

    Keep it positive, specific and personalized. Mention specific shared interests, courses, or complementary attributes by name.
    Do not use generic statements or phrases like "you both." Instead, use their names and specific details from their profiles.
    
    The insight should be immediate and practical - something they can use as a conversation starter.
    ''';
  }

  // Format a list for display in the prompt
  String _formatList(List<dynamic> items) {
    if (items.isEmpty) return 'None';
    return items.join(', ');
  }

  // Call the Gemini model via Firebase Vertex AI
  Future<String> _callGeminiModel(String prompt) async {
    try {
      final content = [Content.text(prompt)];

      final generationConfig = GenerationConfig(
        temperature: 0.2,
        topK: 40,
        topP: 0.95,
        maxOutputTokens: 100,
        candidateCount: 1,
      );

      final response = await _model.generateContent(
        content,
        generationConfig: generationConfig,
      );

      final responseText = response.text;

      if (responseText == null || responseText.isEmpty) {
        log('Empty response from Gemini');
        return 'We couldn\'t generate insights this time. Try again later.';
      }

      return responseText.trim();
    } catch (e) {
      log('Error calling Gemini model: $e');
      return 'Unable to generate match insights at this time.';
    }
  }
}
