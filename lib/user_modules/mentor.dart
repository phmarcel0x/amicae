// Importation of the abstract class 
  // to have the parent attribute and methods 
import "../user_modules/user.dart";

// Class for the Mentor
class Mentor extends User {
  // Admin could start with a special character to differenciate it
  // from the regular users in the database (like the students 
  // and the mentors)
  // All these would be protected attributes 
  
  // added attributes for the mentor 
  String company;
  int startYear;
  // mentees list 
  List? menteesList;  


  // Admin constructor
  Mentor(super.username, super.password, {required super.firstName, super.middleName, 
        required super.lastName, required super.email, required this.company, 
        required this.startYear, this.menteesList});

  @override
  String toString(){
    String? parentString = super.toString();
    return "$parentString You work at $company since $startYear.";
    }

  // maybe add a sort of CV like on LinkedIn 
}

main() {
  Mentor mentor = Mentor("mentor_username", 
  "mentor_password", 
  firstName: "Natasha", 
  lastName: "Dorcainvil", 
  email: "natasha.dorcainvil@amicae.dev", 
  company: "Amicae Corp", 
  startYear: 2024);

  print(mentor);
}