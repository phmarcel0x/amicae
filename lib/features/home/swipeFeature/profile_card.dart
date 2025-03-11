import 'constants.dart';
import 'package:flutter/material.dart';
import 'temp_profile.dart';

class ProfileCard extends StatelessWidget {
  final Profile profile;

  ProfileCard({required this.profile});

  String classes() {
    String str = '';
    for (var i = 0; i < profile.getClasses().length - 1; i++) {
      str += profile.getClasses()[i] + ', ';
    }
    str += profile.getClasses().last;
    return str;
  }

  String skills() {
    String str = '';
    for (var i = 0; i < profile.getSkills().length - 1; i++) {
      str += profile.getSkills()[i] + ', ';
    }
    str += profile.getSkills().last;
    return str;
  }

  @override
  Widget build(BuildContext context) {
    var height = MediaQuery.of(context).size.height;
    return Container(
      decoration: BoxDecoration(
        //Style of the profile card
        borderRadius: BorderRadius.circular(kProfileCardBorderRadius),
        color: kProfileCardColor,
      ),
      child: Column(
        children: [
          Expanded(
            flex: 4,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: [
                CircleAvatar(
                  radius: height * 0.07,
                  backgroundImage: AssetImage(profile.getAvatarSource()),
                ),
                Text(
                  profile.getName(),
                  style: kNameTextStyle,
                ),
                Text(
                  profile.getMajor(),
                  style: kMajorTextStyle,
                ),
              ],
            ),
          ),
          const SizedBox(
            width: 300,
            child: Divider(),
          ),
          Expanded(
            flex: 6,
            child: ListTileTheme(
              textColor: Colors.white,
              child: Column(
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                children: [
                  ListTile(
                    title: const Text(
                      'Biography: ',
                      style: TextStyle(fontSize: 20),
                    ),
                    subtitle: Text(
                      profile.getBio(),
                      style: TextStyle(fontSize: 15),
                    ),
                  ),
                  ListTile(
                    title: const Text(
                      'Classes: ',
                      style: TextStyle(fontSize: 20),
                    ),
                    subtitle: Text(
                      classes(),
                      style: TextStyle(fontSize: 15),
                    ),
                  ),
                  ListTile(
                    title: const Text(
                      'Skills: ',
                      style: TextStyle(fontSize: 20),
                    ),
                    subtitle: Text(
                      skills(),
                      style: TextStyle(fontSize: 15),
                    ),
                  ),
                ],
              ),
            ),
          )
        ],
      ),
    );
  }
}
