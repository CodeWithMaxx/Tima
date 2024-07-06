// ignore_for_file: unused_label
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:tima_app/core/constants/colorConst.dart';
import 'package:tima_app/core/constants/textconst.dart';
import 'package:tima_app/feature/home/builder/homeBuilder.dart';

class Home extends StatefulWidget {
  const Home({super.key});

  @override
  State<Home> createState() => _HomeState();
}

class _HomeState extends HomeBuilder with WidgetsBindingObserver {
  @override
  void initState() {
    WidgetsBinding.instance.addObserver(this);
    callHomeBannerFromApi();
    usreInit();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        backgroundColor: Colors.white,
        appBar: AppBar(
          backgroundColor: Colors.white,
          centerTitle: true,
          title: Text(
            "Tima",
            style: GoogleFonts.poppins(
                fontSize: 22.w, color: greyColor, fontWeight: FontWeight.bold),
          ),
          actions: [
            IconButton(
                onPressed: () {},
                icon: const Icon(
                  Icons.notifications_active,
                  color: greyColor,
                ))
          ],
        ),
        body: Column(
          children: [
            SizedBox(
              height: 10.h,
            ),
            Container(
                alignment: Alignment.center,
                height: 180,
                width: double.infinity,
                margin: const EdgeInsets.only(
                  left: 12,
                  right: 12,
                ),
                decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(10),
                    color: secondryGreyColor.withOpacity(.5)),
                child: ImageSlider()),
            SizedBox(
              height: 60.h,
            ),
            ClipRRect(
              borderRadius: BorderRadius.circular(8),
              child: Image.asset(
                'assets/timaApplogo.jpg',
                height: 100,
                width: 100,
                fit: BoxFit.cover,
              ),
            ),
            SizedBox(
              height: 20.h,
            ),
            txtHelper().heading1Text(timaHomeLogo.toString(), 25, blueColor),
          ],
        ),
        drawer: TimaAppDrawer,
      ),
    );
  }
}
