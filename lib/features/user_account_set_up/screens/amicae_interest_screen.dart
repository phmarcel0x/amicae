import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

import '../screens/amicae_course_selection_screen.dart';
import '../services/user_profile_service.dart';
import '../models/user_interest.dart';
import '../data/interests.dart';

class AmicaeInterestScreen extends StatefulWidget {
  const AmicaeInterestScreen({super.key, required this.documentId});

  final String documentId;

  @override
  State<AmicaeInterestScreen> createState() => _AmicaeInterestScreenState();
}

class _AmicaeInterestScreenState extends State<AmicaeInterestScreen> {
  // List to track selected interest titles (Strings)
  List<String> selectedOptions = [];

  // The limit for the number of selections
  final int selectionLimit = 10;

  // Instance of UserProfileService
  final UserProfileService _userProfileService = UserProfileService();

  Future<void> updateInterest() async {
    try {
      // Update interests using the service method
      await _userProfileService.updateInterests(selectedOptions);
      print('Interests updated successfully!');
    } catch (error) {
      print('Error occurred while updating interests: $error');
      // Optionally show an error dialog to the user
      ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(content: Text('Failed to update interests. Please try again.'))
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 24.0, vertical: 36.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const SizedBox(height: 40),
            Text(
              'Your Interest',
              style: GoogleFonts.lato(
                fontSize: 28,
                fontWeight: FontWeight.bold,
                color: Colors.black,
              ),
            ),
            const SizedBox(height: 10),
            Text(
              'Choose up to 10 interests to connect with others who share your passions.',
              style: GoogleFonts.lato(fontSize: 16, color: Colors.black),
            ),
            const SizedBox(height: 40),
            Expanded(
              child: SingleChildScrollView(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    buildCategory("Creativity", [
                      Interests.Drawing,
                      Interests.Painting,
                      Interests.Writing,
                      Interests.Photography,
                      Interests.Crafting,
                      Interests.Dancing,
                      Interests.Singing,
                      Interests.Acting,
                      Interests.Design,
                      Interests.MusicProduction,
                      Interests.Sewing,
                      Interests.Knitting
                    ]),
                    const SizedBox(height: 20),
                    buildCategory("Sports", [
                      Interests.Soccer,
                      Interests.Basketball,
                      Interests.Tennis,
                      Interests.Swimming,
                      Interests.Running,
                      Interests.Cycling,
                      Interests.Yoga,
                      Interests.Surfing,
                      Interests.Boxing,
                      Interests.Gymnastics,
                      Interests.Weightlifting,
                      Interests.Hiking,
                    ]),
                    const SizedBox(height: 20),
                    buildCategory("Going Out", [
                      Interests.Clubbing,
                      Interests.Bars,
                      Interests.Concerts,
                      Interests.Festivals,
                      Interests.Theater,
                      Interests.Museums,
                      Interests.Shopping,
                      Interests.Picnics,
                    ]),
                    const SizedBox(height: 20),
                    buildCategory("Staying In", [
                      Interests.Reading,
                      Interests.Gaming,
                      Interests.Cooking,
                      Interests.Baking,
                      Interests.Puzzles,
                      Interests.BoardGames,
                      Interests.HomeWorkout,
                      Interests.Gardening,
                    ]),
                    const SizedBox(height: 20),
                    buildCategory("Film & TV", [
                      Interests.Movies,
                      Interests.Documentaries,
                      Interests.Animation,
                      Interests.RealityTV,
                      Interests.Anime,
                      Interests.Sitcoms,
                      Interests.SciFi,
                    ]),
                    const SizedBox(height: 20),
                    buildCategory("Reading", [
                      Interests.Reading,
                      Interests.Writing,
                      Interests.Photography,
                      Interests.MusicProduction,
                    ]),
                    const SizedBox(height: 20),
                    buildCategory("Education", [
                      Interests.Fiction,
                      Interests.NonFiction,
                      Interests.Poetry,
                      Interests.Fantasy,
                      Interests.Mystery,
                      Interests.SelfHelp,
                      Interests.Biography,
                      Interests.History,
                    ]),
                    const SizedBox(height: 20),
                    buildCategory("Music", [
                      Interests.Classical,
                      Interests.Rock,
                      Interests.Pop,
                      Interests.HipHop,
                      Interests.Jazz,
                      Interests.Blues,
                      Interests.Country,
                      Interests.EDM,
                      Interests.Indie,
                      Interests.KPop,
                    ]),
                    const SizedBox(height: 20),
                    buildCategory("Food & Drink", [
                      Interests.Coffee,
                      Interests.Tea,
                      Interests.Wine,
                      Interests.CraftBeer,
                      Interests.Vegetarian,
                      Interests.Vegan,
                      Interests.BakingSweets,
                      Interests.CookingSavory,
                      Interests.Sushi,
                      Interests.Pizza,
                      Interests.BBQ,
                    ]),
                    const SizedBox(height: 20),
                    buildCategory("Travelling", [
                      Interests.RoadTrips,
                      Interests.Backpacking,
                      Interests.BeachTrips,
                      Interests.Camping,
                      Interests.CityTours,
                      Interests.CulturalTrips,
                      Interests.HikingTrails,
                      Interests.AdventureTrips,
                    ]),
                    const SizedBox(height: 20),
                    buildCategory("Pets", [
                      Interests.Dogs,
                      Interests.Cats,
                      Interests.Birds,
                      Interests.Reptiles,
                      Interests.Fish,
                      Interests.Horses,
                      Interests.SmallPets,
                    ]),
                    const SizedBox(height: 20),
                    buildCategory("Values & Traits", [
                      Interests.Environmentalism,
                      Interests.Volunteering,
                      Interests.Kindness,
                      Interests.Honesty,
                      Interests.Loyalty,
                      Interests.Compassion,
                      Interests.Empathy,
                    ]),
                    const SizedBox(height: 20),
                    buildCategory("Values & Allyship", [
                      Interests.Feminism,
                      Interests.LGBTQIAAlly,
                      Interests.AntiRacism,
                      Interests.MentalHealthAwareness,
                      Interests.BodyPositivity,
                      Interests.DisabilityAdvocacy,
                      Interests.Sustainability,
                      Interests.AnimalRights,
                    ]),
                  ],
                ),
              ),
            ),
            // Use a SizedBox with a specific height instead of Spacer()
            const SizedBox(height: 16),
            Align(
              alignment: Alignment.bottomRight,
              child: CircleAvatar(
                backgroundColor: Colors.white,
                radius: 28,
                child: IconButton(
                  icon: const Icon(
                    Icons.arrow_circle_right_sharp,
                    size: 50,
                    color: Colors.black,
                  ),
                  onPressed: () async {
                    await updateInterest();
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => AmicaeCourseSelectionScreen(
                          documentId: widget.documentId,
                        ),
                      ),
                    );
                  },
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget buildCategory(String category, List<Interests> options) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          category,
          style: GoogleFonts.lato(fontSize: 18, fontWeight: FontWeight.bold),
        ),
        const SizedBox(height: 5),
        Wrap(
          runSpacing: 10,
          spacing: 10,
          children: options.map((option) {
            String optionTitle = interests[option]!.title;
            String optionEmoji = interests[option]!.emoji;
            String optionDisplay = "$optionEmoji $optionTitle";

            bool isDisabled = selectedOptions.length >= selectionLimit && !selectedOptions.contains(optionDisplay);

            return GestureDetector(
              onTap: isDisabled ? null : () {
                setState(() {
                  if (selectedOptions.contains(optionDisplay)) {
                    selectedOptions.remove(optionDisplay);
                  } else if (selectedOptions.length < selectionLimit) {
                    selectedOptions.add(optionDisplay);
                  }
                });
              },
              child: Container(
                padding: const EdgeInsets.symmetric(vertical: 10, horizontal: 15),
                decoration: BoxDecoration(
                  color: selectedOptions.contains(optionDisplay) ? Colors.black : Colors.white,
                  borderRadius: BorderRadius.circular(20),
                  border: Border.all(color: isDisabled ? Colors.grey : Colors.black, width: 1),
                ),
                child: Text(
                  optionDisplay,
                  style: GoogleFonts.lato(
                    color: selectedOptions.contains(optionDisplay)
                        ? Colors.white
                        : isDisabled
                        ? Colors.grey
                        : Colors.black,
                    fontSize: 16,
                  ),
                ),
              ),
            );
          }).toList(),
        ),
      ],
    );
  }
}