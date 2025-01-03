// Importation of the test framework 
import "package:test/test.dart";
// importation of the file containing the admin class 
import "../user_modules/admin.dart";
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
  group("Admin", (){


    test("firstName can only be changed a limited amount of times", () {
      final admin = Admin("admin_username", 
      "admin_password", 
      firstName: "Meow", 
      middleName: "Manoushka", 
      lastName: "Woof", 
      email: "meow.woof@amicae.com");

      // Initial change count should be 0
      expect(admin.firstName, equals("Meow"));

      // make a random number generator
      final random = Random();

      // for loop to have a random first name chosen from the list
      for (int i = 0; i < Admin.maxChange; i++) {
        String randomName;
        do {
          randomName = firstNameList[random.nextInt(firstNameList.length)];
        } while(randomName == admin.firstName);
        admin.firstName = randomName;
        print(admin);
      }

      // Verify that the number of changes is equal to the adminMaxChange
      expect(admin.firstNameChangeCounter, equals(Admin.maxChange));

      // Change the first name one more time: with a name not in the list 
      bool exceptionThrown = false;
      try {
        admin.firstName = "Vanessa";
      }
      catch (error) {
        if (error is maxChangeExceeded) {
          exceptionThrown = true;
        }
      }

      // verify that the exception was thrown 
      expect(exceptionThrown, isTrue);

      // verify that the first name is still in the list 
      expect(admin.firstName, isIn(firstNameList));
    });

    test("middleName can only be changed a limited amount of times", () {
      final admin = Admin("admin_username", 
      "admin_password", 
      firstName: "Meow", 
      middleName: "Manoushka", 
      lastName: "Woof", 
      email: "meow.woof@amicae.com");

      // Initial change count should be 0
      expect(admin.middleName, equals("Manoushka"));

      // make a random number generator
      final random = Random();

      // for loop to have a random middle name chosen from the list
      for (int i = 0; i < Admin.maxChange; i++) {
        String randomName;
        do {
          randomName = middleNameList[random.nextInt(middleNameList.length)];
        } while(randomName == admin.middleName);
        admin.middleName = randomName;
      }

      // Verify that the number of changes is equal to the adminMaxChange
      expect(admin.middleNameChangeCounter, equals(Admin.maxChange));

      // Change the middle Name one more time: with a name not in the list
      bool exceptionThrown = false;
      try {
        admin.middleName = "Vanessa";
      }
      catch (error) {
        if (error is maxChangeExceeded) {
          exceptionThrown = true;
        }
      }

      // verify that the exception was thrown 
      expect(exceptionThrown, isTrue);

      // verify that the middle name is still in the list 
      expect(admin.middleName, isIn(middleNameList));
    });

    test("lastName can only be changed a limited amount of times", () {
      final admin = Admin("admin_username", 
      "admin_password", 
      firstName: "Meow", 
      middleName: "Manoushka", 
      lastName: "Woof", 
      email: "meow.woof@amicae.com");

      // Initial change count should be 0
      expect(admin.lastName, equals("Woof"));

      // make a random number generator
      final random = Random();

      // for loop to have a random last name chosen from the list
      for (int i = 0; i < Admin.maxChange; i++) {
        String randomName;
        do {
          randomName = lastNameList[random.nextInt(lastNameList.length)];
        } while(randomName == admin.lastName);
        admin.lastName = randomName;
      }

      // Verify that the number of changes is equal to the adminMaxChange
      expect(admin.lastNameChangeCounter, equals(Admin.maxChange));

      // Change the last Name one more time: with a name not in the list
      bool exceptionThrown = false;
      try {
        admin.lastName = "Michel";
      }
      catch (error) {
        if (error is maxChangeExceeded) {
          exceptionThrown = true;
        }
      }

      // verify that the exception was thrown 
      expect(exceptionThrown, isTrue);

      // verify that the last name is still in the list 
      expect(admin.lastName, isIn(lastNameList));
    });


    test("changing to the same first name does not decrement the change counter", () {
      final admin = Admin("admin_username", 
      "admin_password", 
      firstName: "Meow", 
      middleName: "Manoushka", 
      lastName: "Woof", 
      email: "meow.woof@amicae.com");

      // Initial change count should be 0 
      expect(admin.firstName, equals("Meow"));
      expect(admin.firstNameChangeCounter, equals(0));
      print(admin);

      // Changing the firstName to a different name 
      admin.firstName = firstNameList[0];
      expect(admin.firstName, equals(firstNameList[0]));
      expect(admin.firstNameChangeCounter, equals(1));
      print(admin);

      // Changing the firstName to the same name 
      admin.firstName = firstNameList[0];
      expect(admin.firstName, equals(firstNameList[0]));
      expect(admin.firstNameChangeCounter, equals(1));
      print(admin);
        // Counter should not increment 

    });


    test("changing to the same middle name does not decrement the change counter", () {
      final admin = Admin("admin_username", 
      "admin_password", 
      firstName: "Meow", 
      middleName: "Manoushka", 
      lastName: "Woof", 
      email: "meow.woof@amicae.com");

      // Initial change count should be 0 
      expect(admin.middleName, equals("Manoushka"));
      expect(admin.middleNameChangeCounter, equals(0));
      print(admin);

      // Changing the firstName to a different name 
      admin.middleName = middleNameList[0];
      expect(admin.middleName, equals(middleNameList[0]));
      expect(admin.middleNameChangeCounter, equals(1));
      print(admin);

      // Changing the firstName to the same name 
      admin.middleName = middleNameList[0];
      expect(admin.middleName, equals(middleNameList[0]));
      expect(admin.middleNameChangeCounter, equals(1));
        // Counter should not increment 
      print(admin);

    });


    test("changing to the same last name does not decrement the change counter", () {
      final admin = Admin("admin_username", 
      "admin_password", 
      firstName: "Meow", 
      middleName: "Manoushka", 
      lastName: "Woof", 
      email: "meow.woof@amicae.com");

      // Initial change count should be 0 
      expect(admin.lastName, equals("Woof"));
      expect(admin.lastNameChangeCounter, equals(0));
      print(admin);

      // Changing the firstName to a different name 
      admin.lastName = lastNameList[0];
      expect(admin.lastName, equals(lastNameList[0]));
      expect(admin.lastNameChangeCounter, equals(1));
      print(admin);

      // Changing the firstName to the same name 
      admin.lastName = lastNameList[0];
      expect(admin.lastName, equals(lastNameList[0]));
      expect(admin.lastNameChangeCounter, equals(1));
        // Counter should not increment 
      print(admin);

    });

  });

}
