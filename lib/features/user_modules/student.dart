// Importation of the abstract class
// to have the parent attribute and methods
import "user.dart";

// Class for the Admin
class Student extends User {
  // Student constructor
  Student(
    super.username,
    super.password, {
    required super.firstName,
    super.middleName,
    required super.lastName,
    required super.email,
    required this.studentID,
    required this.collegeUniversity,
    required this.expectedGraduationYear,
    List<String>? courses,
    this.gpa,
  }) : courses = courses ?? [];

  // Additionnal attributes
  int? studentID;
  String? collegeUniversity;
  late List<String> courses;
  int? expectedGraduationYear;
  double? gpa;

  // Admin could start with a special character to differenciate it
  // from the regular users in the database (like the students
  // and the mentors)
  // All these would be protected attributes

  // I do not understand the super parameters.

  // Method to add a course
  void addCourse(String course) {
    if (!courses.contains(course)) {
      courses.add(course);
    } else {
      print("The course is already added to your courses list.");
    }
  }

  // Method to remove a course
  void removeCourse(String course) {
    if (courses.contains(course)) {
      courses.remove(course);
    } else {
      print("The course is not in your courses list.");
    }
  }

  // Method to update the GPA
  void updateGPA(double newGPA) {
    gpa = newGPA;
  }

  // Method to get the student info
  // What will be printed on their presentation card
  String getStudentInfo() {
    if (middleName != null) {
      return "Student: $firstName $middleName $lastName \nSchool: $collegeUniversity\nGrduation Year: $expectedGraduationYear\nCourses:${courses.join(",")}";
    } else {
      return "Student: $firstName $lastName \nSchool: $collegeUniversity\nGrduation Year: $expectedGraduationYear\nCourses: ${courses.join(",")}";
    }
  }
}
