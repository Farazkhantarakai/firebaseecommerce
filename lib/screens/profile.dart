import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_ecommerce/providers/firestoreMethods.dart';
import 'package:firebase_ecommerce/utils/constants.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:image_picker/image_picker.dart';

class Profile extends StatefulWidget {
  const Profile({
    super.key,
  });

  static const routName = 'Profile';

  // final String email;
  // final String name;

  @override
  State<Profile> createState() => _ProfileState();
}

class _ProfileState extends State<Profile> {
  final fireController = FirestoreMethods();

  Uint8List? image;
  String? imageUrl;
  bool isLoading = true;
  String? email;
  String? name;
  String? _email;
  String? _fullName;
  String? _phoneNumber;
  void pickImage() async {
    final picker = ImagePicker();
    XFile? pickedImage =
        await picker.pickImage(source: ImageSource.gallery, imageQuality: 50);
    if (pickedImage == null) return null;
    final bytes = await pickedImage.readAsBytes();
    setState(() {
      image = Uint8List.view(bytes.buffer);
    });
    String imageUrl = await fireController.uploadImage(image!);
    await fireController.uploadProfile(imageUrl);
  }

  @override
  void initState() {
    getProfile();
    super.initState();
  }

  getProfile() async {
    fireController.getProfilePic().then((value) {
      setState(() {
        isLoading = true;
        imageUrl = value['imageUrl'];
        email = value['email'];
        name = value['name'];
        _phoneNumber = value['phoneNumber'];

        if (kDebugMode) {
          print(imageUrl);
        }
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: backAppColor,
        body: SafeArea(
          child: Padding(
              padding: const EdgeInsets.all(20),
              child: ListView(children: [
                const Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text(
                      'Profile',
                      style: TextStyle(color: Colors.white, fontSize: 20),
                    )
                  ],
                ),
                const SizedBox(
                  height: 30,
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Stack(
                      children: [
                        if (imageUrl != null)
                          (imageUrl != '' && image == null)
                              ? CircleAvatar(
                                  maxRadius: 50,
                                  backgroundImage: NetworkImage(imageUrl!),
                                )
                              : image == null && imageUrl == ''
                                  ? const CircleAvatar(
                                      maxRadius: 50,
                                      backgroundImage:
                                          AssetImage('asset/icons/user.png'),
                                    )
                                  : CircleAvatar(
                                      maxRadius: 50,
                                      backgroundImage: MemoryImage(image!),
                                    ),
                        Positioned(
                            right: -10,
                            bottom: -10,
                            child: IconButton(
                              onPressed: pickImage,
                              icon: const Icon(
                                Icons.add_a_photo,
                                color: Colors.white,
                              ),
                            ))
                      ],
                    ),
                  ],
                ),
                const SizedBox(
                  height: 20,
                ),
                Form(
                  // key: _formKey,
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.spaceAround,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: <Widget>[
                      const SizedBox(
                        height: 10,
                      ),
                      TextFormField(
                        initialValue: email,
                        style: const TextStyle(color: Colors.white),
                        keyboardType: TextInputType.emailAddress,
                        validator: (value) {
                          if (value!.isEmpty) {
                            return 'email cannot be empty';
                          } else if (!value.contains('@')) {
                            return '@ is missing';
                          } else if (!value.endsWith('.com')) {
                            return '.com is missing';
                          }
                          return null;
                        },
                        onChanged: (value) {
                          _email = value;
                        },
                        decoration: const InputDecoration(
                            prefixIcon: Padding(
                              padding: EdgeInsets.only(right: 10),
                              child: Icon(
                                Icons.email,
                                color: Colors.white,
                                size: 30,
                              ),
                            ),
                            prefixIconConstraints:
                                BoxConstraints(minWidth: 10, minHeight: 0),
                            contentPadding: EdgeInsets.symmetric(vertical: 10),
                            hintText: 'Email',
                            hintStyle: TextStyle(color: whiteColor),
                            enabledBorder: UnderlineInputBorder(
                                borderSide: BorderSide(color: whiteColor)),
                            focusedBorder: UnderlineInputBorder(
                                borderSide: BorderSide(color: whiteColor))),
                      ),
                      const SizedBox(
                        height: 15,
                      ),
                      TextFormField(
                        initialValue: name,
                        keyboardType: TextInputType.text,
                        style: const TextStyle(color: Colors.white),
                        validator: (value) {
                          if (value!.isEmpty) {
                            return 'Field can not be null';
                          }
                          return null;
                        },
                        onChanged: (value) {
                          _fullName = value;
                        },
                        decoration: const InputDecoration(
                            prefixIcon: Padding(
                              padding: EdgeInsets.only(right: 10),
                              child: Icon(
                                Icons.person,
                                color: Colors.white,
                                size: 30,
                              ),
                            ),
                            prefixIconConstraints:
                                BoxConstraints(minWidth: 10, minHeight: 0),
                            contentPadding: EdgeInsets.symmetric(vertical: 10),
                            hintText: 'Name',
                            hintStyle: TextStyle(color: whiteColor),
                            enabledBorder: UnderlineInputBorder(
                                borderSide: BorderSide(color: whiteColor)),
                            focusedBorder: UnderlineInputBorder(
                                borderSide: BorderSide(color: whiteColor))),
                      ),
                      const SizedBox(
                        height: 15,
                      ),
                      TextFormField(
                        initialValue: _phoneNumber,
                        keyboardType: TextInputType.text,
                        style: const TextStyle(color: Colors.white),
                        validator: (value) {
                          if (value!.isEmpty) {
                            return 'Field can not be null';
                          }
                          return null;
                        },
                        onChanged: (value) {
                          _phoneNumber = value;
                        },
                        decoration: const InputDecoration(
                            prefixIcon: Padding(
                              padding: EdgeInsets.only(right: 10),
                              child: Icon(
                                Icons.phone,
                                color: Colors.white,
                                size: 30,
                              ),
                            ),
                            prefixIconConstraints:
                                BoxConstraints(minWidth: 10, minHeight: 0),
                            contentPadding: EdgeInsets.symmetric(vertical: 10),
                            hintText: 'Phone Number',
                            hintStyle: TextStyle(color: whiteColor),
                            enabledBorder: UnderlineInputBorder(
                                borderSide: BorderSide(color: whiteColor)),
                            focusedBorder: UnderlineInputBorder(
                                borderSide: BorderSide(color: whiteColor))),
                      ),
                      const SizedBox(
                        height: 15,
                      ),
                      SizedBox(
                        width: 300,
                        height: 50,
                        child: ElevatedButton(
                            style: ElevatedButton.styleFrom(
                              backgroundColor: Colors.white,
                            ),
                            onPressed: () {
                              setState(() async {
                                final result =
                                    await fireController.updateProfileInfo(
                                        _fullName!.trim(),
                                        _email!.trim(),
                                        _phoneNumber!.trim());

                                if (result == 'success') {
                                  Fluttertoast.showToast(
                                      msg: 'Profile Updated Succeffuly',
                                      backgroundColor: backAppColor);
                                }
                              });
                            },
                            child: const Text(
                              'Update',
                              style: TextStyle(
                                  fontSize: 18,
                                  color: Colors.black,
                                  fontWeight: FontWeight.bold),
                            )),
                      ),
                      const SizedBox(
                        height: 10,
                      ),
                      SizedBox(
                        width: 300,
                        height: 50,
                        child: ElevatedButton(
                            style: ElevatedButton.styleFrom(
                              backgroundColor: Colors.white,
                            ),
                            onPressed: () {
                              setState(() {
                                FirebaseAuth.instance.signOut();
                              });
                            },
                            child: const Text(
                              'LogOut',
                              style: TextStyle(
                                  fontSize: 18,
                                  color: Colors.black,
                                  fontWeight: FontWeight.bold),
                            )),
                      )
                    ],
                  ),
                )
              ])),
        ));
  }
}
