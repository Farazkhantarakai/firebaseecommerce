import 'package:firebase_ecommerce/providers/firestoreMethods.dart';
import 'package:firebase_ecommerce/screens/detailscreen.dart';
import 'package:firebase_ecommerce/utils/constants.dart';
import 'package:flutter/material.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';
import 'package:get/get.dart';

class SearchScreen extends StatefulWidget {
  const SearchScreen({super.key});

  @override
  State<SearchScreen> createState() => _SearchScreenState();
}

class _SearchScreenState extends State<SearchScreen> {
  final _searchController = TextEditingController();
  late FocusNode _focusNode;

  final _firestoreController = Get.put(FirestoreMethods());

  @override
  void initState() {
    _focusNode = FocusNode();
    // this will direct the focus when the user enter to the screen
    _focusNode.requestFocus();
    super.initState();
  }

  @override
  void dispose() {
    _focusNode.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: backAppColor,
        body: SafeArea(
          child: Padding(
            padding: const EdgeInsets.all(8.0),
            child: Column(children: [
              Row(
                children: [
                  IconButton(
                      onPressed: () {
                        Get.back();
                      },
                      icon: const Icon(
                        Icons.arrow_back,
                        color: Color.fromARGB(221, 190, 186, 186),
                      )),
                  SizedBox(
                    width: Get.width * 0.14,
                  ),
                  const Text(
                    'Search Your Item',
                    style: TextStyle(
                        color: Color.fromARGB(221, 190, 186, 186),
                        fontWeight: FontWeight.bold,
                        fontSize: 17),
                  )
                ],
              ),
              Padding(
                padding: const EdgeInsets.all(5.0),
                child: TextField(
                  controller: _searchController,
                  cursorColor: whiteColor,
                  focusNode: _focusNode,
                  onChanged: (text) async {
                    setState(() {
                      _firestoreController.searchItems(text);
                    });
                  },
                  style: const TextStyle(color: Colors.white),
                  onSubmitted: (data) {
                    _firestoreController.searchItems(data);
                  },
                  decoration: const InputDecoration(
                      prefixIcon: Padding(
                        padding: EdgeInsets.only(right: 10),
                        child: Icon(
                          Icons.search,
                          color: Colors.white,
                          size: 30,
                        ),
                      ),
                      prefixIconConstraints:
                          BoxConstraints(minWidth: 10, minHeight: 0),
                      contentPadding: EdgeInsets.symmetric(vertical: 10),
                      hintText: 'Enter your foods name',
                      hintStyle: TextStyle(color: whiteColor),
                      enabledBorder: UnderlineInputBorder(
                          borderSide: BorderSide(color: whiteColor)),
                      focusedBorder: UnderlineInputBorder(
                          borderSide: BorderSide(color: whiteColor))),
                ),
              ),
              FutureBuilder(
                  future:
                      _firestoreController.searchItems(_searchController.text),
                  builder: (context, snapshot) {
                    if (!snapshot.hasData) {
                      return const Text(
                        'No Product Founded',
                        style: TextStyle(color: Colors.white, fontSize: 17),
                      );
                    }
                    if (snapshot.connectionState == ConnectionState.waiting) {
                      return const Text(
                        'Data is Loading ....',
                        style: TextStyle(color: Colors.white, fontSize: 17),
                      );
                    }
                    return Expanded(
                        child: GridView.builder(
                      padding: const EdgeInsets.only(top: 5),
                      itemCount: snapshot.data!.length,
                      gridDelegate:
                          const SliverGridDelegateWithFixedCrossAxisCount(
                              mainAxisExtent: 230,
                              crossAxisSpacing: 6,
                              crossAxisCount: 2),
                      itemBuilder: (context, index) {
                        // debugPrint(data.length.toString());

                        return GestureDetector(
                          onTap: () {
                            Get.to(() => const DetailScreen(),
                                arguments: snapshot.data![index].id);
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
                                        snapshot.data![index].title!,
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
                                            snapshot.data![index].ingredients!,
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
                                              snapshot.data![index].rating!,
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
                                        '\$ ${snapshot.data![index].price}',
                                        style:
                                            const TextStyle(color: whiteColor),
                                      ),
                                    ],
                                  )),
                            ),
                            Positioned(
                              top: -10,
                              left: 20,
                              child: Image.network(
                                '${snapshot.data![index].imageUrl![0]}',
                                width: 120,
                                height: 120,
                              ),
                            ),
                            Positioned(
                                bottom: 0,
                                right: 0,
                                child: IconButton(
                                    onPressed: () {},
                                    icon: const Icon(
                                      Icons.favorite,
                                      color: whiteColor,
                                    )))
                          ]),
                        );
                      },
                    ));
                  })
            ]),
          ),
        ));
  }
}
