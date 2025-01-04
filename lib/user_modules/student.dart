// Importation of the abstract class 
  // to have the parent attribute and methods 
import "../user_modules/user.dart";


// Class for the Admin
class Student extends User {
  // Admin could start with a special character to differenciate it
  // from the regular users in the database (like the students 
  // and the mentors)
  // All these would be protected attributes 
  
  // Admin constructor
  Student(String username, String password, {required String firstName, String? middleName, required String lastName, required String email})
      : super(username, password, firstName: firstName, middleName: middleName, lastName: lastName, email: email);


  int? studentID;
  String? collegeUniversity;
  int? currentYear; //First, second, third, fourth, etc.

}