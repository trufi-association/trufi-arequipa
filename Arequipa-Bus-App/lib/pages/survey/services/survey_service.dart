import 'dart:async';
import 'dart:convert';

import 'package:http/http.dart' as http;

import 'package:trufi_core/base/utils/trufi_app_id.dart';

class SurveyService {
  final String surveyUpdate;

  SurveyService({
    required this.surveyUpdate,
  });

  Future<void> updateSurvey({
    required String questionId,
    required List<String> options,
  }) async {
    final response = await ApiService.post(
      path: surveyUpdate,
      body: jsonEncode(<String, dynamic>{
        "UserId": TrufiAppId.getUniqueId,
        "QuestionId": questionId,
        "Options": options.toList()
      }),
    );
    if (response.statusCode != 200) {
      throw "Error";
    }
  }
}

abstract class ApiService {
  static Future<http.Response> post({
    required String path,
    Object? body,
  }) async {
    final url = Uri.parse(path);
    return http.post(
      url,
      headers: {
        'Content-Type': 'application/json',
      },
      body: body,
    );
  }
}
