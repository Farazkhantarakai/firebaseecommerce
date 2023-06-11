import 'package:firebase_ecommerce/controller/getLocation.dart';
import 'package:firebase_ecommerce/providers/cart.dart';
import 'package:firebase_ecommerce/screens/bottom.dart';
import 'package:firebase_ecommerce/screens/checkoutscreen.dart';
import 'package:firebase_ecommerce/utils/constants.dart';
import 'package:firebase_ecommerce/widgets/addresTile.dart';
import 'package:firebase_ecommerce/widgets/appBar.dart';
import 'package:firebase_ecommerce/widgets/cartTile.dart';
import 'package:firebase_ecommerce/widgets/promo.dart';
import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:get/get.dart';

class CartScreen extends StatefulWidget {
  const CartScreen({super.key});

  @override
  State<CartScreen> createState() => _CartScreenState();
}

class _CartScreenState extends State<CartScreen>
    with SingleTickerProviderStateMixin {
  final TextEditingController _descriptionController = TextEditingController();
  final cartController = Get.put(Cart());
  final locationController = Get.put(LocationD());
  late AnimationController _animationController;
  String? promo = '';
  String? description = '';
  bool expanded = false;
  String? addressDetail = '';

  @override
  void initState() {
    super.initState();
    _animationController = AnimationController(
        vsync: this, duration: const Duration(milliseconds: 1200));
  }

  void changePromo(String enteredValue) {
    setState(() {
      promo = enteredValue;
      debugPrint(promo);
    });
  }

  void changeHeight(bool value) {
    setState(() {
      expanded = value;
      debugPrint('expanding ${expanded.toString()}');
    });
  }

  void addressDetails(String detail) {
    setState(() {
      addressDetail = detail;
      debugPrint(addressDetail);
    });
  }

  @override
  Widget build(BuildContext context) {
    final mdq = MediaQuery.of(context).size;

    return SafeArea(
      child: Scaffold(
        backgroundColor: backAppColor,
        body: SingleChildScrollView(
            child: Obx(
          () => cartController.getIsLoading == true
              ? Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    SpinKitThreeBounce(
                        size: 25,
                        color: Colors.white,
                        controller: _animationController),
                  ],
                )
              : Column(
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: [
                    const CustomAppBar(),
                    Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.start,
                        children: [
                          Container(
                              width: double.infinity,
                              height: expanded
                                  ? mdq.height * 0.2
                                  : mdq.height * 0.15,
                              decoration: const BoxDecoration(),
                              child: AddressTile(
                                changeTile: changeHeight,
                                addressDetail: addressDetails,
                              )),
                          Container(
                            width: double.infinity,
                            height: mdq.height * 0.3,
                            margin: const EdgeInsets.only(top: 10),
                            decoration: const BoxDecoration(),
                            child: const CartTile(),
                          ),
                          GestureDetector(
                            onTap: () {
                              Get.to(() => const BottomBar());
                            },
                            child: const Row(
                              children: [
                                Text(
                                  '+  ',
                                  style: TextStyle(
                                      color: yellowColor, fontSize: 25),
                                ),
                                Text(
                                  'Add new Items',
                                  style: TextStyle(
                                      color: yellowColor,
                                      fontSize: 17,
                                      fontWeight: FontWeight.w400),
                                )
                              ],
                            ),
                          ),
                        ],
                      ),
                    ),
                    PromoCode(
                      change: changePromo,
                    ),
                    SizedBox(
                      height: mdq.height * 0.02,
                    ),
                    const Row(
                      children: [
                        Text(
                          'Description',
                          textAlign: TextAlign.start,
                          style: TextStyle(
                              fontSize: 17,
                              color: Colors.white,
                              fontWeight: FontWeight.bold),
                        )
                      ],
                    ),
                    Container(
                      width: double.infinity,
                      height: mdq.height * 0.07,
                      margin: const EdgeInsets.all(4),
                      padding: const EdgeInsets.all(5),
                      decoration: const BoxDecoration(
                          color: blackColor,
                          borderRadius: BorderRadius.all(Radius.circular(10))),
                      child: TextField(
                        controller: _descriptionController,
                        cursorColor: Colors.white,
                        decoration: const InputDecoration(
                            border: InputBorder.none,
                            contentPadding: EdgeInsets.only(bottom: 10),
                            hintText:
                                'please write down any thing we should take into consideration',
                            hintStyle: TextStyle(
                                color: Color.fromARGB(115, 119, 117, 117),
                                fontSize: 13)),
                        style: const TextStyle(color: Colors.white),
                      ),
                    ),
                    SizedBox(
                      height: mdq.height * 0.02,
                    ),
                    Container(
                      padding: const EdgeInsets.all(10),
                      decoration: const BoxDecoration(),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          GestureDetector(
                            onTap: () {
                              if (cartController.getPromo.contains(promo)) {
                                if (cartController.getCartItem.isEmpty) {
                                  Fluttertoast.showToast(
                                      msg:
                                          'Cart Cannot be Empty,try to add some items in the cart');
                                } else {
                                  Get.to(() => const CheckOutScreen(),
                                      arguments: {
                                        "promo": promo!.trim(),
                                        "description":
                                            _descriptionController.text.trim(),
                                        "addressDetails": addressDetail!.trim(),
                                        "items": cartController
                                            .getCartItem.values
                                            .toList(),
                                        "totalPrice":
                                            cartController.getTotalPrice,
                                        "cityName":
                                            locationController.getCityName,
                                        "streetName":
                                            locationController.getStreetName,
                                      });
                                }
                              } else {
                                Fluttertoast.showToast(
                                    msg: 'Promo is invalid or expired',
                                    backgroundColor: backAppColor);
                              }
                            },
                            child: Container(
                              width: 200,
                              height: mdq.height * 0.07,
                              decoration: const BoxDecoration(
                                  color: yellowColor,
                                  borderRadius:
                                      BorderRadius.all(Radius.circular(20))),
                              child: const Center(
                                child: Text(
                                  'Confirm',
                                  style: TextStyle(
                                      color: Color.fromARGB(255, 15, 68, 112),
                                      fontSize: 17),
                                ),
                              ),
                            ),
                          ),
                          Column(
                            children: [
                              const Text(
                                'Total Price',
                                style: TextStyle(
                                    color: Color.fromARGB(225, 185, 185, 185),
                                    fontSize: 13),
                              ),
                              const SizedBox(
                                height: 1,
                              ),
                              Obx(() => Text(
                                    '\$  ${cartController.getTotalPrice}',
                                    style: const TextStyle(
                                        color: Colors.white,
                                        fontSize: 16,
                                        fontWeight: FontWeight.bold),
                                  ))
                            ],
                          )
                        ],
                      ),
                    )
                  ],
                ),
        )),
      ),
    );
  }
}
