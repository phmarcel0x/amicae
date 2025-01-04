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
  Mentor(String username, String password, {required String firstName, String? middleName, 
        required String lastName, required String email, required this.company, 
        required this.startYear, this.menteesList})
      : super(username, password, firstName: firstName, middleName: middleName, 
        lastName: lastName, email: email);

  @override
  String toString(){
    String? parentString = super.toString();
    return "$parentString You work at ${this.company} since ${this.startYear}.";
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