import 'package:firebase_auth/firebase_auth.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:resepin/auth/auth_service.dart';
import 'package:resepin/screens/home.dart';
import 'package:flutter/material.dart';

class CreateAccount extends StatefulWidget {
  const CreateAccount({Key? key}) : super(key: key);

  @override
  _CreateAccountState createState() => _CreateAccountState();
}

class _CreateAccountState extends State<CreateAccount> {
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();

  static GoogleSignIn googleSignIn = GoogleSignIn(
    scopes: ['email', 'https://www.googleapis.com/auth/contacts.readonly'],
  );

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      // appBar: AppBar(
      //   title: const Text('Create Account'),
      //   centerTitle: true,
      // ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Image.asset(
              'assets/images/signup.png',
              height: MediaQuery.of(context).size.height / 3,
              fit: BoxFit.cover,
            ),
            SizedBox(
              width: MediaQuery.of(context).size.width / 2,
              child: TextField(
                controller: _emailController,
                decoration: const InputDecoration(hintText: 'Email'),
              ),
            ),
            const SizedBox(
              height: 30.0,
            ),
            SizedBox(
              width: MediaQuery.of(context).size.width / 2,
              child: TextField(
                controller: _passwordController,
                obscureText: true,
                decoration: const InputDecoration(
                  hintText: 'Password',
                ),
              ),
            ),
            const SizedBox(
              height: 30.0,
            ),
            ElevatedButton(
              onPressed: () async {
                final message = await AuthService().registration(
                  email: _emailController.text,
                  password: _passwordController.text,
                );
                if (message!.contains('Success')) {
                  Navigator.of(context).pushReplacement(MaterialPageRoute(
                      builder: (context) => const HomeScreen()));
                }
                ScaffoldMessenger.of(context).showSnackBar(
                  SnackBar(
                    content: Text(message),
                  ),
                );
              },
              child: const Text('Sign Up'),
            ),
            const SizedBox(
              height: 10.0,
            ),
            ElevatedButton.icon(
              onPressed: () async {
                try {
                  await FirebaseAuth.instance.signInWithRedirect(
                    GoogleAuthProvider(),
                  );
                  FirebaseAuth.instance
                      .authStateChanges()
                      .listen((User? user) async {
                    if (user != null) {
                      final message =
                          'Sign Up with Google successful: ${FirebaseAuth.instance.currentUser!.displayName}';
                      ScaffoldMessenger.of(context).showSnackBar(
                        SnackBar(
                          content: Text(message),
                        ),
                      );
                      Navigator.of(context).pushReplacement(MaterialPageRoute(
                        builder: (context) => const HomeScreen(),
                      ));
                    } else {
                      ScaffoldMessenger.of(context).showSnackBar(
                        SnackBar(
                          content: Text('Sign-in failed. Please try again.'),
                        ),
                      );
                      // Optionally, log the error for debugging:
                      print(
                          'Sign-in failed with error: ${FirebaseAuth.instance.currentUser}');
                    }
                  });
                  // final message =
                  //     'Sign Up with Google successful: ${userCredential.user!.displayName}';
                  // ScaffoldMessenger.of(context).showSnackBar(
                  //   SnackBar(
                  //     content: Text(message),
                  //   ),
                  // );
                  // Navigator.of(context).pushReplacement(MaterialPageRoute(
                  //   builder: (context) => const HomeScreen(),
                  // ));
                } catch (error) {
                  ScaffoldMessenger.of(context).showSnackBar(
                    SnackBar(
                      content: Text('Sign Up with Google failed: $error'),
                    ),
                  );
                }
              },
              icon: Image.asset(
                'assets/images/google_logo.png',
                height: MediaQuery.of(context).size.height / 30,
                fit: BoxFit.cover,
              ),
              label: const Text('Sign Up with Google'),
            ),
          ],
        ),
      ),
    );
  }
}
