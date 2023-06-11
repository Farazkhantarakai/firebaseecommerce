import 'package:firebase_ecommerce/models/cartitem.dart';
import 'package:firebase_ecommerce/providers/cart.dart';
import 'package:firebase_ecommerce/utils/constants.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class CartTile extends StatefulWidget {
  const CartTile({super.key});

  @override
  State<CartTile> createState() => _CartTileState();
}

class _CartTileState extends State<CartTile> {
  final cartController = Get.put(Cart());
  bool isLongPressed = false;

  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(builder: (context, constraints) {
      return Container(
        width: double.infinity,
        height: constraints.maxHeight,
        decoration: const BoxDecoration(),
        child: cartController.getCartItem.values.isEmpty
            ? const Center(
                child: Text(
                  'No item Added to Cart',
                  style: TextStyle(
                      color: Colors.white, fontWeight: FontWeight.bold),
                ),
              )
            : ListView.builder(
                itemCount: cartController.getCartItem.values.length,
                itemBuilder: (context, index) {
                  List<CartItem> cartItem =
                      cartController.getCartItem.values.toList();
                  CartItem cart = cartItem[index];

                  return GestureDetector(
                      onTap: () {
                        setState(() {
                          cart.changeCheck();
                          if (cart.isChecked == false) {
                            cartController
                                .removeProductId(cart.prodId.toString());
                          } else {
                            cartController.addProductId(cart.prodId.toString());
                          }
                        });
                      },
                      onLongPress: () {
                        setState(() {
                          cart.changeCheck();
                          if (cart.isChecked == true) {
                            cartController.addProductId(cart.prodId.toString());
                          } else {
                            cartController
                                .removeProductId(cart.prodId.toString());
                          }
                        });
                      },
                      child: Stack(
                        children: [
                          Container(
                            width: double.infinity,
                            height: constraints.maxHeight * 0.4,
                            padding: const EdgeInsets.all(10),
                            margin: const EdgeInsets.only(top: 10),
                            decoration: BoxDecoration(
                                color: cart.isChecked == true
                                    ? const Color.fromARGB(239, 184, 182, 182)
                                    : blackColor,
                                borderRadius: const BorderRadius.all(
                                    Radius.circular(10))),
                            child: Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                children: [
                                  Image.network(
                                    '${cart.imageUrl}',
                                    width: 100,
                                    height: 100,
                                  ),
                                  Column(
                                    children: [
                                      Text(
                                        '${cart.title}',
                                        style: const TextStyle(
                                            color: Colors.white,
                                            fontSize: 17,
                                            fontWeight: FontWeight.w300),
                                      ),
                                      GestureDetector(
                                        onTap: () {
                                          setState(() {
                                            cart.decreaseQuantity();

                                            CartItem cartItem = CartItem(
                                                cart.id,
                                                cart.quantity,
                                                cart.prodId,
                                                cart.title,
                                                cart.imageUrl,
                                                cart.price);
                                            cartController
                                                .updateCartProduct(cartItem);
                                            cartController.getTotalPrice;
                                          });
                                        },
                                        child: Container(
                                          decoration: const BoxDecoration(),
                                          child: Row(
                                            children: [
                                              const Text(
                                                '-',
                                                style: TextStyle(
                                                    color: Colors.white,
                                                    fontSize: 40),
                                              ),
                                              const SizedBox(
                                                width: 30,
                                              ),
                                              Column(
                                                children: [
                                                  Text(
                                                    '${cart.quantity}',
                                                    style: const TextStyle(
                                                        color: Colors.white),
                                                  ),
                                                ],
                                              ),
                                              const SizedBox(
                                                width: 30,
                                              ),
                                              Column(
                                                mainAxisAlignment:
                                                    MainAxisAlignment.center,
                                                children: [
                                                  GestureDetector(
                                                    onTap: () {
                                                      setState(() {
                                                        cart.increaseQuantity();
                                                        CartItem cartItem =
                                                            CartItem(
                                                                cart.id,
                                                                cart.quantity,
                                                                cart.prodId,
                                                                cart.title,
                                                                cart.imageUrl,
                                                                cart.price);
                                                        cartController
                                                            .updateCartProduct(
                                                                cartItem);
                                                        cartController
                                                            .getTotalPrice;
                                                      });
                                                    },
                                                    child: Container(
                                                      width: 20,
                                                      height: 20,
                                                      decoration:
                                                          const BoxDecoration(
                                                              color:
                                                                  yellowColor,
                                                              shape: BoxShape
                                                                  .rectangle),
                                                      child: const Center(
                                                          child: Text(
                                                        '+',
                                                        style: TextStyle(
                                                            fontWeight:
                                                                FontWeight.bold,
                                                            fontSize: 20),
                                                      )),
                                                    ),
                                                  ),
                                                ],
                                              )
                                            ],
                                          ),
                                        ),
                                      )
                                    ],
                                  ),
                                  Text(
                                    '\$ ${cart.price}',
                                    style: const TextStyle(
                                        color: Colors.white, fontSize: 14),
                                  )
                                ]),
                          ),
                        ],
                      ));
                }),
      );
    });
  }
}
