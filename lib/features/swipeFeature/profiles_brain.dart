import 'temp_profile.dart';

class ProfilesBrain {
  int userNumber = 1;

  List<Profile> users = [
    Profile(
        iD: 01,
        name: "coolCat",
        imgSource: "assets/temp_avatars/cool_cat.jpg",
        major: "Applied rizzing",
        classes: ["SKAT356, DRIP203, RIZZ258"],
        skills: ["backflip, breakdance, mewing"],
        bio:
            "meow meow meow meow meow meow meow moew moew moew moew moew moew moew moew moew moew moew moew moew moew moew moew moew"),
    Profile(
        iD: 02,
        name: "nerDog",
        imgSource: "assets/temp_avatars/nerd_dog.webp",
        major: "Software engineering",
        classes: ["COMP232", "ENGR213", "COMP248", "MANA202"],
        skills: ["good at maths", "flutter", "c++", "java"],
        bio:
            "woof woof woof woof woof woof woof woof woof woof woof woof woof woof woof woof woof woof woof woof woof woof woof woof")
  ];

  void swipeProfile() {
    //algorithm to recommend next profil
    if (userNumber < users.length - 1) {
      userNumber += 1;
    } else {
      userNumber = 0;
    }
  }
}
