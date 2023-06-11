import 'package:flutter/material.dart';

class CheckOutPrice extends StatelessWidget {
  const CheckOutPrice({super.key, required this.price});

  final double price;

  @override
  Widget build(BuildContext context) {
    final mdq = MediaQuery.of(context).size;

    return Row(
      mainAxisAlignment: MainAxisAlignment.start,
      children: [
        const Text(
          'Total Price',
          style: TextStyle(
              color: Colors.white, fontWeight: FontWeight.bold, fontSize: 15),
        ),
        SizedBox(
          width: mdq.width * 0.2,
        ),
        Text(
          '$price',
          style: const TextStyle(color: Colors.white, fontSize: 15),
        ),
      ],
    );
  }
}
