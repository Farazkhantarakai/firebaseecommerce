import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_ecommerce/models/OrderModel.dart';
import 'package:firebase_ecommerce/utils/constants.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:get/get.dart';

class Order extends GetxController {
  RxList<OrderModel> _orderList = <OrderModel>[].obs;
  final _firebaseFirestore = FirebaseFirestore.instance;
  final uId = FirebaseAuth.instance.currentUser!.uid;

  get getOrders => _orderList;

  void addOrders(OrderModel orderModel) async {
    try {
      await _firebaseFirestore
          .collection('user')
          .doc(uId)
          .collection('orders')
          .doc()
          .set(orderModel.toMap());
    } on FirebaseException catch (err) {
      Fluttertoast.showToast(
          msg: err.toString(), backgroundColor: backAppColor);
      debugPrint(err.toString());
    }
  }

  fetchOrders() async {
    QuerySnapshot querySnapshot = await _firebaseFirestore
        .collection('users')
        .doc(uId)
        .collection('orders')
        .get();

    final allOrders = querySnapshot.docs.map((doc) {
      Map<String, dynamic> orderData = doc.data() as Map<String, dynamic>;

      return OrderModel.fromMap(orderData);
    }).toList();

    debugPrint(allOrders.toString());
  }
}
