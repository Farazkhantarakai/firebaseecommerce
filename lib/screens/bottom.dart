import 'package:firebase_ecommerce/screens/Orders.dart';
import 'package:firebase_ecommerce/screens/favourite.dart';
import 'package:firebase_ecommerce/screens/home.dart';
import 'package:firebase_ecommerce/screens/profile.dart';
import 'package:firebase_ecommerce/utils/constants.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart' as fa;

class BottomBar extends StatefulWidget {
  const BottomBar({super.key});

  @override
  State<BottomBar> createState() => _BottomBarState();
}

class _BottomBarState extends State<BottomBar> {
  final _page = const [
    HomeScreen(),
    OrderScreen(),
    FavouriteScreen(),
    Profile()
  ];
  int _index = 0;
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
              currentIndex: _index,
              onTap: (int index) {
                setState(() {
                  _index = index;
                });
              },
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
      body: _page[_index],
    );
  }
}
