import 'package:firebase_ecommerce/utils/constants.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart' as fa;

import '../providers/bottomBar.dart';

class MainDrawer extends StatelessWidget {
  MainDrawer({super.key});

  final _controller = Get.put(BottomBarController());

  @override
  Widget build(BuildContext context) {
    return Drawer(
      backgroundColor: backAppColor,
      child: Column(
        mainAxisAlignment: MainAxisAlignment.spaceAround,
        children: [
          Column(
            children: [
              SizedBox(
                height: Get.height * 0.07,
              ),
              Card(
                elevation: 1,
                color: backAppColor,
                child: ListTile(
                  onTap: () {
                    _controller.changePage(0);
                  },
                  leading: const Icon(
                    Icons.home,
                    color: Colors.white,
                  ),
                  title: const Text(
                    'Home Screen',
                    style: TextStyle(color: Colors.white, fontSize: 18),
                  ),
                ),
              ),
              Card(
                elevation: 1,
                color: backAppColor,
                child: ListTile(
                  onTap: () {
                    _controller.changePage(0);
                  },
                  leading: const fa.FaIcon(
                    fa.FontAwesomeIcons.fileLines,
                    color: Colors.white,
                  ),
                  title: const Text(
                    'Order Screen',
                    style: TextStyle(color: Colors.white),
                  ),
                ),
              ),
              Card(
                elevation: 1,
                color: backAppColor,
                child: ListTile(
                  onTap: () {
                    _controller.changePage(0);
                  },
                  leading: const Icon(
                    Icons.favorite,
                    color: Colors.white,
                  ),
                  title: const Text(
                    'Favourite Screen',
                    style: TextStyle(color: Colors.white),
                  ),
                ),
              ),
              Card(
                elevation: 1,
                color: backAppColor,
                child: ListTile(
                  onTap: () {
                    _controller.changePage(0);
                  },
                  leading: const Icon(
                    Icons.person,
                    color: Colors.white,
                  ),
                  title: const Text(
                    'Profile Screen',
                    style: TextStyle(color: Colors.white),
                  ),
                ),
              ),
            ],
          ),
          Container(
            width: double.infinity,
            height: MediaQuery.of(context).size.height * 0.07,
            margin: const EdgeInsets.only(left: 10, right: 10),
            decoration: const BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.all(Radius.circular(10))),
            child: const Center(
              child: Text(
                'Log Out',
                style: TextStyle(
                    color: Colors.black,
                    fontSize: 16,
                    fontWeight: FontWeight.bold),
              ),
            ),
          )
        ],
      ),
    );
  }
}
