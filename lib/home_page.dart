// home_page.dart
import 'package:flutter/material.dart';
import 'planet_detail_page.dart'; // Importing Planet Detail Page

class HomePage extends StatefulWidget {
  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  // Base planets list
  final List<String> basePlanetNames = [
    'Kepler-22b',
    'Kepler-69C',
    'Kepler-452b',
    'Kepler-62f',
    'Kepler-186f'
  ];

  final List<String> basePlanetImages = [
    'assets/kepler-22b.png',
    'assets/kepler-69c.png',
    'assets/kepler-452b.png',
    'assets/kepler-62f.png',
    'assets/kepler-186f.png'
  ];

  // Expanded lists by repeating the base list 10 times
  late List<String> planetNames;
  late List<String> planetImages;
  List<String> displayedPlanets = [];

  @override
  void initState() {
    super.initState();
    planetNames = List.generate(10, (index) => basePlanetNames).expand((x) => x).toList();
    planetImages = List.generate(10, (index) => basePlanetImages).expand((x) => x).toList();
    displayedPlanets = planetNames;
  }

  void searchPlanets(String query) {
    final suggestions = planetNames.where((planet) {
      final planetName = planet.toLowerCase();
      final input = query.toLowerCase();
      return planetName.contains(input);
    }).toList();

    setState(() {
      displayedPlanets = suggestions;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Exoplanet Explorer'),
      ),
      drawer: Drawer(
        child: ListView(
          padding: EdgeInsets.zero,
          children: <Widget>[
            DrawerHeader(
              decoration: BoxDecoration(
                color: Colors.blue,
              ),
              child: Text(
                'Menu',
                style: TextStyle(
                  color: Colors.white,
                  fontSize: 24,
                ),
              ),
            ),
            ListTile(
              leading: Icon(Icons.favorite),
              title: Text('Favorite Planets'),
              onTap: () {
                // Navigate to favorite planets
              },
            ),
            ListTile(
              leading: Icon(Icons.star),
              title: Text('Constellation View'),
              onTap: () {
                // Navigate to constellation view
              },
            ),
          ],
        ),
      ),
      body: SingleChildScrollView(
        child: Column(
          children: [
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: TextField(
                onChanged: searchPlanets,
                decoration: InputDecoration(
                  labelText: 'Search Planets',
                  border: OutlineInputBorder(),
                  prefixIcon: Icon(Icons.search),
                ),
              ),
            ),
            SizedBox(height: 8), // Add some spacing between search bar and list
            ListView.builder(
              itemCount: displayedPlanets.length,
              shrinkWrap: true, // Ensure ListView only takes up as much space as needed
              physics: NeverScrollableScrollPhysics(), // Disable scrolling within ListView
              itemBuilder: (context, index) {
                return ListTile(
                  leading: Image.asset(
                    planetImages[index],
                    width: 50, // Ensure width and height are set
                    height: 50,
                    errorBuilder: (context, error, stackTrace) {
                      return Icon(Icons.broken_image); // Handle missing image gracefully
                    },
                  ),
                  title: Text(displayedPlanets[index]),
                  onTap: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => PlanetDetailPage(
                          planetName: displayedPlanets[index],
                          skyImage: 'assets/skychartasset/kepler${(index % 5) + 1}.jpeg',
                        ),
                      ),
                    );
                  },
                );
              },
            ),
          ],
        ),
      ),
    );
  }
}
