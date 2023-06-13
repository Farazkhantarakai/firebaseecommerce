import 'package:firebase_ecommerce/providers/firestoreMethods.dart';
import 'package:flutter/material.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';
import 'package:get/get.dart';
import '../../models/product.dart';
import '../../screens/detailscreen.dart';
import '../../utils/constants.dart';

class AllProducts extends StatefulWidget {
  const AllProducts({super.key, required this.products});

  final List<Product> products;

  @override
  State<AllProducts> createState() => _AllProductsState();
}

class _AllProductsState extends State<AllProducts> {
  final _firestoreController = Get.put(FirestoreMethods());

  _changeFavourite(Product pro) {
    setState(() {
      pro.isFavourite = !pro.isFavourite!;
      _firestoreController.changeProductFavourite(
          id: pro.id!, isFavourite: pro.isFavourite!);
      _firestoreController.addItemsToFavourite(pro);
      // _firestoreController.getFavouriteItems();
      // _firestoreController.addItemsToFavourite(pro);
    });
  }

  @override
  Widget build(BuildContext context) {
    debugPrint(_firestoreController.getFirstLoaded.toString());

    return Column(
      children: [
        Obx(() {
          return _firestoreController.getFirstLoaded == false
              ? Expanded(
                  child: GridView.builder(
                    padding: const EdgeInsets.only(top: 5),
                    itemCount: widget.products.length,
                    gridDelegate:
                        const SliverGridDelegateWithFixedCrossAxisCount(
                            mainAxisExtent: 230,
                            crossAxisSpacing: 6,
                            crossAxisCount: 2),
                    itemBuilder: (context, index) {
                      // debugPrint(data.length.toString());

                      return GestureDetector(
                        onTap: () {
                          Get.to(
                            () => const DetailScreen(),
                            arguments: widget.products[index].id,
                          );
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
                                      widget.products[index].title!,
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
                                          widget.products[index].ingredients!,
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
                                            widget.products[index].rating!,
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
                                      '\$ ${widget.products[index].price}',
                                      style: const TextStyle(color: whiteColor),
                                    ),
                                  ],
                                )),
                          ),
                          Positioned(
                            top: -10,
                            left: 20,
                            child: Image.network(
                              '${widget.products[index].imageUrl![0]}',
                              width: 120,
                              height: 120,
                            ),
                          ),
                          Positioned(
                              bottom: 0,
                              right: 0,
                              child: widget.products[index].isFavourite!
                                  ? IconButton(
                                      onPressed: () {
                                        debugPrint(widget.products[index].id
                                            .toString());
                                        _changeFavourite(
                                            widget.products[index]);
                                      },
                                      icon: const Icon(
                                        Icons.favorite,
                                        color: Colors.white,
                                      ))
                                  : IconButton(
                                      onPressed: () {
                                        _changeFavourite(
                                            widget.products[index]);
                                      },
                                      icon: const Icon(
                                        Icons.favorite,
                                        color: whiteColor,
                                      )))
                        ]),
                      );
                    },
                  ),
                )
              : Expanded(
                  child: GridView.builder(
                    padding: const EdgeInsets.only(top: 5),
                    itemCount: _firestoreController.getAllData.length,
                    gridDelegate:
                        const SliverGridDelegateWithFixedCrossAxisCount(
                            mainAxisExtent: 230,
                            crossAxisSpacing: 6,
                            crossAxisCount: 2),
                    itemBuilder: (context, index) {
                      // debugPrint(data.length.toString());

                      List<Product> newProducts =
                          _firestoreController.getAllData;

                      // debugPrint('new Products ${newProducts[0].title}');

                      return newProducts.isEmpty
                          ? const Center(
                              child: Text(
                                'No Item added yet',
                                style: TextStyle(
                                    color: Colors.white,
                                    fontWeight: FontWeight.bold,
                                    fontSize: 19),
                              ),
                            )
                          : GestureDetector(
                              onTap: () {
                                Get.to(() => const DetailScreen(),
                                    arguments: newProducts[index].id);
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
                                        crossAxisAlignment:
                                            CrossAxisAlignment.start,
                                        children: [
                                          SizedBox(
                                            height: Get.height * 0.07,
                                          ),
                                          Text(
                                            newProducts[index].title!,
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
                                                newProducts[index].ingredients!,
                                                textAlign: TextAlign.start,
                                                style: const TextStyle(
                                                    fontSize: 12,
                                                    color: Colors.white24,
                                                    fontWeight:
                                                        FontWeight.bold),
                                              )),
                                          SizedBox(
                                            height: Get.height * 0.01,
                                          ),
                                          RatingBar.builder(
                                              itemSize: 17,
                                              initialRating:
                                                  newProducts[index].rating!,
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
                                            '\$ ${newProducts[index].price}',
                                            style: const TextStyle(
                                                color: whiteColor),
                                          ),
                                        ],
                                      )),
                                ),
                                Positioned(
                                  top: -10,
                                  left: 20,
                                  child: Image.network(
                                    '${newProducts[index].imageUrl![0]}',
                                    width: 120,
                                    height: 120,
                                  ),
                                ),
                                Positioned(
                                    bottom: 0,
                                    right: 0,
                                    child: newProducts[index].isFavourite!
                                        ? IconButton(
                                            onPressed: () {
                                              debugPrint(newProducts[index]
                                                  .id
                                                  .toString());
                                              _changeFavourite(
                                                  newProducts[index]);
                                            },
                                            icon: const Icon(
                                              Icons.favorite,
                                              color: Colors.white,
                                            ))
                                        : IconButton(
                                            onPressed: () {
                                              _changeFavourite(
                                                  newProducts[index]);
                                            },
                                            icon: const Icon(
                                              Icons.favorite,
                                              color: whiteColor,
                                            )))
                              ]),
                            );
                    },
                  ),
                );
        }),
      ],
    );
  }
}
