import 'package:firebase_ecommerce/models/product.dart';
import 'package:firebase_ecommerce/providers/firestoreMethods.dart';
import 'package:firebase_ecommerce/screens/detailscreen.dart';
import 'package:firebase_ecommerce/utils/constants.dart';
import 'package:flutter/material.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';
import 'package:get/get.dart';

class FavouriteScreen extends StatefulWidget {
  const FavouriteScreen({super.key});

  @override
  State<FavouriteScreen> createState() => _FavouriteScreenState();
}

class _FavouriteScreenState extends State<FavouriteScreen>
    with SingleTickerProviderStateMixin {
  late AnimationController _animationController;
  late Animation _animation;
  final fireController = Get.put(FirestoreMethods());
  List<Product> _favouriteProduct = [];
  @override
  void initState() {
    _animationController =
        AnimationController(vsync: this, duration: const Duration(seconds: 3));
    _animation =
        Tween<Offset>(begin: const Offset(0, 0), end: const Offset(0, -1))
            .animate(_animationController);
    _animationController.forward();
    _favouriteProduct = fireController.getFavouriteItem;
    super.initState();
  }

  _changeFavourite(Product pro) {
    setState(() {
      pro.isFavourite = !pro.isFavourite!;
      fireController.changeProductFavourite(
          id: pro.id!, isFavourite: pro.isFavourite);
    });
  }

  @override
  void dispose() {
    super.dispose();
    _animationController.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: backAppColor,
      body: SafeArea(
        child: Column(
          children: [
            SizedBox(
              height: Get.height * 0.02,
            ),
            const Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text(
                  'Your Favourite Items',
                  style: TextStyle(
                      color: Colors.white24,
                      fontSize: 18,
                      fontWeight: FontWeight.bold),
                ),
              ],
            ),
            Expanded(child: Obx(() {
              final _favouriteProduct = fireController.getFavouriteItem;

              return GridView.builder(
                padding: const EdgeInsets.only(top: 5),
                itemCount: _favouriteProduct.length,
                gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                    mainAxisExtent: 230,
                    crossAxisSpacing: 6,
                    crossAxisCount: 2),
                itemBuilder: (context, index) {
                  // debugPrint(data.length.toString());

                  return GestureDetector(
                    onTap: () {
                      Get.to(() => const DetailScreen(),
                          arguments: _favouriteProduct[index].id);
                    },
                    child: Stack(children: [
                      Align(
                        alignment: Alignment.center,
                        child: Container(
                            margin: const EdgeInsets.only(top: 35),
                            // width: mdq.width * 0.5,
                            // height: mdq.height * 0.2,
                            padding: const EdgeInsets.all(5),
                            decoration: const BoxDecoration(
                                color: Colors.white24,
                                borderRadius: BorderRadius.only(
                                    topLeft: Radius.circular(20),
                                    topRight: Radius.circular(20))),
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                SizedBox(
                                  height: Get.height * 0.07,
                                ),
                                Text(
                                  _favouriteProduct[index].title!,
                                  style: const TextStyle(
                                      color: Colors.white,
                                      fontWeight: FontWeight.bold),
                                ),
                                SizedBox(
                                  height: Get.height * 0.01,
                                ),
                                Container(
                                    width: double.infinity,
                                    height: Get.height * 0.05,
                                    decoration: const BoxDecoration(),
                                    child: Text(
                                      _favouriteProduct[index].ingredients!,
                                      textAlign: TextAlign.start,
                                      style: const TextStyle(
                                          fontSize: 12,
                                          color: Colors.white24,
                                          fontWeight: FontWeight.bold),
                                    )),
                                SizedBox(
                                  height: Get.height * 0.01,
                                ),
                                RatingBar.builder(
                                    itemSize: 17,
                                    initialRating:
                                        _favouriteProduct[index].rating!,
                                    itemBuilder: (context, index) {
                                      return const Icon(
                                        Icons.star,
                                        color: yellowColor,
                                      );
                                    },
                                    onRatingUpdate: (rating) {
                                      debugPrint(rating.toString());
                                    }),
                                SizedBox(
                                  height: Get.height * 0.01,
                                ),
                                Text(
                                  '\$ ${_favouriteProduct[index].price}',
                                  style: const TextStyle(color: whiteColor),
                                ),
                              ],
                            )),
                      ),
                      Positioned(
                        top: -10,
                        left: 20,
                        child: Image.network(
                          '${_favouriteProduct[index].imageUrl![0]}',
                          width: 120,
                          height: 120,
                        ),
                      ),
                      Positioned(
                          bottom: 0,
                          right: 0,
                          child: _favouriteProduct[index].isFavourite!
                              ? IconButton(
                                  onPressed: () {
                                    debugPrint(
                                        _favouriteProduct[index].id.toString());
                                    _changeFavourite(_favouriteProduct[index]);
                                  },
                                  icon: const Icon(
                                    Icons.favorite,
                                    color: Colors.white,
                                  ))
                              : IconButton(
                                  onPressed: () {
                                    _changeFavourite(_favouriteProduct[index]);
                                  },
                                  icon: const Icon(
                                    Icons.favorite,
                                    color: whiteColor,
                                  )))
                    ]),
                  );
                },
              );
            }))
          ],
        ),
      ),
    );
  }
}
