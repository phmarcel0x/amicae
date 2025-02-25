import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

import 'package:http/http.dart' as http;

// import 'package:amicae_v5/screens/amicae_profile_picture_screen.dart';
import '../screens/amicae_course_selection_screen.dart';

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

  Future<void> updateInterest(String documentId, List<String> _selectedOptions) async {
    // Construct the Firebase URL using the document ID to update the specific user's profile
    final url = Uri.https(
      'amicae-app-default-rtdb.firebaseio.com',
      'user-profile/$documentId.json',
    );

    try {
      // Send PATCH request to update the  mode
      final response = await http.patch(
        url,
        body: json.encode({'interests': _selectedOptions}), // Sending the mode as JSON
      );

      if (response.statusCode == 200) {
        print('Interests updated successfully!');
      } else {
        print('Failed to update Interests: ${response.statusCode}');
      }
    } catch (error) {
      print('Error occurred: $error');
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        automaticallyImplyLeading: false,
        backgroundColor: Colors.white,
      ),
      body: Stack(
        children: [
          Padding(
            padding: const EdgeInsets.all(20.0),
            child: SizedBox(
              height: 700,
              child: SingleChildScrollView(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      'Your Interest',
                      style: GoogleFonts.lato(
                        fontSize: 24,
                        fontWeight: FontWeight.bold,
                        color: Colors.black,
                      ),
                    ),
                    Text(
                      'Pick up to 10 to find friends with shared experiences.',
                      style: GoogleFonts.lato(fontSize: 16, color: Colors.black54),
                    ),
                    SizedBox(height: 20),
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
                    SizedBox(height: 20),
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
                    SizedBox(height: 20),
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
                    SizedBox(height: 20),
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
                    SizedBox(height: 20),
                    buildCategory("Film & TV", [
                      Interests.Movies,
                      Interests.Documentaries,
                      Interests.Animation,
                      Interests.RealityTV,
                      Interests.Anime,
                      Interests.Sitcoms,
                      Interests.SciFi,
                    ]),
                    SizedBox(height: 20),
                    buildCategory("Reading", [
                      Interests.Reading,
                      Interests.Writing,
                      Interests.Photography,
                      Interests.MusicProduction,
                    ]),
                    SizedBox(height: 20),
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
                    SizedBox(height: 20),
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
                    SizedBox(height: 20),
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
                    SizedBox(height: 20),
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
                    SizedBox(height: 20),
                    buildCategory("Pets", [
                      Interests.Dogs,
                      Interests.Cats,
                      Interests.Birds,
                      Interests.Reptiles,
                      Interests.Fish,
                      Interests.Horses,
                      Interests.SmallPets,
                    ]),
                    SizedBox(height: 20),
                    buildCategory("Values & Traits", [
                      Interests.Environmentalism,
                      Interests.Volunteering,
                      Interests.Kindness,
                      Interests.Honesty,
                      Interests.Loyalty,
                      Interests.Compassion,
                      Interests.Empathy,
                    ]),
                    SizedBox(height: 20),
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
                    SizedBox(height: 50),
                  ],
                ),
              ),
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(26.5),
            child: Align(
              alignment: Alignment.bottomRight,
              child: IconButton(
                  icon: Icon(
                      Icons.arrow_circle_right_sharp,
                      size: 50,
                      color: Colors.black
                  ),
                  onPressed: (){
                    updateInterest(widget.documentId, selectedOptions);
                    // Proceed to the next screen
                    Navigator.push(
                      context,
                      // MaterialPageRoute(builder: (context) => AmicaeProfilePictureScreen(documentId: widget.documentId)),
                      MaterialPageRoute(builder: (context) => AmicaeCourseSelectionScreen(documentId: widget.documentId)),
                    );
                  }
              ),
            ),
          ),
        ],
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
        Wrap(
          runSpacing: 10,
          spacing: 10,
          children: options.map((option) {
            String optionTitle = interests[option]!.title;  // Get the title
            String optionEmoji = interests[option]!.emoji;  // Get the emoji
            String optionDisplay = "$optionEmoji $optionTitle"; // Combine emoji and title

            // Disable the button if the selection limit is reached and the option is not selected
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
                padding: EdgeInsets.symmetric(vertical: 10, horizontal: 15),
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