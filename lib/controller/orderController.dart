import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

import '../models/OrderModel.dart';

class OrderController {
  final FirebaseFirestore _firebaseFirestore = FirebaseFirestore.instance;
  final FirebaseAuth _firebaseAuth = FirebaseAuth.instance;

  List<OrderModel> _orderItem = [];

  get getOrderedItems => _orderItem;

  void addOrderedItems(OrderModel orderModel) {
    try {
      _firebaseFirestore
          .collection('user')
          .doc(_firebaseAuth.currentUser!.uid)
          .collection('order')
          .doc()
          .set(orderModel.toMap());
    } on FirebaseAuthException catch (err) {
      debugPrint(err.toString());
    }
  }
}
