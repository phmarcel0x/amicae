import 'package:flutter/material.dart';
import 'package:flutter_map/flutter_map.dart';
import 'package:latlong2/latlong.dart';

class SpotsPage extends StatefulWidget {
  const SpotsPage({super.key});

  @override
  State createState() => _SpotsPage();
}

class _SpotsPage extends State<SpotsPage> {
  // List of marker data (latitude, longitude, icon size, and color)
  final List<Map<String, dynamic>> markersData = [
    {
      'lat': 45.496887587705764,
      'lng': -73.57787953861875,
      'icon': Icons.location_on,
      'color': Colors.red,
    },
    {
      'lat': 45.497059,
      'lng': -73.578421,
      'icon': Icons.location_pin,
      'color': Colors.blue,
    },
    {
      'lat': 45.497059,
      'lng': -73.578421,
      'icon': Icons.location_on,
      'color': Colors.green,
    },
    {
      'lat': 45.497059,
      'lng': -73.578421,
      'icon': Icons.location_pin,
      'color': Colors.purple,
    },
    // Add more markers here...
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          FlutterMap(
            options: const MapOptions(
              initialCenter: LatLng(45.497059, -73.578421),
              initialZoom: 16,
            ),
            children: [
              TileLayer(
                urlTemplate: 'https://tile.openstreetmap.org/{z}/{x}/{y}.png',
                userAgentPackageName: 'com.example.app',
              ),
              MarkerLayer(
                markers: markersData.map((markerData) {
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
                }).toList(),  // Convert the generated markers to a list
              ),
            ],
          ),
        ],
      ),
    );
  }
}