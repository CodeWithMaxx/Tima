// ignore_for_file: unused_label
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:tima_app/core/constants/colorConst.dart';
import 'package:tima_app/core/constants/textconst.dart';
import 'package:tima_app/feature/LogOut/logout.dart';
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
          title: txtHelper().heading1Text('TIMA', 23, blueColor),
          actions: [
            IconButton(
                onPressed: () => showDialog(
                      context: context,
                      builder: (BuildContext context) {
                        return CustomDialog();
                      },
                    ),
                icon: const Icon(
                  CupertinoIcons.settings_solid,
                  color: greyColor,
                  size: 27,
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
            timaHomeLogo != null
                ? txtHelper()
                    .heading1Text(timaHomeLogo.toString(), 25, blueColor)
                : txtHelper().heading1Text('Powered by TIMA', 25, blueColor)
          ],
        ),
        drawer: TimaAppDrawer,
      ),
    );
  }
}
