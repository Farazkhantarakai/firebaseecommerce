import 'package:firebase_ecommerce/models/product.dart';
import 'package:firebase_ecommerce/providers/cart.dart';
import 'package:flutter/material.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:get/get.dart';
import 'package:uuid/uuid.dart';

import '../../models/cartitem.dart';
import '../../screens/bottom.dart';
import '../../utils/constants.dart';

class MainScreenItem extends StatefulWidget {
  const MainScreenItem({super.key, required this.product});

  final Product product;

  @override
  State<MainScreenItem> createState() => _MainScreenItemState();
}

class _MainScreenItemState extends State<MainScreenItem> {
  final _cartCont = Get.put(Cart());

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        const Row(
          children: [
            Text(
              'Special Offer',
              style: TextStyle(
                  fontSize: 20,
                  color: Colors.white,
                  fontWeight: FontWeight.w600),
            )
          ],
        ),
        Stack(children: [
          Positioned(
              bottom: 1,
              left: 1,
              child: GestureDetector(
                onTap: () async {
                  CartItem cartItem = CartItem(
                      const Uuid().v4(),
                      1,
                      widget.product.id.toString(),
                      widget.product.title,
                      widget.product.imageUrl![0].toString(),
                      widget.product.price.toString());

                  final response = await _cartCont.addItemToCart(cartItem);
                  if (response == true) {
                    Fluttertoast.showToast(
                        msg: 'Item Added Succefully',
                        backgroundColor: blackColor);

                    _cartCont.getAllCartItem();
                  }
                },
                child: Container(
                  width: Get.width * 0.4,
                  height: Get.height * 0.06,
                  decoration: const BoxDecoration(
                      color: Color.fromARGB(224, 202, 186, 44),
                      borderRadius: BorderRadius.only(
                          topRight: Radius.circular(30),
                          bottomLeft: Radius.circular(20))),
                  child: const Center(
                    child: Text(
                      'Add to Cart',
                      style: TextStyle(
                          color: Color.fromARGB(255, 11, 40, 54),
                          fontSize: 15,
                          fontWeight: FontWeight.bold),
                    ),
                  ),
                ),
              )),
          Container(
            width: double.infinity,
            height: Get.height * 0.2,
            padding: const EdgeInsets.all(20),
            margin: const EdgeInsets.only(top: 10),
            decoration: const BoxDecoration(
                color: Colors.white24,
                borderRadius: BorderRadius.all(Radius.circular(20))),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Column(
                  children: [
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          widget.product.title!,
                          textAlign: TextAlign.end,
                          style: const TextStyle(
                              fontSize: 15,
                              fontWeight: FontWeight.bold,
                              color: Colors.white),
                        ),
                        SizedBox(
                          height: Get.height * 0.02,
                        ),
                        Row(
                          children: [
                            Text(
                              '${widget.product.rating}',
                              style: const TextStyle(color: whiteColor),
                            ),
                            const SizedBox(
                              width: 10,
                            ),
                            RatingBar.builder(
                                initialRating: widget.product.rating!,
                                itemSize: 17,
                                itemBuilder: (context, _) {
                                  return const Icon(
                                    Icons.star,
                                    color: yellowColor,
                                    size: 2,
                                  );
                                },
                                onRatingUpdate: (rating) {
                                  debugPrint(rating.toString());
                                })
                          ],
                        ),
                        SizedBox(
                          height: Get.height * 0.01,
                        ),
                        Text(
                          ' \$ ${widget.product.price}',
                          style: const TextStyle(
                            color: Colors.white,
                          ),
                        )
                      ],
                    )
                  ],
                ),
                Center(
                  child: Image.network(
                    '${widget.product.imageUrl![0]}',
                    scale: 1,
                    width: 120,
                    height: 120,
                  ),
                )
              ],
            ),
          ),
        ])
      ],
    );
  }
}
