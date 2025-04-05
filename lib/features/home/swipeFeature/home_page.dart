import 'package:flutter/material.dart';
import 'profiles_brain.dart';
import 'profile_card.dart';
import 'swipe_buttons.dart';
import 'constants.dart';
import 'package:provider/provider.dart';

class SwipePage extends StatelessWidget {
  const SwipePage({super.key});

  @override
  Widget build(BuildContext context) {
    // Use Consumer to access the ProfilesBrain provided by the parent
    return Consumer<ProfilesBrain>(
      builder: (context, profilesBrain, child) {
        // Show loading indicator
        if (profilesBrain.isLoading) {
          return const Center(
            child: CircularProgressIndicator(
              color: Colors.black,
            ),
          );
        }

        // Error message should only be shown for initial loading errors
        // We'll completely hide any error message for swipe errors
        if (profilesBrain.errorMessage != null && profilesBrain.noMoreProfiles == false && profilesBrain.currentProfile == null) {
          return Center(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                const Text(
                  'Could not load profiles. Please try again.',
                  style: TextStyle(color: Colors.red),
                  textAlign: TextAlign.center,
                ),
                const SizedBox(height: 20),
                ElevatedButton(
                  onPressed: () => profilesBrain.refreshProfiles(),
                  child: const Text('Try Again'),
                ),
              ],
            ),
          );
        }

        // Show message when no more profiles are available
        if (profilesBrain.noMoreProfiles || profilesBrain.currentProfile == null) {
          return Center(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                const Text(
                  'No more profiles available',
                  style: TextStyle(fontSize: 18),
                  textAlign: TextAlign.center,
                ),
                const SizedBox(height: 20),
                ElevatedButton(
                  onPressed: () => profilesBrain.refreshProfiles(),
                  child: const Text('Refresh'),
                ),
              ],
            ),
          );
        }

        // Show profile and swipe buttons
        return Column(
          children: [
            Expanded(
              flex: 4,
              child: Padding(
                padding: const EdgeInsets.only(
                  top: 16,
                  left: 16,
                  right: 16,
                  bottom: 8,
                ),
                child: ProfileCard(profile: profilesBrain.currentProfile!),
              ),
            ),

            // Buttons
            Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: [
                // Dislike button
                SwipeButton(
                  swipeAction: () =>
                      profilesBrain.swipeProfile(isLike: false),
                  buttonColor: kDislikeButtonColor,
                  buttonIcon: Icons.block_rounded,
                  iconColor: kDislikeIconColor,
                ),
                // Like button
                SwipeButton(
                  swipeAction: () => profilesBrain.swipeProfile(isLike: true),
                  buttonColor: kLikeButtonColor,
                  // buttonIcon: Icons.handshake_outlined,
                  buttonIcon: Icons.connect_without_contact_rounded,
                  iconColor: kLikeIconColor,
                ),
              ],
            ),
            const SizedBox(height: 8.0),
          ],
        );
      },
    );
  }
}