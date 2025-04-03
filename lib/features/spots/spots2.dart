import 'package:flutter/material.dart';
import 'package:flutter_map/flutter_map.dart';
import 'package:latlong2/latlong.dart';
import 'package:geolocator/geolocator.dart'; // Import geolocator

class SpotsPage extends StatefulWidget {
  const SpotsPage({super.key});

  @override
  State createState() => _SpotsPage();
}

class _SpotsPage extends State<SpotsPage> {
  // List of marker data (latitude, longitude, icon size, and color)
  final List<Map<String, dynamic>> markersData = [
    {
      // Concordia LB Library
      'lat': 45.496897262275894,
      'lng': -73.57803940368039,
      'icon': Icons.location_on,
      'color': Colors.purple,
    },
    {
      // JMSB
      'lat': 45.49549875350397,
      'lng': -73.5791596854202,
      'icon': Icons.location_pin,
      'color': Colors.purple,
    },
    {
      // Cafe Myriade
      'lat': 45.49617056163946,
      'lng': -73.57783838610834,
      'icon': Icons.location_on,
      'color': Colors.purple,
    },
    {
      // Hall Building
      'lat': 45.4972551775201,
      'lng': -73.57887262723726,
      'icon': Icons.location_pin,
      'color': Colors.purple,
    },
    {
      // Bibliothèque et Archives nationales du Québec (BAnQ)
      'lat': 45.518683,
      'lng': -73.561565,
      'icon': Icons.location_on,
      'color': Colors.purple,
    },
    {
      // Cafe Olimpico - Mile End
      'lat': 45.526279,
      'lng': -73.593798,
      'icon': Icons.location_on,
      'color': Colors.purple,
    },
    {
      // Dispatch Coffee - Old Montreal
      'lat': 45.502947,
      'lng': -73.553951,
      'icon': Icons.location_on,
      'color': Colors.purple,
    },
    {
      // McGill University McLennan Library
      'lat': 45.504284,
      'lng': -73.578964,
      'icon': Icons.location_on,
      'color': Colors.purple,
    },
    {
      // Cafe Résonance
      'lat': 45.517336,
      'lng': -73.570776,
      'icon': Icons.location_on,
      'color': Colors.purple,
    },
    {
      // Cafe Différance
      'lat': 45.522237,
      'lng': -73.587522,
      'icon': Icons.location_on,
      'color': Colors.purple,
    },
    // Add more markers here...
  ];

  // Variable to hold the current user location
  LatLng? _userLocation;

  // Function to get the user's current location
  Future<void> _getUserLocation() async {
    // Check if location services are enabled
    bool serviceEnabled = await Geolocator.isLocationServiceEnabled();
    if (!serviceEnabled) {
      print("Location services are disabled.");
      return;
    }

    // Request location permissions
    LocationPermission permission = await Geolocator.requestPermission();
    if (permission == LocationPermission.denied) {
      print("Location permissions denied.");
      return;
    }

    if (permission == LocationPermission.deniedForever) {
      print("Location permissions permanently denied.");
      return;
    }

    // Get current position
    Position position = await Geolocator.getCurrentPosition();
    print("User location: ${position.latitude}, ${position.longitude}"); // Debugging

    setState(() {
      _userLocation = LatLng(position.latitude, position.longitude);
    });
  }

  @override
  void initState() {
    super.initState();
    _getUserLocation(); // Get the user's location when the widget is created
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          FlutterMap(
            options: MapOptions(
              initialCenter: _userLocation ?? LatLng(45.497059, -73.578421), // Default to a fixed location if no location found
              initialZoom: 16,

            ),
            children: [
              TileLayer(
                urlTemplate: 'https://tile.openstreetmap.org/{z}/{x}/{y}.png',
                userAgentPackageName: 'com.example.app',
              ),
              MarkerLayer(
                markers: [
                  if (_userLocation != null)
                    Marker(
                      point: _userLocation!,
                      width: 80,
                      height: 80,
                      child: Icon(
                        Icons.location_history,  // Custom icon for the user location
                        size: 40,
                        color: Colors.blue,
                      ),
                    ),
                  ...markersData.map((markerData) {
                    return Marker(
                      point: LatLng(markerData['lat'], markerData['lng']),
                      width: 80,
                      height: 80,
                      child: Icon(
                        markerData['icon'],
                        size: 40,
                        color: markerData['color'],
                      ),
                    );
                  }).toList(),
                ],
              ),
            ],
          ),
        ],
      ),
    );
  }
}