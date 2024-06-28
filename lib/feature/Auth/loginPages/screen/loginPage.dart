import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:go_router/go_router.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:tima_app/core/constants/colorConst.dart';
import 'package:tima_app/core/constants/textconst.dart';
import 'package:tima_app/feature/Auth/loginPages/controller/loginController.dart';
import 'package:tima_app/router/routes/routerConst.dart';

class PhoneEmailLogin extends StatefulWidget {
  const PhoneEmailLogin({super.key});

  @override
  State<PhoneEmailLogin> createState() => _PhoneEmailLoginState();
}

class _PhoneEmailLoginState extends LoginController {
  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        backgroundColor: Colors.white,
        body: Stack(
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
                padding:
                    const EdgeInsets.symmetric(horizontal: 30, vertical: 20),
                alignment: Alignment.center,
                height: double.infinity,
                width: double.infinity,
                decoration: const BoxDecoration(
                  borderRadius: BorderRadius.only(topLeft: Radius.circular(70)),
                  color: Colors.white,
                ),
                child: SingleChildScrollView(
                  scrollDirection: Axis.vertical,
                  child: Form(
                    key: changePassKey,
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            txtHelper()
                                .heading1Text('Mobile LogIn', 25, blueColor),
                          ],
                        ),
                        SizedBox(
                          height: 40.h,
                        ),

                        // ! Email textfield
                        Text(
                          'Email',
                          style: GoogleFonts.aBeeZee(
                              fontWeight: FontWeight.w700,
                              fontSize: 15,
                              color: blueColor),
                        ),
                        SizedBox(
                          height: 8.h,
                        ),
                        Container(
                          alignment: Alignment.centerLeft,
                          padding: const EdgeInsets.only(top: 5),
                          height: 54,
                          width: double.infinity,
                          decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(10),
                              color: tfColor),
                          child: TextFormField(
                            controller: emailController,
                            obscureText: newpasswordVisible,
                            decoration: InputDecoration(
                                border: InputBorder.none,
                                hintText: "Email",
                                prefixIcon: const Icon(Icons.email),
                                suffixIcon: IconButton(
                                    onPressed: () => setState(() {
                                          newpasswordVisible =
                                              !newpasswordVisible;
                                        }),
                                    icon: newpasswordVisible
                                        ? const Icon(Icons.visibility_off)
                                        : const Icon(Icons.visibility))),
                            validator: (value) {
                              if (emailController.text.isEmpty &&
                                  mobileController.text.isEmpty) {
                                return 'Either email or mobile number is required';
                              }
                              return null;
                            },
                          ),
                        ),
                        SizedBox(
                          height: 15.h,
                        ),
                        Center(
                          child: Text(
                            'OR',
                            style: GoogleFonts.poppins(
                                fontSize: 20,
                                fontWeight: FontWeight.bold,
                                color: blueColor),
                          ),
                        ),
                        SizedBox(
                          height: 15.h,
                        ),
                        // ! Email textfield
                        Text(
                          'Mobile Number',
                          style: GoogleFonts.aBeeZee(
                              fontWeight: FontWeight.w700,
                              fontSize: 15,
                              color: blueColor),
                        ),
                        SizedBox(
                          height: 8.h,
                        ),
                        Container(
                          alignment: Alignment.centerLeft,
                          padding: const EdgeInsets.only(top: 5),
                          height: 54,
                          width: double.infinity,
                          decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(10),
                              color: tfColor),
                          child: TextFormField(
                            controller: mobileController,
                            obscureText: newpasswordVisible,
                            decoration: InputDecoration(
                                border: InputBorder.none,
                                hintText: "Mobile",
                                prefixIcon:
                                    const Icon(Icons.phone_android_rounded),
                                suffixIcon: IconButton(
                                    onPressed: () => setState(() {
                                          newpasswordVisible =
                                              !newpasswordVisible;
                                        }),
                                    icon: newpasswordVisible
                                        ? const Icon(Icons.visibility_off)
                                        : const Icon(Icons.visibility))),
                            validator: (value) {
                              if (emailController.text.isEmpty &&
                                  mobileController.text.isEmpty) {
                                return 'Either email or mobile number is required';
                              }
                              return null;
                            },
                          ),
                        ),
                        SizedBox(
                          height: 30.h,
                        ),

                        // !password phone number textfield
                        Text(
                          'Password',
                          style: GoogleFonts.aBeeZee(
                              fontWeight: FontWeight.w700,
                              fontSize: 15,
                              color: blueColor),
                        ),
                        SizedBox(
                          height: 8.h,
                        ),
                        Container(
                          alignment: Alignment.centerLeft,
                          padding: const EdgeInsets.only(top: 5),
                          height: 54,
                          width: double.infinity,
                          decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(10),
                              color: tfColor),
                          child: TextFormField(
                            controller: passController,
                            obscureText: rePasswordVisible,
                            decoration: InputDecoration(
                                border: InputBorder.none,
                                hintText: "Password",
                                prefixIcon: const Icon(Icons.password),
                                suffixIcon: IconButton(
                                    onPressed: () => setState(() {
                                          rePasswordVisible =
                                              !rePasswordVisible;
                                        }),
                                    icon: Icon(
                                      rePasswordVisible
                                          ? Icons.visibility_off
                                          : Icons.visibility,
                                    ))),
                          ),
                        ),

                        SizedBox(
                          height: 50.h,
                        ),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            TextButton(
                                onPressed: () {
                                  // *navigate to forgot password page
                                  // context.pushNamed(routerConst.forgotPage);
                                  GoRouter.of(context)
                                      .goNamed(routerConst.forgotPage);
                                },
                                child: const Text(
                                  'Forgot Password',
                                  style: TextStyle(
                                    fontWeight: FontWeight.bold,
                                    fontSize: 18,
                                  ),
                                )),
                            GestureDetector(
                              onTap: () => setState(() {
                                appLogInAuthentication();
                              }),
                              child: Container(
                                alignment: Alignment.center,
                                padding:
                                    const EdgeInsets.symmetric(horizontal: 12),
                                height: 50.h,
                                width: 120.w,
                                decoration: BoxDecoration(
                                    borderRadius: BorderRadius.circular(25),
                                    color: blueColor),
                                child: const Row(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceBetween,
                                  children: [
                                    Text(
                                      'LogIn',
                                      style: TextStyle(
                                          fontWeight: FontWeight.bold,
                                          fontSize: 17,
                                          color: Colors.white),
                                    ),
                                    Icon(
                                      Icons.navigate_next,
                                      color: Colors.white,
                                    )
                                  ],
                                ),
                              ),
                            ),
                          ],
                        ),
                        SizedBox(
                          height: 70.h,
                        )
                      ],
                    ),
                  ),
                ),
              ),
            ),
            Positioned(
              top: 10.h,
              left: 140.w,
              child: txtHelper().heading1Text('Tima', 27, Colors.white),
            )
          ],
        ),
      ),
    );
  }
}
