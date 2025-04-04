import 'package:flutter/material.dart';
import 'package:flutter_map/flutter_map.dart';
import 'package:location/location.dart';
import 'package:latlong2/latlong.dart';

class SpotsPage extends StatefulWidget {
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
      'name': 'Tim Hortons (Guy & de Maisonneuve)',
      'lat': 45.49580,
      'lng': -73.57850,
      'icon': Icons.coffee,
      'color': Colors.brown,
    },
    {
      'name': 'Starbucks (Guy & de Maisonneuve)',
      'lat': 45.49590,
      'lng': -73.57880,
      'icon': Icons.coffee,
      'color': Colors.green,
    },
    {
      'name': 'Second Cup (Guy & de Maisonneuve)',
      'lat': 45.49570,
      'lng': -73.57920,
      'icon': Icons.coffee,
      'color': Colors.orange,
    },
    {
      'name': 'Vanier Library',
      'lat': 45.49470,
      'lng': -73.57950,
      'icon': Icons.library_books,
      'color': Colors.blue,
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
      'name': 'Webster Library',
      'lat': 45.49700,
      'lng': -73.57880,
      'icon': Icons.library_books,
      'color': Colors.blue,
    },
    {
      'name': 'Oscar Peterson Concert Hall',
      'lat': 45.49600,
      'lng': -73.57780,
      'icon': Icons.music_note,
      'color': Colors.deepPurple,
    },
    {
      'name': 'Molson Building',
      'lat': 45.49520,
      'lng': -73.57900,
      'icon': Icons.business,
      'color': Colors.teal,
    },
    {
      'name': 'H-Building',
      'lat': 45.49630,
      'lng': -73.57850,
      'icon': Icons.school,
      'color': Colors.green,
    },
    {
      'name': 'Grey Nuns Residence',
      'lat': 45.49800,
      'lng': -73.58000,
      'icon': Icons.home,
      'color': Colors.indigo,
    },
    {
      'name': 'The Study Cafe',
      'lat': 45.49620,
      'lng': -73.57950,
      'icon': Icons.coffee,
      'color': Colors.brown,
    },
    {
      'name': 'Cafe Myriade',
      'lat': 45.49550,
      'lng': -73.57800,
      'icon': Icons.coffee,
      'color': Colors.brown,
    },
    {
      'name': 'Bibliothèque et Archives nationales du Québec (BAnQ)',
      'lat': 45.50050,
      'lng': -73.57100,
      'icon': Icons.library_books,
      'color': Colors.blue,
    },
    {
      'name': 'Atwater Library and Computer Centre',
      'lat': 45.49250,
      'lng': -73.58500,
      'icon': Icons.library_books,
      'color': Colors.blue,
    },
    {
      'name': 'Sentier des Faubourgs',
      'lat': 45.50150,
      'lng': -73.56800,
      'icon': Icons.park,
      'color': Colors.green,
    },
    {
      'name': 'Square Cabot',
      'lat': 45.49300,
      'lng': -73.58100,
      'icon': Icons.park,
      'color': Colors.green,
    },
    {
      'name': 'Cafe Depot',
      'lat': 45.49720,
      'lng': -73.57980,
      'icon': Icons.coffee,
      'color': Colors.brown,
    },
    {
      'name': 'Tim Hortons (Saint-Catherine)',
      'lat': 45.49820,
      'lng': -73.57900,
      'icon': Icons.coffee,
      'color': Colors.brown,
    },
    {
      'name': 'Starbucks (Saint-Catherine)',
      'lat': 45.49850,
      'lng': -73.57930,
      'icon': Icons.coffee,
      'color': Colors.green,
    },
    {
      'name': 'Cafe Aunja',
      'lat': 45.49500,
      'lng': -73.57700,
      'icon': Icons.coffee,
      'color': Colors.brown,
    },
    {
      'name': 'Cafe Noir',
      'lat': 45.49670,
      'lng': -73.57900,
      'icon': Icons.coffee,
      'color': Colors.brown,
    },
    {
      'name': 'Cafe Lola Rosa',
      'lat': 45.49780,
      'lng': -73.57830,
      'icon': Icons.restaurant,
      'color': Colors.orange,
    },
    {
      'name': 'Le Darling',
      'lat': 45.49900,
      'lng': -73.57750,
      'icon': Icons.restaurant,
      'color': Colors.orange,
    },
    {
      'name': 'Philemon Bar a Vin',
      'lat': 45.49880,
      'lng': -73.57800,
      'icon': Icons.wine_bar,
      'color': Colors.deepOrange,
    },
    {
      'name': 'Brasserie Harricana',
      'lat': 45.50000,
      'lng': -73.57600,
      'icon': Icons.local_bar,
      'color': Colors.deepOrange,
    },
    {
      'name': 'McGill University Library',
      'lat': 45.50400,
      'lng': -73.57800,
      'icon': Icons.library_books,
      'color': Colors.blue,
    },
    {
      'name': 'Cafe Sfouf',
      'lat': 45.49690,
      'lng': -73.57720,
      'icon': Icons.coffee,
      'color': Colors.brown,
    },
    {
      'name': 'Cafe Vito',
      'lat': 45.49730,
      'lng': -73.57870,
      'icon': Icons.coffee,
      'color': Colors.brown,
    },
    {
      'name': 'Cafe Creme',
      'lat': 45.49610,
      'lng': -73.57930,
      'icon': Icons.coffee,
      'color': Colors.brown,
    },
    {
      'name': 'Cafe Pixel',
      'lat': 45.49560,
      'lng': -73.57830,
      'icon': Icons.coffee,
      'color': Colors.brown,
    },
    {
      'name': 'Cafe Baba Yaga',
      'lat': 45.49480,
      'lng': -73.57970,
      'icon': Icons.coffee,
      'color': Colors.brown,
    },
    {
      'name': 'Cafe La Vieille Europe',
      'lat': 45.49390,
      'lng': -73.58010,
      'icon': Icons.coffee,
      'color': Colors.brown,
    },
    {
      'name': 'Cafe Tommy',
      'lat': 45.50300,
      'lng': -73.57400,
      'icon': Icons.coffee,
      'color': Colors.brown,
    },
    {
      'name': 'Cafe Dispatch',
      'lat': 45.50100,
      'lng': -73.57500,
      'icon': Icons.coffee,
      'color': Colors.brown,
    },
    {
      'name': 'Cafe Humble Lion',
      'lat': 45.50200,
      'lng': -73.57600,
      'icon': Icons.coffee,
      'color': Colors.brown,
    },
    {
      'name': 'Cafe Olimpico',
      'lat': 45.50500,
      'lng': -73.57700,
      'icon': Icons.coffee,
      'color': Colors.brown,
    },
    {
      'name': 'Cafe Myriade (Mackay)',
      'lat': 45.49710,
      'lng': -73.58020,
      'icon': Icons.coffee,
      'color': Colors.brown,
    },
    {
      'name': 'Cafe Kitsune',
      'lat': 45.50020,
      'lng': -73.57300,
      'icon': Icons.coffee,
      'color': Colors.brown,
    },
    {
      'name': 'Cafe Parvis',
      'lat': 45.49950,
      'lng': -73.57450,
      'icon': Icons.restaurant,
      'color': Colors.orange,
    },
    {
      'name': 'Cafe Santropol',
      'lat': 45.50120,
      'lng': -73.57200,
      'icon': Icons.restaurant,
      'color': Colors.orange,
    },
    {
      'name': 'Cafe Resonance',
      'lat': 45.50250,
      'lng': -73.57350,
      'icon': Icons.restaurant,
      'color': Colors.orange,
    },
    {
      'name': 'Cafe Chat l\'heureux',
      'lat': 45.50450,
      'lng': -73.57550,
      'icon': Icons.pets,
      'color': Colors.deepPurple,
    },
    {
      'name': 'Cafe Neon',
      'lat': 45.49890,
      'lng': -73.57780,
      'icon': Icons.coffee,
      'color': Colors.brown,
    },
    {
      'name': 'Cafe Melk',
      'lat': 45.49760,
      'lng': -73.57860,
      'icon': Icons.coffee,
      'color': Colors.brown,
    },
    {
      'name': 'Cafe Myriade (Clark)',
      'lat': 45.50350,
      'lng': -73.57150,
      'icon': Icons.coffee,
      'color': Colors.brown,
    },
    {
      'name': 'Cafe Bloom',
      'lat': 45.49530,
      'lng': -73.57770,
      'icon': Icons.coffee,
      'color': Colors.brown,
    },
    {
      'name': 'Cafe Pista',
      'lat': 45.49420,
      'lng': -73.57920,
      'icon': Icons.coffee,
      'color': Colors.brown,
    },

  ];
  Location _location = Location();
  MapController _mapController = MapController();
  LatLng? _currentLocation;
  bool _isLocationFetched = false;

  @override
  void initState() {
    super.initState();
    _getLocation();
  }

  Future<void> _getLocation() async {
    try {
      bool _serviceEnabled = await _location.serviceEnabled();
      if (!_serviceEnabled) {
        _serviceEnabled = await _location.requestService();
        if (!_serviceEnabled) {
          return;
        }
      }

      PermissionStatus _permissionGranted = await _location.hasPermission();
      if (_permissionGranted == PermissionStatus.denied) {
        _permissionGranted = await _location.requestPermission();
        if (_permissionGranted != PermissionStatus.granted) {
          return;
        }
      }

      LocationData _locationData = await _location.getLocation();

      setState(() {
        _currentLocation = LatLng(_locationData.latitude!, _locationData.longitude!);
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
      _mapController.move(_currentLocation!, 17); // Move map back to current location with zoom
    }
  }

  // Method to show the place's name when a marker is tapped
  void _showPlaceName(String placeName) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text(placeName),
          content: Row(
            children: [
              const Text(
                'Share Spot: ',
                style: TextStyle(
                  fontSize: 16,
                  fontWeight: FontWeight.w500,
                ),
              ),
              IconButton(
                onPressed: () {
                  // Add logic for sharing here if needed
                  print("Sharing location for $placeName");
                  Navigator.of(context).pop();
                },
                icon: Icon(Icons.share_location),  // Correcting the icon to `Icons.share`

              ),


            ],
          ),
          actions: [

            TextButton(
              style: TextButton.styleFrom(
                foregroundColor: Colors.black,
              ),
              onPressed: () {
                Navigator.of(context).pop();
              },
              child: Text('OK'),
            ),
          ],
        );
      },
    );
  }
  @override
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
          initialCenter: _currentLocation ?? LatLng(0, 0), // Provide a fallback if null
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
                      _showPlaceName(markerData['name']);
                    },
                    child: Icon(
                      markerData['icon'],
                      size: 40,
                      color: markerData['color'],
                    ),
                  ),
                );
              }).toList(),
            ],
          ),
        ],
      )
          : const Center(child: CircularProgressIndicator(color: Colors.black,)),
      floatingActionButton: _isLocationFetched
          ? FloatingActionButton(
        onPressed: _centerOnUserLocation,
        child: Icon(Icons.my_location),
        tooltip: "Center on user location",
        backgroundColor: Colors.white,
      )
          : null, // Show FAB only after location is fetched
    );
  }
}