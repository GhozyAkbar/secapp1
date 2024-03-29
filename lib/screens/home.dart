import 'package:flutter/material.dart';
import 'package:resepin/screens/tabs_screen.dart';
import '../Models/meal.dart';
import '../data/dummy_data.dart';
import 'categories_screen.dart';
import 'category_meals_screen.dart';
import 'filters_screen.dart';
import 'meal_detail_screen.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({Key? key}) : super(key: key);

  @override
  _HomeScreen createState() => _HomeScreen();
}

class _HomeScreen extends State<HomeScreen> {
  Map<String, bool> _filters = {
    'gluten': false,
    'lactose': false,
    'vegetarian': false,
    'vegan': false,
  };
  List<Meal> _availableMeals = DUMMY_MEALS;
  List<Meal> _favoriteMeals = [];

  void _setFilters(Map<String, bool> filterData) {
    setState(() {
      _filters = filterData;
      _availableMeals = DUMMY_MEALS.where((meal) {
        if (_filters['gluten']! && !meal.isGlutenFree) {
          return false;
        }
        if (_filters['lactose']! && !meal.isLactoseFree) {
          return false;
        }
        if (_filters['vegan']! && !meal.isVegan) {
          return false;
        }
        if (_filters['vegetarian']! && !meal.isVegetarian) {
          return false;
        }
        return true;
      }).toList();
    });
  }

  void _toggleFavorite(String mealId) {
    final existingIndex =
        _favoriteMeals.indexWhere((meal) => meal.id == mealId);
    if (existingIndex >= 0) {
      setState(() {
        _favoriteMeals.removeAt(existingIndex);
      });
    } else {
      setState(() {
        _favoriteMeals.add(DUMMY_MEALS.firstWhere((meal) => meal.id == mealId));
      });
    }
  }

  bool isMealFavorite(String id) {
    return _favoriteMeals.any((meal) => meal.id == id);
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Resepin',
      theme: ThemeData(
        primarySwatch: Colors.deepPurple,
        colorScheme: ColorScheme.fromSwatch().copyWith(secondary: Colors.white),
        canvasColor: Colors.black,
        fontFamily: 'Raleway',
        textTheme: ThemeData.light().textTheme.copyWith(
            bodyText1: TextStyle(color: Colors.grey[800]),
            bodyText2: TextStyle(color: Color.fromARGB(255, 28, 28, 28)),
            headline6: const TextStyle(
                fontSize: 20,
                fontFamily: 'RobotoCondensed',
                fontWeight: FontWeight.bold)),
        appBarTheme: const AppBarTheme(
            backgroundColor: Colors.white,
            titleTextStyle: TextStyle(
                fontFamily: 'Raleway', fontSize: 24, color: Colors.black)),
      ),
      // home: CategoriesScreen(),
      initialRoute: '/',
      routes: {
        '/': ((context) => TabsScreen(_favoriteMeals)),
        CategoryMealsScreen.routeName: ((context) =>
            CategoryMealsScreen(_availableMeals)),
        // '/category-meals': ((context) => CategoryMealsScreen()),
        MealDetailScreen.routeName: (context) =>
            MealDetailScreen(_toggleFavorite, isMealFavorite),
        FiltersScreen.routeName: (context) =>
            FiltersScreen(_filters, _setFilters),
      },

      onUnknownRoute: (settings) {
        return MaterialPageRoute(builder: ((context) => CategoriesScreen()));
      },
    );
  }
}
