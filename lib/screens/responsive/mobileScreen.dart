import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_ecommerce/screens/AuthScreens/signin.dart';
import 'package:firebase_ecommerce/screens/bottom.dart';
import 'package:flutter/material.dart';

class MobileScreenLayout extends StatelessWidget {
  const MobileScreenLayout({super.key});

  @override
  Widget build(BuildContext context) {
    return StreamBuilder(
      stream: FirebaseAuth.instance.authStateChanges(),
      builder: (BuildContext context, AsyncSnapshot<dynamic> snapshot) {
        if (snapshot.hasData) {
          return const BottomBar();
        } else {
          return const SignIn();
        }
      },
    );
  }
}
