import 'package:get/get.dart';
import 'package:tima_app/Admin/screen/requestAdmin.dart';
import 'package:tima_app/Error/401.dart';
import 'package:tima_app/feature/Auth/forgotPassword/screen/forgotPassword.dart';
import 'package:tima_app/feature/Auth/forgotPassword/screen/home_forgot_pass.dart';
import 'package:tima_app/feature/Auth/loginPages/screen/loginPage.dart';
import 'package:tima_app/feature/Auth/register/screen/register.dart';
import 'package:tima_app/feature/NavBar/home/homeNavBar.dart';
import 'package:tima_app/feature/attendence/screen/markAttendenc.dart';
import 'package:tima_app/feature/drawerPage/homeLocation/homelocation.dart';
import 'package:tima_app/feature/drawerPage/inquiry/createInquiry/screen/createInqueryPage.dart';
import 'package:tima_app/feature/drawerPage/inquiry/generateInquiry/screen/generateInquiry.dart';
import 'package:tima_app/feature/drawerPage/inquiry/reciveInquiry/screen/reciveInquiry.dart';
import 'package:tima_app/feature/home/screen/home.dart';
import 'package:tima_app/feature/splashScreen/splashScreen.dart';
import 'package:tima_app/router/routes/routerConst.dart';

class AppRoutes {
  static List<GetPage> routes = [
    GetPage(name: routerConst.homeNavBar, page: () => HomeNavBar()),
    GetPage(name: routerConst.homePage, page: () => Home()),
    GetPage(name: routerConst.registerScreen, page: () => RegisterScreen()),
    GetPage(name: routerConst.createInquiryPage, page: () => CreateInquiry()),
    GetPage(name: routerConst.forgotPage, page: () => ForgotPasswordScreen()),
    GetPage(
        name: routerConst.homeUpdateLocation, page: () => HomeMapLocation()),
    GetPage(name: routerConst.homeForgotPass, page: () => HomeForgotPass()),
    GetPage(name: routerConst.error401, page: () => Error401Page()),
    GetPage(name: routerConst.splashScreen, page: () => SplashScreen()),
    GetPage(name: routerConst.markAttendence, page: () => Markattendance()),
    GetPage(name: routerConst.loginScreen, page: () => PhoneEmailLogin()),
    // GetPage(name: routerConst.visitDetailScreen, page: () => VisitDeatil(visitDetailScreenParams:VisitDetailScreenParams())),
    // GetPage(name: routerConst.inquiryDetailScreen, page: () => InquiryDeatil()),
    GetPage(name: routerConst.requestAdmin, page: () => RequestAdmin()),
    GetPage(name: routerConst.recivedInquiry, page: () => ReciveInquiry()),
    GetPage(name: routerConst.generateInquiry, page: () => Generateinquiry()),
    // GetPage(name: routerConst.homePage, page: () => Home()),
  ];
}
