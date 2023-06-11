import 'package:firebase_ecommerce/providers/cart.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../controller/getLocation.dart';
import '../../screens/cartScreen.dart';
import '../../utils/constants.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart' as fa;

class HomeScreenBar extends StatefulWidget {
  const HomeScreenBar({super.key});

  @override
  State<HomeScreenBar> createState() => _HomeScreenBarState();
}

class _HomeScreenBarState extends State<HomeScreenBar> {
  final _locationController = Get.put(LocationD());
  final _cartController = Get.put(Cart());
  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        IconButton(
            onPressed: () {},
            icon: const Icon(
              Icons.menu,
              color: Color.fromARGB(216, 155, 153, 153),
            )),
        Column(
          children: [
            const Text(
              'Your Address',
              style: TextStyle(
                  color: whiteColor, fontSize: 11, fontWeight: FontWeight.bold),
            ),
            const SizedBox(
              height: 5,
            ),
            Row(
              children: [
                const fa.FaIcon(
                  fa.FontAwesomeIcons.locationDot,
                  color: yellowColor,
                  size: 13,
                ),
                const SizedBox(
                  width: 7,
                ),
                Obx(() => Text(
                      _locationController.getCityName,
                      style: const TextStyle(
                          color: Colors.white, fontWeight: FontWeight.bold),
                    ))
              ],
            ),
          ],
        ),
        Stack(
          children: [
            Positioned(
                right: 10,
                child: Obx(
                  () => _cartController.getCartItem.isNotEmpty
                      ? Text(
                          '${_cartController.getTotalLength}',
                          style: const TextStyle(
                              color: Colors.white,
                              fontWeight: FontWeight.bold,
                              fontSize: 16),
                        )
                      : const Text(
                          '0',
                          style: TextStyle(color: Colors.white),
                        ),
                )),
            IconButton(
                onPressed: () {
                  Get.to(() => const CartScreen());
                },
                icon: const Icon(
                  Icons.shopping_cart,
                  color: whiteColor,
                ))
          ],
        )
      ],
    );
  }
}
