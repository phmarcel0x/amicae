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
    return Container(
      
      decoration: BoxDecoration(
        //Style of the profile card
        borderRadius: BorderRadius.circular(kProfileCardBorderRadius),
        color: kProfileCardColor,
      ),
      child: ListView(
        padding: EdgeInsets.symmetric(vertical: 16),
        children: [

                // Profile Image
                CircleAvatar(
                  radius: 50,
                  backgroundImage: AssetImage(profile.getAvatarSource()),
                  backgroundColor: Colors.grey[300],
                ),
                // Name
                Text(
                  profile.getName(),
                  textAlign: TextAlign.center,
                  style: kNameTextStyle,
                ),
                const SizedBox(height: 16),
                // Department and Education Status
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 16.0),
                  child: Text(
                    '${profile.getDepartment()} - ${profile.getEducationStatus()}',
                    style: kMajorTextStyle,
                  ),
                ),
          Divider(color: Colors.white54,
indent: 16,
            endIndent: 16,
          ),
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
    );
  }
}
