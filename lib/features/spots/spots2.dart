import 'package:flutter/material.dart';
import 'package:flutter_map/flutter_map.dart';
import 'package:location/location.dart';
import 'package:latlong2/latlong.dart';

class SpotsPage extends StatefulWidget {
  const SpotsPage({super.key});

  @override
  _SpotsPageState createState() => _SpotsPageState();
}

class _SpotsPageState extends State<SpotsPage> {

  final List<Map<String, dynamic>> markersData = [
    {
      'name': 'Concordia LB Library',
      'lat': 45.496897262275894,
      'lng': -73.57803940368039,
      'icon': Icons.location_on,
      'color': Colors.purple,
    },
    {
      'name': 'JMSB',
      'lat': 45.49549875350397,
      'lng': -73.5791596854202,
      'icon': Icons.location_pin,
      'color': Colors.purple,
    },
    {
      'name': 'EV Building',
      'lat': 45.49750,
      'lng': -73.57750,
      'icon': Icons.business,
      'color': Colors.grey,
    },
    {
      'name': 'Hall Building',
      'lat': 45.49650,
      'lng': -73.57820,
      'icon': Icons.school,
      'color': Colors.red,
    },
    {
      'name': 'Bibliothèque et Archives nationales du Québec (BAnQ)',
      'lat': 45.50050,
      'lng': -73.57100,
      'icon': Icons.library_books,
      'color': Colors.blue,
    },
  ];
  final Location _location = Location();
  final MapController _mapController = MapController();
  LatLng? _currentLocation;
  bool _isLocationFetched = false;

  @override
  void initState() {
    super.initState();
    _getLocation();
  }

  Future<void> _getLocation() async {
    try {
      bool serviceEnabled = await _location.serviceEnabled();
      if (!serviceEnabled) {
        serviceEnabled = await _location.requestService();
        if (!serviceEnabled) {
          return;
        }
      }

      PermissionStatus permissionGranted = await _location.hasPermission();
      if (permissionGranted == PermissionStatus.denied) {
        permissionGranted = await _location.requestPermission();
        if (permissionGranted != PermissionStatus.granted) {
          return;
        }
      }

      LocationData locationData = await _location.getLocation();

      setState(() {
        _currentLocation = LatLng(locationData.latitude!, locationData.longitude!);
        _isLocationFetched = true;
      });

      _mapController.move(_currentLocation!, 14); // Adjust initial zoom
    } catch (e) {
      print("Error fetching location: $e");
    }
  }

  // Method to move map to center the user's location
  void _centerOnUserLocation() {
    if (_currentLocation != null) {
      _mapController.move(_currentLocation!, 16); // Move map back to current location with zoom
    }
  }

  // Method to show the place's name when a marker is tapped
  void _showPlaceName(BuildContext context, String placeName) {
    showModalBottomSheet(
      context: context,
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(top: Radius.circular(20.0)),
      ),
      builder: (BuildContext context) {
        return Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              Text(
                placeName,
                style: const TextStyle(
                  fontSize: 20.0,
                  fontWeight: FontWeight.bold,
                ),
              ),
              const SizedBox(height: 12.0),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: <Widget>[
                  const Text(
                    'Share this spot:',
                    style: TextStyle(
                      fontSize: 16.0,
                      color: Colors.black,
                    ),
                  ),
                  IconButton(
                    icon: const Icon(Icons.share_location),
                    onPressed: () {
                      // In a real implementation, you would add sharing logic here.
                      print("Share button tapped for $placeName");
                      Navigator.of(context).pop(); // Optionally dismiss after "sharing"
                    },
                  ),
                ],
              ),
              const SizedBox(height: 16.0),
              Align(
                alignment: Alignment.centerRight,
                child: TextButton(
                  onPressed: () {
                    Navigator.of(context).pop();
                  },
                  child: const Text('OK'),
                ),
              ),
            ],
          ),
        );
      },
    );
  }  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Study Spots'),
        automaticallyImplyLeading: false,
      ),
      body: _isLocationFetched
          ? FlutterMap(
        mapController: _mapController,
        options: MapOptions(
          initialCenter: _currentLocation ?? const LatLng(0, 0), // Provide a fallback if null
          initialZoom: 16.0,
          minZoom: 10.0, // Minimum zoom level
          maxZoom: 18.0, // Maximum zoom level
          interactionOptions: const InteractionOptions(
              flags: InteractiveFlag.pinchZoom | InteractiveFlag.drag),
          onTap: (_, __) {}, // Disable map tap to prevent accidental map move
        ),
        children: [
          TileLayer(
            urlTemplate: "https://{s}.basemaps.cartocdn.com/light_all/{z}/{x}/{y}.png",
            subdomains: ['a', 'b', 'c'],
          ),
          MarkerLayer(
            markers: [
              if (_currentLocation != null)
                Marker(
                  point: _currentLocation!,
                  child: const Icon(
                    Icons.accessibility_new_rounded,
                    color: Colors.red,
                    size: 40,
                  ),
                ),
              ...markersData.map((markerData) {
                return Marker(
                  point: LatLng(markerData['lat'], markerData['lng']),
                  width: 80,
                  height: 80,
                  child: GestureDetector(
                    onTap: () {
                      _showPlaceName(context, markerData['name']);
                    },
                    child: Icon(
                      markerData['icon'],
                      size: 40,
                      color: markerData['color'],
                    ),
                  ),
                );
              }),
            ],
          ),
        ],
      )
          : const Center(child: CircularProgressIndicator(color: Colors.black,)),
      floatingActionButton: _isLocationFetched
          ? FloatingActionButton(
        onPressed: _centerOnUserLocation,
        tooltip: "Center on user location",
        backgroundColor: Colors.white,
        child: const Icon(Icons.my_location),
      )
          : null, // Show FAB only after location is fetched
    );
  }
}