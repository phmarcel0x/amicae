import 'dart:async';
import 'dart:convert';
import 'dart:io';
import 'package:flutter/material.dart';
import 'package:flutter_widget_from_html_core/flutter_widget_from_html_core.dart';
import 'package:http/http.dart' as http;
import 'package:intl/intl.dart';

// API call and data models remain largely the same
Future<List<Album>> fetchAlbum() async {
  final response = await http.get(
    Uri.parse('https://opendata.concordia.ca/API/v1/library/events/'),
    headers: {
      HttpHeaders.authorizationHeader:
          'Basic ODIwOjljNzYzZDRmYWQ3MzZhYTliYzYxYWVhOTczZGY5MDMz',
    },
  );

  if (response.statusCode == 200) {
    final jsonData = jsonDecode(response.body);
    final events = jsonData['events'] as List;
    return events.map((event) => Album.fromJson(event)).toList();
  } else {
    throw Exception('Failed to load album');
  }
}

class Album {
  final int id;
  final String title;
  final bool allDay;
  final DateTime start;
  final DateTime end;
  final String description;
  final String publicUrl;
  final String adminUrl;
  final Location location;
  final String presenter;
  final Calendar calendar;
  final bool registration;
  final String color;
  final String featuredImage;

  Album({
    required this.id,
    required this.title,
    required this.allDay,
    required this.start,
    required this.end,
    required this.description,
    required this.publicUrl,
    required this.adminUrl,
    required this.location,
    required this.presenter,
    required this.calendar,
    required this.registration,
    required this.color,
    required this.featuredImage,
  });

  factory Album.fromJson(Map<String, dynamic> json) {
    try {
      return Album(
        id: json['id'] ?? 0,
        title: json['title'] ?? '',
        allDay: json['allday'] ?? false,
        start:
            DateTime.parse(json['start'] ?? DateTime.now().toIso8601String()),
        end: DateTime.parse(json['end'] ?? DateTime.now().toIso8601String()),
        description: json['description'] ?? '',
        publicUrl: json['public'] ?? '',
        adminUrl: json['admin'] ?? '',
        location: Location.fromJson(json['location'] ?? {}),
        presenter: json['presenter'] ?? '',
        calendar: Calendar.fromJson(json['calendar'] ?? {}),
        registration: json['registration'] ?? false,
        color: json['color'] ?? '',
        featuredImage: json['featured_image'] ?? '',
      );
    } catch (e) {
      throw Exception("Error parsing Album JSON: $e");
    }
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'title': title,
      'allday': allDay,
      'start': start.toIso8601String(),
      'end': end.toIso8601String(),
      'description': description,
      'public': publicUrl,
      'admin': adminUrl,
      'location': location.toJson(),
      'presenter': presenter,
      'calendar': calendar.toJson(),
      'registration': registration,
      'color': color,
      'featured_image': featuredImage,
    };
  }
}

class Location {
  final int id;
  final int type;
  final String name;
  final String campus;

  Location({
    required this.id,
    required this.type,
    required this.name,
    required this.campus,
  });

  factory Location.fromJson(Map<String, dynamic> json) {
    try {
      return Location(
        id: json['id'] ?? 0,
        type: json['type'] ?? 0,
        name: json['name'] ?? '',
        campus: json['campus'] ?? '',
      );
    } catch (e) {
      throw Exception("Error parsing Location JSON: $e");
    }
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'type': type,
      'name': name,
      'campus': campus,
    };
  }
}

class Calendar {
  final int id;
  final String name;
  final String publicUrl;
  final String adminUrl;

  Calendar({
    required this.id,
    required this.name,
    required this.publicUrl,
    required this.adminUrl,
  });

  factory Calendar.fromJson(Map<String, dynamic> json) {
    try {
      return Calendar(
        id: json['id'] ?? 0,
        name: json['name'] ?? '',
        publicUrl: json['public'] ?? '',
        adminUrl: json['admin'] ?? '',
      );
    } catch (e) {
      throw Exception("Error parsing Calendar JSON: $e");
    }
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'name': name,
      'public': publicUrl,
      'admin': adminUrl,
    };
  }
}

class EventDate {
  final int eventId;
  final DateTime start;

  EventDate({
    required this.eventId,
    required this.start,
  });

  factory EventDate.fromJson(Map<String, dynamic> json) {
    try {
      return EventDate(
        eventId: json['event_id'] ?? 0,
        start:
            DateTime.parse(json['start'] ?? DateTime.now().toIso8601String()),
      );
    } catch (e) {
      throw Exception("Error parsing EventDate JSON: $e");
    }
  }

  Map<String, dynamic> toJson() {
    return {
      'event_id': eventId,
      'start': start.toIso8601String(),
    };
  }
}

// Revised Event Detail Screen
class EventDetailScreen extends StatelessWidget {
  final Album album;

  const EventDetailScreen({super.key, required this.album});

  @override
  Widget build(BuildContext context) {
    final DateFormat dateFormat = DateFormat('MMM dd, yyyy - hh:mm a');

    return Scaffold(
      appBar: AppBar(
        title: const Text("Event Details"),
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              album.title,
              style: Theme.of(context).textTheme.headlineSmall,
            ),
            const SizedBox(height: 8),
            Text("Start: ${dateFormat.format(album.start)}"),
            const SizedBox(height: 8),
            Text("End: ${dateFormat.format(album.end)}"),
            const SizedBox(height: 16),
            HtmlWidget(album.description),
            const SizedBox(height: 16),
            Text(
              "Location: ${album.location.name}, ${album.location.campus}",
              style: Theme.of(context).textTheme.bodyLarge,
            ),
            const SizedBox(height: 16),
            Text(
              "Presenter: ${album.presenter}",
              style: Theme.of(context).textTheme.bodyLarge,
            ),
            const SizedBox(height: 16),
            Text(
              "More Information:",
              style: Theme.of(context).textTheme.titleMedium,
            ),
            const SizedBox(height: 8),
            InkWell(
              onTap: () {
                // You can add functionality to open the URL
              },
              child: Text(
                album.publicUrl,
                style: const TextStyle(
                  color: Colors.blue,
                  decoration: TextDecoration.underline,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

// Revised Events List Page with enhanced UI
void main() => runApp(const APIEventsPage());

class APIEventsPage extends StatefulWidget {
  const APIEventsPage({super.key});

  @override
  State<APIEventsPage> createState() => _APIEventsPageState();
}

class _APIEventsPageState extends State<APIEventsPage> {
  late Future<List<Album>> futureAlbums;
  final DateFormat dateFormat = DateFormat('MMM dd, yyyy - hh:mm a');

  @override
  void initState() {
    super.initState();
    futureAlbums = fetchAlbum();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Events"),
        centerTitle: true,
      ),
      body: FutureBuilder<List<Album>>(
        future: futureAlbums,
        builder: (context, snapshot) {
          if (snapshot.hasData) {
            final albums = snapshot.data!;
            return ListView.builder(
              padding: const EdgeInsets.all(8),
              itemCount: albums.length,
              itemBuilder: (context, index) {
                final album = albums[index];
                return Card(
                  elevation: 4,
                  margin:
                      const EdgeInsets.symmetric(vertical: 8, horizontal: 8),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(12),
                  ),
                  child: ListTile(
                    contentPadding: const EdgeInsets.all(16),
                    title: Text(
                      album.title,
                      style: const TextStyle(fontWeight: FontWeight.bold),
                    ),
                    subtitle: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        const SizedBox(height: 4),
                        Text(
                          dateFormat.format(album.start),
                          style: const TextStyle(color: Colors.grey),
                        ),
                        const SizedBox(height: 4),
                        Text(
                          "Location: ${album.location.name}",
                          style: const TextStyle(color: Colors.grey),
                        ),
                      ],
                    ),
                    trailing: const Icon(Icons.arrow_forward_ios),
                    onTap: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) =>
                              EventDetailScreen(album: album),
                        ),
                      );
                    },
                  ),
                );
              },
            );
          } else if (snapshot.hasError) {
            return Center(child: Text('Error: ${snapshot.error}'));
          }
          return const Center(child: CircularProgressIndicator());
        },
      ),
    );
  }
}
