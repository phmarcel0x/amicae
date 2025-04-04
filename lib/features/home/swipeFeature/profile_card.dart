import 'constants.dart';
import 'package:flutter/material.dart';
import 'temp_profile.dart';
import 'match_insight.dart';
import 'package:provider/provider.dart';
import 'profiles_brain.dart';

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
        color: Colors.black,
      ),
      child: ListView(
        padding: const EdgeInsets.all(8),
        children: [
          // Profile Image
          CircleAvatar(
            radius: 50,
            backgroundColor: Colors.grey[300],
            child: Container(
              decoration: BoxDecoration(
                shape: BoxShape.circle,
                image: DecorationImage(
                  image: AssetImage(profile.getAvatarSource()),
                  fit: BoxFit.contain, // Adjust this property as needed
                ),
              ),
            ),
          ),
          const SizedBox(height: 8),

          // Name
          Text(
            profile.getName(),
            textAlign: TextAlign.center,
            style: kNameTextStyle,
          ),
          const SizedBox(height: 8),
          // Department and Education Status

          Align(
            alignment: Alignment.center,
            child: Container(
              padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(15),
              ),
              child: Text(
                profile.getDepartment(),
                textAlign: TextAlign.center,
                style: const TextStyle(
                  fontSize: 16,
                  color: Colors.black,
                ),
              ),
            ),
          ),
          const SizedBox(height: 8),
          Align(
            alignment: Alignment.center,
            child: Container(
              padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(15),
              ),
              child: Text(
                profile.getEducationStatus(),
                textAlign: TextAlign.center,
                style: const TextStyle(
                  fontSize: 16,
                  color: Colors.black,
                ),
              ),
            ),
          ),
          const Divider(
            color: Colors.white,
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
              'Courses: ',
              style: kSectionTitleStyle,
            ),
            subtitle: Wrap(
              spacing: 8,
              runSpacing: 8,
              children: profile.getCourses().map((course) =>
                  Container(
                    padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
                    decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(15),
                    ),
                    child: Text(
                      course,
                      style: const TextStyle(
                        color: Colors.black,
                      ),
                    ),
                  )
              ).toList(),
            ),
          ),
          // Interests/Skills
          ListTile(
            title: const Text(
              'Interests: ',
              style: kSectionTitleStyle,
            ),
            subtitle: Wrap(
              spacing: 8,
              runSpacing: 8,
              children: profile.getInterests().map((interest) =>
                  Container(
                    padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
                    decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(15),
                    ),
                    child: Text(
                      interest,
                      style: const TextStyle(
                        color: Colors.black,
                      ),
                    ),
                  )
              ).toList(),
            ),

          ),

          // Looking For
          // ListTile(
          //   title: const Text(
          //     'Looking For: ',
          //     style: kSectionTitleStyle,
          //   ),
          //   subtitle: Text(
          //     profile.getLookingFor(),
          //     style: kSectionContentStyle,
          //   ),
          // ),
        ],
      ),
    );
  }
}
