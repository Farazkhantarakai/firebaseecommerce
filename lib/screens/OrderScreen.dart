import 'package:firebase_ecommerce/utils/constants.dart';
import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';

import '../providers/order.dart';

class OrderScreen extends StatefulWidget {
  const OrderScreen({super.key});

  @override
  State<OrderScreen> createState() => _OrderScreenState();
}

class _OrderScreenState extends State<OrderScreen>
    with SingleTickerProviderStateMixin {
  final orderController = Get.put(Order());

  late AnimationController _animationController;

  @override
  void initState() {
    getOrder();
    _animationController = AnimationController(
        vsync: this, duration: const Duration(seconds: 1200));
    super.initState();
  }

  getOrder() async {
    await orderController.fetchOrders();
  }

  @override
  void dispose() {
    _animationController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: backAppColor,
        body: SafeArea(
          child: Column(
            children: [
              const Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text(
                    'Ordered Items',
                    style: TextStyle(
                        color: Colors.white24,
                        fontSize: 18,
                        fontWeight: FontWeight.bold),
                  )
                ],
              ),
              FutureBuilder(
                  future: orderController.fetchOrders(),
                  builder: (context, snapshot) {
                    if (snapshot.connectionState == ConnectionState.waiting) {
                      return Center(
                        child: SpinKitThreeBounce(
                            size: 25,
                            color: Colors.white,
                            controller: _animationController),
                      );
                    } else {
                      return Expanded(
                        child: ListView.builder(
                            itemCount: snapshot.data!.length,
                            itemBuilder: (context, index) {
                              final _dateTime = DateFormat('yMd').format(
                                  DateTime.fromMicrosecondsSinceEpoch(
                                      snapshot.data![index].dateTime!));

                              return Card(
                                color: blackColor,
                                margin: const EdgeInsets.all(10),
                                elevation: 2,
                                shadowColor: Colors.white,
                                child: ListTile(
                                  leading: Text(
                                    '${index + 1}',
                                    style: const TextStyle(color: Colors.white),
                                  ),
                                  title: Text(
                                    '${snapshot.data![index].price}',
                                    style: const TextStyle(color: Colors.white),
                                  ),
                                  subtitle: Text(
                                    _dateTime,
                                    style: const TextStyle(
                                        color: Colors.white, fontSize: 12),
                                  ),
                                ),
                              );
                            }),
                      );
                    }
                  }),
            ],
          ),
        ));
  }
}
