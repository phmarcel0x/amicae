import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:amicae/features/nav%20bar/nav_bar.dart';
import '../models/user_courses_code.dart';
import '../data/courses_codes.dart';
import '../services/user_profile_service.dart';

const String username = '791';
const String password = 'cb24f3d4b086f625bc33f2097f28539c';

class AmicaeCourseSelectionScreen extends StatefulWidget {
  const AmicaeCourseSelectionScreen({super.key, required this.documentId});

  final String documentId;

  @override
  State<AmicaeCourseSelectionScreen> createState() =>
      _AmicaeCourseSelectionScreenState();
}

class _AmicaeCourseSelectionScreenState
    extends State<AmicaeCourseSelectionScreen> {
  String? selectedSubject;
  String? selectedCourse;
  Map<CourseCode, UserCoursesCode> subjects = coursesCodes;
  List<String> courseCodes = [];
  List<String> selectedCourses = [];
  final UserProfileService _userProfileService = UserProfileService();

  Future<void> fetchCourseCodes(String subject) async {
    final url = 'https://opendata.concordia.ca/API/v1/course/catalog/filter/$subject/*/*';
    final response = await http.get(Uri.parse(url), headers: {
      'Authorization': 'Basic ' + base64Encode(utf8.encode('$username:$password')),
    });

    if (response.statusCode == 200) {
      final List<dynamic> data = jsonDecode(response.body);
      setState(() {
        courseCodes = data.map((course) {
          final courseCode = course['subject'];
          if (coursesCodes.containsKey(courseCode)) {
            return '${coursesCodes[courseCode]?.emoji} ${coursesCodes[courseCode]?.courseCode}';
          }
          return "${courseCode} ${course['catalog']}";
        }).toList();
      });
    } else {
      print("Failed to load courses for $subject");
      setState(() {
        courseCodes = [];
      });
    }
  }

  void addCourse(String course) {
    if (selectedCourses.length < 5 && !selectedCourses.contains(course)) {
      setState(() {
        selectedCourses.add(course);
        selectedSubject = null;
        selectedCourse = null;
      });
    }
  }

  void removeCourse(String course) {
    setState(() {
      selectedCourses.remove(course);
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 24.0, vertical: 36.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const SizedBox(height: 40),
            Text(
              'Your Courses',
              style: GoogleFonts.lato(
                fontSize: 28,
                fontWeight: FontWeight.bold,
                color: Colors.black,
              ),
            ),
            const SizedBox(height: 10),
            Text(
              'Select up to 5 courses to connect with others in the same classes.',
              style: GoogleFonts.lato(fontSize: 16, color: Colors.black54),
            ),
            const SizedBox(height: 40),
            // Row to display Subject and Course Code on the same line
            if (selectedCourses.length < 5)
              Row(
                children: [
                  // Dropdown for Subject Selection
                  Expanded(
                    child: DropdownButton<String>(
                      value: selectedSubject,
                      hint: const Text('Select Subject'),
                      isExpanded: true,
                      items: coursesCodes.keys.map((CourseCode courseCode) {
                        return DropdownMenuItem<String>(
                          value: coursesCodes[courseCode]?.courseCode,
                          child: Text(
                              '${coursesCodes[courseCode]?.emoji} ${coursesCodes[courseCode]?.courseCode}'),
                        );
                      }).toList(),
                      onChanged: (String? subject) {
                        setState(() {
                          selectedSubject = subject;
                          if (subject != null) {
                            fetchCourseCodes(subject);
                          }
                        });
                      },
                      // Add this line to limit the dropdown height and remove blue tint
                      menuMaxHeight: MediaQuery.of(context).size.height * 0.4,
                      dropdownColor: Colors.white, // Set dropdown background to white
                      style: const TextStyle(color: Colors.black), // Text color
                      icon: const Icon(Icons.arrow_drop_down, color: Colors.black), // Icon color
                      underline: Container(height: 2, color: Colors.black), // Underline color
                    ),
                  ),
                  const SizedBox(width: 10),
                  // Dropdown for Course Codes (if available)
                  if (selectedSubject != null && courseCodes.isNotEmpty)
                    Expanded(
                      child: DropdownButton<String>(
                        value: selectedCourse,
                        hint: const Text('Course Code'),
                        isExpanded: true,
                        items: courseCodes.map((String courseCode) {
                          return DropdownMenuItem<String>(
                            value: courseCode,
                            child: Text(courseCode),
                          );
                        }).toList(),
                        onChanged: (String? courseCode) {
                          setState(() {
                            selectedCourse = courseCode;
                          });
                        },
                        // Add this line to limit the dropdown height and remove blue tint
                        menuMaxHeight: MediaQuery.of(context).size.height * 0.4,
                        dropdownColor: Colors.white, // Set dropdown background to white
                        style: const TextStyle(color: Colors.black), // Text color
                        icon: const Icon(Icons.arrow_drop_down, color: Colors.black), // Icon color
                        underline: Container(height: 2, color: Colors.black), // Underline color
                      ),
                    ),
                ],
              ),


            // Button to add the selected course to the list
            if (selectedCourse != null && selectedCourses.length < 5)
              Column(
                  children: [
                    const SizedBox(height: 8),

                    Center(
                      child: ElevatedButton(
                        style: ElevatedButton.styleFrom(
                            backgroundColor: Colors.black,
                            foregroundColor: Colors.white,
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(10),
                            )
                        ),
                        onPressed: () {
                          addCourse(selectedCourse!);
                        },
                        child: const Text('Add Course'),
                      ),
                    ),
                    const SizedBox(height: 8),

                  ]

              ),


            if (selectedCourses.length < 5)
              const SizedBox(height: 16),

            // Display the selected courses
            if (selectedCourses.isNotEmpty)
              Column(
                children: [
                  // const Divider(
                  //   color: Colors.black,
                  //   indent: 4,
                  //   endIndent: 4,
                  // ),

                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        'Selected Courses (${selectedCourses.length}/5):',
                        style: const TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
                      ),
                      const SizedBox(height: 8),
                      ...selectedCourses.map((course) => ListTile(
                        title: Text(course),
                        trailing: IconButton(
                          icon: const Icon(Icons.remove_circle_outline, color: Colors.red),
                          onPressed: () {
                            removeCourse(course);
                          },
                        ),
                      )),
                    ],
                  ),
                ],
              ),


            // Display a message when 5 courses have been selected
            const Spacer(),
            Row(
              children: [
                if (selectedCourses.length == 5)
                  Row(
                      children: [
                        const Icon(
                          Icons.info_outline,
                          color: Colors.black,
                          size: 20.0,
                        ),
                        const SizedBox(width: 4.0),
                        Text(
                          'You’ve reached the max course selection.',
                          style: GoogleFonts.lato(
                            fontSize: 12.0,
                            color: Colors.black,
                          ),
                        ),
                      ]
                  ),
                const Spacer(),
                CircleAvatar(
                  backgroundColor: Colors.white,
                  radius: 28,
                  child: IconButton(
                    icon: const Icon(
                      Icons.arrow_circle_right_sharp,
                      size: 50,
                      color: Colors.black,
                    ),
                    onPressed: () async {
                      try {
                        // Update courses using the UserProfileService
                        await _userProfileService.updateCourses(selectedCourses);
                        // Proceed to the next screen
                        Navigator.push(
                          context,
                          MaterialPageRoute(builder: (context) => const NavBar()),
                        );
                      } catch (e) {
                        // Handle any errors during course update
                        ScaffoldMessenger.of(context).showSnackBar(
                          SnackBar(content: Text('Failed to update courses: $e')),
                        );
                      }
                    },
                  ),
                ),
              ],
            ),

          ],
        ),
      ),
    );
  }
}