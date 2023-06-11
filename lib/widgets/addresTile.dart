import 'package:firebase_ecommerce/controller/getLocation.dart';
import 'package:firebase_ecommerce/utils/constants.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class AddressTile extends StatefulWidget {
  const AddressTile(
      {super.key, required this.changeTile, required this.addressDetail});

  final Function changeTile;
  final Function addressDetail;

  @override
  State<AddressTile> createState() => _AddressTileState();
}

class _AddressTileState extends State<AddressTile> {
  final controllerLocation = Get.put(LocationD());
  bool showLocationDetails = false;

  final _descriptionController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(builder: (context, constraints) {
      return Container(
        width: double.infinity,
        height: constraints.maxHeight,
        padding: const EdgeInsets.all(10),
        decoration: const BoxDecoration(
            color: yellowColor,
            borderRadius: BorderRadius.all(Radius.circular(10))),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Column(
                    mainAxisAlignment: !showLocationDetails
                        ? MainAxisAlignment.spaceEvenly
                        : MainAxisAlignment.start,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      const Text(
                        'Send to',
                        style: TextStyle(
                            fontSize: 13, fontWeight: FontWeight.bold),
                      ),
                      SizedBox(
                        height: constraints.maxHeight * 0.02,
                      ),
                      Obx(() => Text(
                            controllerLocation.getCityName,
                            style: const TextStyle(
                                color: Colors.black,
                                fontSize: 17,
                                fontWeight: FontWeight.bold),
                          )),
                      SizedBox(
                        height: constraints.maxHeight * 0.02,
                      ),
                      Obx(() => Text(
                            controllerLocation.getStreetName,
                            style: const TextStyle(
                                fontSize: 14, fontWeight: FontWeight.w500),
                          )),
                    ],
                  ),
                ),
                Column(
                  mainAxisAlignment: !showLocationDetails
                      ? MainAxisAlignment.center
                      : MainAxisAlignment.start,
                  children: [
                    IconButton(
                        onPressed: () {
                          setState(() {
                            showLocationDetails = !showLocationDetails;
                            widget.changeTile(showLocationDetails);
                          });
                        },
                        icon: !showLocationDetails
                            ? const Icon(
                                Icons.expand_more,
                                color: Colors.black,
                              )
                            : const Icon(
                                Icons.expand_less,
                                color: Colors.black,
                              ))
                  ],
                ),
              ],
            ),
            showLocationDetails
                ? Expanded(
                    child: TextField(
                      controller: _descriptionController,
                      maxLines: 2,
                      cursorColor: Colors.black,
                      onChanged: (value) {
                        setState(() {
                          widget.addressDetail(value);
                        });
                      },
                      decoration: const InputDecoration(
                          border: InputBorder.none,
                          contentPadding: EdgeInsets.only(bottom: 10),
                          hintText: 'Enter All your Address Details',
                          hintStyle:
                              TextStyle(color: Colors.black, fontSize: 13)),
                      style: const TextStyle(color: Colors.black),
                    ),
                  )
                : Container()
          ],
        ),
      );
    });
  }
}
