// Importation of the abstract class
// to have the parent attribute and methods
import "user.dart";

// Class for the Mentor
class Mentor extends User {
  Mentor(
    super.username,
    super.password, {
    required super.firstName,
    super.middleName,
    required super.lastName,
    required super.email,
    required this.company,
    required this.startYear,
    List<String>? menteesList,
  }) : menteesList = menteesList ?? [];

  // Admin could start with a special character to differenciate it
  // from the regular users in the database (like the students
  // and the mentors)
  // All these would be protected attributes

  // added attributes for the mentor
  String company;
  int startYear;
  // mentees list
  late List<String> menteesList;

  // Admin constructor

  // Method to add a mentee
  void addMentee(String mentee) {
    if (menteesList.contains(mentee)) {
      menteesList.add(mentee);
      print("Mentee $mentee added.");
    } else {
      print("Mentee $mentee is already in the list.");
    }
  }

  @override
  String toString() {
    String? parentString = super.toString();
    return "$parentString You work at $company since $startYear.";
  }

  // maybe add a sort of CV like on LinkedIn
}

main() {
  Mentor mentor = Mentor("mentor_username", "mentor_password",
      firstName: "Natasha",
      lastName: "Dorcainvil",
      email: "natasha.dorcainvil@amicae.dev",
      company: "Amicae Corp",
      startYear: 2024);

  print(mentor);

  mentor.addMentee("Johanna");

  print(mentor.menteesList);
}
