import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

import '../services/user_profile_service.dart';
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
  final _userProfileService = UserProfileService();
  List<String> selectedOptions = [];
  final int selectionLimit = 10;
  bool _isUpdating = false;

  Future<void> _updateInterests() async {
    if (_isUpdating) return;

    setState(() {
      _isUpdating = true;
    });

    try {
      await _userProfileService.updateInterests(selectedOptions);

      if (mounted) {
        Navigator.push(
          context,
          MaterialPageRoute(
            builder: (context) =>
                AmicaeCourseSelectionScreen(documentId: widget.documentId),
          ),
        );
      }
    } catch (error) {
      if (mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text('Failed to update interests: $error')),
        );
      }
    } finally {
      if (mounted) {
        setState(() {
          _isUpdating = false;
        });
      }
    }
  }

  Widget buildCategory(
      String categoryTitle, List<Interests> categoryInterests) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          categoryTitle,
          style: GoogleFonts.lato(
            fontSize: 18,
            fontWeight: FontWeight.bold,
            color: Colors.black87,
          ),
        ),
        const SizedBox(height: 10),
        Wrap(
          spacing: 8.0,
          runSpacing: 8.0,
          children: categoryInterests.map((interest) {
            final interestInfo = interests[interest]!;
            final isSelected = selectedOptions.contains(interestInfo.title);

            return FilterChip(
              label: Text(
                '${interestInfo.emoji} ${interestInfo.title}',
                style: GoogleFonts.lato(
                  color: isSelected ? Colors.white : Colors.black87,
                ),
              ),
              selected: isSelected,
              onSelected: (bool selected) {
                setState(() {
                  if (selected && selectedOptions.length < selectionLimit) {
                    selectedOptions.add(interestInfo.title);
                  } else if (!selected) {
                    selectedOptions.remove(interestInfo.title);
                  }
                });
              },
              backgroundColor: Colors.white,
              selectedColor: Colors.black87,
              checkmarkColor: Colors.white,
              elevation: 2,
            );
          }).toList(),
        ),
      ],
    );
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
                      'Your Interests',
                      style: GoogleFonts.lato(
                        fontSize: 24,
                        fontWeight: FontWeight.bold,
                        color: Colors.black,
                      ),
                    ),
                    Text(
                      'Pick up to ${selectionLimit} to find friends with shared experiences.',
                      style:
                          GoogleFonts.lato(fontSize: 16, color: Colors.black54),
                    ),
                    const SizedBox(height: 20),
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
                    const SizedBox(height: 50),
                  ],
                ),
              ),
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(26.5),
            child: Align(
              alignment: Alignment.bottomRight,
              child: CircleAvatar(
                backgroundColor: Colors.white,
                radius: 28,
                child: IconButton(
                  icon: _isUpdating
                      ? const SizedBox(
                          width: 24,
                          height: 24,
                          child: CircularProgressIndicator(
                            color: Colors.black,
                            strokeWidth: 2,
                          ),
                        )
                      : Icon(
                          Icons.arrow_circle_right_sharp,
                          size: 50,
                          color: selectedOptions.isNotEmpty
                              ? Colors.black
                              : Colors.grey,
                        ),
                  onPressed: selectedOptions.isNotEmpty && !_isUpdating
                      ? _updateInterests
                      : null,
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
