import 'dart:convert';

import 'package:arequipa_bus/pages/survey/survey/survey_cubit/survey_cubit.dart';
import 'package:hive/hive.dart';

class SurveyHiveLocalRepository {
  static const _surveyKey = '_surveyKey';
  static const _countKey = '_count';
  static const String path = "SurveyHiveLocalRepository";
  late Box _box;

  Future<void> loadRepository() async {
    _box = Hive.box(path);
  }

  Future<void> saveSurvey(Map<String, dynamic> data) async {
    await _box.put(_surveyKey, jsonEncode(data));
  }

  Future<SurveyState?> getSurvey() async {
    if (!_box.containsKey(_surveyKey)) return null;
    return SurveyState.fromJson(jsonDecode(_box.get(_surveyKey)));
  }

  Future<void> saveCount(int count) async {
    await _box.put(_countKey, count);
  }

  Future<int> getCount() async {
    if (!_box.containsKey(_countKey)) {
      return 0;
    }
    return _box.get(_countKey) as int;
  }
}
