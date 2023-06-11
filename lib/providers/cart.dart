import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_ecommerce/models/cartitem.dart';
import 'package:firebase_ecommerce/utils/constants.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:get/get.dart';

class Cart extends GetxController {
  final _firebaseFirestore = FirebaseFirestore.instance;
  final _firebaseAuth = FirebaseAuth.instance;
  RxInt length = 0.obs;
  RxDouble total = 0.0.obs;
  List cartProductIds = [];
  RxBool _isLoading = false.obs;
  final List<String> _promo = ['ge12f'];

  List<String> get getPromo => _promo;

  RxMap<String, CartItem> cartItem = RxMap<String, CartItem>();

  Map<String, CartItem> get getCartItem => cartItem.value;

  int get getTotalLength => length.value;

  bool get getIsLoading => _isLoading.value;

  double get getTotalPrice {
    total = 0.0.obs;
    cartItem.value.values.forEach((element) {
      total.value += double.parse(element.price.toString()) *
          double.parse(element.quantity.toString());
      debugPrint(total.toString());
    });
    return total.value;
  }

  getAllCartItem() async {
    try {
      QuerySnapshot querySnapshot = await _firebaseFirestore
          .collection('user')
          .doc(_firebaseAuth.currentUser!.uid)
          .collection('cart')
          .get();

      // Clear the existing items in the cartItem map
      cartItem.clear();

      // Loop through the documents in the query snapshot
      querySnapshot.docs.forEach((doc) {
        // Get the data from each document
        Map<String, dynamic> data = doc.data() as Map<String, dynamic>;

        // Extract the id and product fields from the data
        String id = data['id'];
        CartItem item = CartItem.fromMap(data);

        // Add the item to the cartItem map using the id as the key
        cartItem[id] = item;
      });
      debugPrint(cartItem.toString());
      length.value = querySnapshot.size;
    } on FirebaseAuthException catch (er) {
      debugPrint(er.toString());
    }
  }

  void addProductId(String id) {
    debugPrint(id);
    cartProductIds.add(id);
    debugPrint(cartProductIds.toString());
  }

  void removeProductId(String id) {
    cartProductIds.remove(id);
    debugPrint(cartProductIds.toString());
  }

  void updateCartProduct(CartItem ci) async {
    if (cartItem.containsKey(ci.id)) {
      cartItem[ci.id!] = ci;
    }

    _firebaseFirestore
        .collection('user')
        .doc(_firebaseAuth.currentUser!.uid)
        .collection('cart')
        .doc(ci.prodId)
        .update(ci.toMap());
  }

  deleteItemsFromCart() async {
    // debugPrint(isLoading.toString());
    _isLoading.value = true;
    try {
      cartProductIds.forEach((element) {
        _firebaseFirestore
            .collection('user')
            .doc(_firebaseAuth.currentUser!.uid)
            .collection('cart')
            .doc(element)
            .delete()
            .then((value) {
          _isLoading.value = false;
        });
      });
    } on FirebaseAuthException catch (err) {
      debugPrint(err.toString());
    }
  }

  Future<bool> addItemToCart(CartItem cm) async {
    bool dataAdded = false;

    if (!cartItem.containsKey(cm.id)) {
      cartItem[cm.id!] = cm;
    }

    try {
      // this will check that item is already to the cart or not
      final snapshot = await _firebaseFirestore
          .collection('user')
          .doc(_firebaseAuth.currentUser!.uid)
          .collection('cart')
          .doc(cm.prodId)
          .get();

      if (snapshot.exists) {
        Fluttertoast.showToast(
            msg: 'Item Already exists in the cart',
            backgroundColor: blackColor);
      } else {
        await _firebaseFirestore
            .collection('user')
            .doc(_firebaseAuth.currentUser!.uid)
            .collection('cart')
            .doc(cm.prodId)
            .set(cm.toMap())
            .then((value) {
          dataAdded = true;
        });
      }
    } catch (err) {
      debugPrint(err.toString());
    }
    return dataAdded;
  }
}
