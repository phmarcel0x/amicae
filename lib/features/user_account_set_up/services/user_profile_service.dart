// ignore_for_file: unused_import

import 'package:firebase_database/firebase_database.dart';
import 'package:firebase_auth/firebase_auth.dart';
import '../models/user_info.dart';
import '../models/user_interest.dart';
import '../models/user_edu_status.dart';
import '../models/user_department.dart';
import '../models/user_courses_code.dart';
import '../data/education_status.dart';

class UserProfileService {
  final DatabaseReference _database = FirebaseDatabase.instance.ref();
  final FirebaseAuth _auth = FirebaseAuth.instance;

  // Get current user profile reference
  DatabaseReference _getUserProfileRef() {
    final user = _auth.currentUser;
    if (user == null) throw Exception('No authenticated user found');
    return _database.child('user-profiles/${user.uid}');
  }

  // Initialize user profile with basic data
  Future<void> initializeProfile({
    required String firstName,
    required String description,
    required String lookingFor,
    required EducationStatus educationStatus,
    required UserDepartment department,
    required List<String> interests,
    required List<String> coursesCodes,
  }) async {
    try {
      final profileRef = _getUserProfileRef();
      await profileRef.set({
        'firstName': firstName,
        'description': description,
        'lookingFor': lookingFor,
        'educationStatus': educationStatus.name,
        'department': department.toString(),
        'interests': interests,
        'coursesCodes': coursesCodes,
        'createdAt': ServerValue.timestamp,
        'lastUpdated': ServerValue.timestamp,
      });
    } catch (e) {
      throw Exception('Failed to initialize profile: $e');
    }
  }

  // Update specific field in user profile
  Future<void> updateProfileField(String field, dynamic value) async {
    try {
      final profileRef = _getUserProfileRef();
      await profileRef.update({
        field: value,
        'lastUpdated': ServerValue.timestamp,
      });
    } catch (e) {
      throw Exception('Failed to update $field: $e');
    }
  }

  // Update first name
  Future<void> updateFirstName(String firstName) async {
    await updateProfileField('firstName', firstName);
  }

  // Update description
  Future<void> updateDescription(String description) async {
    await updateProfileField('description', description);
  }

  // Update looking for
  Future<void> updateLookingFor(String lookingFor) async {
    await updateProfileField('lookingFor', lookingFor);
  }

  // Update education status
  Future<void> updateEducationStatus(EducationStatus status) async {
    await updateProfileField('educationStatus', status.name);
  }

  // Update department
  Future<void> updateDepartment(UserDepartment department) async {
    await updateProfileField('department', department.toString());
  }

  // Update interests
  Future<void> updateInterests(List<String> interests) async {
    await updateProfileField('interests', interests);
  }

  // Update courses
  Future<void> updateCourses(List<String> coursesCodes) async {
    await updateProfileField('coursesCodes', coursesCodes);
  }

  // Get current user profile
  Future<Map<String, dynamic>?> getCurrentProfile() async {
    try {
      final profileRef = _getUserProfileRef();
      final snapshot = await profileRef.get();
      return snapshot.value as Map<String, dynamic>?;
    } catch (e) {
      throw Exception('Failed to get profile: $e');
    }
  }

  // Check if profile exists
  Future<bool> profileExists() async {
    try {
      final profile = await getCurrentProfile();
      return profile != null;
    } catch (e) {
      return false;
    }
  }
}
