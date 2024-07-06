// ignore_for_file: must_be_immutable

import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:provider/provider.dart';
import 'package:tima_app/feature/NavBar/report/provider/reportProvder.dart';
import 'package:tima_app/providers/LocationProvider/location_provider.dart';
import 'package:tima_app/providers/inquireyProvider/inquiry_provider.dart';
import 'package:tima_app/router/routes/routerConfig.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();

  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  MyApp({super.key});
  GlobalKey<NavigatorState> navigatorKey = GlobalKey<NavigatorState>();

  @override
  Widget build(BuildContext context) {
    return ScreenUtilInit(
      // * dependency injection for mulitblocproviders
      child: MultiProvider(
        providers: [
          ChangeNotifierProvider(create: (_) => LocationProvider()),
          ChangeNotifierProvider(create: (_) => InquiryProvider()),
          ChangeNotifierProvider(create: (_) => ReportProvider()),
        ],
        child: MaterialApp.router(
          theme: ThemeData(
              scaffoldBackgroundColor: Colors.white,
              bottomNavigationBarTheme: const BottomNavigationBarThemeData(
                  backgroundColor: Colors.transparent, elevation: 0)),
          debugShowCheckedModeBanner: false,
          routerConfig: routerConfigue().pageRouter,
          builder: FToastBuilder(),
          key: navigatorKey,
        ),
      ),
    );
  }
}
