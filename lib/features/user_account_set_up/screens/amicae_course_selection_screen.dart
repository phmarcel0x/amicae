import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'dart:convert';
import 'package:http/http.dart' as http;
// import '../screens/amicae_profile_picture_screen.dart';
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
  final _userProfileService = UserProfileService();
  String? selectedSubject;
  String? selectedCourse;
  Map<CourseCode, UserCoursesCode> subjects = coursesCodes;
  List<String> courseCodes = [];
  List<String> selectedCourses = [];
  bool _isUpdating = false;

  Future<void> fetchCourseCodes(String subject) async {
    final url =
        'https://opendata.concordia.ca/API/v1/course/catalog/filter/$subject/*/*';
    final response = await http.get(Uri.parse(url), headers: {
      'Authorization':
          'Basic ' + base64Encode(utf8.encode('$username:$password')),
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

  Future<void> _updateCourses() async {
    if (_isUpdating) return;

    setState(() {
      _isUpdating = true;
    });

    try {
      await _userProfileService.updateCourses(selectedCourses);

      if (mounted) {
        Navigator.push(
          context,
          MaterialPageRoute(
            builder: (context) => const NavBar(),
          ),
        );
      }
    } catch (error) {
      if (mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text('Failed to update courses: $error')),
        );
      }
    } finally {
      if (mounted) {
        setState(() {
          _isUpdating = false;
        });
      }
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
    return MaterialApp(
      home: Scaffold(
        appBar: AppBar(
          backgroundColor: Colors.white,
          automaticallyImplyLeading: false,
        ),
        backgroundColor: Colors.white,
        body: Padding(
          padding: const EdgeInsets.all(20.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // Title and Description
              Text(
                'Your Courses',
                style: GoogleFonts.lato(
                  fontSize: 24,
                  fontWeight: FontWeight.bold,
                  color: Colors.black,
                ),
              ),
              const SizedBox(height: 8),
              Text(
                'Pick up to 5 to find friends with shared courses',
                style: GoogleFonts.lato(fontSize: 16, color: Colors.black54),
              ),
              const SizedBox(height: 20),

              // Row to display Subject and Course Code on the same line
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
                      ),
                    ),
                ],
              ),

              const SizedBox(height: 16),

              // Button to add the selected course to the list
              if (selectedCourse != null && selectedCourses.length < 5)
                Center(
                  child: ElevatedButton(
                    style: ElevatedButton.styleFrom(
                      backgroundColor: Colors.black,
                      foregroundColor: Colors.white,
                    ),
                    onPressed: () => addCourse(selectedCourse!),
                    child: const Text('Add Course'),
                  ),
                ),

              const SizedBox(height: 16),

              // Display the selected courses
              if (selectedCourses.isNotEmpty)
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      'Selected Courses (${selectedCourses.length}/5):',
                      style:
                          const TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
                    ),
                    const SizedBox(height: 8),
                    ...selectedCourses.map((course) => ListTile(
                          title: Text(course),
                          trailing: IconButton(
                            icon: const Icon(Icons.remove_circle_outline),
                            onPressed: () {
                              removeCourse(course);
                            },
                          ),
                        )),
                  ],
                ),

              // Display a message when 5 courses have been selected
              if (selectedCourses.length == 5)
                const Center(
                  child: Text(
                    'You have selected the maximum number of courses.',
                    style: TextStyle(
                        color: Colors.red, fontWeight: FontWeight.bold),
                  ),
                ),
              const Spacer(),
              Align(
                alignment: Alignment.bottomRight,
                child: CircleAvatar(
                  backgroundColor: Colors.white,
                  radius: 28,
                  child: IconButton(
                    icon: _isUpdating
                        ? const SizedBox(
                            width: 24,
                            height: 24,
                            child: CircularProgressIndicator(
                              color: Colors.black,
                              strokeWidth: 2,
                            ),
                          )
                        : Icon(
                            Icons.arrow_circle_right_sharp,
                            size: 50,
                            color: selectedCourses.isNotEmpty
                                ? Colors.black
                                : Colors.grey,
                          ),
                    onPressed: selectedCourses.isNotEmpty && !_isUpdating
                        ? _updateCourses
                        : null,
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
