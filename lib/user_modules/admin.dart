// Importation of the abstract class 
  // to have the parent attribute and methods 
import "../user_modules/user.dart";


// Class for the Admin
class Admin extends User {
  // Admin could start with a special character to differenciate it
  // from the regular users in the database (like the students 
  // and the mentors)
  // All these would be protected attributes 
  
  // Admin constructor
  Admin(super.username, super.password, {required super.firstName, super.middleName, required super.lastName, required super.email});

  // admins should have the right to change delete users that may be problematic 
    // admin should have the right to observe the app in a mentor or student view 
}