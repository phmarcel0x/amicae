import "dart:math";

import "package:amicae/features/user_modules/student.dart";
import "package:amicae/features/user_modules/user.dart";
import "package:amicae/features/user_modules/user_errors.dart";
import "package:test/test.dart";

// creation of a list of names to test the middle names
List<String> firstNameList = [
  "Christella",
  "Claudia",
  "Marie",
  "Carole",
  "Solange",
  "Patricia",
  "Claudine",
  "Anne Rose",
  "Marie Denise",
  "Evelyne"
];

List<String> middleNameList = [
  "Natalie",
  "Fabiola",
  "Margarette",
  "Junie",
  "Julienne",
  "Marie Louise",
  "Guerda",
  "Anouse",
  "Jesula",
  "Wideline"
];

List<String> lastNameList = [
  "Saintil",
  "Lindor",
  "Civil",
  "Exantus",
  "Constant",
  "Saint Fleur",
  "Georges",
  "Bien Aime",
  "Gaspard",
  "Lundy"
];

// function where the tests are defined
void main() {
  // grouping of all the related tests together
  group("Student", () {
    test("firstName can only be changed a limited amount of times", () {
      final student = Student("admin_username", "admin_password",
          firstName: "Meow",
          middleName: "Manoushka",
          lastName: "Woof",
          email: "meow.woof@amicae.com",
          studentID: 123456789,
          collegeUniversity: "PolyMTL",
          expectedGraduationYear: 2028);

      // Initial change count should be 0
      expect(student.firstName, equals("Meow"));

      // make a random number generator
      final random = Random();

      // for loop to have a random first name chosen from the list
      for (int i = 0; i < User.maxChange; i++) {
        String randomName;
        do {
          randomName = firstNameList[random.nextInt(firstNameList.length)];
        } while (randomName == student.firstName);
        student.firstName = randomName;
        print(student);
      }

      // Verify that the number of changes is equal to the adminMaxChange
      expect(student.firstNameChangeCounter, equals(User.maxChange));

      // Change the first name one more time: with a name not in the list
      bool exceptionThrown = false;
      try {
        student.firstName = "Vanessa";
      } on UserErrors {
        exceptionThrown = true;
      }

      // verify that the exception was thrown
      expect(exceptionThrown, isTrue);

      // verify that the first name is still in the list
      expect(student.firstName, isIn(firstNameList));
    });

    test("middleName can only be changed a limited amount of times", () {
      final student = Student("admin_username", "admin_password",
          firstName: "Meow",
          middleName: "Manoushka",
          lastName: "Woof",
          email: "meow.woof@amicae.com",
          studentID: 123456789,
          collegeUniversity: "PolyMTL",
          expectedGraduationYear: 2028);

      // Initial change count should be 0
      expect(student.middleName, equals("Manoushka"));

      // make a random number generator
      final random = Random();

      // for loop to have a random middle name chosen from the list
      for (int i = 0; i < User.maxChange; i++) {
        String randomName;
        do {
          randomName = middleNameList[random.nextInt(middleNameList.length)];
        } while (randomName == student.middleName);
        student.middleName = randomName;
      }

      // Verify that the number of changes is equal to the adminMaxChange
      expect(student.middleNameChangeCounter, equals(User.maxChange));

      // Change the middle Name one more time: with a name not in the list
      bool exceptionThrown = false;
      try {
        student.middleName = "Vanessa";
      } on UserErrors {
        exceptionThrown = true;
      }

      // verify that the exception was thrown
      expect(exceptionThrown, isTrue);

      // verify that the middle name is still in the list
      expect(student.middleName, isIn(middleNameList));
    });

    test("lastName can only be changed a limited amount of times", () {
      final student = Student("admin_username", "admin_password",
          firstName: "Meow",
          middleName: "Manoushka",
          lastName: "Woof",
          email: "meow.woof@amicae.com",
          studentID: 123456789,
          collegeUniversity: "PolyMTL",
          expectedGraduationYear: 2028);

      // Initial change count should be 0
      expect(student.lastName, equals("Woof"));

      // make a random number generator
      final random = Random();

      // for loop to have a random last name chosen from the list
      for (int i = 0; i < User.maxChange; i++) {
        String randomName;
        do {
          randomName = lastNameList[random.nextInt(lastNameList.length)];
        } while (randomName == student.lastName);
        student.lastName = randomName;
      }

      // Verify that the number of changes is equal to the adminMaxChange
      expect(student.lastNameChangeCounter, equals(User.maxChange));

      // Change the last Name one more time: with a name not in the list
      bool exceptionThrown = false;
      try {
        student.lastName = "Michel";
      } on UserErrors {
        exceptionThrown = true;
      }

      // verify that the exception was thrown
      expect(exceptionThrown, isTrue);

      // verify that the last name is still in the list
      expect(student.lastName, isIn(lastNameList));
    });

    test(
        "changing to the same first name does not decrement the change counter",
        () {
      final student = Student("admin_username", "admin_password",
          firstName: "Meow",
          middleName: "Manoushka",
          lastName: "Woof",
          email: "meow.woof@amicae.com",
          studentID: 123456789,
          collegeUniversity: "PolyMTL",
          expectedGraduationYear: 2028);

      // Initial change count should be 0
      expect(student.firstName, equals("Meow"));
      expect(student.firstNameChangeCounter, equals(0));
      print(student);

      // Changing the firstName to a different name
      student.firstName = firstNameList[0];
      expect(student.firstName, equals(firstNameList[0]));
      expect(student.firstNameChangeCounter, equals(1));
      print(student);

      // Changing the firstName to the same name
      student.firstName = firstNameList[0];
      expect(student.firstName, equals(firstNameList[0]));
      expect(student.firstNameChangeCounter, equals(1));
      print(student);
      // Counter should not increment
    });

    test(
        "changing to the same middle name does not decrement the change counter",
        () {
      final student = Student("admin_username", "admin_password",
          firstName: "Meow",
          middleName: "Manoushka",
          lastName: "Woof",
          email: "meow.woof@amicae.com",
          studentID: 123456789,
          collegeUniversity: "PolyMTL",
          expectedGraduationYear: 2028);

      // Initial change count should be 0
      expect(student.middleName, equals("Manoushka"));
      expect(student.middleNameChangeCounter, equals(0));
      print(student);

      // Changing the firstName to a different name
      student.middleName = middleNameList[0];
      expect(student.middleName, equals(middleNameList[0]));
      expect(student.middleNameChangeCounter, equals(1));
      print(student);

      // Changing the firstName to the same name
      student.middleName = middleNameList[0];
      expect(student.middleName, equals(middleNameList[0]));
      expect(student.middleNameChangeCounter, equals(1));
      // Counter should not increment
      print(student);
    });

    test("changing to the same last name does not decrement the change counter",
        () {
      final student = Student("admin_username", "admin_password",
          firstName: "Meow",
          middleName: "Manoushka",
          lastName: "Woof",
          email: "meow.woof@amicae.com",
          studentID: 123456789,
          collegeUniversity: "PolyMTL",
          expectedGraduationYear: 2028);

      // Initial change count should be 0
      expect(student.lastName, equals("Woof"));
      expect(student.lastNameChangeCounter, equals(0));
      print(student);

      // Changing the firstName to a different name
      student.lastName = lastNameList[0];
      expect(student.lastName, equals(lastNameList[0]));
      expect(student.lastNameChangeCounter, equals(1));
      print(student);

      // Changing the firstName to the same name
      student.lastName = lastNameList[0];
      expect(student.lastName, equals(lastNameList[0]));
      expect(student.lastNameChangeCounter, equals(1));
      // Counter should not increment
      print(student);
    });
  });
}
