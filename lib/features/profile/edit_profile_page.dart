// import 'package:flutter/material.dart';
// import 'package:amicae/features/profile/entity/profile.dart';
// import 'package:amicae/features/profile/service/profile_service.dart';
// import 'package:firebase_auth/firebase_auth.dart';
//
// import 'package:amicae/features/profile/profile_page.dart';
//
// class EditProfilePage extends StatefulWidget {
//   final Profile profile;
//
//   const EditProfilePage({
//     super.key,
//     required this.profile,
//   });
//
//   @override
//   State<EditProfilePage> createState() => _EditProfilePageState();
// }
//
// class _EditProfilePageState extends State<EditProfilePage> {
//   final ProfileService _profileService = ProfileService();
//   late TextEditingController firstNameController;
//   late TextEditingController departmentController;
//   late TextEditingController descriptionController;
//   late TextEditingController educationStatusController;
//
//   // For courses and interests (we'll use a simple approach here)
//   late TextEditingController coursesController;
//   late TextEditingController interestsController;
//
//   bool _isLoading = false;
//
//   @override
//   void initState() {
//     super.initState();
//     // Initialize controllers with existing profile data
//     firstNameController = TextEditingController(text: widget.profile.firstName);
//     departmentController = TextEditingController(text: widget.profile.department);
//     descriptionController = TextEditingController(text: widget.profile.description);
//     educationStatusController = TextEditingController(text: widget.profile.educationStatus);
//
//     // Join list items with commas for editing
//     coursesController = TextEditingController(text: widget.profile.coursesCodes.join(', '));
//     interestsController = TextEditingController(text: widget.profile.interests.join(', '));
//   }
//
//   @override
//   void dispose() {
//     // Clean up controllers
//     firstNameController.dispose();
//     departmentController.dispose();
//     descriptionController.dispose();
//     educationStatusController.dispose();
//     coursesController.dispose();
//     interestsController.dispose();
//     super.dispose();
//   }
//
//   Future<void> _saveProfile() async {
//     setState(() {
//       _isLoading = true;
//       Navigator.push(
//         context,
//         MaterialPageRoute(
//           builder: (context) => const ProfilePage(),
//         ),
//       );
//     });
//
//     final User? currentUser = FirebaseAuth.instance.currentUser;
//     if (currentUser == null) {
//       ScaffoldMessenger.of(context).showSnackBar(
//         const SnackBar(content: Text('User not authenticated')),
//       );
//       setState(() {
//         _isLoading = false;
//       });
//       return;
//     }
//
//     try {
//       // Create updated profile
//       final updatedProfile = Profile(
//
//         id: widget.profile.id,
//         firstName: firstNameController.text,
//         department: departmentController.text,
//         description: descriptionController.text,
//         educationStatus: educationStatusController.text,
//         // Split comma-separated values into lists, trim whitespace
//         coursesCodes: coursesController.text
//             .split(',')
//             .map((course) => course.trim())
//             .where((course) => course.isNotEmpty)
//             .toList(),
//         interests: interestsController.text
//             .split(',')
//             .map((interest) => interest.trim())
//             .where((interest) => interest.isNotEmpty)
//             .toList(), createdAt: 000, lastUpdated: 00,
//       );
//
//       // Save to database
//       await _profileService.update(updatedProfile);
//
//       if (mounted) {
//         ScaffoldMessenger.of(context).showSnackBar(
//           const SnackBar(content: Text('Profile updated successfully')),
//         );
//         Navigator.pop(context, true); // Pop with result to trigger refresh
//       }
//     } catch (e) {
//       if (mounted) {
//         ScaffoldMessenger.of(context).showSnackBar(
//           SnackBar(content: Text('Error updating profile: $e')),
//         );
//       }
//     } finally {
//       if (mounted) {
//         setState(() {
//           _isLoading = false;
//         });
//       }
//     }
//   }
//
//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       backgroundColor: Colors.grey[100],
//       appBar: AppBar(
//         title: const Text('Edit Profile'),
//         backgroundColor: Colors.white,
//         elevation: 0,
//         leading: IconButton(
//           icon: const Icon(Icons.arrow_back, color: Colors.black),
//           onPressed: () => Navigator.pop(context),
//         ),
//       ),
//       body: SafeArea(
//         child: _isLoading
//             ? const Center(child: CircularProgressIndicator())
//             : Padding(
//           padding: const EdgeInsets.symmetric(horizontal: 24.0),
//           child: Column(
//             children: [
//               Expanded(
//                 child: Container(
//                   decoration: BoxDecoration(
//                     color: Colors.white,
//                     borderRadius: BorderRadius.circular(30),
//                     boxShadow: [
//                       BoxShadow(
//                         color: Colors.grey.withOpacity(0.3),
//                         spreadRadius: 2,
//                         blurRadius: 5,
//                         offset: const Offset(0, 3),
//                       ),
//                     ],
//                     border: Border.all(color: Colors.grey[200]!),
//                   ),
//                   child: ClipRRect(
//                     borderRadius: BorderRadius.circular(30),
//                     child: SingleChildScrollView(
//                       physics: const BouncingScrollPhysics(),
//                       child: Padding(
//                         padding: const EdgeInsets.all(20.0),
//                         child: Column(
//                           crossAxisAlignment: CrossAxisAlignment.start,
//                           children: [
//                             // Profile Image (placeholder for now)
//                             Center(
//                               child: Stack(
//                                 children: [
//                                   CircleAvatar(
//                                     radius: 60,
//                                     backgroundColor: Colors.grey[300],
//                                     backgroundImage: const AssetImage(
//                                         'assets/images/profile_placeholder.jpg'),
//                                     child: Container(), // Empty container to avoid error if image is null
//                                   ),
//                                   Positioned(
//                                     right: 0,
//                                     bottom: 0,
//                                     child: Container(
//                                       padding: const EdgeInsets.all(6),
//                                       decoration: BoxDecoration(
//                                         color: Colors.blue,
//                                         shape: BoxShape.circle,
//                                         border: Border.all(
//                                           width: 2,
//                                           color: Colors.white,
//                                         ),
//                                       ),
//                                       child: const Icon(
//                                         Icons.camera_alt,
//                                         color: Colors.white,
//                                         size: 20,
//                                       ),
//                                     ),
//                                   ),
//                                 ],
//                               ),
//                             ),
//                             const SizedBox(height: 24),
//
//                             // Name field
//                             const Text(
//                               "Name",
//                               style: TextStyle(
//                                 fontSize: 16,
//                                 fontWeight: FontWeight.bold,
//                               ),
//                             ),
//                             const SizedBox(height: 8),
//                             TextFormField(
//                               controller: firstNameController,
//                               decoration: InputDecoration(
//                                 hintText: "Enter your name",
//                                 border: OutlineInputBorder(
//                                   borderRadius: BorderRadius.circular(15),
//                                 ),
//                                 contentPadding: const EdgeInsets.symmetric(
//                                   horizontal: 16,
//                                   vertical: 12,
//                                 ),
//                               ),
//                             ),
//                             const SizedBox(height: 16),
//
//                             // Department field
//                             const Text(
//                               "Department",
//                               style: TextStyle(
//                                 fontSize: 16,
//                                 fontWeight: FontWeight.bold,
//                               ),
//                             ),
//                             const SizedBox(height: 8),
//                             TextFormField(
//                               controller: departmentController,
//                               decoration: InputDecoration(
//                                 hintText: "Enter your department",
//                                 border: OutlineInputBorder(
//                                   borderRadius: BorderRadius.circular(15),
//                                 ),
//                                 contentPadding: const EdgeInsets.symmetric(
//                                   horizontal: 16,
//                                   vertical: 12,
//                                 ),
//                               ),
//                             ),
//                             const SizedBox(height: 16),
//
//                             // Bio field
//                             const Text(
//                               "My Bio",
//                               style: TextStyle(
//                                 fontSize: 16,
//                                 fontWeight: FontWeight.bold,
//                               ),
//                             ),
//                             const SizedBox(height: 8),
//                             TextFormField(
//                               controller: descriptionController,
//                               decoration: InputDecoration(
//                                 hintText: "Tell us about yourself",
//                                 border: OutlineInputBorder(
//                                   borderRadius: BorderRadius.circular(15),
//                                 ),
//                                 contentPadding: const EdgeInsets.symmetric(
//                                   horizontal: 16,
//                                   vertical: 12,
//                                 ),
//                               ),
//                               maxLines: 5,
//                             ),
//                             const SizedBox(height: 16),
//
//                             // Education field
//                             const Text(
//                               "Education",
//                               style: TextStyle(
//                                 fontSize: 16,
//                                 fontWeight: FontWeight.bold,
//                               ),
//                             ),
//                             const SizedBox(height: 8),
//                             TextFormField(
//                               controller: educationStatusController,
//                               decoration: InputDecoration(
//                                 hintText: "Enter your education details",
//                                 border: OutlineInputBorder(
//                                   borderRadius: BorderRadius.circular(15),
//                                 ),
//                                 contentPadding: const EdgeInsets.symmetric(
//                                   horizontal: 16,
//                                   vertical: 12,
//                                 ),
//                               ),
//                             ),
//                             const SizedBox(height: 16),
//
//                             // Courses field
//                             const Text(
//                               "Courses (comma separated)",
//                               style: TextStyle(
//                                 fontSize: 16,
//                                 fontWeight: FontWeight.bold,
//                               ),
//                             ),
//                             const SizedBox(height: 8),
//                             TextFormField(
//                               controller: coursesController,
//                               decoration: InputDecoration(
//                                 hintText: "e.g. CS101, MATH202, PHYS301",
//                                 border: OutlineInputBorder(
//                                   borderRadius: BorderRadius.circular(15),
//                                 ),
//                                 contentPadding: const EdgeInsets.symmetric(
//                                   horizontal: 16,
//                                   vertical: 12,
//                                 ),
//                               ),
//                             ),
//                             const SizedBox(height: 16),
//
//                             // Interests field
//                             const Text(
//                               "Interests (comma separated)",
//                               style: TextStyle(
//                                 fontSize: 16,
//                                 fontWeight: FontWeight.bold,
//                               ),
//                             ),
//                             const SizedBox(height: 8),
//                             TextFormField(
//                               controller: interestsController,
//                               decoration: InputDecoration(
//                                 hintText: "e.g. Reading, Coding, Tennis",
//                                 border: OutlineInputBorder(
//                                   borderRadius: BorderRadius.circular(15),
//                                 ),
//                                 contentPadding: const EdgeInsets.symmetric(
//                                   horizontal: 16,
//                                   vertical: 12,
//                                 ),
//                               ),
//                             ),
//                             const SizedBox(height: 20),
//                           ],
//                         ),
//                       ),
//                     ),
//                   ),
//                 ),
//               ),
//               // Save button at bottom
//               Container(
//                 margin: const EdgeInsets.only(top: 20, bottom: 30),
//                 decoration: BoxDecoration(
//                   borderRadius: BorderRadius.circular(30),
//                   boxShadow: [
//                     BoxShadow(
//                       color: Colors.green.withOpacity(0.3),
//                       spreadRadius: 1,
//                       blurRadius: 10,
//                       offset: const Offset(0, 4),
//                     ),
//                   ],
//                 ),
//                 width: double.infinity, // Full width
//                 height: 60, // Increased height for better visibility
//                 child: ElevatedButton.icon(
//                   icon: const Icon(Icons.save, size: 24),
//                   label: const Text(
//                     "Save Profile",
//                     style: TextStyle(
//                       fontSize: 18,
//                       fontWeight: FontWeight.bold,
//                     ),
//                   ),
//                   style: ElevatedButton.styleFrom(
//                     backgroundColor: Colors.green[700],
//                     foregroundColor: Colors.white,
//                     padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
//                     shape: RoundedRectangleBorder(
//                       borderRadius: BorderRadius.circular(30),
//                     ),
//                   ),
//                   onPressed: _saveProfile,
//                 ),
//               ),
//             ],
//           ),
//         ),
//       ),
//     );
//   }
// }

import 'package:flutter/material.dart';
import 'package:amicae/features/profile/entity/profile.dart';
import 'package:amicae/features/profile/service/profile_service.dart';
import 'package:firebase_auth/firebase_auth.dart';

class EditProfilePage extends StatefulWidget {
  final Profile profile;

  const EditProfilePage({
    super.key,
    required this.profile,
  });

  @override
  State<EditProfilePage> createState() => _EditProfilePageState();
}

class _EditProfilePageState extends State<EditProfilePage> {
  final ProfileService _profileService = ProfileService();
  late TextEditingController firstNameController;
  late TextEditingController departmentController;
  late TextEditingController descriptionController;
  late TextEditingController educationStatusController;

  // For courses and interests (we'll use a simple approach here)
  late TextEditingController coursesController;
  late TextEditingController interestsController;

  bool _isLoading = false;

  @override
  void initState() {
    super.initState();
    // Initialize controllers with existing profile data
    firstNameController = TextEditingController(text: widget.profile.firstName);
    departmentController = TextEditingController(text: widget.profile.department);
    descriptionController = TextEditingController(text: widget.profile.description);
    educationStatusController = TextEditingController(text: widget.profile.educationStatus);

    // Join list items with commas for editing
    coursesController = TextEditingController(text: widget.profile.coursesCodes.join(', '));
    interestsController = TextEditingController(text: widget.profile.interests.join(', '));
  }

  @override
  void dispose() {
    // Clean up controllers
    firstNameController.dispose();
    departmentController.dispose();
    descriptionController.dispose();
    educationStatusController.dispose();
    coursesController.dispose();
    interestsController.dispose();
    super.dispose();
  }

  Future<void> _saveProfile() async {
    setState(() {
      _isLoading = true;
    });

    final User? currentUser = FirebaseAuth.instance.currentUser;
    if (currentUser == null) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('User not authenticated')),
      );
      setState(() {
        _isLoading = false;
      });
      return;
    }

    try {
      // Create updated profile
      final updatedProfile = Profile(
        id: widget.profile.id,
        firstName: firstNameController.text,
        department: departmentController.text,
        description: descriptionController.text,
        educationStatus: educationStatusController.text,
        // Split comma-separated values into lists, trim whitespace
        coursesCodes: coursesController.text
            .split(',')
            .map((course) => course.trim())
            .where((course) => course.isNotEmpty)
            .toList(),
        interests: interestsController.text
            .split(',')
            .map((interest) => interest.trim())
            .where((interest) => interest.isNotEmpty)
            .toList(),
        createdAt: widget.profile.createdAt,
        lastUpdated: DateTime.now().millisecondsSinceEpoch,
      );

      // Save to database
      await _profileService.update(updatedProfile);

      if (mounted) {
        // Show success message
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(content: Text('Profile updated successfully')),
        );

        // Return to previous page with true result to trigger refresh
        Navigator.pop(context, true);
      }
    } catch (e) {
      if (mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text('Error updating profile: $e')),
        );
      }
    } finally {
      if (mounted) {
        setState(() {
          _isLoading = false;
        });
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey[100],
      appBar: AppBar(
        title: const Text('Edit Profile'),
        backgroundColor: Colors.white,
        elevation: 0,
        leading: IconButton(
          icon: const Icon(Icons.arrow_back, color: Colors.black),
          onPressed: () => Navigator.pop(context),
        ),
      ),
      body: SafeArea(
        child: _isLoading
            ? const Center(child: CircularProgressIndicator())
            : Padding(
          padding: const EdgeInsets.symmetric(horizontal: 24.0),
          child: Column(
            children: [
              Expanded(
                child: Container(
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(30),
                    boxShadow: [
                      BoxShadow(
                        color: Colors.grey.withOpacity(0.3),
                        spreadRadius: 2,
                        blurRadius: 5,
                        offset: const Offset(0, 3),
                      ),
                    ],
                    border: Border.all(color: Colors.grey[200]!),
                  ),
                  child: ClipRRect(
                    borderRadius: BorderRadius.circular(30),
                    child: SingleChildScrollView(
                      physics: const BouncingScrollPhysics(),
                      child: Padding(
                        padding: const EdgeInsets.all(20.0),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            // Profile Image (placeholder for now)
                            Center(
                              child: Stack(
                                children: [
                                  CircleAvatar(
                                    radius: 60,
                                    backgroundColor: Colors.grey[300],
                                    backgroundImage: const AssetImage(
                                        'assets/images/profile_placeholder.jpg'),
                                    child: Container(), // Empty container to avoid error if image is null
                                  ),
                                  Positioned(
                                    right: 0,
                                    bottom: 0,
                                    child: Container(
                                      padding: const EdgeInsets.all(6),
                                      decoration: BoxDecoration(
                                        color: Colors.blue,
                                        shape: BoxShape.circle,
                                        border: Border.all(
                                          width: 2,
                                          color: Colors.white,
                                        ),
                                      ),
                                      child: const Icon(
                                        Icons.camera_alt,
                                        color: Colors.white,
                                        size: 20,
                                      ),
                                    ),
                                  ),
                                ],
                              ),
                            ),
                            const SizedBox(height: 24),

                            // Name field
                            const Text(
                              "Name",
                              style: TextStyle(
                                fontSize: 16,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                            const SizedBox(height: 8),
                            TextFormField(
                              controller: firstNameController,
                              decoration: InputDecoration(
                                hintText: "Enter your name",
                                border: OutlineInputBorder(
                                  borderRadius: BorderRadius.circular(15),
                                ),
                                contentPadding: const EdgeInsets.symmetric(
                                  horizontal: 16,
                                  vertical: 12,
                                ),
                              ),
                            ),
                            const SizedBox(height: 16),

                            // Department field
                            const Text(
                              "Department",
                              style: TextStyle(
                                fontSize: 16,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                            const SizedBox(height: 8),
                            TextFormField(
                              controller: departmentController,
                              decoration: InputDecoration(
                                hintText: "Enter your department",
                                border: OutlineInputBorder(
                                  borderRadius: BorderRadius.circular(15),
                                ),
                                contentPadding: const EdgeInsets.symmetric(
                                  horizontal: 16,
                                  vertical: 12,
                                ),
                              ),
                            ),
                            const SizedBox(height: 16),

                            // Bio field
                            const Text(
                              "My Bio",
                              style: TextStyle(
                                fontSize: 16,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                            const SizedBox(height: 8),
                            TextFormField(
                              controller: descriptionController,
                              decoration: InputDecoration(
                                hintText: "Tell us about yourself",
                                border: OutlineInputBorder(
                                  borderRadius: BorderRadius.circular(15),
                                ),
                                contentPadding: const EdgeInsets.symmetric(
                                  horizontal: 16,
                                  vertical: 12,
                                ),
                              ),
                              maxLines: 5,
                            ),
                            const SizedBox(height: 16),

                            // Education field
                            const Text(
                              "Education",
                              style: TextStyle(
                                fontSize: 16,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                            const SizedBox(height: 8),
                            TextFormField(
                              controller: educationStatusController,
                              decoration: InputDecoration(
                                hintText: "Enter your education details",
                                border: OutlineInputBorder(
                                  borderRadius: BorderRadius.circular(15),
                                ),
                                contentPadding: const EdgeInsets.symmetric(
                                  horizontal: 16,
                                  vertical: 12,
                                ),
                              ),
                            ),
                            const SizedBox(height: 16),

                            // Courses field
                            const Text(
                              "Courses (comma separated)",
                              style: TextStyle(
                                fontSize: 16,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                            const SizedBox(height: 8),
                            TextFormField(
                              controller: coursesController,
                              decoration: InputDecoration(
                                hintText: "e.g. CS101, MATH202, PHYS301",
                                border: OutlineInputBorder(
                                  borderRadius: BorderRadius.circular(15),
                                ),
                                contentPadding: const EdgeInsets.symmetric(
                                  horizontal: 16,
                                  vertical: 12,
                                ),
                              ),
                            ),
                            const SizedBox(height: 16),

                            // Interests field
                            const Text(
                              "Interests (comma separated)",
                              style: TextStyle(
                                fontSize: 16,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                            const SizedBox(height: 8),
                            TextFormField(
                              controller: interestsController,
                              decoration: InputDecoration(
                                hintText: "e.g. Reading, Coding, Tennis",
                                border: OutlineInputBorder(
                                  borderRadius: BorderRadius.circular(15),
                                ),
                                contentPadding: const EdgeInsets.symmetric(
                                  horizontal: 16,
                                  vertical: 12,
                                ),
                              ),
                            ),
                            const SizedBox(height: 20),
                          ],
                        ),
                      ),
                    ),
                  ),
                ),
              ),
              // Save button at bottom
              Container(
                margin: const EdgeInsets.only(top: 20, bottom: 30),
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(30),
                  boxShadow: [
                    BoxShadow(
                      color: Colors.green.withOpacity(0.3),
                      spreadRadius: 1,
                      blurRadius: 10,
                      offset: const Offset(0, 4),
                    ),
                  ],
                ),
                width: double.infinity, // Full width
                height: 60, // Increased height for better visibility
                child: ElevatedButton.icon(
                  icon: const Icon(Icons.save, size: 24),
                  label: const Text(
                    "Save Profile",
                    style: TextStyle(
                      fontSize: 18,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Colors.green[700],
                    foregroundColor: Colors.white,
                    padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(30),
                    ),
                  ),
                  onPressed: _saveProfile,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}