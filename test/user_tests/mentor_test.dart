// Importation of the test framework
import "package:test/test.dart";
// importation of the module for the user abstract class
import "../user_modules/user.dart";
// importation of the file containing the admin class 
import "../user_modules/mentor.dart";
// importing the exception files 
import "../exception_modules/custom_exceptions.dart";
// import the math library 
import "dart:math";

// creation of a list of names to test the middle names 
List <String> firstNameList = ["Christella", "Claudia", "Marie", "Carole", "Solange",
                                "Patricia", "Claudine", "Anne Rose", "Marie Denise", "Evelyne"];


List <String> middleNameList = ["Natalie", "Fabiola", "Margarette", "Junie", "Julienne",
                                "Marie Louise", "Guerda", "Anouse", "Jesula", "Wideline"];


List <String> lastNameList = ["Saintil", "Lindor", "Civil", "Exantus", "Constant",
                              "Saint Fleur", "Georges", "Bien Aime", "Gaspard",
                              "Lundy"];

// function where the tests are defined 
void main() {
  // grouping of all the related tests together 
  group("Mentor", (){


    test("firstName can only be changed a limited amount of times", () {
      final mentor = Mentor("admin_username", 
      "admin_password", 
      firstName: "Meow", 
      middleName: "Manoushka", 
      lastName: "Woof", 
      email: "meow.woof@amicae.com", 
      company: "Amicae Inc", 
      startYear: 2024);

      // Initial change count should be 0
      expect(mentor.firstName, equals("Meow"));

      // make a random number generator
      final random = Random();

      // for loop to have a random first name chosen from the list
      for (int i = 0; i < User.maxChange; i++) {
        String randomName;
        do {
          randomName = firstNameList[random.nextInt(firstNameList.length)];
        } while(randomName == mentor.firstName);
        mentor.firstName = randomName;
        print(mentor);
      }

      // Verify that the number of changes is equal to the adminMaxChange
      expect(mentor.firstNameChangeCounter, equals(User.maxChange));

      // Change the first name one more time: with a name not in the list 
      bool exceptionThrown = false;
      try {
        mentor.firstName = "Vanessa";
      }
      catch (error) {
        if (error is MaxChangeExceeded) {
          exceptionThrown = true;
        }
      }

      // verify that the exception was thrown 
      expect(exceptionThrown, isTrue);

      // verify that the first name is still in the list 
      expect(mentor.firstName, isIn(firstNameList));
    });

    test("middleName can only be changed a limited amount of times", () {
      final mentor = Mentor("admin_username", 
      "admin_password", 
      firstName: "Meow", 
      middleName: "Manoushka", 
      lastName: "Woof", 
      email: "meow.woof@amicae.com", 
      company: "Amicae Inc", 
      startYear: 2024);

      // Initial change count should be 0
      expect(mentor.middleName, equals("Manoushka"));

      // make a random number generator
      final random = Random();

      // for loop to have a random middle name chosen from the list
      for (int i = 0; i < User.maxChange; i++) {
        String randomName;
        do {
          randomName = middleNameList[random.nextInt(middleNameList.length)];
        } while(randomName == mentor.middleName);
        mentor.middleName = randomName;
      }

      // Verify that the number of changes is equal to the adminMaxChange
      expect(mentor.middleNameChangeCounter, equals(User.maxChange));

      // Change the middle Name one more time: with a name not in the list
      bool exceptionThrown = false;
      try {
        mentor.middleName = "Vanessa";
      }
      catch (error) {
        if (error is MaxChangeExceeded) {
          exceptionThrown = true;
        }
      }

      // verify that the exception was thrown 
      expect(exceptionThrown, isTrue);

      // verify that the middle name is still in the list 
      expect(mentor.middleName, isIn(middleNameList));
    });

    test("lastName can only be changed a limited amount of times", () {
      final mentor = Mentor("admin_username", 
      "admin_password", 
      firstName: "Meow", 
      middleName: "Manoushka", 
      lastName: "Woof", 
      email: "meow.woof@amicae.com", 
      company: "Amicae Inc", 
      startYear: 2024);

      // Initial change count should be 0
      expect(mentor.lastName, equals("Woof"));

      // make a random number generator
      final random = Random();

      // for loop to have a random last name chosen from the list
      for (int i = 0; i < User.maxChange; i++) {
        String randomName;
        do {
          randomName = lastNameList[random.nextInt(lastNameList.length)];
        } while(randomName == mentor.lastName);
        mentor.lastName = randomName;
      }

      // Verify that the number of changes is equal to the adminMaxChange
      expect(mentor.lastNameChangeCounter, equals(User.maxChange));

      // Change the last Name one more time: with a name not in the list
      bool exceptionThrown = false;
      try {
        mentor.lastName = "Michel";
      }
      catch (error) {
        if (error is MaxChangeExceeded) {
          exceptionThrown = true;
        }
      }

      // verify that the exception was thrown 
      expect(exceptionThrown, isTrue);

      // verify that the last name is still in the list 
      expect(mentor.lastName, isIn(lastNameList));
    });


    test("changing to the same first name does not decrement the change counter", () {
      final mentor = Mentor("admin_username", 
      "admin_password", 
      firstName: "Meow", 
      middleName: "Manoushka", 
      lastName: "Woof", 
      email: "meow.woof@amicae.com", 
      company: "Amicae Inc", 
      startYear: 2024);

      // Initial change count should be 0 
      expect(mentor.firstName, equals("Meow"));
      expect(mentor.firstNameChangeCounter, equals(0));
      print(mentor);

      // Changing the firstName to a different name 
      mentor.firstName = firstNameList[0];
      expect(mentor.firstName, equals(firstNameList[0]));
      expect(mentor.firstNameChangeCounter, equals(1));
      print(mentor);

      // Changing the firstName to the same name 
      mentor.firstName = firstNameList[0];
      expect(mentor.firstName, equals(firstNameList[0]));
      expect(mentor.firstNameChangeCounter, equals(1));
      print(mentor);
        // Counter should not increment 

    });


    test("changing to the same middle name does not decrement the change counter", () {
      final mentor = Mentor("admin_username", 
      "admin_password", 
      firstName: "Meow", 
      middleName: "Manoushka", 
      lastName: "Woof", 
      email: "meow.woof@amicae.com", 
      company: "Amicae Inc", 
      startYear: 2024);

      // Initial change count should be 0 
      expect(mentor.middleName, equals("Manoushka"));
      expect(mentor.middleNameChangeCounter, equals(0));
      print(mentor);

      // Changing the middleName to a different name 
      mentor.middleName = middleNameList[0];
      expect(mentor.middleName, equals(middleNameList[0]));
      expect(mentor.middleNameChangeCounter, equals(1));
      print(mentor);

      // Changing the middleName to the same name 
      mentor.middleName = middleNameList[0];
      expect(mentor.middleName, equals(middleNameList[0]));
      expect(mentor.middleNameChangeCounter, equals(1));
        // Counter should not increment 
      print(mentor);

    });


    test("changing to the same last name does not decrement the change counter", () {
      final mentor = Mentor("admin_username", 
      "admin_password", 
      firstName: "Meow", 
      middleName: "Manoushka", 
      lastName: "Woof", 
      email: "meow.woof@amicae.com", 
      company: "Amicae Inc", 
      startYear: 2024);

      // Initial change count should be 0 
      expect(mentor.lastName, equals("Woof"));
      expect(mentor.lastNameChangeCounter, equals(0));
      print(mentor);

      // Changing the lastName to a different name 
      mentor.lastName = lastNameList[0];
      expect(mentor.lastName, equals(lastNameList[0]));
      expect(mentor.lastNameChangeCounter, equals(1));
      print(mentor);

      // Changing the lastName to the same name 
      mentor.lastName = lastNameList[0];
      expect(mentor.lastName, equals(lastNameList[0]));
      expect(mentor.lastNameChangeCounter, equals(1));
        // Counter should not increment 
      print(mentor);

    });

  });

}
