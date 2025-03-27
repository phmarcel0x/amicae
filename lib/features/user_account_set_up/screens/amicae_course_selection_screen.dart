import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'dart:convert';
import 'package:http/http.dart' as http;
// import '../screens/amicae_profile_picture_screen.dart';
import 'package:amicae/features/nav%20bar/nav_bar.dart';
import '../models/user_courses_code.dart';
import '../data/courses_codes.dart';

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

  Future<void> updateCourses(String documentId, List<String> _selectedCourses) async {
    final url = Uri.https(
      'amicae-app-default-rtdb.firebaseio.com',
      'user-profile/$documentId.json',
    );

    try {
      final response = await http.patch(
        url,
        body: json.encode({'courses': _selectedCourses}),
      );

      if (response.statusCode == 200) {
        print('Courses updated successfully!');
      } else {
        print('Failed to update Courses: ${response.statusCode}');
      }
    } catch (error) {
      print('Error occurred: $error');
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
              SizedBox(height: 8),
              Text(
                'Pick up to 5 to find friends with shared courses',
                style: GoogleFonts.lato(fontSize: 16, color: Colors.black54),
              ),
              SizedBox(height: 20),

              // Row to display Subject and Course Code on the same line
              Row(
                children: [
                  // Dropdown for Subject Selection
                  Expanded(
                    child: DropdownButton<String>(
                      value: selectedSubject,
                      hint: Text('Select Subject'),
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
                  SizedBox(width: 10),
                  // Dropdown for Course Codes (if available)
                  if (selectedSubject != null && courseCodes.isNotEmpty)
                    Expanded(
                      child: DropdownButton<String>(
                        value: selectedCourse,
                        hint: Text('Course Code'),
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

              SizedBox(height: 16),

              // Button to add the selected course to the list
              if (selectedCourse != null && selectedCourses.length < 5)
                Center(
                  child: ElevatedButton(
                    onPressed: () {
                      addCourse(selectedCourse!);
                    },
                    child: Text('Add Course'),
                  ),
                ),

              SizedBox(height: 16),

              // Display the selected courses
              if (selectedCourses.isNotEmpty)
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      'Selected Courses (${selectedCourses.length}/5):',
                      style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
                    ),
                    SizedBox(height: 8),
                    ...selectedCourses.map((course) => ListTile(
                      title: Text(course),
                      trailing: IconButton(
                        icon: Icon(Icons.remove_circle_outline),
                        onPressed: () {
                          removeCourse(course);
                        },
                      ),
                    )),
                  ],
                ),

              // Display a message when 5 courses have been selected
              if (selectedCourses.length == 5)
                Center(
                  child: Text(
                    'You have selected the maximum number of courses.',
                    style: TextStyle(color: Colors.red, fontWeight: FontWeight.bold),
                  ),
                ),
              Padding(
                padding: const EdgeInsets.all(26.5),
                child: Align(
                  alignment: Alignment.bottomRight,
                  child: IconButton(
                    icon: Icon(
                      Icons.arrow_circle_right_sharp,
                      size: 50,
                      color: Colors.black,
                    ),
                    onPressed: () {
                      updateCourses(widget.documentId, selectedCourses);
                      // Proceed to the next screen
                      Navigator.push(
                        context,
                        // MaterialPageRoute(
                        //   builder: (context) => AmicaeProfilePictureScreen(
                        //       documentId: widget.documentId),
                        // ),
                        MaterialPageRoute(builder: (context) => NavBar()),
                      );
                    },
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
