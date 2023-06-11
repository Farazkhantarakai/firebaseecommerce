import 'package:flutter/material.dart';

class Promo extends StatelessWidget {
  const Promo({super.key, required this.promo});

  final String promo;

  @override
  Widget build(BuildContext context) {
    final mdq = MediaQuery.of(context).size;

    return Row(
      // mainAxisAlignment: MainAxisAlignment.spaceAround,
      children: [
        const Text(
          'Promo',
          style: TextStyle(
              color: Colors.white, fontWeight: FontWeight.bold, fontSize: 15),
        ),
        SizedBox(
          width: mdq.width * 0.3,
        ),
        Text(
          '$promo ',
          style: const TextStyle(color: Colors.white),
        ),
      ],
    );
  }
}
