import "../exception_modules/custom_exceptions.dart";

// Creation of the abstract User class
abstract class User {
  final String? _username;
  String? _password;
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
  User(String username, String password, {required String firstName, String? middleName, required String lastName, required String email})
      : _username = username,
        _password = password,
        _firstName = firstName,
        _middleName = middleName,
        _lastName = lastName,
        _email = email;




  // Getters
  // Getter for the private variable: username
  String? get username => _username;

  // Getter for the private variabke: password
  String? get password => _password;

  // Getter for private variable: firstName
  String? get firstName => _firstName;

  // Getter for private variable: middleName
  String? get middleName => _middleName;

  // Getter for private variable: lastName 
  String? get lastName => _lastName;

  // Getter for private variable: email
  String? get email => _email;
    // made it in a way that the email cannot be changed 

  // Getter for the private variable: _firstNameChangeCounter 
  int get firstNameChangeCounter => _firstNameChangeCounter;

  // Getter for the private variable: _middleNameChangeCounter 
  int get middleNameChangeCounter => _middleNameChangeCounter;

  // Getter for the private variable: _lastNameChangeCounter 
  int get lastNameChangeCounter => _lastNameChangeCounter;

  // getter for the private variable: _totalNameChangeCounter
  int get totalNameChangeCounter => _totalNameChangeCounter;


  


  // Setters

  // No setter for the username b/c the user should not be 
  // able to change it

  // Setter for the password 
  set password(String? addedPassword) {
    _password = addedPassword;
  }


  // Setter for firstName 
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
      throw MaxChangeExceeded();
    }
  }

  // Setter for middleName
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
      throw MaxChangeExceeded();
    }
  }

  // Setter for lastName
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
      throw MaxChangeExceeded();
    }
  }


  // Method to show the input
  @override
  String toString(){
    if (totalNameChangeCounter == 0)  {
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


