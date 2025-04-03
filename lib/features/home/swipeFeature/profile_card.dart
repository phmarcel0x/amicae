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
        color: kProfileCardColor,
      ),
      child: ListView(
        padding: EdgeInsets.symmetric(vertical: 16),
        children: [
          // Match Insights Section at the very top
          Consumer<ProfilesBrain>(
            builder: (context, profilesBrain, child) {
              final matchInsight = profilesBrain.matchInsight;

              if (matchInsight.isLoading) {
                return Padding(
                  padding: const EdgeInsets.all(16.0),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        'Why we think it\'s a good match:',
                        style: kSectionTitleStyle.copyWith(
                          color: Colors.amber,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      const SizedBox(height: 8),
                      Row(
                        children: [
                          const SizedBox(
                            width: 18,
                            height: 18,
                            child: CircularProgressIndicator(
                              color: Colors.amber,
                              strokeWidth: 2.0,
                            ),
                          ),
                          const SizedBox(width: 10),
                          Text(
                            'Analyzing profiles...',
                            style: kSectionContentStyle.copyWith(
                              color: Colors.amberAccent,
                              fontStyle: FontStyle.italic,
                            ),
                          ),
                        ],
                      ),
                      const Divider(
                        color: Colors.amberAccent,
                        indent: 16,
                        endIndent: 16,
                        height: 32,
                      ),
                    ],
                  ),
                );
              }

              if (matchInsight.isEmpty) {
                return const SizedBox.shrink(); // Hide if no insights available
              }

              return Padding(
                padding: const EdgeInsets.all(16.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      'Why we think it\'s a good match:',
                      style: kSectionTitleStyle.copyWith(
                        color: Colors.amber,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    const SizedBox(height: 8),
                    Text(
                      matchInsight.content,
                      style: kSectionContentStyle.copyWith(
                        color: Colors.amberAccent,
                        fontStyle: FontStyle.italic,
                      ),
                    ),
                    const Divider(
                      color: Colors.amberAccent,
                      indent: 16,
                      endIndent: 16,
                      height: 32,
                    ),
                  ],
                ),
              );
            },
          ),
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
          Divider(
            color: Colors.white54,
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
