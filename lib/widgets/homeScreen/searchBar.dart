import 'package:firebase_ecommerce/screens/searchScreen.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../../utils/constants.dart';

class SearchBarItem extends StatefulWidget {
  const SearchBarItem({super.key});

  @override
  State<SearchBarItem> createState() => _SearchBarItemState();
}

class _SearchBarItemState extends State<SearchBarItem> {
  final TextEditingController _searchController = TextEditingController();
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(5.0),
      child: TextField(
        controller: _searchController,
        cursorColor: whiteColor,
        onTap: () {
          Get.to(() => const SearchScreen());
        },
        onChanged: (text) {
          setState(() {
            // debugPrint(text);
          });
        },
        style: const TextStyle(color: Colors.white),
        onSubmitted: (data) {
          debugPrint(data);
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
            prefixIconConstraints: BoxConstraints(minWidth: 10, minHeight: 0),
            contentPadding: EdgeInsets.symmetric(vertical: 10),
            hintText: 'Enter your foods name',
            hintStyle: TextStyle(color: whiteColor),
            enabledBorder:
                UnderlineInputBorder(borderSide: BorderSide(color: whiteColor)),
            focusedBorder: UnderlineInputBorder(
                borderSide: BorderSide(color: whiteColor))),
      ),
    );
  }
}
