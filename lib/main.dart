import 'dart:io';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:resepin/screens/home.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:resepin/screens/login_screen.dart';

// import './data/dummy_data.dart';
// import './screens/filters_screen.dart';
// import './screens/tabs_screen.dart';
// import './screens/meal_detail_screen.dart';
// import './screens/category_meals_screen.dart';
// import './screens/categories_screen.dart';
// import './Models/meal.dart';

// void main() => runApp(MyApp());

// class MyApp extends StatefulWidget {
//   const MyApp({Key? key}) : super(key: key);

//   @override
//   State<MyApp> createState() => _MyAppState();
// }

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  Platform.isAndroid
      ? await Firebase.initializeApp(
          options: const FirebaseOptions(
          apiKey: 'AIzaSyC4kYUegGAjU5t4eGYD9s28A-Vlc9Kwv7I',
          appId: '1:546688766919:android:57fba2adcfde5736adbfe2',
          messagingSenderId: '546688766919',
          projectId: 'resepin-9b834',
        ))
      : await Firebase.initializeApp();
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    FirebaseAuth auth = FirebaseAuth.instance;

    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Hello',
      theme: ThemeData(
        // primarySwatch: Colors.grey,
        primaryColor: Colors.deepPurple[400],
      ),
      home: StreamBuilder(
        stream: auth.authStateChanges(),
        builder: (context, snapshot) {
          print('state: ${snapshot.connectionState}');
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const Center(
              child: CircularProgressIndicator(),
            );
          } else if (snapshot.connectionState == ConnectionState.done ||
              snapshot.connectionState == ConnectionState.active) {
            if (snapshot.hasData) {
              return const HomeScreen();
            } else {
              return const LoginScreen();
            }
          } else {
            return Center(
              child: Text('State: ${snapshot.connectionState}'),
            );
          }
        },
      ),
    );
  }
}
