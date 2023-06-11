import 'package:firebase_ecommerce/utils/constants.dart';
import 'package:flutter/material.dart';

class Forgot extends StatefulWidget {
  const Forgot({super.key});

  @override
  State<Forgot> createState() => _ForgotState();
}

class _ForgotState extends State<Forgot> {
  final emailController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    final mdq = MediaQuery.of(context).size;
    return Scaffold(
      body: Column(
        children: [
          const Text(
            'Forgot Password',
            style: TextStyle(color: Colors.white),
          ),
          TextFormField(
            controller: emailController,
            cursorColor: Colors.white,
            style: const TextStyle(color: Colors.white),
            validator: (value) {
              if (value!.isEmpty) {
                return 'Please enter your email';
              }
              return null;
            },
            decoration: const InputDecoration(
                prefixIcon: Icon(
                  Icons.email,
                  color: Colors.white,
                  size: 20,
                ),
                prefixIconConstraints:
                    BoxConstraints(minWidth: 10, minHeight: 0),
                contentPadding: EdgeInsets.symmetric(vertical: 10),
                hintText: 'Email',
                hintStyle: TextStyle(color: Colors.white),
                enabledBorder: UnderlineInputBorder(
                    borderSide: BorderSide(color: Colors.white)),
                focusedBorder: UnderlineInputBorder(
                    borderSide: BorderSide(color: Colors.white))),
          ),
          Container(
            width: double.infinity,
            height: mdq.height * 0.07,
            decoration: const BoxDecoration(
                color: yellowColor,
                borderRadius: BorderRadius.all(Radius.circular(25))),
            child: const Center(
              child: Text(
                'Recover Password',
                style: TextStyle(
                    color: Colors.white,
                    fontWeight: FontWeight.bold,
                    fontSize: 18),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
