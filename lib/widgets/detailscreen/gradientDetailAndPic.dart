import 'package:firebase_ecommerce/utils/constants.dart';
import 'package:flutter/material.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';
import 'package:get/get.dart';
import 'package:firebase_ecommerce/models/product.dart';

class GradientDetailAndPic extends StatelessWidget {
  const GradientDetailAndPic({super.key, required this.product});

  final Product product;

  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(builder: (context, constraints) {
      return Container(
        width: double.infinity,
        height: constraints.maxHeight,
        decoration: const BoxDecoration(),
        child: Stack(
          children: [
            Align(
              alignment: Alignment.topLeft,
              child: Container(
                width: constraints.maxWidth * 0.4,
                height: double.infinity,
                padding: const EdgeInsets.all(20),
                decoration: const BoxDecoration(
                    color: Colors.white24,
                    borderRadius: BorderRadius.only(
                        topRight: Radius.circular(20),
                        bottomRight: Radius.circular(20))),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    Container(
                      margin: const EdgeInsets.only(bottom: 30),
                      decoration: const BoxDecoration(),
                      child: Column(
                        children: [
                          const Text(
                            'Rate',
                            style: TextStyle(color: whiteColor),
                          ),
                          Text(
                            '${product.rating}',
                            style: const TextStyle(
                                color: Colors.white, fontSize: 16),
                          ),
                          RatingBar.builder(
                              initialRating: product.rating!,
                              itemSize: 17,
                              itemBuilder: (context, index) {
                                return const Icon(
                                  Icons.star,
                                  color: yellowColor,
                                );
                              },
                              onRatingUpdate: (rating) {}),
                        ],
                      ),
                    ),
                    Container(
                      margin: const EdgeInsets.only(bottom: 30),
                      decoration: const BoxDecoration(),
                      child: Column(
                        children: [
                          const Text(
                            'Delivery Time',
                            style: TextStyle(
                                color: whiteColor,
                                fontWeight: FontWeight.bold,
                                fontSize: 15),
                          ),
                          SizedBox(
                            height: Get.height * 0.01,
                          ),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Text(
                                '${product.deliveryTime}',
                                style: const TextStyle(
                                    color: Colors.white, fontSize: 17),
                              )
                            ],
                          ),
                        ],
                      ),
                    ),
                    Container(
                      margin: const EdgeInsets.only(bottom: 30),
                      decoration: const BoxDecoration(),
                      child: Column(
                        children: [
                          const Text(
                            'Calorie',
                            style: TextStyle(color: whiteColor),
                          ),
                          SizedBox(
                            height: Get.height * 0.01,
                          ),
                          Text(
                            '${product.calories} Cal',
                            style: const TextStyle(color: Colors.white),
                          ),
                        ],
                      ),
                    ),
                    Container(
                      margin: const EdgeInsets.only(bottom: 30),
                      decoration: const BoxDecoration(),
                      child: Column(
                        children: [
                          const Text(
                            'Branch',
                            style: TextStyle(color: whiteColor),
                          ),
                          SizedBox(
                            height: Get.height * 0.01,
                          ),
                          const Text(
                            'Creek Road',
                            style: TextStyle(color: Colors.white),
                          ),
                        ],
                      ),
                    ),
                    Container(
                      decoration: const BoxDecoration(),
                      child: Column(
                        children: [
                          const Text(
                            'Price',
                            style: TextStyle(color: whiteColor),
                          ),
                          SizedBox(
                            height: Get.height * 0.01,
                          ),
                          const Text(
                            '\$10.99',
                            style: TextStyle(color: Colors.white),
                          ),
                        ],
                      ),
                    )
                  ],
                ),
              ),
            ),
            Align(
                alignment: Alignment.topRight,
                child: Container(
                  width: constraints.maxWidth * 0.5,
                  height: double.infinity,
                  decoration: const BoxDecoration(),
                  child: product.imageUrl!.length == 2
                      ? Image.network(
                          '${product.imageUrl![1]}',
                          width: double.infinity,
                          height: double.infinity,
                        )
                      : Image.network(
                          '${product.imageUrl![0]}',
                          width: double.infinity,
                          height: double.infinity,
                        ),
                ))
          ],
        ),
      );
    });
  }
}
