import 'package:flutter/material.dart';
import 'package:tima_app/core/constants/textconst.dart';
import 'package:tima_app/feature/visit/client.dart';
import 'package:tima_app/feature/visit/vender.dart';

class VisitPage extends StatefulWidget {
  const VisitPage({super.key});

  @override
  State<VisitPage> createState() => _VisitPageState();
}

class _VisitPageState extends State<VisitPage> {
  PageController _pageController = PageController(initialPage: 0);
  String _selectedValue = 'Client';

  void _onRadioChanged(String? value) {
    setState(() {
      _selectedValue = value!;
      if (_selectedValue == 'Client') {
        _pageController.jumpToPage(0);
      } else if (_selectedValue == 'Vendor') {
        _pageController.jumpToPage(1);
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        appBar: AppBar(
          title: txtHelper().headingText('Visit'),
          centerTitle: true,
        ),
        body: Column(
          children: <Widget>[
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Expanded(
                  child: RadioListTile<String>(
                    title: const Text(
                      'Client',
                      style: TextStyle(
                        fontWeight: FontWeight.w500,
                      ),
                    ),
                    value: 'Client',
                    groupValue: _selectedValue,
                    onChanged: _onRadioChanged,
                  ),
                ),
                Expanded(
                  child: RadioListTile<String>(
                    title: const Text(
                      'Vendor',
                      style: TextStyle(
                        fontWeight: FontWeight.w500,
                      ),
                    ),
                    value: 'Vendor',
                    groupValue: _selectedValue,
                    onChanged: _onRadioChanged,
                  ),
                ),
              ],
            ),
            const SizedBox(
              height: 20,
            ),
            Expanded(
              child: PageView(
                controller: _pageController,
                children: <Widget>[
                  ClientPageView(),
                  VendorPageView(),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
