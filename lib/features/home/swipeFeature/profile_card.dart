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
        border: Border.all(color: Colors.black, width: 4.0), // Black border
        color: Colors.white, // White background
      ),
      child: ListView(
        padding: const EdgeInsets.all(8),
        children: [
          // Amicae MatchUp AI
          Padding(
            padding: const EdgeInsets.only(left: 8.0, right: 8.0, bottom: 8.0),
            child: Consumer<ProfilesBrain>(
              builder: (context, profilesBrain, child) {
                final matchInsight = profilesBrain.matchInsight;

                if (matchInsight.isLoading) {
                  return Container(
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(kProfileCardBorderRadius),
                      border: Border.all(color: Colors.green, width: 2.0),
                      color: Colors.white,
                    ),
                    child: Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          Text(
                            'Amicae MatchUp AI: ',
                            style: kSectionTitleStyle.copyWith(
                              color: Colors.green,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                          const SizedBox(height: 0),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              const SizedBox(
                                width: 18,
                                height: 18,
                                child: CircularProgressIndicator(
                                  color: Colors.black,
                                  strokeWidth: 2.0,
                                ),
                              ),
                              const SizedBox(width: 16),
                              Text(
                                'Analyzing profiles...',
                                style: kSectionContentStyle.copyWith(
                                  color: Colors.black,
                                  fontStyle: FontStyle.italic,
                                ),
                              ),
                            ],
                          ),
                        ],
                      ),
                    ),
                  );
                }

                if (matchInsight.isEmpty) {
                  return const SizedBox.shrink(); // Hide if no insights available
                }

                return Container(
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(kProfileCardBorderRadius),
                    border: Border.all(color: Colors.green, width: 2.0),
                    color: Colors.white,
                  ),
                  child: Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        Text(
                          'Amicae MatchUp AI: ',
                          textAlign: TextAlign.center, // Center the text within its container
                          style: kSectionTitleStyle.copyWith(
                            color: Colors.green,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        const SizedBox(height: 0),
                        Text(
                          textAlign: TextAlign.center, // Center the text within its container
                          "\"${matchInsight.content}\"",
                          style: kSectionContentStyle.copyWith(
                            color: Colors.black,
                            fontStyle: FontStyle.italic,
                          ),
                        ),
                      ],
                    ),
                  ),
                );
              },
            ),
          ),

          const SizedBox(height: 8),

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
            style: kNameTextStyle.copyWith(color: Colors.black, fontSize: 32), // Black text
          ),
          // Department and Education Status
          const Divider(
            color: Colors.black, // Black divider
            indent: 16,
            endIndent: 16,
          ),
          const SizedBox(height: 8),

          Align(
            alignment: Alignment.centerRight,
            child: Container(
              padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(15),
                border: Border.all(color: Colors.black, width: 1.0), // Optional black border for these containers
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
            alignment: Alignment.centerRight,
            child: Container(
              padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(15),
                border: Border.all(color: Colors.black, width: 1.0), // Optional black border for these containers
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

          // Bio
          ListTile(
            title: Text(
              'Biography: ',
              style: kSectionTitleStyle.copyWith(color: Colors.black), // Black text
            ),
            subtitle: Text(
              profile.getBio(),
              style: kSectionContentStyle.copyWith(color: Colors.black), // Black text
            ),
          ),
          // Courses
          ListTile(
            title: Text(
              'Courses: ',
              style: kSectionTitleStyle.copyWith(color: Colors.black), // Black text
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
                      border: Border.all(color: Colors.black, width: 1.0), // Optional black border for course tags
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
            title: Text(
              'Interests: ',
              style: kSectionTitleStyle.copyWith(color: Colors.black), // Black text
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
                      border: Border.all(color: Colors.black, width: 1.0), // Optional black border for interest tags
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