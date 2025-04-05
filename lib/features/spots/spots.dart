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
      'color': Colors.black,
      'address': '1400 de Maisonneuve Blvd. W., Montreal, Quebec, Canada H3G 1M8',
      'details': 'The main library on Concordia\'s Sir George Williams Campus.',
    },
    {
      'name': 'JMSB',
      'lat': 45.49549875350397,
      'lng': -73.5791596854202,
      'icon': Icons.location_on,
      'color': Colors.black,
      'address': '1450 Guy Street, Montreal, QC H3H 0A1',
      'details': 'The John Molson School of Business building with study areas.',
    },
    {
      'name': 'EV Building',
      'lat': 45.49750,
      'lng': -73.57750,
      'icon': Icons.location_on,
      'color': Colors.black,
      'address': '1515 Ste-Catherine street West, Montreal, Quebec, Canada, H3G 1M8',
      'details': 'The Engineering, Computer Science and Visual Arts Integrated Complex.',
    },
    {
      'name': 'Hall Building',
      'lat': 45.49650,
      'lng': -73.57820,
      'icon': Icons.location_on,
      'color': Colors.black,
      'address': '1455 de Maisonneuve Boulevard West, Montreal, Quebec, Canada',
      'details': 'The Henry F. Hall Building with a reading room and greenhouse study space.',
    },
    {
      'name': 'BAnQ',
      'lat': 45.50050,
      'lng': -73.57100,
      'icon': Icons.location_on,
      'color': Colors.black,
      'address': '475, boulevard De Maisonneuve Est, Montréal, QC, H2L 5C4',
      'details': 'A large public library near Concordia.',
    },
    {
      'name': 'Anticafé Montreal',
      'lat': 45.5033,
      'lng': -73.5717,
      'icon': Icons.location_on,
      'color': Colors.black,
      'address': '294 Rue Sainte-Catherine Ouest, Montréal, QC H2X 2A1',
      'details': 'A pay-per-hour cafe with unlimited drinks and snacks.',
    },
    {
      'name': 'Leaves House McGill',
      'lat': 45.5038,
      'lng': -73.5773,
      'icon': Icons.location_on,
      'color': Colors.black,
      'address': '1800 McGill College Ave, Montreal, QC H3A 3J6',
      'details': 'A plant-filled cafe near McGill.',
    },
    {
      'name': 'Accio Cup',
      'lat': 45.4973,
      'lng': -73.5803,
      'icon': Icons.location_on,
      'color': Colors.black,
      'address': '2155 Rue Mackay, Montréal, QC H3G 2J2',
      'details': 'An Asian-inspired cafe near Concordia.',
    },
    {
      'name': 'Ri Yuè Ri Yuè',
      'lat': 45.5018,
      'lng': -73.5738,
      'icon': Icons.location_on,
      'color': Colors.black,
      'address': '1418 Rue Sainte-Catherine Ouest, Montréal, QC H3G 1S8',
      'details': 'A cafe with a zen ambiance.',
    },
    {
      'name': 'BHive Café',
      'lat': 45.5008,
      'lng': -73.5733,
      'icon': Icons.location_on,
      'color': Colors.black,
      'address': '1450 Rue Peel, Montréal, QC H3A 1T4',
      'details': 'A downtown cafe with many outlets.',
    },
    {
      'name': 'Café St-Henri',
      'lat': 45.5013,
      'lng': -73.5693,
      'icon': Icons.location_on,
      'color': Colors.black,
      'address': '3632 Rue Robert-Bourassa, Montréal, QC H3A 2M9',
      'details': 'A cafe with multiple locations, this one near downtown.',
    },
    {
      'name': 'Café La Finca',
      'lat': 45.5057,
      'lng': -73.5677,
      'icon': Icons.location_on,
      'color': Colors.black,
      'address': '1432 Rue Amherst, Montréal, QC H2L 3L3',
      'details': 'A downtown cafe with a welcoming ambiance.',
    },
    {
      'name': 'Cafe Myriade',
      'lat': 45.4978,
      'lng': -73.5798,
      'icon': Icons.location_on,
      'color': Colors.black,
      'address': '1432 Rue Mackay, Montréal, QC H3G 2H7',
      'details': 'A cafe with multiple locations, including Mackay St.',
    },
    {
      'name': 'Milton B',
      'lat': 45.5058,
      'lng': -73.5768,
      'icon': Icons.location_on,
      'color': Colors.black,
      'address': '3498 Avenue du Parc, Montréal, QC H2X 2H5',
      'details': 'A 24/7 urban cafeteria near McGill.',
    },
    {
      'name': 'La Poubelle Magnifique',
      'lat': 45.4993,
      'lng': -73.5763,
      'icon': Icons.location_on,
      'color': Colors.black,
      'address': '16 Rue Sainte-Catherine Ouest, Montréal, QC H2X 1Y3',
      'details': 'A cozy and affordable cafe.',
    },
    {
      'name': 'Café Cosé',
      'lat': 45.4853,
      'lng': -73.5613,
      'icon': Icons.location_on,
      'color': Colors.black,
      'address': '170 Rue Charron, Montréal, QC H3K 2P6',
      'details': 'A calm atmosphere cafe in Pointe-Saint-Charles.',
    },
    {
      'name': 'Café Redwood',
      'lat': 45.4864,
      'lng': -73.5684,
      'icon': Icons.location_on,
      'color': Colors.black,
      'address': '100 Rue Peel, Montréal, QC H3C 2G2',
      'details': 'A cafe with multiple locations.',
    },
    {
      'name': 'Le Petit Dep.',
      'lat': 45.4933,
      'lng': -73.5623,
      'icon': Icons.location_on,
      'color': Colors.black,
      'address': '179 Rue Peel, Montréal, QC H3C 2G8',
      'details': 'A cafe in Griffintown that can get crowded.',
    },
    {
      'name': 'Canard Café',
      'lat': 45.5068,
      'lng': -73.5828,
      'icon': Icons.location_on,
      'color': Colors.black,
      'address': '1800 Avenue McGill College, Montréal, QC H3A 3J6',
      'details': 'A cafe located near McGill.',
    },
    {
      'name': 'La Buvette du Dep',
      'lat': 45.5228,
      'lng': -73.5678,
      'icon': Icons.location_on,
      'color': Colors.black,
      'address': '3500 Rue Parc, Montréal, QC H2X 2H6',
      'details': 'A cafe on Parc Avenue.',
    },
    {
      'name': 'Café des habitudes',
      'lat': 45.5308,
      'lng': -73.6008,
      'icon': Icons.location_on,
      'color': Colors.black,
      'address': '1601 Rue Beaubien Est, Montréal, QC H2G 1L1',
      'details': 'A vegan cafe in Rosemont-La Petite-Patrie.',
    },
    {
      'name': 'Savsav',
      'lat': 45.4798,
      'lng': -73.5808,
      'icon': Icons.location_on,
      'color': Colors.black,
      'address': '170 Rue Wellington Ouest, Montréal, QC H2Z 1H6',
      'details': 'An aesthetically pleasing, productivity-focused cafe.',
    },
    {
      'name': 'Café Sfouf',
      'lat': 45.5168,
      'lng': -73.5588,
      'icon': Icons.location_on,
      'color': Colors.black,
      'address': '125 Rue Jean-Talon Est, Montréal, QC H2R 1S8',
      'details': 'A Lebanese-inspired, dog-friendly cafe.',
    },
    {
      'name': 'Atomic Cafe',
      'lat': 45.5206,
      'lng': -73.5516,
      'icon': Icons.location_on,
      'color': Colors.black,
      'address': '3606 Rue Ontario Est, Montréal, QC H1W 1R6',
      'details': 'A retro-vintage cafe that stays open late.',
    },
    {
      'name': 'Cafe Olimpico',
      'lat': 45.5198,
      'lng': -73.5888,
      'icon': Icons.location_on,
      'color': Colors.black,
      'address': '124 Rue Prince Arthur Ouest, Montréal, QC H2X 1S4',
      'details': 'A cafe with multiple locations, some open late.',
    },
    {
      'name': 'McGill University Library',
      'lat': 45.5047,
      'lng': -73.5788,
      'icon': Icons.location_on,
      'color': Colors.black,
      'address': '3459 McTavish St, Montreal, QC H3A 0C9',
      'details': 'The main library at nearby McGill University.',
    },
    {
      'name': 'Birks Reading Room',
      'lat': 45.5038,
      'lng': -73.5783,
      'icon': Icons.location_on,
      'color': Colors.black,
      'address': 'McLennan Library Building, McGill University',
      'details': 'A silent study room in McGill\'s McLennan Library Building.',
    },
    {
      'name': 'HSSL McGill',
      'lat': 45.5033,
      'lng': -73.5788,
      'icon': Icons.location_on,
      'color': Colors.black,
      'address': 'McLennan Library Building, McGill University',
      'details': 'The Humanities and Social Sciences Library at McGill.',
    },
    {
      'name': 'Law Library McGill',
      'lat': 45.5023,
      'lng': -73.5793,
      'icon': Icons.location_on,
      'color': Colors.black,
      'address': 'Nahum Gelber Law Library, McGill University',
      'details': 'The Nahum Gelber Law Library at McGill.',
    },
    {
      'name': 'Schulich Library',
      'lat': 45.5063,
      'lng': -73.5783,
      'icon': Icons.location_on,
      'color': Colors.black,
      'address': 'Macdonald Engineering Building, McGill University',
      'details': 'McGill\'s library for physical sciences, life sciences, and engineering.',
    },
    {
      'name': 'Blackader-Lauterman Library',
      'lat': 45.5030,
      'lng': -73.5795,
      'icon': Icons.location_on,
      'color': Colors.black,
      'address': 'Redpath Library Building, McGill University',
      'details': 'McGill\'s library for architecture and art.',
    },
    {
      'name': 'Islamic Studies Library',
      'lat': 45.5003,
      'lng': -73.5768,
      'icon': Icons.location_on,
      'color': Colors.black,
      'address': 'Morrice Hall, McGill University',
      'details': 'McGill\'s library focused on Islamic Studies.',
    },
    {
      'name': 'Music Library McGill',
      'lat': 45.5035,
      'lng': -73.5760,
      'icon': Icons.location_on,
      'color': Colors.black,
      'address': 'Strathcona Music Building, McGill University',
      'details': 'McGill\'s library dedicated to music.',
    },
    {
      'name': 'Osler Library',
      'lat': 45.5030,
      'lng': -73.5798,
      'icon': Icons.location_on,
      'color': Colors.black,
      'address': 'McIntyre Medical Building, McGill University',
      'details': 'McGill\'s library for the history of medicine.',
    },
    {
      'name': 'Rare Books McGill',
      'lat': 45.5030,
      'lng': -73.5795,
      'icon': Icons.location_on,
      'color': Colors.black,
      'address': 'Redpath Library Building, McGill University',
      'details': 'The Rare Books and Special Collections at McGill Library.',
    },
    {
      'name': 'Education CRC McGill',
      'lat': 45.5028,
      'lng': -73.5778,
      'icon': Icons.location_on,
      'color': Colors.black,
      'address': 'Education Building, McGill University',
      'details': 'McGill\'s Education Curriculum Resources Centre.',
    },
    {
      'name': 'Montreal Public Library Central',
      'lat': 45.5075,
      'lng': -73.5530,
      'icon': Icons.location_on,
      'color': Colors.black,
      'address': '227 Rue Sainte-Catherine Est, Montréal, QC H2X 1L7',
      'details': 'The central branch of the Montreal Public Library.',
    },
    {
      'name': 'Atwater Library',
      'lat': 45.4950,
      'lng': -73.5820,
      'icon': Icons.location_on,
      'color': Colors.black,
      'address': '1200 Atwater Ave, Westmount, QC H3Z 1X4',
      'details': 'The Atwater Library of Literacy in Westmount.',
    },
    {
      'name': 'Saint-Sulpice Library',
      'lat': 45.5180,
      'lng': -73.5670,
      'icon': Icons.location_on,
      'color': Colors.black,
      'address': '1700 Rue Saint-Denis, Montréal, QC H2X 3K6',
      'details': 'A branch of the Montreal Public Library.',
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
  void _showPlaceDetails(BuildContext context, Map<String, dynamic> placeData) {
    showModalBottomSheet(
      context: context,
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(top: Radius.circular(20.0)),
      ),
      backgroundColor: Colors.white, // Set the background color of the bottom sheet
      builder: (BuildContext context) {
        return Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              Text(
                placeData['name'] ?? 'No Name',
                style: const TextStyle(
                  fontSize: 20.0,
                  fontWeight: FontWeight.bold,
                ),
              ),
              const SizedBox(height: 8.0),
              if (placeData.containsKey('address') && placeData['address'] != null)
                Text(
                  placeData['address'],
                  style: const TextStyle(
                    fontSize: 14.0,
                    color: Colors.grey,
                  ),
                ),
              const SizedBox(height: 16.0),
              if (placeData.containsKey('details') && placeData['details'] != null)
                Text(
                  placeData['details'],
                  style: const TextStyle(
                    fontSize: 16.0,
                  ),
                ),
              const SizedBox(height: 16.0),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: <Widget>[
                  ElevatedButton(
                      style: ElevatedButton.styleFrom(
                        backgroundColor: Colors.white,
                        foregroundColor: Colors.black,
                        side: const BorderSide(color: Colors.black, width: 2.0), // Add black border
                      ),
                      onPressed: () {
                        print("Share button tapped");
                      },
                      child: const Text("Share this spot")
                  ),
                  ElevatedButton(
                      style: ElevatedButton.styleFrom(
                        backgroundColor: Colors.black,
                        foregroundColor: Colors.white,

                      ),
                      onPressed: () {
                        Navigator.of(context).pop();
                      },
                      child: const Text("OK")
                  ),

                ],

              ),
              const SizedBox(height: 16.0),
            ],
          ),
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
                    Icons.person_pin_circle_rounded,
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
                      _showPlaceDetails(context, markerData);
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
        tooltip: "Return to user location",
        backgroundColor: Colors.white,

        child: const Icon(Icons.my_location),
      )
          : null, // Show FAB only after location is fetched
    );
  }
}