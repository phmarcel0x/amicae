import 'dart:async';
import 'dart:convert';
import 'dart:io';
import 'package:http/http.dart' as http;

import 'package:flutter/material.dart';
import 'package:flutter_widget_from_html_core/flutter_widget_from_html_core.dart';

Future<List<Album>> fetchAlbum() async {
  final response = await http.get(
    Uri.parse('https://opendata.concordia.ca/API/v1/library/events/'),
    headers: {
      HttpHeaders.authorizationHeader: 'Basic ODIwOjljNzYzZDRmYWQ3MzZhYTliYzYxYWVhOTczZGY5MDMz',
    },
  );

  if (response.statusCode == 200) {
    // return Album.fromJson(jsonDecode(response.body) as Map<String, dynamic>);
    // Decode the response and extract the 'events' list
    final jsonData = jsonDecode(response.body);
    final events = jsonData['events'] as List;

    // Map each event from the 'events' list to an Album
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
    required this.featuredImage
  });

  factory Album.fromJson(Map<String, dynamic> json) {
    try {
      return Album(
        id: json['id'] ?? 0,
        title: json['title'] ?? '',
        allDay: json['allday'] ?? false,
        start: DateTime.parse(json['start'] ?? DateTime.now().toIso8601String()),
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
        start: DateTime.parse(json['start'] ?? DateTime.now().toIso8601String()),
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

class EventDetailScreen extends StatelessWidget {
  final Album album;

  const EventDetailScreen({Key? key, required this.album}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,

      appBar: AppBar(
        title: Text(album.title),
        backgroundColor: Colors.white,
        // titleTextStyle: TextStyle(
        //   color: Colors.white,
        // ),
        shape: RoundedRectangleBorder(
          side: const BorderSide(color: Colors.black, width: 5),
          borderRadius: BorderRadius.circular(0),
        ),
      ),
      body: SingleChildScrollView(

        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                album.title,
                style: Theme.of(context).textTheme.headlineSmall,
              ),
              const SizedBox(height: 8),
              Text(
                'Start: ${album.start}',
                style: Theme.of(context).textTheme.titleMedium,
              ),
              const SizedBox(height: 8),
              Text(
                'End: ${album.end}',
                style: Theme.of(context).textTheme.titleMedium,
              ),
              const SizedBox(height: 8),
              HtmlWidget(
                album.description,
              ),
              const SizedBox(height: 8),
              Text(
                'Location: ${album.location.name}, ${album.location.campus}',
                style: Theme.of(context).textTheme.titleMedium,
              ),
              const SizedBox(height: 16),
              Text(
                'More Information:',
                style: Theme.of(context).textTheme.titleMedium,
              ),
              const SizedBox(height: 8),
              Text(
                'Public URL: ${album.publicUrl}',
                style: Theme.of(context).textTheme.bodyLarge,
              ),

            ],

          ),
        ),
      ),
    );
  }
}

void main() => runApp(const API_EventsPage());

class API_EventsPage extends StatefulWidget {
  const API_EventsPage({super.key});

  @override
  State<API_EventsPage> createState() => _API_EventsPageState();
}

class _API_EventsPageState extends State<API_EventsPage> {
  late Future<List<Album>> futureAlbums;

  @override
  void initState() {
    super.initState();
    futureAlbums = fetchAlbum(); // Fetch the list of albums (events)
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Fetch Data Example',
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
      ),
      home: Scaffold(
        backgroundColor: Colors.white,

        body: Center(

          child: FutureBuilder<List<Album>>(
            future: futureAlbums,
            builder: (context, snapshot) {
              if (snapshot.hasData) {
                final albums = snapshot.data!;
                return ListView.builder(
                  itemCount: albums.length,
                  itemBuilder: (context, index) {
                    return Padding(
                        padding: const EdgeInsets.all(10),
                        child: ListTile(
                          title: Text(albums[index].title),
                          subtitle: Text(albums[index].start.toString()),
                          onTap: () {
                            Navigator.push(
                              context,
                              MaterialPageRoute(
                                builder: (context) => EventDetailScreen(album: albums[index]),
                              ),
                            );
                          },
                          shape: RoundedRectangleBorder(
                            side: const BorderSide(color: Colors.black, width: 2),
                            borderRadius: BorderRadius.circular(10),
                          ),
                        ),
                    );
                  },
                );
              } else if (snapshot.hasError) {
                return Text('${snapshot.error}');
              }

              // By default, show a loading spinner.
              return const CircularProgressIndicator();
            },
          ),
        ),
      ),
    );
  }
}