import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:resepin/screens/login_screen.dart';
import 'package:resepin/screens/filters_screen.dart';
import 'package:google_fonts/google_fonts.dart';

class MainDrawer extends StatelessWidget {
  const MainDrawer({Key? key}) : super(key: key);

  Widget buildListTile(String title, IconData icon, Function() tapHandler) {
    return ListTile(
      leading: Icon(
        icon,
        size: 26,
      ),
      title: Text(
        title,
        style: GoogleFonts.quicksand(fontSize: 26),
      ),
      onTap: tapHandler,
    );
  }

  @override
  Widget build(BuildContext context) {
    return Drawer(
      child: Column(
        children: <Widget>[
          Container(
            height: 120,
            width: double.infinity,
            padding: EdgeInsets.all(20),
            alignment: Alignment.centerLeft,
            color: Colors.purple,
            child: Center(
              child: (Text(
                'Resepin',
                style:
                    GoogleFonts.concertOne(fontSize: 42, color: Colors.white),
              )),
            ),
          ),
          const SizedBox(
            height: 20,
          ),
          buildListTile('Meals', Icons.restaurant, () {
            Navigator.of(context).pushReplacementNamed('/');
          }),
          buildListTile('Filters', Icons.settings, () {
            Navigator.of(context).pushReplacementNamed(FiltersScreen.routeName);
          }),
          const Spacer(), // Menambahkan spacer untuk mendorong widget ke bawah

          buildListTile(
            'Logout',
            Icons.logout,
            () async {
              try {
                await FirebaseAuth.instance.signOut();
                // Navigate to appropriate screen after logout (e.g., login screen)
                Navigator.of(context).pushReplacement(
                  MaterialPageRoute(builder: (context) => const LoginScreen()),
                );
              } catch (error) {
                print(error); // Handle any errors here
              }
            },
          ),
        ],
      ),
    );
  }
}
