import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_ecommerce/models/OrderModel.dart';
import 'package:firebase_ecommerce/utils/constants.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:get/get.dart';

class Order extends GetxController {
  final _firebaseFirestore = FirebaseFirestore.instance;
  final uId = FirebaseAuth.instance.currentUser!.uid;

  Future<String> addOrders(OrderModel orderModel) async {
    String? response = '';
    try {
      await _firebaseFirestore
          .collection('user')
          .doc(uId)
          .collection('orders')
          .doc()
          .set(orderModel.toMap())
          .then((value) {
        response = 'success';
      });
    } on FirebaseException catch (err) {
      Fluttertoast.showToast(
          msg: err.toString(), backgroundColor: backAppColor);
      debugPrint(err.toString());
    }
    return response!;
  }

  Future<List<OrderModel>> fetchOrders() async {
    QuerySnapshot querySnapshot = await _firebaseFirestore
        .collection('user')
        .doc(uId)
        .collection('orders')
        .get();

    List<OrderModel> orderList = querySnapshot.docs.map<OrderModel>((doc) {
      Map<String, dynamic> newItem = doc.data() as Map<String, dynamic>;
      return OrderModel.fromMap(newItem);
    }).toList();

    return orderList;
  }
}
