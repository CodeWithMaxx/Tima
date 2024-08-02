import 'package:flutter/material.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:go_router/go_router.dart';
import 'package:tima_app/DataBase/keys/keys.dart';
import 'package:tima_app/core/GWidgets/toast.dart';
import 'package:tima_app/router/routes/routerConst.dart';

class CustomDialog extends StatelessWidget {
  final FlutterSecureStorage secureStorage = const FlutterSecureStorage();
  @override
  Widget build(BuildContext context) {
    return Dialog(
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(20.0),
      ),
      child: Container(
        padding: EdgeInsets.all(20.0),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(20.0),
          color: Colors.white,
        ),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            const Text(
              'Choose an action',
              style: TextStyle(fontSize: 18.0, fontWeight: FontWeight.bold),
            ),
            SizedBox(height: 20.0),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                GestureDetector(
                  onTap: () {
                    Navigator.of(context).pop();
                  },
                  child: CircularButton(
                    icon: Icons.arrow_back,
                    label: 'Back',
                    color: Colors.green,
                  ),
                ),
                GestureDetector(
                  onTap: () {
                    secureStorage.write(
                        key: StorageKeys.loginKey, value: false.toString());
                    // SystemNavigator.pop();
                    GoRouter.of(context).goNamed(routerConst.loginScreen);

                    ModalRoute.withName(routerConst.loginScreen);
                    toastMsg('User LogedOut', true);
                  },
                  child: CircularButton(
                    icon: Icons.logout,
                    label: 'Logout',
                    color: Colors.red,
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}

class CircularButton extends StatelessWidget {
  final IconData icon;
  final String label;
  Color color;

  CircularButton(
      {required this.icon, required this.label, required this.color});

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        CircleAvatar(
          radius: 30.0,
          backgroundColor: color,
          child: Icon(icon, color: Colors.white),
        ),
        SizedBox(height: 8.0),
        Text(label),
      ],
    );
  }
}
