import 'package:flutter/material.dart';
import 'package:get/get.dart';

class CartItem extends GetxController {
  String? id;
  int? quantity;
  String? prodId;
  String? title;
  String? imageUrl;
  String? price;
  bool? isChecked;

  CartItem(this.id, this.quantity, this.prodId, this.title, this.imageUrl,
      this.price,
      [this.isChecked = false]);

  toMap() {
    return {
      "id": id,
      "quantity": quantity,
      "prodId": prodId,
      "title": title,
      "imageUrl": imageUrl,
      "price": price,
      "isChecked": isChecked
    };
  }

  void increaseQuantity() {
    quantity = quantity! + 1;
    update();
  }

  void changeCheck() {
    isChecked = !isChecked!;
    debugPrint(isChecked.toString());
    update();
  }

  void decreaseQuantity() {
    quantity = quantity! - 1;
    update();
  }

  static fromMap(Map<String, dynamic> data) {
    return CartItem(data['id'], data['quantity'], data['prodId'], data['title'],
        data['imageUrl'], data['price']);
  }
}
