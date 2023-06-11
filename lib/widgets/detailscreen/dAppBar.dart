import 'package:firebase_ecommerce/models/product.dart';
import 'package:firebase_ecommerce/providers/firestoreMethods.dart';
import 'package:firebase_ecommerce/utils/constants.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class DetailScreenBar extends StatefulWidget {
  const DetailScreenBar({
    super.key,
    required this.product,
  });

  final Product product;

  @override
  State<DetailScreenBar> createState() => _DetailScreenBarState();
}

class _DetailScreenBarState extends State<DetailScreenBar> {
  final fireController = Get.put(FirestoreMethods());

  @override
  Widget build(BuildContext context) {
    debugPrint(widget.product.isFavourite.toString());

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
          'Food Detail',
          style: TextStyle(
              color: whiteColor, fontWeight: FontWeight.w500, fontSize: 20),
        ),
        Container(
          margin: const EdgeInsets.only(right: 5),
          child: widget.product.isFavourite!
              ? const Icon(
                  Icons.favorite,
                  color: Colors.white,
                )
              : const Icon(
                  Icons.favorite,
                  color: whiteColor,
                ),
        )
      ],
    );
  }
}
