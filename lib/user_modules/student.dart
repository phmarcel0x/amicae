// Importation of the abstract class 
  // to have the parent attribute and methods 
import "../user_modules/user.dart";


// Class for the Admin
class Student extends User {
  // Additionnal attributes 
  int? studentID;
  String? collegeUniversity;
  int? currentYear; //First, second, third, fourth, etc.


  // Admin could start with a special character to differenciate it
  // from the regular users in the database (like the students 
  // and the mentors)
  // All these would be protected attributes 
  
  // Admin constructor
  Student(super.username, super.password, {required super.firstName, 
          super.middleName, required super.lastName, 
          required super.email, required this.studentID,
          required this.collegeUniversity, required this.currentYear});

  @override
  String toString() {
    String? parentString = super.toString();
    if (currentYear == 1){
      return "$parentString Your student ID is $studentID and you study at $collegeUniversity. You are in your ${currentYear}st";
      }
    
    else if (currentYear == 2) {
      return "$parentString Your student ID is $studentID and you study at $collegeUniversity. You are in your ${currentYear}nd";
      }
    
    else if (currentYear == 3) {
      return "$parentString Your student ID is $studentID and you study at $collegeUniversity. You are in your ${currentYear}rd";
      }
    
    else {
      return "$parentString Your student ID is $studentID and you study at $collegeUniversity. You are in your ${currentYear}th";
      }
    }
  }

