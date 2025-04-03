import 'constants.dart';
import 'package:flutter/material.dart';
import 'temp_profile.dart';

class ProfileCard extends StatelessWidget {
  final Profile profile;

  const ProfileCard({super.key, required this.profile});

  String _formatList(List<String> items) {
    if (items.isEmpty) return 'None';

    String str = '';
    for (var i = 0; i < items.length - 1; i++) {
      str += items[i] + ', ';
    }
    str += items.last;
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
                // Profile Image
                CircleAvatar(
                  radius: height * 0.07,
                  backgroundImage: AssetImage(profile.getAvatarSource()),
                  backgroundColor: Colors.grey[300],
                ),
                // Name
                Text(
                  profile.getName(),
                  style: kNameTextStyle,
                ),
                // Department and Education Status
                Text(
                  '${profile.getDepartment()} - ${profile.getEducationStatus()}',
                  style: kMajorTextStyle,
                ),
              ],
            ),
          ),
          const SizedBox(
            width: 300,
            child: Divider(color: Colors.white54),
          ),
          Expanded(
            flex: 6,
            child: ListTileTheme(
              textColor: Colors.white,
              child: Column(
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                children: [
                  // Bio
                  ListTile(
                    title: const Text(
                      'Biography: ',
                      style: kSectionTitleStyle,
                    ),
                    subtitle: Text(
                      profile.getBio(),
                      style: kSectionContentStyle,
                    ),
                  ),
                  // Courses
                  ListTile(
                    title: const Text(
                      'Current Courses: ',
                      style: kSectionTitleStyle,
                    ),
                    subtitle: Text(
                      _formatList(profile.getCourses()),
                      style: kSectionContentStyle,
                    ),
                  ),
                  // Interests/Skills
                  ListTile(
                    title: const Text(
                      'Interests & Skills: ',
                      style: kSectionTitleStyle,
                    ),
                    subtitle: Text(
                      _formatList(profile.getInterests()),
                      style: kSectionContentStyle,
                    ),
                  ),
                  // Looking For
                  ListTile(
                    title: const Text(
                      'Looking For: ',
                      style: kSectionTitleStyle,
                    ),
                    subtitle: Text(
                      profile.getLookingFor(),
                      style: kSectionContentStyle,
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
