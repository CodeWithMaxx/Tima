// ignore_for_file: prefer_final_fields, unused_field

import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:tima_app/core/constants/colorConst.dart';
import 'package:tima_app/core/constants/formValidation.dart';
import 'package:tima_app/core/constants/textconst.dart';
import 'package:tima_app/feature/Auth/forgotPassword/builder/forgotPassController.dart';
import 'package:tima_app/router/routes/routerConst.dart';

class ForgotPasswordScreen extends StatefulWidget {
  const ForgotPasswordScreen({super.key});

  @override
  State<ForgotPasswordScreen> createState() => _ForgotPasswordScreenState();
}

class _ForgotPasswordScreenState extends ForgotPasswordController {
  GlobalKey<FormState> changePassKey = GlobalKey<FormState>();
  bool _newpasswordVisible = true;
  bool _confirmpasswordVisible = true;
  bool isloading = false;
  bool errorcurrentpass = true,
      errornewpassword = true,
      errorconfirmpassword = true;

  @override
  void dispose() {
    newPassController.dispose();
    rePassController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return SafeArea(
      child: Scaffold(
        backgroundColor: Colors.white,
        body: isloading
            ? const Align(
                alignment: Alignment.center,
                child: CircularProgressIndicator.adaptive(),
              )
            : Stack(
                children: [
                  Positioned(
                    left: 0,
                    top: 60,
                    child: Container(
                      height: 120,
                      width: 100,
                      color: blueColor,
                    ),
                  ),
                  Container(
                    height: 100,
                    width: double.infinity,
                    decoration: const BoxDecoration(
                        borderRadius:
                            BorderRadius.only(bottomRight: Radius.circular(70)),
                        color: blueColor),
                  ),
                  Padding(
                    padding: const EdgeInsets.only(top: 100),
                    child: Container(
                      padding: const EdgeInsets.symmetric(
                          horizontal: 30, vertical: 20),
                      alignment: Alignment.center,
                      height: double.infinity,
                      width: double.infinity,
                      decoration: const BoxDecoration(
                        borderRadius:
                            BorderRadius.only(topLeft: Radius.circular(70)),
                        color: Colors.white,
                      ),
                      child: SingleChildScrollView(
                        child: Form(
                          key: changePassKey,
                          child: Column(
                            children: [
                              Row(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  txtHelper().heading1Text(
                                      'FORGOT PASSWORD', 23, blueColor),
                                ],
                              ),
                              const SizedBox(
                                height: 30,
                              ),
                              Container(
                                decoration: BoxDecoration(
                                    borderRadius: BorderRadius.circular(15),
                                    color: tfColor),
                                width: size.width,
                                child: TextFormField(
                                  controller: newPassController,
                                  validator:
                                      form_validation.validatenewpassword,
                                  obscureText: _newpasswordVisible,
                                  decoration: InputDecoration(
                                      border: InputBorder.none,
                                      hintText: "New Password",
                                      prefixIcon: const Icon(Icons.password),
                                      suffixIcon: IconButton(
                                          onPressed: () {
                                            setState(() {
                                              _newpasswordVisible =
                                                  !_newpasswordVisible;
                                            });
                                          },
                                          icon: Icon(
                                            _newpasswordVisible
                                                ? Icons.visibility_off
                                                : Icons.visibility,
                                          ))),
                                  onChanged: (text) {
                                    setState(() {
                                      if (text.isEmpty) {
                                        errornewpassword = true;
                                      }
                                    });
                                  },
                                ),
                              ),
                              const SizedBox(
                                height: 20,
                              ),
                              Container(
                                decoration: BoxDecoration(
                                    borderRadius: BorderRadius.circular(15),
                                    color: tfColor),
                                width: size.width,
                                child: TextFormField(
                                  controller: rePassController,
                                  obscureText: _confirmpasswordVisible,
                                  decoration: InputDecoration(
                                      border: InputBorder.none,
                                      hintText: "Confirm Password",
                                      prefixIcon: const Icon(Icons.password),
                                      suffixIcon: IconButton(
                                          onPressed: () {
                                            setState(() {
                                              _confirmpasswordVisible =
                                                  !_confirmpasswordVisible;
                                            });
                                          },
                                          icon: Icon(
                                            _confirmpasswordVisible
                                                ? Icons.visibility_off
                                                : Icons.visibility,
                                          ))),
                                  onChanged: (text) {
                                    setState(() {
                                      if (text.isNotEmpty) {
                                        errornewpassword = true;
                                      }
                                    });
                                  },
                                ),
                              ),
                              const SizedBox(
                                height: 30,
                              ),
                              GestureDetector(
                                onTap: () {
                                  if (changePassKey.currentState!.validate()) {
                                    resetUserPassword();
                                  }
                                },
                                child: Container(
                                  alignment: Alignment.center,
                                  padding: const EdgeInsets.symmetric(
                                      horizontal: 12),
                                  height: 50,
                                  width: 160,
                                  decoration: BoxDecoration(
                                      borderRadius: BorderRadius.circular(25),
                                      color: blueColor),
                                  child: const Row(
                                    mainAxisAlignment:
                                        MainAxisAlignment.spaceBetween,
                                    children: [
                                      Text(
                                        'Confirm',
                                        style: TextStyle(
                                            fontWeight: FontWeight.bold,
                                            fontSize: 17,
                                            color: Colors.white),
                                      ),
                                      Icon(
                                        Icons.arrow_forward,
                                        color: Colors.white,
                                      )
                                    ],
                                  ),
                                ),
                              )
                            ],
                          ),
                        ),
                      ),
                    ),
                  ),
                  Positioned(
                    top: 10,
                    left: 10,
                    child: Container(
                      height: 50,
                      width: 50,
                      decoration: const BoxDecoration(
                          shape: BoxShape.circle, color: Colors.white),
                      child: IconButton(
                        icon: const Icon(
                          Icons.arrow_back_ios_new,
                          color: blueColor,
                        ),
                        onPressed: () {
                          GoRouter.of(context).goNamed(routerConst.loginScreen);
                        },
                      ),
                    ),
                  ),
                  Positioned(
                    top: 10,
                    left: 140,
                    child: txtHelper().heading1Text('TIMA', 27, Colors.white),
                  )
                ],
              ),
      ),
    );
  }
}
