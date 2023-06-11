import 'package:flutter/material.dart';
import 'package:get/get.dart';

class CheckOutBar extends StatelessWidget {
  const CheckOutBar({super.key});

  @override
  Widget build(BuildContext context) {
    final mdq = MediaQuery.of(context).size;

    return Row(
      mainAxisAlignment: MainAxisAlignment.start,
      children: [
        GestureDetector(
            onTap: () {
              Get.back();
            },
            child: const Icon(
              Icons.arrow_back,
              color: Colors.white,
            )),
        SizedBox(
          width: mdq.width * 0.2,
        ),
        const Text(
          'Check Out Screen',
          style: TextStyle(
              color: Colors.white, fontSize: 16, fontWeight: FontWeight.bold),
        )
      ],
    );
  }
}
