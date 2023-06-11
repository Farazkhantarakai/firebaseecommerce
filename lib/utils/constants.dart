import 'package:firebase_ecommerce/models/categoryModel.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';

const yellowColor = Color.fromARGB(255, 202, 187, 48);
const blackColor = Color.fromARGB(255, 53, 52, 52);
const backAppColor = Color.fromARGB(255, 29, 28, 28);
const whiteColor = Color.fromARGB(216, 155, 153, 153);
const webApiKey = 'AIzaSyDe4xw8Gg2CwrY-6PmPSwh9MipI-xGdTuM';

void showToast(String message) {
  Fluttertoast.showToast(msg: message, backgroundColor: yellowColor);
}

final dummyData = [
  CategoryModel(imageUrl: 'assets/icons/pizza.png', text: 'pizza'),
  CategoryModel(imageUrl: 'assets/icons/burger.png', text: 'burger'),
  CategoryModel(imageUrl: 'assets/icons/cupcake.png', text: 'desset'),
  CategoryModel(imageUrl: 'assets/icons/sandwich.png', text: 'sandwitch'),
  CategoryModel(imageUrl: 'assets/icons/skewer.png', text: 'Kebab'),
  CategoryModel(imageUrl: 'assets/icons/orange-juice.png', text: 'juice')
];
