import 'package:firebase_ecommerce/providers/authMethods.dart';
import 'package:firebase_ecommerce/screens/AuthScreens/signin.dart';
import 'package:firebase_ecommerce/screens/bottom.dart';
import 'package:firebase_ecommerce/utils/constants.dart';
import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart' as fa;
import 'package:get/get.dart';

class SignUp extends StatefulWidget {
  const SignUp({super.key});

  @override
  State<SignUp> createState() => _SignUpState();
}

class _SignUpState extends State<SignUp> with TickerProviderStateMixin {
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();
  final TextEditingController _nameController = TextEditingController();
  final TextEditingController _phoneNumber = TextEditingController();
  bool isVisible = true;
  final AuthMethods firestoreMethods = AuthMethods();
  bool isLoading = false;
  late AnimationController _animationController;

  @override
  void initState() {
    super.initState();
    _animationController = AnimationController(
        vsync: this, duration: const Duration(milliseconds: 1200));
  }

  @override
  void dispose() {
    super.dispose();
    _animationController.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final mdq = MediaQuery.of(context).size;

    return Scaffold(
      backgroundColor: blackColor,
      body: isLoading
          ? SpinKitThreeBounce(
              size: 25,
              color: Colors.white,
              controller: _animationController,
            )
          : Padding(
              padding: const EdgeInsets.only(left: 19, right: 19),
              child: SingleChildScrollView(
                child: Column(
                  children: [
                    SizedBox(
                      height: mdq.height * 0.15,
                    ),
                    const Text(
                      'SignUp',
                      style: TextStyle(
                          fontSize: 20,
                          fontWeight: FontWeight.bold,
                          color: Colors.white),
                      textAlign: TextAlign.center,
                    ),
                    SizedBox(
                      height: mdq.height * 0.1,
                    ),
                    Form(
                        key: _formKey,
                        child: Column(
                          children: [
                            TextFormField(
                              controller: _nameController,
                              cursorColor: Colors.white,
                              style: const TextStyle(color: Colors.white),
                              validator: (value) {
                                if (value!.isEmpty) {
                                  return 'Please enter your name';
                                }
                                return null;
                              },
                              decoration: const InputDecoration(
                                  prefixIcon: Padding(
                                    padding: EdgeInsets.only(right: 10),
                                    child: Icon(
                                      Icons.person,
                                      color: Colors.white,
                                      size: 20,
                                    ),
                                  ),
                                  prefixIconConstraints:
                                      BoxConstraints(minWidth: 0, minHeight: 0),
                                  hintText: 'Name',
                                  hintStyle: TextStyle(color: Colors.white),
                                  enabledBorder: UnderlineInputBorder(
                                      borderSide:
                                          BorderSide(color: Colors.white)),
                                  focusedBorder: UnderlineInputBorder(
                                      borderSide:
                                          BorderSide(color: Colors.white))),
                            ),
                            SizedBox(
                              height: mdq.height * 0.02,
                            ),
                            TextFormField(
                              controller: _emailController,
                              cursorColor: Colors.white,
                              style: const TextStyle(color: Colors.white),
                              validator: (value) {
                                if (value!.isEmpty) {
                                  return 'Please enter your email';
                                }
                                return null;
                              },
                              decoration: const InputDecoration(
                                  prefixIcon: Padding(
                                    padding: EdgeInsets.only(right: 10),
                                    child: Icon(
                                      Icons.email,
                                      color: Colors.white,
                                      size: 20,
                                    ),
                                  ),
                                  prefixIconConstraints:
                                      BoxConstraints(minWidth: 0, minHeight: 0),
                                  hintText: 'Email',
                                  hintStyle: TextStyle(color: Colors.white),
                                  enabledBorder: UnderlineInputBorder(
                                      borderSide:
                                          BorderSide(color: Colors.white)),
                                  focusedBorder: UnderlineInputBorder(
                                      borderSide:
                                          BorderSide(color: Colors.white))),
                            ),
                            SizedBox(
                              height: mdq.height * 0.02,
                            ),
                            TextFormField(
                              controller: _phoneNumber,
                              cursorColor: Colors.white,
                              style: const TextStyle(color: Colors.white),
                              validator: (value) {
                                if (value!.isEmpty) {
                                  return 'Please enter your email';
                                }
                                return null;
                              },
                              decoration: const InputDecoration(
                                  prefixIcon: Padding(
                                    padding: EdgeInsets.only(right: 10),
                                    child: Icon(
                                      Icons.phone,
                                      color: Colors.white,
                                      size: 20,
                                    ),
                                  ),
                                  prefixIconConstraints:
                                      BoxConstraints(minWidth: 0, minHeight: 0),
                                  hintText: 'Phone Number',
                                  hintStyle: TextStyle(color: Colors.white),
                                  enabledBorder: UnderlineInputBorder(
                                      borderSide:
                                          BorderSide(color: Colors.white)),
                                  focusedBorder: UnderlineInputBorder(
                                      borderSide:
                                          BorderSide(color: Colors.white))),
                            ),
                            SizedBox(
                              height: mdq.height * 0.02,
                            ),
                            TextFormField(
                              controller: _passwordController,
                              cursorColor: Colors.white,
                              style: const TextStyle(color: Colors.white),
                              validator: (value) {
                                if (value!.isEmpty) {
                                  return 'Please enter your password';
                                }
                                return null;
                              },
                              obscureText: isVisible,
                              decoration: InputDecoration(
                                  prefixIcon: const Padding(
                                    padding: EdgeInsets.only(right: 10),
                                    child: Icon(
                                      Icons.lock,
                                      color: Colors.white,
                                      size: 20,
                                    ),
                                  ),
                                  prefixIconConstraints: const BoxConstraints(
                                      minHeight: 0, minWidth: 0),
                                  suffixIcon: IconButton(
                                      onPressed: () {
                                        setState(() {
                                          isVisible = !isVisible;
                                        });
                                      },
                                      icon: isVisible
                                          ? const Icon(
                                              Icons.visibility,
                                              color: Colors.white,
                                            )
                                          : const Icon(
                                              Icons.visibility_off,
                                              color: Colors.white,
                                            )),
                                  hintText: 'Password',
                                  hintStyle:
                                      const TextStyle(color: Colors.white),
                                  enabledBorder: const UnderlineInputBorder(
                                      borderSide:
                                          BorderSide(color: Colors.white)),
                                  focusedBorder: const UnderlineInputBorder(
                                      borderSide:
                                          BorderSide(color: Colors.white))),
                            ),
                            const SizedBox(height: 8.0),
                            SizedBox(height: mdq.height * 0.04),
                            const Text(
                              'OR SIGNUP WITH',
                              style: TextStyle(color: Colors.white),
                              textAlign: TextAlign.center,
                            ),
                            SizedBox(
                              height: mdq.height * 0.04,
                            ),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Container(
                                  width: mdq.width * 0.4,
                                  height: mdq.height * 0.05,
                                  decoration:
                                      const BoxDecoration(color: Colors.blue),
                                  child: const Center(
                                      child: Row(
                                    mainAxisAlignment: MainAxisAlignment.center,
                                    children: [
                                      fa.FaIcon(
                                        fa.FontAwesomeIcons.facebook,
                                        color: Colors.white,
                                      ),
                                      SizedBox(
                                        width: 5,
                                      ),
                                      Text(
                                        'Facebook',
                                        style: TextStyle(color: Colors.white),
                                      )
                                    ],
                                  )),
                                ),
                                GestureDetector(
                                  onTap: () async {
                                    setState(() {
                                      isLoading = true;
                                    });

                                    final result = await AuthMethods()
                                        .googleSignInFunction();

                                    if (result == 'success') {
                                      setState(() {
                                        isLoading = false;
                                      });
                                      Get.off(() => const BottomBar());
                                    } else {
                                      setState(() {
                                        isLoading = false;
                                      });
                                    }
                                  },
                                  child: Container(
                                    width: mdq.width * 0.4,
                                    height: mdq.height * 0.05,
                                    decoration: const BoxDecoration(
                                        color: Colors.white),
                                    child: const Center(
                                        child: Row(
                                      mainAxisAlignment:
                                          MainAxisAlignment.center,
                                      children: [
                                        fa.FaIcon(
                                          fa.FontAwesomeIcons.google,
                                          color:
                                              Color.fromARGB(255, 158, 41, 41),
                                        ),
                                        SizedBox(
                                          width: 5,
                                        ),
                                        Text(
                                          'Google',
                                          style: TextStyle(
                                              fontWeight: FontWeight.bold,
                                              fontSize: 13),
                                        )
                                      ],
                                    )),
                                  ),
                                )
                              ],
                            ),
                            SizedBox(
                              height: mdq.height * 0.04,
                            ),
                            GestureDetector(
                              onTap: () async {
                                if (_formKey.currentState!.validate()) {
                                  // Form is valid, do something with the data
                                  // String email = _emailController.text;
                                  // String password = _passwordController.text;
                                  setState(() {
                                    isLoading = true;
                                  });
                                  final result = await firestoreMethods
                                      .signUpWithEmailAndPassword(
                                          _emailController.text,
                                          _passwordController.text,
                                          _nameController.text,
                                          _phoneNumber.text);

                                  if (result == 'success') {
                                    setState(() {
                                      isLoading = true;
                                    });
                                    showToast('user Registered Succefuly');

                                    Get.off(() => const SignIn());
                                  } else {
                                    setState(() {
                                      isLoading = false;
                                    });
                                  }

                                  // debugPrint('Email: $email');
                                  // debugPrint('Password: $password');
                                }
                              },
                              child: Container(
                                width: double.infinity,
                                height: mdq.height * 0.07,
                                decoration: const BoxDecoration(
                                    color: yellowColor,
                                    borderRadius:
                                        BorderRadius.all(Radius.circular(25))),
                                child: const Center(
                                  child: Text(
                                    'SignUp',
                                    style: TextStyle(
                                        color: Colors.white,
                                        fontWeight: FontWeight.bold,
                                        fontSize: 18),
                                  ),
                                ),
                              ),
                            ),
                          ],
                        )),
                    SizedBox(
                      height: mdq.height * 0.1,
                    ),
                    GestureDetector(
                      onTap: () {
                        Get.to(() => const SignIn());
                      },
                      child: const Text(
                        'LOG IN',
                        style: TextStyle(
                            color: Colors.white,
                            fontSize: 15,
                            decoration: TextDecoration.underline),
                      ),
                    )
                  ],
                ),
              ),
            ),
    );
  }
}
