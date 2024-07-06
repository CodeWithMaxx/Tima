// import 'dart:convert';
// import 'dart:developer';

// import 'package:http/http.dart' as http;
// import 'package:tima_app/DataBase/dataHub/secureStorageService.dart';
// import 'package:tima_app/DataBase/keys/keys.dart';
// import 'package:tima_app/core/constants/apiUrlConst.dart';
// import 'package:tima_app/core/models/nextvisitmodel.dart';

// class NextVisitRepo {
//   final client = http.Client();
//   final SecureStorageService _secureStorageService = SecureStorageService();

//   Future<NextVisitResponseModel> nextVisitApi(String startDate, String endDate) async {
//     String? userid =
//         await _secureStorageService.getUserID(key: StorageKeys.userIDKey);
//     var url = Uri.parse(show_next_visit_app_url);
//     var response = await client.post(url, body: {
//       'user_id': userid.toString(),
//       'from_date': startDate,
//       'to_date': endDate
//     });
//     try {
//       var decodedResponse = jsonDecode(response.body);

//       if (response.statusCode == 200) {
//         if (decodedResponse['status'] == 1) {
//           NextVisitResponseModel.fromJson(decodedResponse);
//         } else {
//           {
//             NextVisitResponseModel.fromJson(decodedResponse);
//           }
//         }
//       }
//     } catch (error) {
//       log(error.toString());
//     }
//     return NextVisitResponseModel;
//   }
// }
