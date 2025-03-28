import 'package:firebase_database/firebase_database.dart';
import 'package:amicae/features/profile/entity/profile.dart';

import '../../common/service/resource_service.dart';

class ProfileService implements IResourceService<Profile> {
  final DatabaseReference database = FirebaseDatabase.instance.ref().child('user-profiles');

  @override
  Future<void> delete(String id) async {
    try {
      await database.child(id).remove();
    } catch (e) {
      print('Error deleting profile: $e');
      rethrow;
    }
  }

  @override
  Future<List<Profile>> findAll() async {
    try {
      final snapshot = await database.get();

      if (snapshot.exists) {
        final Map<dynamic, dynamic>? profilesMap =
        snapshot.value as Map<dynamic, dynamic>?;

        if (profilesMap == null) return [];

        return profilesMap.entries.map((entry) {
          // Convert each entry to a Profile object
          return Profile.fromJson({
            ...entry.value,
            'id': entry.key // Use the database key as the ID
          });
        }).toList();
      }
      return [];
    } catch (e) {
      print('Error finding all profiles: $e');
      rethrow;
    }
  }

  @override
  Future<Profile> findById(String id) async {
    try {
      print('Attempting to fetch profile for ID: $id');
      final snapshot = await database.child(id).get();

      print('Snapshot exists: ${snapshot.exists}');
      print('Snapshot value: ${snapshot.value}');

      if (snapshot.exists) {
        return Profile.fromJson({
          ...snapshot.value as Map<dynamic, dynamic>,
          'id': id
        });
      }
      throw Exception('Profile not found');
    } catch (e) {
      print('Detailed error finding profile by ID: $e');
      rethrow;
    }
  }

  @override
  Future<Profile> update(Profile entity) async {
    try {
      // Convert Profile to a map, removing the 'id'
      final profileMap = entity.toJson()..remove('id');

      // If the entity doesn't have an ID, create a new entry
      if (entity.id.isEmpty) {
        final newRef = database.push();
        await newRef.set(profileMap);

        // Return a new Profile with the generated ID
        return entity.copyWith(id: newRef.key!);
      }

      // Update existing profile
      await database.child(entity.id).update(profileMap);
      return entity;
    } catch (e) {
      print('Error updating profile: $e');
      rethrow;
    }
  }

  // Additional method to stream a profile in real-time
  Stream<Profile?> streamProfile(String id) {
    return database.child(id).onValue.map((event) {
      if (event.snapshot.exists) {
        return Profile.fromJson({
          ...event.snapshot.value as Map<dynamic, dynamic>,
          'id': id
        });
      }
      return null;
    });
  }

  Future<void> checkDatabaseAccess(String uid) async {
    try {
      print('Attempting manual database access check');
      final database = FirebaseDatabase.instance.ref();

      // Try to access a known path
      final snapshot = await database.child('users/$uid').get();

      print('Snapshot exists: ${snapshot.exists}');
      print('Snapshot value: ${snapshot.value}');
    } catch (e) {
      print('Database access check failed: $e');
    }
  }
}