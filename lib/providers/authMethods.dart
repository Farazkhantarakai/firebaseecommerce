import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_ecommerce/utils/constants.dart';
import 'package:flutter/foundation.dart';
import 'package:google_sign_in/google_sign_in.dart';

class AuthMethods {
  final firebaseAuth = FirebaseAuth.instance;

  Future<String> signUpWithEmailAndPassword(
      String email, String password, String name, String phoneNumber) async {
    String response = '';
    try {
      UserCredential user = await firebaseAuth
          .createUserWithEmailAndPassword(email: email, password: password)
          .timeout(const Duration(milliseconds: 10000));

      await FirebaseFirestore.instance
          .collection('user')
          .doc(user.user!.uid)
          .set({
        "email": email,
        "name": name,
        "phoneNumber": phoneNumber,
        "userId": user.user!.uid,
        "imageUrl": ''
      }).then((value) {
        response = 'success';
      });
    } on FirebaseAuthException catch (err) {
      debugPrint(err.toString());
      showToast(err.toString());
      response = 'fail';
    }
    return response;
  }

  Future<String> signInWithEmail(String email, String password) async {
    String response = '';
    debugPrint('i am here');
    try {
      UserCredential user = await firebaseAuth
          .signInWithEmailAndPassword(email: email, password: password)
          .timeout(const Duration(milliseconds: 10000));
      if (user.user!.uid.isNotEmpty) {
        response = 'success';
      }
    } on FirebaseAuthException catch (err) {
      debugPrint(err.toString());
      showToast(err.toString());
      response = 'failure';
    }
    return response;
  }

  Future<String> googleSignInFunction() async {
    String response = '';
    GoogleSignInAccount? googleUser = await GoogleSignIn().signIn();

    GoogleSignInAuthentication? googleAuth = await googleUser?.authentication;
    AuthCredential credential = GoogleAuthProvider.credential(
        accessToken: googleAuth?.accessToken, idToken: googleAuth?.idToken);

    UserCredential user = await FirebaseAuth.instance
        .signInWithCredential(credential)
        .timeout(const Duration(milliseconds: 10000));

    if (user.user!.uid.isNotEmpty) {
      response = 'success';
      await FirebaseFirestore.instance
          .collection('user')
          .doc(user.user?.uid)
          .set({
        "email": user.user?.email,
        "name": user.user?.displayName,
        "phoneNumber": user.user?.phoneNumber,
        "userId": user.user!.uid,
        'imageUrl': '${user.user!.photoURL}'
      });
    }
    return response;
  }
}
