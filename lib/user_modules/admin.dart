// Importation of the abstract class 
  // to have the parent attribute and methods 
import "../user_modules/user.dart";

// importing the custom exception module
import "../exception_modules/custom_exceptions.dart";


// Class for the Admin
class Admin extends User {
  // Admin could start with a special character to differenciate it
  // from the regular users in the database (like the students 
  // and the mentors)
  // All these would be protected attributes 
  String? _firstName;
  String? _middleName;
  String? _lastName;
  final String? _email;


  // counter for the number of times the info coould be changed 
  int _firstNameChangeCounter = 0;
  int _middleNameChangeCounter = 0;
  int _lastNameChangeCounter = 0;
  int _totalNameChangeCounter = 0;

  // Maximum number of changes possible
  static const int maxChange = 5;

  // Admin constructor
  Admin(super.username, super.password, {required String firstName, String? middleName, required String lastName, required String email}):
    _firstName = firstName,
    _middleName = middleName,
    _lastName = lastName,
    _email = email;
  

  // Getters 
  // Getter for private variable: firstName
  @override
  String? get firstName => _firstName;

  // Getter for private variable: middleName
  @override
  String? get middleName => _middleName;

  // Getter for private variable: lastName 
  @override
  String? get lastName => _lastName;

  // Getter for private variable: email
  @override
  String? get email => _email;
    // made it in a way that the email cannot be changed 

  // Getter for the private variable: _firstNameChangeCounter 
  int get firstNameChangeCounter => _firstNameChangeCounter;

  // Getter for the private variable: _middleNameChangeCounter 
  int get middleNameChangeCounter => _middleNameChangeCounter;

  // Getter for the private variable: _firstNameChangeCounter 
  int get lastNameChangeCounter => _lastNameChangeCounter;

  // getter for the private variable: _totalNameChangeCounter
  int get totalNameChangeCounter => _totalNameChangeCounter;


  
  // Setters 
  // Setter for firstName 
  @override
  set firstName(String? addedFirstName) {
    if (_firstNameChangeCounter < maxChange) {
      if (firstName != addedFirstName) {
        _firstName = addedFirstName;
        _firstNameChangeCounter++;
        _totalNameChangeCounter++;
        int numRemaining = maxChange - _firstNameChangeCounter;
        print("Number of times remaining to change the first name: $numRemaining.");
      }

      else {
        int numRemaining = maxChange - _firstNameChangeCounter;
        print("Number of times remaining to change the first name: $numRemaining.");
      }
    }
    else {
      throw maxChangeExceeded();
    }
  }

  // Setter for middleName
  @override
  set middleName(String? addedMiddleName) {
    if (_middleNameChangeCounter < maxChange) {
      if (middleName != addedMiddleName){
      _middleName = addedMiddleName;
      _middleNameChangeCounter++;
      _totalNameChangeCounter++;
      int numRemaining = maxChange - _middleNameChangeCounter;
      print("Number of times remaining to change the middle name: $numRemaining.");
      }

      else {
        int numRemaining = maxChange - _middleNameChangeCounter;
        print("Number of times remaining to change the middle name: $numRemaining.");
      }
    }

    else {
      throw maxChangeExceeded();
    }
  }

  // Setter for lastName
  @override
  set lastName(String? addedLastName) {
    if (_lastNameChangeCounter < maxChange) {
      if (lastName != addedLastName) {
      _lastName = addedLastName;
      _lastNameChangeCounter++;
      _totalNameChangeCounter++;
      int numRemaining = maxChange - _lastNameChangeCounter;
      print("Number of times remaining to change the last name: $numRemaining.");
      }

      else {
        int numRemaining = maxChange - _lastNameChangeCounter;
        print("Number of times remaining to change the last name: $numRemaining.");
      }
    }
    else {
      throw maxChangeExceeded();
    }
  }


  // Method to show the input
  @override
  String toString(){
    if (totalNameChangeCounter == 0) {
      if (middleName != null) {
      return "Your name is: $firstName $middleName $lastName. You registered with the following email: $email.";
      }
      else {
        return "Your name is: $firstName $lastName. You registered with the following email: $email.";
      }
    }
    else {
      if (middleName != null) {
      return "Your new name is: $firstName $middleName $lastName. You registered with the following email: $email.";
      }
      else {
        return "Your new name is: $firstName $lastName. You registered with the following email: $email.";
      }
    }
  }
}