import 'dart:async';

import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:lottie/lottie.dart';
import 'package:tima_app/router/routes/routerConst.dart';

class HomeLoadingAnimation extends StatefulWidget {
  const HomeLoadingAnimation({super.key});

  @override
  State<HomeLoadingAnimation> createState() => _HomeLoadingAnimationState();
}

class _HomeLoadingAnimationState extends State<HomeLoadingAnimation> {
  @override
  void initState() {
    Timer(const Duration(seconds: 2), () {
      GoRouter.of(context).goNamed(routerConst.homeNavBar);
    });
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Lottie.asset('assets/loading.json', height: 70, width: 70),
    );
  }
}
