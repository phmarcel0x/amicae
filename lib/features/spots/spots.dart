import 'package:flutter/material.dart';

import 'package:flutter_map/flutter_map.dart';
import 'package:latlong2/latlong.dart';

class SpotsPage extends StatefulWidget {
  const SpotsPage({super.key});

  @override
  State createState() => _SpotsPage();
}

class _SpotsPage extends State<SpotsPage> {

  @override
  Widget build(BuildContext context) {
    return FlutterMap(
      options: MapOptions(
        initialCenter: LatLng(45.497059, -73.578421), // Center the map over Concordia University
        initialZoom: 16,
      ),
      children: [
        TileLayer( // Display map tiles from any source
          urlTemplate: 'https://tile.openstreetmap.org/{z}/{x}/{y}.png', // OSMF's Tile Server
          userAgentPackageName: 'com.example.app',
          // And many more recommended properties!
        ),
        // RichAttributionWidget( // Include a stylish prebuilt attribution widget that meets all requirments
        //   attributions: [
        //     TextSourceAttribution(
        //       'OpenStreetMap contributors',
        //       // onTap: () => launchUrl(Uri.parse('https://openstreetmap.org/copyright')), // (external)
        //     ),
        //     // Also add images...
        //   ],
        // ),
      ],
    );
  }
}