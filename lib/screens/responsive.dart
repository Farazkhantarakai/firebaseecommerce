import 'package:firebase_ecommerce/screens/responsive/webScreen.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import 'responsive/mobileScreen.dart';

class Responsive extends StatelessWidget {
  const Responsive({super.key});

  @override
  Widget build(BuildContext context) {
    if (Get.width >= 600) {
      return const WebScreenLayout();
    } else {
      return const MobileScreenLayout();
    }
  }
}
