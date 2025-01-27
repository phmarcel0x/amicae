import 'dart:async';
import 'dart:convert';
import 'dart:io';

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

Future<List<Album>> fetchAlbum() async {
  final response = await http.get(
    Uri.parse('https://opendata.concordia.ca/API/v1/library/events/'),
    headers: {
      HttpHeaders.authorizationHeader: 'Basic ODIwOjljNzYzZDRmYWQ3MzZhYTliYzYxYWVhOTczZGY5MDMz',
    },
  );

  print(response.body);

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
//with a lot of error handling
/*
class Album {
  final int id;
  final String title;
  final bool allday;
  final DateTime start;
  final DateTime end;
  final String description;
  final String? publicUrl;
  final String? adminUrl;
  final Location? location;
  final List<Category> categories;
  final Owner owner;
  final Calendar calendar;
  final String? seats;
  final bool registration;
  final String color;
  final String featuredImage;
  final List<FutureDate> futureDates;

  Album({
    required this.id,
    required this.title,
    required this.allday,
    required this.start,
    required this.end,
    required this.description,
    this.publicUrl,
    this.adminUrl,
    this.location,
    required this.categories,
    required this.owner,
    required this.calendar,
    this.seats,
    required this.registration,
    required this.color,
    required this.featuredImage,
    required this.futureDates,
  });

  factory Album.fromJson(Map<String, dynamic> json) {
    try {
      return Album(
        id: json['id'] ?? (throw FormatException('Missing field: id')),
        title: json['title'] ?? (throw FormatException('Missing field: title')),
        allday: json['allday'] ?? (throw FormatException('Missing field: allday')),
        start: json['start'] != null ? DateTime.parse(json['start']) : (throw FormatException('Missing or invalid field: start')),
        end: json['end'] != null ? DateTime.parse(json['end']) : (throw FormatException('Missing or invalid field: end')),
        description: json['description'] ?? (throw FormatException('Missing field: description')),
        publicUrl: json['public'],
        adminUrl: json['admin'],
        location: json['location'] != null
            ? Location.fromJson(json['location'])
            : null,
        categories: (json['category'] as List?)?.map((e) => Category.fromJson(e)).toList() ?? (throw FormatException('Missing field: category')),
        owner: json['owner'] != null ? Owner.fromJson(json['owner']) : (throw FormatException('Missing field: owner')),
        calendar: json['calendar'] != null ? Calendar.fromJson(json['calendar']) : (throw FormatException('Missing field: calendar')),
        seats: json['seats'],
        registration: json['registration'] ?? (throw FormatException('Missing field: registration')),
        color: json['color'] ?? (throw FormatException('Missing field: color')),
        featuredImage: json['featured_image'] ?? (throw FormatException('Missing field: featured_image')),
        futureDates: (json['future_dates'] as List?)?.map((e) => FutureDate.fromJson(e)).toList() ?? (throw FormatException('Missing field: future_dates')),
      );
    } catch (e) {
      throw FormatException('Error parsing Album JSON: \$e');
    }
  }
}

class Location {
  final int id;
  final int type;
  final String name;
  final String? campus;

  Location({
    required this.id,
    required this.type,
    required this.name,
    this.campus,
  });

  factory Location.fromJson(Map<String, dynamic> json) {
    try {
      return Location(
        id: json['id'] ?? (throw FormatException('Missing field: id in Location')),
        type: json['type'] ?? (throw FormatException('Missing field: type in Location')),
        name: json['name'] ?? (throw FormatException('Missing field: name in Location')),
        campus: json['campus'],
      );
    } catch (e) {
      throw FormatException('Error parsing Location JSON: \$e');
    }
  }
}

class Category {
  final int id;
  final String name;

  Category({
    required this.id,
    required this.name,
  });

  factory Category.fromJson(Map<String, dynamic> json) {
    try {
      return Category(
        id: json['id'] ?? (throw FormatException('Missing field: id in Category')),
        name: json['name'] ?? (throw FormatException('Missing field: name in Category')),
      );
    } catch (e) {
      throw FormatException('Error parsing Category JSON: \$e');
    }
  }
}

class Owner {
  final int id;
  final String name;

  Owner({
    required this.id,
    required this.name,
  });

  factory Owner.fromJson(Map<String, dynamic> json) {
    try {
      return Owner(
        id: json['id'] ?? (throw FormatException('Missing field: id in Owner')),
        name: json['name'] ?? (throw FormatException('Missing field: name in Owner')),
      );
    } catch (e) {
      throw FormatException('Error parsing Owner JSON: \$e');
    }
  }
}

class Calendar {
  final int id;
  final String name;
  final String? publicUrl;
  final String? adminUrl;

  Calendar({
    required this.id,
    required this.name,
    this.publicUrl,
    this.adminUrl,
  });

  factory Calendar.fromJson(Map<String, dynamic> json) {
    try {
      return Calendar(
        id: json['id'] ?? (throw FormatException('Missing field: id in Calendar')),
        name: json['name'] ?? (throw FormatException('Missing field: name in Calendar')),
        publicUrl: json['public'],
        adminUrl: json['admin'],
      );
    } catch (e) {
      throw FormatException('Error parsing Calendar JSON: \$e');
    }
  }
}

class FutureDate {
  final int eventId;
  final DateTime start;

  FutureDate({
    required this.eventId,
    required this.start,
  });

  factory FutureDate.fromJson(Map<String, dynamic> json) {
    try {
      return FutureDate(
        eventId: json['event_id'] ?? (throw FormatException('Missing field: event_id in FutureDate')),
        start: json['start'] != null ? DateTime.parse(json['start']) : (throw FormatException('Missing or invalid field: start in FutureDate')),
      );
    } catch (e) {
      throw FormatException('Error parsing FutureDate JSON: \$e');
    }
  }
}


 */

class Album {
  final int id;
  final String title;
  final bool allday;
  final DateTime start;
  final DateTime end;
  final String description;
  final String? publicUrl;
  final String? adminUrl;
  final Location? location;
  final List<Category> categories;
  final Owner owner;
  final Calendar calendar;
  final String? seats;
  final bool registration;
  final String color;
  final String featuredImage;
  final List<FutureDate> futureDates;

  Album({
    required this.id,
    required this.title,
    required this.allday,
    required this.start,
    required this.end,
    required this.description,
    this.publicUrl,
    this.adminUrl,
    this.location,
    required this.categories,
    required this.owner,
    required this.calendar,
    this.seats,
    required this.registration,
    required this.color,
    required this.featuredImage,
    required this.futureDates,
  });

  factory Album.fromJson(Map<String, dynamic> json) {
    try {
      return Album(
        id: json['id'],
        title: json['title'],
        allday: json['allday'],
        start: DateTime.parse(json['start']),
        end: DateTime.parse(json['end']),
        description: json['description'],
        publicUrl: json['public'],
        adminUrl: json['admin'],
        location: json['location'] != null
            ? Location.fromJson(json['location'])
            : null,
        categories: (json['category'] as List)
            .map((e) => Category.fromJson(e))
            .toList(),
        owner: Owner.fromJson(json['owner']),
        calendar: Calendar.fromJson(json['calendar']),
        seats: json['seats'],
        registration: json['registration'],
        color: json['color'],
        featuredImage: json['featured_image'],
        futureDates: (json['future_dates'] as List)
            .map((e) => FutureDate.fromJson(e))
            .toList(),
      );
    } catch (e) {
      throw const FormatException('Error parsing Album JSON: \$e');
    }
  }
}

class Location {
  final int id;
  final int type;
  final String name;
  final String? campus;

  Location({
    required this.id,
    required this.type,
    required this.name,
    this.campus,
  });

  factory Location.fromJson(Map<String, dynamic> json) {
    try {
      return Location(
        id: json['id'],
        type: json['type'],
        name: json['name'],
        campus: json['campus'],
      );
    } catch (e) {
      throw const FormatException('Error parsing Location JSON: \$e');
    }
  }
}

class Category {
  final int id;
  final String name;

  Category({
    required this.id,
    required this.name,
  });

  factory Category.fromJson(Map<String, dynamic> json) {
    try {
      return Category(
        id: json['id'],
        name: json['name'],
      );
    } catch (e) {
      throw const FormatException('Error parsing Category JSON: \$e');
    }
  }
}

class Owner {
  final int id;
  final String name;

  Owner({
    required this.id,
    required this.name,
  });

  factory Owner.fromJson(Map<String, dynamic> json) {
    try {
      return Owner(
        id: json['id'],
        name: json['name'],
      );
    } catch (e) {
      throw const FormatException('Error parsing Owner JSON: \$e');
    }
  }
}

class Calendar {
  final int id;
  final String name;
  final String? publicUrl;
  final String? adminUrl;

  Calendar({
    required this.id,
    required this.name,
    this.publicUrl,
    this.adminUrl,
  });

  factory Calendar.fromJson(Map<String, dynamic> json) {
    try {
      return Calendar(
        id: json['id'],
        name: json['name'],
        publicUrl: json['public'],
        adminUrl: json['admin'],
      );
    } catch (e) {
      throw const FormatException('Error parsing Calendar JSON: \$e');
    }
  }
}

class FutureDate {
  final int eventId;
  final DateTime start;

  FutureDate({
    required this.eventId,
    required this.start,
  });

  factory FutureDate.fromJson(Map<String, dynamic> json) {
    try {
      return FutureDate(
        eventId: json['event_id'],
        start: DateTime.parse(json['start']),
      );
    } catch (e) {
      throw const FormatException('Error parsing FutureDate JSON: \$e');
    }
  }
}

void main() => runApp(const MyApp());

class MyApp extends StatefulWidget {
  const MyApp({super.key});

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  late Future<List<Album>> futureAlbums;

  @override
  void initState() {
    super.initState();
    futureAlbums = fetchAlbum();  // Fetch the list of albums (events)
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Fetch Data Example',
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
      ),
      home: Scaffold(
        appBar: AppBar(
          title: const Text('Fetch Data Example'),
        ),
        body: Center(
          child: FutureBuilder<List<Album>>(
            future: futureAlbums,
            builder: (context, snapshot) {
              if (snapshot.hasData) {
                final albums = snapshot.data!;
                return ListView.builder(
                  itemCount: albums.length,
                  itemBuilder: (context, index) {
                    return ListTile(
                      title: Text(albums[index].title),
                      subtitle: Text(albums[index].start.toString()),
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