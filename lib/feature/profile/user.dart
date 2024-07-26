import 'package:flutter/material.dart';
import 'package:tima_app/core/GWidgets/btnText.dart';
import 'package:tima_app/core/constants/colorConst.dart';

class UserPorfolio extends StatelessWidget {
  const UserPorfolio({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title:
            lebelText(labelText: 'User Porfolio', size: 20, color: blueColor),
      ),
    );
  }
}
