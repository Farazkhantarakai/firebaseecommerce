import 'dart:convert';
import 'package:firebase_ecommerce/models/OrderModel.dart';
import 'package:firebase_ecommerce/models/cartitem.dart';
import 'package:firebase_ecommerce/providers/firestoreMethods.dart';
import 'package:firebase_ecommerce/providers/order.dart';
import 'package:firebase_ecommerce/screens/home.dart';
import 'package:firebase_ecommerce/utils/constants.dart';
import 'package:firebase_ecommerce/widgets/checkoutscreen.dart/checkout.dart';
import 'package:firebase_ecommerce/widgets/checkoutscreen.dart/checkoutprice.dart';
import 'package:flutter/material.dart';
import 'package:flutter_stripe/flutter_stripe.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:get/get.dart';
import 'package:http/http.dart' as http;
import 'package:uuid/uuid.dart';
import '../widgets/checkoutscreen.dart/promo.dart';

class CheckOutScreen extends StatefulWidget {
  const CheckOutScreen({super.key});

  @override
  State<CheckOutScreen> createState() => _CheckOutScreenState();
}

class _CheckOutScreenState extends State<CheckOutScreen> {
  final fireController = FirestoreMethods();
  final _order = Get.put(Order());

  Map<String, dynamic>? paymentIntentData;
  String? name;
  String? _email;
  @override
  void initState() {
    getProfile();
    super.initState();
  }

  getProfile() async {
    fireController.getProfilePic().then((value) {
      setState(() {
        _email = value['email'];
        name = value['name'];
      });
    });
  }

  Future<void> intpayment(
      {required String email,
      required double amount,
      required List<CartItem> item}) async {
    try {
      final response = await http
          .post(Uri.parse("https://api.stripe.com/v1/payment_intents"), body: {
        "receipt_email": email,
        "amount": amount.toInt().toString(),
        "currency": "usd"
      }, headers: {
        'Authorization': 'Bearer '
            'sk_test_51N1SG5HWB5SDvH3syHrIesOj0zNqHDKsYRo1Dr7JKW2NXIrtJ7SQJnWjOVYntDuhdxWutxguDkK2WJH7mweZgU5Z00zo2wdygM',
        'Content-Type': 'application/x-www-form-urlencoded'
      });

      final jsonresponse = jsonDecode(response.body);
      String clientSecret = jsonresponse['client_secret'];

      await Stripe.instance.initPaymentSheet(
          paymentSheetParameters: SetupPaymentSheetParameters(
        paymentIntentClientSecret: clientSecret,
        merchantDisplayName: 'Faraz khan',
      ));

      await Stripe.instance.presentPaymentSheet();

      Fluttertoast.showToast(
        msg: "You Added payment successfully and the order is on the way now ",
      );
    } catch (e) {
      if (e is StripeException) {
        Fluttertoast.showToast(
          msg: "Stripe error $e",
        );

        debugPrint(e.toString());
      }
      debugPrint(e.toString());
      Fluttertoast.showToast(
        msg: "Payment cancelled",
        toastLength: Toast.LENGTH_SHORT,
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    final mdq = MediaQuery.of(context).size;
    final data =
        ModalRoute.of(context)!.settings.arguments as Map<String, dynamic>;

    List<CartItem> cartItem = data['items'] as List<CartItem>;

    return Scaffold(
      backgroundColor: backAppColor,
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(4.0),
          child: Column(
            children: [
              SizedBox(
                height: mdq.height * 0.02,
              ),
              const CheckOutBar(),
              SizedBox(
                height: mdq.height * 0.05,
              ),
              CheckOutPrice(price: data['totalPrice']),
              SizedBox(
                height: mdq.height * 0.01,
              ),
              Promo(
                promo: data['promo'],
              ),
              SizedBox(
                height: mdq.height * 0.02,
              ),
              Row(
                children: [
                  const Text(
                    'Name',
                    style: TextStyle(
                        color: Colors.white,
                        fontWeight: FontWeight.bold,
                        fontSize: 15),
                  ),
                  SizedBox(
                    width: mdq.width * 0.3,
                  ),
                  Text(
                    '$name',
                    style: const TextStyle(color: Colors.white),
                  ),
                ],
              ),
              SizedBox(
                height: mdq.height * 0.01,
              ),
              Row(
                children: [
                  const Text(
                    'Email',
                    style: TextStyle(
                        color: Colors.white,
                        fontWeight: FontWeight.bold,
                        fontSize: 15),
                  ),
                  SizedBox(
                    width: mdq.width * 0.3,
                  ),
                  Text(
                    '$_email ',
                    style: const TextStyle(color: Colors.white),
                  ),
                ],
              ),
              SizedBox(
                height: mdq.height * 0.01,
              ),
              Row(
                children: [
                  const Text(
                    'Description',
                    style: TextStyle(
                        color: Colors.white,
                        fontWeight: FontWeight.bold,
                        fontSize: 15),
                  ),
                  SizedBox(
                    width: mdq.width * 0.2,
                  ),
                  Expanded(
                    child: Text(
                      '${data['description']}',
                      style: const TextStyle(color: Colors.white),
                    ),
                  ),
                ],
              ),
              SizedBox(
                height: mdq.height * 0.01,
              ),
              Column(
                children: [
                  Row(
                    // mainAxisAlignment: MainAxisAlignment.spaceAround,
                    children: [
                      const Text(
                        'City Name',
                        style: TextStyle(
                            color: Colors.white,
                            fontWeight: FontWeight.bold,
                            fontSize: 14),
                      ),
                      SizedBox(
                        width: mdq.width * 0.2,
                      ),
                      Text(
                        '${data['cityName']}',
                        style: const TextStyle(color: Colors.white),
                      ),
                    ],
                  ),
                  SizedBox(
                    height: mdq.height * 0.01,
                  ),
                  Row(
                    // mainAxisAlignment: MainAxisAlignment.spaceAround,
                    children: [
                      const Text(
                        'Street Name',
                        style: TextStyle(
                            color: Colors.white,
                            fontWeight: FontWeight.bold,
                            fontSize: 14),
                      ),
                      SizedBox(
                        width: mdq.width * 0.2,
                      ),
                      Text(
                        '${data['streetName']}',
                        style: const TextStyle(color: Colors.white),
                      ),
                    ],
                  ),
                  Container(
                    width: double.infinity,
                    height: mdq.height * 0.2,
                    decoration: const BoxDecoration(),
                    child: ListView.builder(
                        scrollDirection: Axis.horizontal,
                        itemCount: cartItem.length,
                        itemBuilder: (context, index) {
                          return Image.network(
                            '${cartItem[index].imageUrl}',
                            width: 200,
                            height: 200,
                            fit: BoxFit.contain,
                          );
                        }),
                  ),
                  SizedBox(
                    height: mdq.height * 0.25,
                  ),
                  GestureDetector(
                    onTap: () async {
                      // await intpayment(
                      //     email: _email!,
                      //     amount: data['totalPrice'],
                      //     item: cartItem);

                      OrderModel orderModel = OrderModel(
                          id: const Uuid().v4(),
                          cartItem: cartItem,
                          countryName: data['cityName'],
                          cityName: data['streetName'],
                          addressDetails: data['addressDetails'],
                          promoCode: data['promo'],
                          description: data['description'],
                          price: data['totalPrice'],
                          userName: name,
                          email: _email);
                      final result = await _order.addOrders(orderModel);

                      if (result == 'success') {
                        Fluttertoast.showToast(msg: 'Item Ordered Succefully');
                        Get.to(() => const HomeScreen());
                      }
                    },
                    child: Container(
                      width: mdq.width * 0.9,
                      height: mdq.height * 0.06,
                      alignment: Alignment.bottomCenter,
                      decoration: const BoxDecoration(
                          color: yellowColor,
                          borderRadius: BorderRadius.all(Radius.circular(10))),
                      child: const Center(
                        child: Text(
                          'Pay now',
                          style: TextStyle(
                              color: Colors.black,
                              fontSize: 15,
                              fontWeight: FontWeight.bold),
                        ),
                      ),
                    ),
                  )
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}
