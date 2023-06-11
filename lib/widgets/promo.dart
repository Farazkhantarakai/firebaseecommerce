import 'package:firebase_ecommerce/utils/constants.dart';
import 'package:flutter/material.dart';

class PromoCode extends StatefulWidget {
  const PromoCode({super.key, required this.change});

  final Function change;

  @override
  State<PromoCode> createState() => _PromoCodeState();
}

class _PromoCodeState extends State<PromoCode> {
  final TextEditingController _promoController = TextEditingController();
  @override
  Widget build(BuildContext context) {
    final mdq = MediaQuery.of(context).size;

    return Container(
      width: double.infinity,
      height: mdq.height * 0.07,
      padding: const EdgeInsets.all(10),
      margin: const EdgeInsets.only(top: 10),
      decoration: const BoxDecoration(
          color: blackColor,
          borderRadius: BorderRadius.all(Radius.circular(10))),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          const Text(
            'Promo Code',
            style: TextStyle(
                color: Colors.white, fontSize: 14, fontWeight: FontWeight.bold),
          ),
          SizedBox(
            width: mdq.width * 0.03,
          ),
          const Padding(
            padding: EdgeInsets.only(
              top: 6.0,
              bottom: 6.0,
            ),
            child: VerticalDivider(
              width: 7,
              color: Colors.white,
            ),
          ),
          Expanded(
              child: TextField(
            controller: _promoController,
            cursorColor: Colors.white,
            onChanged: (value) {
              widget.change(value);
            },
            style: const TextStyle(color: Colors.white),
            decoration: const InputDecoration(
              contentPadding: EdgeInsets.only(bottom: 12, left: 10),
              border: InputBorder.none,
            ),
          )),
          const Text(
            '+',
            style: TextStyle(color: yellowColor, fontSize: 30),
          )
        ],
      ),
    );
  }
}
