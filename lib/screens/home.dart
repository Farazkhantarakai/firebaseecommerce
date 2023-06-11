import 'package:firebase_ecommerce/models/product.dart';
import 'package:firebase_ecommerce/providers/cart.dart';
import 'package:firebase_ecommerce/providers/firestoreMethods.dart';
import 'package:firebase_ecommerce/utils/constants.dart';
import 'package:firebase_ecommerce/widgets/homeScreen/categorySection.dart';
import 'package:firebase_ecommerce/widgets/homeScreen/allProducts.dart';
import 'package:firebase_ecommerce/widgets/homeScreen/homeScreenBar.dart';
import 'package:firebase_ecommerce/widgets/homeScreen/mainScreenItem.dart';
import 'package:firebase_ecommerce/widgets/homeScreen/searchBar.dart';
import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:get/get.dart';
import '../controller/getLocation.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> with TickerProviderStateMixin {
  final _locationController = Get.put(LocationD());
  final _firestoreController = Get.put(FirestoreMethods());
  final _cartController = Get.put(Cart());
  late AnimationController _animationController;
  late AnimationController _secondController;
  late Animation<Offset> _animation;
  late AnimationController _categoryController;
  late Animation<Offset> _catogoryAnimation;
  // late String name;
  @override
  void initState() {
    _locationController.determinePosition();
    _firestoreController.getData();
    _firestoreController.getFavouriteItems();
    _cartController.getAllCartItem();

    _animationController = AnimationController(
        vsync: this, duration: const Duration(milliseconds: 1200));
    _secondController =
        AnimationController(vsync: this, duration: const Duration(seconds: 3));
    _animation =
        Tween<Offset>(begin: const Offset(-1, 0), end: const Offset(0.0, 0.0))
            .animate(_secondController);
    _secondController.forward();
    _categoryController =
        AnimationController(vsync: this, duration: const Duration(seconds: 3));
    _catogoryAnimation =
        Tween<Offset>(begin: const Offset(0, -1), end: const Offset(0, 0))
            .animate(_categoryController);
    _categoryController.forward();
    super.initState();
  }

  @override
  void dispose() {
    _animationController.dispose();
    _secondController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final mdq = MediaQuery.of(context).size;

    return SafeArea(
        child: Scaffold(
            backgroundColor: backAppColor,
            body: FutureBuilder(
                future: FirestoreMethods().getData(),
                builder: (context, snapshot) {
                  if (snapshot.connectionState == ConnectionState.waiting) {
                    return Center(
                        child: SpinKitThreeBounce(
                            size: 25,
                            color: Colors.white,
                            controller: _animationController));
                  }
                  if (snapshot.hasError) {
                    return const Center(
                      child: Text('There is some error founded'),
                    );
                  }
                  List<Product> product = snapshot.data as List<Product>;
                  return Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: ListView(
                          // crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            const HomeScreenBar(),
                            SizedBox(
                              height: mdq.height * 0.01,
                            ),
                            const SearchBarItem(),
                            SizedBox(
                              height: mdq.height * 0.02,
                            ),
                            SlideTransition(
                              position: _animation,
                              child: MainScreenItem(
                                product: product[0],
                              ),
                            ),
                            SizedBox(
                              height: mdq.height * 0.03,
                            ),
                            SlideTransition(
                                position: _catogoryAnimation,
                                child: const CategorySection()),
                            SizedBox(
                              height: mdq.height * 0.02,
                            ),
                            Container(
                              width: double.infinity,
                              height: Get.height * 0.5,
                              decoration: const BoxDecoration(),
                              child: AllProducts(
                                products: product,
                              ),
                            ),
                          ]));
                })));
  }
}
