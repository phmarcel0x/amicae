import 'package:firebase_database/firebase_database.dart';
import 'package:firebase_auth/firebase_auth.dart';
import '../../../features/user_account_set_up/models/user_info.dart';
import '../../../features/user_account_set_up/models/user_interest.dart';
import '../../../features/user_account_set_up/models/user_edu_status.dart';
import '../../../features/user_account_set_up/models/user_department.dart';
import '../../../features/user_account_set_up/models/user_courses_code.dart';
import 'dart:developer';

class ProfileService {
  final DatabaseReference _database = FirebaseDatabase.instance.ref();
  final FirebaseAuth _auth = FirebaseAuth.instance;

  // Get current user ID
  String? getCurrentUserId() {
    return _auth.currentUser?.uid;
  }

  // Fetch all user profiles except the current user
  Future<List<Map<String, dynamic>>> getProfilesToSwipe() async {
    try {
      final currentUserId = getCurrentUserId();
      if (currentUserId == null) throw Exception('No authenticated user found');

      // Get all user profiles
      final snapshot = await _database.child('user-profiles').get();
      if (!snapshot.exists) return [];

      final data = snapshot.value as Map<dynamic, dynamic>;
      final profiles = <Map<String, dynamic>>[];

      // Convert to list and filter out current user
      data.forEach((key, value) {
        if (key != currentUserId) {
          final profile = Map<String, dynamic>.from(value as Map);
          profile['id'] = key; // Add the user ID to the profile data
          profiles.add(profile);
        }
      });

      return profiles;
    } catch (e) {
      throw Exception('Failed to fetch profiles: $e');
    }
  }

  // Record user swipe (like/dislike)
  Future<void> recordSwipe({
    required String targetUserId,
    required bool isLike,
  }) async {
    try {
      final currentUserId = getCurrentUserId();
      if (currentUserId == null) {
        log('No authenticated user found, skipping swipe recording');
        return;
      }

      // Skip recording for sample profiles
      if (targetUserId.startsWith('sample')) {
        log('Sample profile swipe, not recording to database');
        return;
      }

      final swipeType = isLike ? 'likes' : 'dislikes';
      await _database
          .child('swipes/$currentUserId/$swipeType/$targetUserId')
          .set(ServerValue.timestamp);

      // Note: We've removed the match creation logic since it requires additional permissions
      // If match creation is needed in the future, the Firebase rules will need to be updated
    } catch (e) {
      log('Error recording swipe: $e');
      // Silently fail for permission errors
      if (e.toString().contains('permission-denied') ||
          e.toString().contains('permission')) {
        log('Permission denied when recording swipe');
        return;
      }
      throw Exception('Failed to record swipe: $e');
    }
  }

  // Check if user has already swiped on a profile
  Future<bool> hasAlreadySwiped(String targetUserId) async {
    try {
      // Sample profiles are never swiped
      if (targetUserId.startsWith('sample')) {
        return false;
      }

      final currentUserId = getCurrentUserId();
      if (currentUserId == null) {
        log('No authenticated user found when checking swipe status');
        return false;
      }

      final likesSnapshot = await _database
          .child('swipes/$currentUserId/likes/$targetUserId')
          .get();
      final dislikesSnapshot = await _database
          .child('swipes/$currentUserId/dislikes/$targetUserId')
          .get();

      return likesSnapshot.exists || dislikesSnapshot.exists;
    } catch (e) {
      log('Error checking swipe status: $e');
      // Silently fail on any errors - default to "not swiped"
      if (e.toString().contains('permission-denied') ||
          e.toString().contains('permission')) {
        log('Permission denied when checking swipe status');
        return false;
      }
      // For other errors, just log and assume not swiped
      log('Unknown error checking swipe status: $e');
      return false;
    }
  }
}
