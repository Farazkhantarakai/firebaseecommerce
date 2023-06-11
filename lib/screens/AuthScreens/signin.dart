import 'package:firebase_ecommerce/controller/getLocation.dart';
import 'package:firebase_ecommerce/providers/authMethods.dart';
import 'package:firebase_ecommerce/screens/AuthScreens/signup.dart';
import 'package:firebase_ecommerce/screens/bottom.dart';
import 'package:firebase_ecommerce/utils/constants.dart';
import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart' as fa;
import 'package:get/get.dart';

class SignIn extends StatefulWidget {
  const SignIn({super.key});

  @override
  State<SignIn> createState() => _SignInState();
}

class _SignInState extends State<SignIn> with SingleTickerProviderStateMixin {
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();

  final TextEditingController _emailController = TextEditingController();

  final TextEditingController _passwordController = TextEditingController();
  bool isVisible = true;
  final AuthMethods _firestoreMethods = AuthMethods();
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
              size: 25, color: Colors.white, controller: _animationController)
          : Padding(
              padding: const EdgeInsets.only(left: 19, right: 19),
              child: SingleChildScrollView(
                child: Column(
                  children: [
                    SizedBox(
                      height: mdq.height * 0.15,
                    ),
                    const Text(
                      'Welcome Back!',
                      style: TextStyle(
                          color: Colors.white,
                          fontSize: 21,
                          fontWeight: FontWeight.bold),
                      textAlign: TextAlign.center,
                    ),
                    const Text(
                      'Login to continue',
                      style: TextStyle(
                          fontSize: 15,
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
                                  prefixIconConstraints: BoxConstraints(
                                      minWidth: 10, minHeight: 0),
                                  contentPadding:
                                      EdgeInsets.symmetric(vertical: 10),
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
                                      minWidth: 0, minHeight: 0),
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
                            SizedBox(
                              height: mdq.height * 0.02,
                            ),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.end,
                              children: [
                                GestureDetector(
                                    onTap: () {},
                                    child: const Text(
                                      'Forgot Password',
                                      textAlign: TextAlign.end,
                                      style: TextStyle(
                                          decoration: TextDecoration.underline,
                                          color: Colors.white),
                                    )),
                              ],
                            ),
                            SizedBox(height: mdq.height * 0.05),
                            const Text(
                              'OR SIGNIN WITH',
                              style: TextStyle(color: Colors.white),
                              textAlign: TextAlign.center,
                            ),
                            SizedBox(
                              height: mdq.height * 0.06,
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
                                      final controller = Get.put(LocationD());
                                      controller.determinePosition();
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
                                  setState(() {
                                    isLoading = true;
                                    debugPrint(isLoading.toString());
                                  });

                                  final result =
                                      await _firestoreMethods.signInWithEmail(
                                          _emailController.text,
                                          _passwordController.text);

                                  if (result == 'success') {
                                    final controller = Get.put(LocationD());
                                    controller.determinePosition();
                                    setState(() {
                                      isLoading = false;
                                    });
                                    showToast('Logged In Succefful');

                                    Get.off(() => const BottomBar());
                                  } else {
                                    setState(() {
                                      isLoading = false;
                                    });
                                  }
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
                                    'SignIn',
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
                        debugPrint('i am pressed');
                        Get.to(() => const SignUp());
                      },
                      child: const Text(
                        'CREATE ACCOUNT',
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
