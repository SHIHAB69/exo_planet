// planet_detail_page.dart
import 'package:flutter/material.dart';
import 'package:zoom_widget/zoom_widget.dart'; // For zooming capabilities
import 'package:shared_preferences/shared_preferences.dart'; // For saving favorites and constellations

class PlanetDetailPage extends StatefulWidget {
  final String planetName;
  final String skyImage;

  PlanetDetailPage({required this.planetName, required this.skyImage});

  @override
  _PlanetDetailPageState createState() => _PlanetDetailPageState();
}

class _PlanetDetailPageState extends State<PlanetDetailPage> {
  bool _isFavorite = false;

  @override
  void initState() {
    super.initState();
    _checkIfFavorite();
  }

  Future<void> _checkIfFavorite() async {
    final prefs = await SharedPreferences.getInstance();
    final favorites = prefs.getStringList('favorites') ?? [];
    setState(() {
      _isFavorite = favorites.contains(widget.planetName);
    });
  }

  Future<void> _toggleFavorite() async {
    final prefs = await SharedPreferences.getInstance();
    final favorites = prefs.getStringList('favorites') ?? [];

    if (_isFavorite) {
      favorites.remove(widget.planetName);
    } else {
      favorites.add(widget.planetName);
    }

    await prefs.setStringList('favorites', favorites);
    setState(() {
      _isFavorite = !_isFavorite;
    });
  }

  Future<void> _createConstellation() async {
    final prefs = await SharedPreferences.getInstance();
    final constellations = prefs.getStringList('constellations') ?? [];

    if (!constellations.contains(widget.planetName)) {
      constellations.add(widget.planetName);
      await prefs.setStringList('constellations', constellations);
      // Show confirmation message
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Constellation created!')),
      );
    } else {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Constellation already exists!')),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.planetName),
        actions: [
          IconButton(
            icon: Icon(
              _isFavorite ? Icons.favorite : Icons.favorite_border,
              color: _isFavorite ? Colors.red : null,
            ),
            onPressed: _toggleFavorite,
          ),
          IconButton(
            icon: Icon(Icons.star_border),
            onPressed: _createConstellation,
          ),
        ],
      ),
      body: Stack(
        children: [
          Zoom(
            maxZoomWidth: 1800,
            maxZoomHeight: 1800,
            backgroundColor: Colors.black, // Set a background color to enhance visibility
            child: Image.asset(
              widget.skyImage,
              fit: BoxFit.contain, // Use BoxFit to properly scale the image
              width: double.infinity,
              height: double.infinity,
              errorBuilder: (context, error, stackTrace) {
                // Display an error message if the image fails to load
                return Center(
                  child: Text(
                    'Failed to load image',
                    style: TextStyle(color: Colors.white, fontSize: 18),
                  ),
                );
              },
            ),
          ),
          Positioned(
            top: 16,
            left: 16,
            child: Container(
              padding: EdgeInsets.all(8),
              color: Colors.black54,
              child: Text(
                'Primary system name: Kepler-22\n'
                    'Alternative system names: KOI-87, KIC 10593626\n'
                    'Right ascension: 19 16 52.1904\n'
                    'Declination: +47 53 03.9475\n'
                    'Distance [parsec]: 180.0\n'
                    'Distance [lightyears]: 587\n'
                    'Number of stars in system: 1\n'
                    'Number of planets in the system: 1',
                style: TextStyle(color: Colors.white),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
