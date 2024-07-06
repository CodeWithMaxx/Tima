// import 'dart:convert';

// import 'package:flutter/material.dart';
// import 'package:flutter_screenutil/flutter_screenutil.dart';
// import 'package:http/http.dart' as http;
// import 'package:intl/intl.dart';
// import 'package:tima_app/DataBase/dataHub/secureStorageService.dart';
// import 'package:tima_app/DataBase/keys/keys.dart';
// import 'package:tima_app/core/GWidgets/btnText.dart';
// import 'package:tima_app/core/constants/apiUrlConst.dart';
// import 'package:tima_app/core/constants/colorConst.dart';
// import 'package:tima_app/core/models/nextvisitmodel.dart';

// class NextVisitApiTesting extends StatefulWidget {
//   const NextVisitApiTesting({super.key});

//   @override
//   State<NextVisitApiTesting> createState() => _NextVisitApiTestingState();
// }

// class _NextVisitApiTestingState extends State<NextVisitApiTesting> {
//   SecureStorageService _secureStorageService = SecureStorageService();
//   late String startDateController;
//   late String endDateController;
//   DateTime selectedDate = DateTime.now();
//   DateTime selectedEndDate = DateTime.now();
//   List<NextVisitModel> nextVisitList = [];
//   bool isLoading = false;
//   @override
//   void initState() {
//     startDateController = DateFormat('yyyy-MM-dd').format(selectedDate);
//     endDateController = DateFormat('yyyy-MM-dd').format(selectedEndDate);
//     nextVisit();
//     super.initState();
//   }

//   Future<void> selectStartDate(BuildContext context) async {
//     DateTime? picked = await showDatePicker(
//       context: context,
//       initialDate: DateTime.now(),
//       firstDate: DateTime(1900),
//       lastDate: DateTime(2100),
//       initialDatePickerMode: DatePickerMode.day,
//     );

//     if (picked != null) {
//       setState(() {
//         selectedDate = picked;
//         var date = DateFormat.yMd().format(selectedDate);
//         startDateController = DateFormat('yyyy-MM-dd').format(selectedDate);
//         if (endDateController != "") {}
//       });
//     }
//   }

//   Future<void> selectEndDate(BuildContext context) async {
//     final DateTime? picked = await showDatePicker(
//       context: context,
//       initialDate: DateTime.now(),
//       firstDate: DateTime(1900),
//       lastDate: DateTime(2100),
//       initialDatePickerMode: DatePickerMode.day,
//     );
//     if (picked != null) {
//       setState(() {
//         selectedEndDate = picked;
//         endDateController = DateFormat('yyyy-MM-dd').format(selectedEndDate);
//       });
//     }
//   }

//   Future<void> nextVisit() async {
//     setState(() {
//       isLoading = true;
//     });
//     final client = http.Client();
//     String? userid =
//         await _secureStorageService.getUserID(key: StorageKeys.userIDKey);
//     var url = Uri.parse(show_next_visit_app_url);
//     var response = await client.post(url, body: {
//       'user_id': 117,
//       'from_date': startDateController.toString(),
//       'to_date': endDateController.toString()
//     });
//     var decodedResponse = jsonDecode(response.body);
//     if (response.statusCode == 200) {
//       NextVisitModel nextVisitModel = NextVisitModel.fromJson(decodedResponse);
//       nextVisitList.add(nextVisitModel);
//       setState(() {
//         isLoading = false;
//       });
//     }
//   }

//   @override
//   Widget build(BuildContext context) {
//     Size size = MediaQuery.of(context).size;
//     return Scaffold(
//         body: Column(children: [
//       Container(
//           padding: const EdgeInsets.symmetric(horizontal: 15, vertical: 15),
//           child: Column(
//             children: [
//               Row(
//                 mainAxisAlignment: MainAxisAlignment.start,
//                 children: [
//                   lebelText(
//                       labelText: 'Start Date', size: 16.5, color: blueColor)
//                 ],
//               ),
//               SizedBox(
//                 height: 8.h,
//               ),
//               GestureDetector(
//                 onTap: () {
//                   selectStartDate(context);
//                 },
//                 child: Container(
//                   height: 55,
//                   width: size.width,
//                   alignment: Alignment.centerLeft,
//                   padding: const EdgeInsets.all(8.0),
//                   decoration: BoxDecoration(
//                     color: tfColor,
//                     borderRadius: BorderRadius.circular(10),
//                   ),
//                   child: Text(
//                     startDateController.toString(),
//                     style: const TextStyle(
//                       color: colorConst.colorIconBlue,
//                       fontSize: 14.0,
//                       fontWeight: FontWeight.w600,
//                     ),
//                   ),
//                 ),
//               ),
//               SizedBox(
//                 height: 20.h,
//               ),
//               Row(
//                 mainAxisAlignment: MainAxisAlignment.start,
//                 children: [
//                   lebelText(labelText: 'End Date', size: 16.5, color: blueColor)
//                 ],
//               ),
//               SizedBox(
//                 height: 8.h,
//               ),
//               GestureDetector(
//                 onTap: () {
//                   selectEndDate(context);
//                 },
//                 child: Container(
//                   height: 55,
//                   width: size.width,
//                   alignment: Alignment.centerLeft,
//                   padding: const EdgeInsets.all(8.0),
//                   decoration: BoxDecoration(
//                     color: tfColor,
//                     borderRadius: BorderRadius.circular(10),
//                   ),
//                   child: Text(
//                     endDateController.toString(),
//                     style: const TextStyle(
//                       color: colorConst.colorIconBlue,
//                       fontSize: 14.0,
//                       fontWeight: FontWeight.bold,
//                     ),
//                   ),
//                 ),
//               ),
//               SizedBox(
//                 height: 30.h,
//               ),
//               Expanded(child: ListView.builder(itemBuilder: (context, index) {
//                 return Text(nextVisitList.first.data![index].client);
//               }))
//             ],
//           ))
//     ]));
//   }
// }
