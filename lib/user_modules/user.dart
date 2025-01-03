// Creation of the abstract User class
abstract class User {
  String? _username;
  String? _password;
  String? firstName;
  String? middleName;
  String? lastName;
  String? email;
  

  // making the constructor
  User(String username, String password, {this.firstName, this.middleName, this.lastName, this.email}) {
    _username = username;
    _password = password;
  }

  // Getter for private variable: username
  String? get username => _username;

  // Getter for private variable: password
  String? get password => _password;

  // setter for the password
  set password(String? newPassword) {
    password = newPassword;
  }

  // Method to show the input
  showInput(){
    print("Username: $username, Password: $password");
  }
  
  }


