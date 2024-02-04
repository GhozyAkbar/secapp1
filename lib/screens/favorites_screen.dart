import 'package:flutter/material.dart';
import '../widgets/meal_item.dart';
import '../Models/meal.dart';

class FavoritesScreen extends StatelessWidget {
  final List<Meal> favoriteMeals;

  FavoritesScreen(this.favoriteMeals);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white, // Set background color to white
      body: favoriteMeals.isEmpty
          ? Center(
              child: Text(
                'You have no Favorites--Start Adding Some',
                style: TextStyle(color: Colors.grey[900], fontSize: 19),
              ),
            )
          : ListView.builder(
              itemBuilder: (ctx, index) {
                return MealItem(
                  id: favoriteMeals[index].id,
                  title: favoriteMeals[index].title,
                  imageUrl: favoriteMeals[index].imageUrl,
                  duration: favoriteMeals[index].duration,
                  complexity: favoriteMeals[index].complexity,
                  affordability: favoriteMeals[index].affordability,
                );
              },
              itemCount: favoriteMeals.length,
            ),
    );
  }
}
