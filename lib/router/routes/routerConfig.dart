import 'package:go_router/go_router.dart';
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
import 'package:tima_app/feature/drawerPage/inquiry/inquiryDetails/screen/inquiryDetail.dart';
import 'package:tima_app/feature/drawerPage/inquiry/reciveInquiry/screen/reciveInquiry.dart';
import 'package:tima_app/feature/home/screen/home.dart';
import 'package:tima_app/feature/splashScreen/splashScreen.dart';
import 'package:tima_app/feature/visit/visitDetails/visitDetail.dart';
import 'package:tima_app/router/routeParams/inquiryDetailParams.dart';
import 'package:tima_app/router/routeParams/nextVisitParams.dart';
import 'package:tima_app/router/routes/routerConst.dart';

class routerConfigue {
  final GoRouter pageRouter =
      GoRouter(initialLocation: routerConst.homeNavBar, routes: [
    // !home page
    GoRoute(
      path: routerConst.homePage,
      name: routerConst.homePage,
      builder: (context, state) {
        return const Home();
      },
    ),

    // ! register screen
    GoRoute(
      path: routerConst.registerScreen,
      name: routerConst.registerScreen,
      builder: (context, state) {
        String inquiryID = state.extra as String;
        return RegisterScreen(
          inquryID: inquiryID,
        );
      },
    ),

    // !loginScreem Inquiry page
    GoRoute(
      path: routerConst.createInquiryPage,
      name: routerConst.createInquiryPage,
      builder: (context, state) {
        return const CreateInquiry();
      },
    ),

    // !forgot page
    GoRoute(
      path: routerConst.forgotPage,
      name: routerConst.forgotPage,
      builder: (context, state) {
        return const ForgotPasswordScreen();
      },
    ),

    // !NavigationBar LogIn
    GoRoute(
      path: routerConst.homeNavBar,
      name: routerConst.homeNavBar,
      builder: (context, state) {
        return HomeNavBar();
      },
    ),

    // ! update home location
    GoRoute(
      path: routerConst.homeUpdateLocation,
      name: routerConst.homeUpdateLocation,
      builder: (context, state) {
        return const HomeMapLocation();
      },
    ),

    // ! loading animation for home
    // GoRoute(
    //   path: routerConst.globalNavBar,
    //   name: routerConst.globalNavBar,
    //   builder: (context, state) {
    //     return const GlobalBottomNavBar();
    //   },
    // ),

    // ! Home Forgot Password
    GoRoute(
      path: routerConst.homeForgotPass,
      name: routerConst.homeForgotPass,
      builder: (context, state) {
        return const HomeForgotPass();
      },
    ),

    //  GoRoute(
    //   path: routerConst.passwordPage,
    //   name: routerConst.passwordPage,
    //   builder: (context, state) {
    //     EmailOrPassword emailOrPassword = state.extra as EmailOrPassword;
    //     return PasswordLoginField(
    //       emailOrPassword: emailOrPassword,
    //     );
    //   },
    // ),

    // !Splash Screens
    GoRoute(
      path: routerConst.splashScreen,
      name: routerConst.splashScreen,
      builder: (context, state) {
        return const SplashScreen();
      },
    ),

    // !clientRegister Screens
    GoRoute(
      path: routerConst.register,
      name: routerConst.register,
      builder: (context, state) {
        String inquiryID = state.extra as String;
        return RegisterScreen(
          inquryID: inquiryID,
        );
      },
    ),

    // ! Error 401  Screens
    GoRoute(
      path: routerConst.error401,
      name: routerConst.error401,
      builder: (context, state) {
        return const Error401Page();
      },
    ),

    // ! Error 401  Screens
    GoRoute(
      path: routerConst.markAttendence,
      name: routerConst.markAttendence,
      builder: (context, state) {
        return const Markattendance();
      },
    ),

    // GoRoute(
    //   path: routerConst.demoPage,
    //   name: routerConst.demoPage,
    //   builder: (context, state) {
    //     return AnotherPage();
    //   },
    // ),

    GoRoute(
      path: routerConst.loginScreen,
      name: routerConst.loginScreen,
      builder: (context, state) {
        return const PhoneEmailLogin();
      },
    ),

    // ! visit details page

    GoRoute(
      path: routerConst.visitDetailScreen,
      name: routerConst.visitDetailScreen,
      builder: (context, state) {
        VisitDetailScreenParams visitDetailScreenParams =
            state.extra as VisitDetailScreenParams;
        return VisitDeatil(
          visitDetailScreenParams: visitDetailScreenParams,
        );
      },
    ),

    // ! visit details page

    GoRoute(
      path: routerConst.inquiryDetailScreen,
      name: routerConst.inquiryDetailScreen,
      builder: (context, state) {
        InquiryDetailParams inquiryDetailParams =
            state.extra as InquiryDetailParams;
        return InquiryDeatil(
          inquiryDetailParams: inquiryDetailParams,
        );
      },
    ),

    // ! request admin page

    GoRoute(
      path: routerConst.requestAdmin,
      name: routerConst.requestAdmin,
      builder: (context, state) {
        String inquiryID = state.extra as String;
        return RequestAdmin(
          inquiryID: inquiryID,
        );
      },
    ),

    // ! create inquiry page

    GoRoute(
      path: routerConst.recivedInquiry,
      name: routerConst.recivedInquiry,
      builder: (context, state) {
        String indexlistno = state.extra as String;
        return ReciveInquiry(
          indexlistno: indexlistno,
        );
      },
    ),

    // ! generate inquiry page

    GoRoute(
      path: routerConst.generateInquiry,
      name: routerConst.generateInquiry,
      builder: (context, state) {
        String indexListNo = state.extra as String;
        return Generateinquiry(
          indexlistno: indexListNo,
        );
      },
    ),

    // GoRoute(
    //   path: routerConst.hiddenDrawer,
    //   name: routerConst.hiddenDrawer,
    //   builder: (context, state) {
    //     return const HiddenDrawerMenuView();
    //   },
    // ),
  ]);
}
