import 'package:firebase_ecommerce/providers/cart.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:get/get.dart';
import '../utils/constants.dart';

class CustomAppBar extends StatefulWidget {
  const CustomAppBar({super.key});

  @override
  State<CustomAppBar> createState() => _CustomAppBarState();
}

class _CustomAppBarState extends State<CustomAppBar> {
  final cartController = Get.put(Cart());

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        IconButton(
            onPressed: () {
              Get.back();
            },
            icon: const Icon(
              Icons.arrow_back,
              color: whiteColor,
            )),
        const Text(
          'Cart',
          style: TextStyle(color: whiteColor, fontSize: 20),
        ),
        IconButton(
            onPressed: () {
              setState(() {
                if (cartController.getCartItem.isEmpty) {
                  Fluttertoast.showToast(
                      msg: 'Cart is Empty', backgroundColor: backAppColor);
                } else {
                  cartController.deleteItemsFromCart();
                  cartController.getAllCartItem();
                }
              });
            },
            icon: const Icon(
              Icons.delete,
              color: whiteColor,
            ))
      ],
    );
  }
}
