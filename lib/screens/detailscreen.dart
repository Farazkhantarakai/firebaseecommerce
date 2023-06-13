import 'package:firebase_ecommerce/models/cartitem.dart';
import 'package:firebase_ecommerce/providers/firestoreMethods.dart';
import 'package:firebase_ecommerce/screens/bottom.dart';
import 'package:firebase_ecommerce/screens/home.dart';
import 'package:firebase_ecommerce/utils/constants.dart';
import 'package:firebase_ecommerce/widgets/detailscreen/dAppBar.dart';
import 'package:firebase_ecommerce/widgets/detailscreen/gradientDetailAndPic.dart';
import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:get/get.dart';
import 'package:uuid/uuid.dart';
import '../providers/cart.dart';

class DetailScreen extends StatefulWidget {
  const DetailScreen({super.key});

  @override
  State<DetailScreen> createState() => _DetailScreenState();
}

class _DetailScreenState extends State<DetailScreen>
    with SingleTickerProviderStateMixin {
  final _firestoreController = Get.put(FirestoreMethods());
  late AnimationController _animationController;

  final _cartCont = Get.put(Cart());
  bool isLoading = false;

  @override
  void initState() {
    _animationController = AnimationController(
        vsync: this, duration: const Duration(milliseconds: 1200));

    super.initState();
  }

  @override
  void dispose() {
    _animationController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final id = ModalRoute.of(context)!.settings.arguments as int;

    final productItem = _firestoreController.getAllData
        .singleWhere((element) => element.id == id);

    return Scaffold(
      backgroundColor: backAppColor,
      body: SafeArea(
        child: isLoading
            ? SpinKitThreeBounce(
                size: 25, color: Colors.white, controller: _animationController)
            : Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  DetailScreenBar(
                    product: productItem,
                  ),
                  SizedBox(
                    height: Get.height * 0.02,
                  ),
                  Padding(
                    padding: const EdgeInsets.only(left: 12),
                    child: Text(
                      productItem.title!,
                      style: const TextStyle(
                          color: Colors.white,
                          fontSize: 18,
                          fontWeight: FontWeight.bold),
                    ),
                  ),
                  SizedBox(
                    height: Get.height * 0.02,
                  ),
                  Container(
                      width: double.infinity,
                      height: Get.height * 0.5,
                      decoration: const BoxDecoration(),
                      child: GradientDetailAndPic(
                        product: productItem,
                      )),
                  SizedBox(
                    height: Get.height * 0.03,
                  ),
                  Padding(
                    padding: const EdgeInsets.all(12),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        const Text(
                          'Ingredients',
                          style: TextStyle(
                              color: Colors.white,
                              fontSize: 19,
                              fontWeight: FontWeight.bold),
                        ),
                        SizedBox(
                          height: Get.height * 0.02,
                        ),
                        Text(
                          productItem.ingredients!,
                          style: const TextStyle(
                              color: whiteColor,
                              fontSize: 14,
                              fontWeight: FontWeight.bold),
                        ),
                        GestureDetector(
                          onTap: () async {
                            setState(() {
                              isLoading = true;
                            });
                            // CartItem cartItem = CartItem(
                            //   id: const Uuid().v4(),
                            //   imageUrl: productItem.imageUrl![0].toString(),
                            //   price: productItem.price.toString(),
                            //   prodId: productItem.id.toString(),
                            //   quantity: 1,
                            //   title: productItem.title,
                            // );
                            CartItem cartItem = CartItem(
                                const Uuid().v4(),
                                1,
                                productItem.id.toString(),
                                productItem.title,
                                productItem.imageUrl![0].toString(),
                                productItem.price.toString());

                            final response =
                                await _cartCont.addItemToCart(cartItem);
                            if (response == true) {
                              Fluttertoast.showToast(
                                  msg: 'Item Added Succefully',
                                  backgroundColor: blackColor);

                              _cartCont.getAllCartItem();
                              setState(() {
                                isLoading = false;
                              });
                              Get.to(() => const BottomBar());
                            } else {
                              setState(() {
                                isLoading = false;
                              });
                              Get.to(() => const BottomBar());
                            }
                          },
                          child: Container(
                            width: double.infinity,
                            height: Get.height * 0.06,
                            margin: const EdgeInsets.only(
                                top: 10, left: 2, right: 2),
                            decoration: const BoxDecoration(
                                color: yellowColor,
                                borderRadius:
                                    BorderRadius.all(Radius.circular(30))),
                            child: const Center(
                              child: Text(
                                'Add to Cart',
                                style: TextStyle(
                                    color: Color.fromARGB(255, 20, 77, 124),
                                    fontSize: 16,
                                    fontWeight: FontWeight.bold),
                              ),
                            ),
                          ),
                        )
                      ],
                    ),
                  )
                ],
              ),
      ),
    );
  }
}
