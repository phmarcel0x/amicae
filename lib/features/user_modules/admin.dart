// Importation of the abstract class
// to have the parent attribute and methods
// importing the custom exception module
import "user.dart";
import "user_errors.dart";

// Class for the Admin
class Admin extends User {
  // Admin could start with a special character to differenciate it
  // from the regular users in the database (like the students
  // and the mentors)
  // All these would be protected attributes

  // counter for the number of times the info coould be changed
  int _firstNameChangeCounter = 0;
  int _middleNameChangeCounter = 0;
  int _lastNameChangeCounter = 0;

  // Maximum number of changes possible
  static const int maxChange = 5;

  // Admin constructor
  Admin(
    super.username,
    super.password, {
    required super.firstName,
    super.middleName,
    required super.lastName,
    required super.email,
  });

  // made it in a way that the email cannot be changed

  // Setters
  // Setter for firstName
  @override
  set firstName(String? addedFirstName) {
    if (_firstNameChangeCounter < maxChange) {
      if (firstName != addedFirstName) {
        firstName = addedFirstName;
        _firstNameChangeCounter++;
        int numRemaining = maxChange - _firstNameChangeCounter;
        print(
            "Number of times remaining to change the first name: $numRemaining.");
      } else {
        int numRemaining = maxChange - _firstNameChangeCounter;
        print(
            "Number of times remaining to change the first name: $numRemaining.");
      }
    } else {
      throw UserErrors.maxChangesExceeded;
    }
  }

  // Setter for middleName
  @override
  set middleName(String? addedMiddleName) {
    if (_middleNameChangeCounter < maxChange) {
      if (middleName != addedMiddleName) {
        middleName = addedMiddleName;
        _middleNameChangeCounter++;
        int numRemaining = maxChange - _middleNameChangeCounter;
        print(
            "Number of times remaining to change the middle name: $numRemaining.");
      } else {
        int numRemaining = maxChange - _middleNameChangeCounter;
        print(
            "Number of times remaining to change the middle name: $numRemaining.");
      }
    } else {
      throw UserErrors.maxChangesExceeded;
    }
  }

  // Setter for lastName
  @override
  set lastName(String? addedLastName) {
    if (_lastNameChangeCounter < maxChange) {
      if (lastName != addedLastName) {
        lastName = addedLastName;
        _lastNameChangeCounter++;
        int numRemaining = maxChange - _lastNameChangeCounter;
        print(
            "Number of times remaining to change the last name: $numRemaining.");
      } else {
        int numRemaining = maxChange - _lastNameChangeCounter;
        print(
            "Number of times remaining to change the last name: $numRemaining.");
      }
    } else {
      throw UserErrors.maxChangesExceeded;
    }
  }

  // Method to show the input
  @override
  String toString() {
    if (totalNameChangeCounter == 0) {
      if (middleName != null) {
        return "Your name is: $firstName $middleName $lastName. You registered with the following email: $email.";
      } else {
        return "Your name is: $firstName $lastName. You registered with the following email: $email.";
      }
    } else {
      if (middleName != null) {
        return "Your new name is: $firstName $middleName $lastName. You registered with the following email: $email.";
      } else {
        return "Your new name is: $firstName $lastName. You registered with the following email: $email.";
      }
    }
  }
}
