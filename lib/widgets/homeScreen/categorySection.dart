import 'package:firebase_ecommerce/providers/firestoreMethods.dart';
import 'package:firebase_ecommerce/utils/constants.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class CategorySection extends StatefulWidget {
  const CategorySection({super.key});

  @override
  State<CategorySection> createState() => _CategorySectionState();
}

class _CategorySectionState extends State<CategorySection> {
  int currentIndex = 0;

  final _firestoreController = Get.put(FirestoreMethods());

  @override
  Widget build(BuildContext context) {
    final mdq = MediaQuery.of(context).size;

    return Column(
      children: [
        const Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          crossAxisAlignment: CrossAxisAlignment.end,
          children: [
            Text(
              'Category',
              style: TextStyle(
                  color: whiteColor, fontSize: 20, fontWeight: FontWeight.bold),
            ),
            Text(
              'See all',
              style: TextStyle(color: yellowColor),
            )
          ],
        ),
        Container(
          height: mdq.height * 0.1,
          decoration: const BoxDecoration(),
          margin: const EdgeInsets.only(top: 5),
          child: ListView.builder(
              scrollDirection: Axis.horizontal,
              itemCount: dummyData.length,
              itemBuilder: (context, index) {
                return GestureDetector(
                  onTap: () {
                    setState(() {
                      currentIndex = index;
                      _firestoreController.getCategoriesOfItem(
                          category: dummyData[index].text);
                    });
                  },
                  child: Container(
                    // color: Colors.blue,
                    margin: const EdgeInsets.only(right: 16, left: 4),
                    decoration: const BoxDecoration(),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Container(
                            width: 48,
                            height: 48,
                            padding: const EdgeInsets.all(10),
                            decoration: BoxDecoration(
                                color: currentIndex == index
                                    ? yellowColor
                                    : const Color.fromARGB(255, 185, 182, 182),
                                borderRadius:
                                    const BorderRadius.all(Radius.circular(10)),
                                shape: BoxShape.rectangle),
                            child: Image.asset(
                              dummyData[index].imageUrl,
                              scale: 1,
                            )),
                        Padding(
                          padding: const EdgeInsets.only(left: 4, top: 4),
                          child: Text(
                            dummyData[index].text,
                            style: TextStyle(
                                color: currentIndex == index
                                    ? Colors.white
                                    : Colors.white24,
                                fontSize: 12),
                          ),
                        )
                      ],
                    ),
                  ),
                );
              }),
        )
      ],
    );
  }
}
