import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_ecommerce/screens/responsive.dart';
import 'package:firebase_ecommerce/utils/constants.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get_navigation/src/root/get_material_app.dart';
import 'package:flutter_stripe/flutter_stripe.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  if (kIsWeb) {
    await Firebase.initializeApp(
        options: const FirebaseOptions(
            apiKey: webApiKey,
            appId: '1:74657616142:web:861fe43a438f8028f1875f',
            messagingSenderId: '74657616142',
            projectId: 'fluttercommerce-2bf2f',
            measurementId: "G-CVD5K4SV9Y",
            storageBucket: "fluttercommerce-2bf2f.appspot.com",
            databaseURL:
                "https://fluttercommerce-2bf2f-default-rtdb.firebaseio.com",
            authDomain: "fluttercommerce-2bf2f.firebaseapp.com"));
  } else {
    await Firebase.initializeApp();
  }

  Stripe.publishableKey =
      'pk_test_51N1SG5HWB5SDvH3sT2neTO8ScQ54gBMLqHh2Sb758IWQLhhur4p3ZsKHcZSwzLrObb31iMODH1zRwCCwkTiEXWHq00edQWN4sL';

  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
      // theme: ThemeData(fontFamily: 'Roboto'),
      darkTheme: ThemeData(),
      theme: ThemeData(
          fontFamily: 'Roboto',
          appBarTheme: const AppBarTheme(
              iconTheme: IconThemeData(color: Colors.white),
              systemOverlayStyle: SystemUiOverlayStyle(
                  statusBarIconBrightness: Brightness.light))),
      home: const Scaffold(
        body: Responsive(),
      ),
    );
  }
}
