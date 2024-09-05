// favorites_page.dart
import 'package:flutter/material.dart';

class FavoritesPage extends StatelessWidget {
  final List<String> favoritePlanets;

  FavoritesPage({required this.favoritePlanets});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Favorite Planets'),
      ),
      body: ListView.builder(
        itemCount: favoritePlanets.length,
        itemBuilder: (context, index) {
          return ListTile(
            title: Text(favoritePlanets[index]),
            onTap: () {
              // Navigate to the detail page of the selected favorite planet
            },
          );
        },
      ),
    );
  }
}
