import 'dart:convert';
import 'dart:developer';

import 'package:http/http.dart' as http;
import 'package:tima_app/DataBase/dataHub/secureStorageService.dart';
import 'package:tima_app/DataBase/keys/keys.dart';
import 'package:tima_app/core/constants/apiUrlConst.dart';
import 'package:tima_app/core/models/nextvisitmodel.dart';

class nextVisitRepo {
  late NextVisitModel nextVisitModel;
  Future<NextVisitModel> getNextVisit({
    required String startDate,
    required String endDate,
  }) async {
    final SecureStorageService _secureStorageService = SecureStorageService();
    try {
      String? userId =
          await _secureStorageService.getUserID(key: StorageKeys.userIDKey);
      var url = Uri.parse(show_next_visit_app_url);

      var response = await http.post(
        url,
        body: {
          'user_id': userId,
          'from_date': startDate,
          'to_date': endDate,
        },
      );

      if (response.statusCode == 200) {
        var responseDecoded = jsonDecode(response.body);
        nextVisitModel = NextVisitModel.fromJson(responseDecoded);
      } else {
        // Handle non-200 responses
        log('Failed to load next visit data');
        return nextVisitModel;
      }
    } catch (error) {
      log('Error: $error');
    }
    return nextVisitModel;
  }
}
