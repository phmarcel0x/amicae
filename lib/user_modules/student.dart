// Importation of the abstract class 
  // to have the parent attribute and methods 
import "../user_modules/user.dart";


// Class for the Admin
class Student extends User {
  // Additionnal attributes 
  int? studentID;
  String? collegeUniversity;
  List <String> courses;
  int? expectedGraduationYear; 
  double? GPA;


  // Admin could start with a special character to differenciate it
  // from the regular users in the database (like the students 
  // and the mentors)
  // All these would be protected attributes 
  

  // I do not understand the super parameters.



  // Student constructor
  Student(String username, String password, {required String firstName, 
          String? middleName, required String lastName, required String email, required this.studentID, 
          required this.collegeUniversity, required this.expectedGraduationYear, List <String>? courses, this.GPA}):
          courses = courses ?? [],
          super(username, password, firstName: firstName, middleName: middleName, lastName: lastName, email: email);

  // Method to add a course 
  void addCourse(String course) {
    if (!courses.contains(course)) {
      courses.add(course);
    }
    else{
      print("The course is already added to your courses list.");
    }
  }

  // Method to remove a course
  void removeCourse(String course) {
    if (courses.contains(course)){
      courses.remove(course);
    }
    else{
      print("The course is not in your courses list.");
    }
  }


  // Method to update the GPA
  void updateGPA(double newGPA){
    GPA = newGPA;
  }

  // Method to get the student info
    // What will be printed on their presentation card 
  String getStudentInfo() {
    if (middleName != null)  {
    return "Student: $firstName $middleName $lastName \nSchool: $collegeUniversity\nGrduation Year: $expectedGraduationYear\nCourses:${courses.join(",")}";
    }

    else {
      return "Student: $firstName $lastName \nSchool: $collegeUniversity\nGrduation Year: $expectedGraduationYear\nCourses: ${courses.join(",")}";
    }
  }
}

