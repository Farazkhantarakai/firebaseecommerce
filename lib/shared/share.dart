//this is for creating a part of the widgets
import 'package:flutter/material.dart';

const inputDecoration = InputDecoration(
  hintStyle: TextStyle(color: Colors.black),
  enabledBorder: OutlineInputBorder(
    borderSide: BorderSide(
      color: Color.fromARGB(148, 126, 212, 105),
      width: 2,
    ),
  ),
  focusedBorder: OutlineInputBorder(
    borderSide: BorderSide(color: Color.fromARGB(148, 126, 212, 105), width: 2),
  ),
  errorBorder: OutlineInputBorder(
    borderSide: BorderSide(color: Color.fromARGB(148, 126, 212, 105), width: 2),
  ),
);
