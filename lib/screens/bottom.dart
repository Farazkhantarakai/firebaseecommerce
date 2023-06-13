import 'package:firebase_ecommerce/screens/OrderScreen.dart';
import 'package:firebase_ecommerce/screens/favourite.dart';
import 'package:firebase_ecommerce/screens/home.dart';
import 'package:firebase_ecommerce/screens/profile.dart';
import 'package:firebase_ecommerce/utils/constants.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart' as fa;
import 'package:get/get.dart';

import '../providers/bottomBar.dart';

class BottomBar extends StatefulWidget {
  const BottomBar({super.key});

  @override
  State<BottomBar> createState() => _BottomBarState();
}

class _BottomBarState extends State<BottomBar> {
  final BottomBarController _controller = Get.put(BottomBarController());
  final _page = const [
    HomeScreen(),
    OrderScreen(),
    FavouriteScreen(),
    Profile()
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: backAppColor,
      bottomNavigationBar: ClipRRect(
        borderRadius: const BorderRadius.only(
          topLeft: Radius.circular(20.0),
          topRight: Radius.circular(20.0),
        ),
        child: Container(
          height: MediaQuery.of(context).size.height * 0.1,
          decoration: const BoxDecoration(),
          child: BottomNavigationBar(
              type: BottomNavigationBarType.fixed,
              backgroundColor: blackColor,
              selectedItemColor: yellowColor,
              unselectedItemColor: const Color.fromARGB(255, 180, 170, 170),
              currentIndex: _controller.currentIndex.value,
              onTap: _controller.changePage,
              items: const [
                BottomNavigationBarItem(icon: Icon(Icons.home), label: 'Home'),
                BottomNavigationBarItem(
                    icon: fa.FaIcon(fa.FontAwesomeIcons.fileLines),
                    label: 'Orders'),
                BottomNavigationBarItem(
                    icon: Icon(Icons.favorite), label: 'Favourite'),
                BottomNavigationBarItem(
                    icon: Icon(Icons.person), label: 'Profile')
              ]),
        ),
      ),
      body: Obx(() => _page[_controller.currentIndex.value]),
    );
  }
}
