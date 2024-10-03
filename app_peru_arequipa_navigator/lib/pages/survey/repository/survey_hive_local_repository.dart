import 'dart:convert';

import 'package:arequipa_bus/pages/survey/survey_cubit/models/survey_enums.dart';
import 'package:arequipa_bus/pages/survey/survey_cubit/models/survey_model.dart';
import 'package:arequipa_bus/pages/survey/survey_cubit/survey_cubit.dart';
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

  static Future<void> migrationSurveyOldData() async {
    final box = Hive.box(SurveyHiveLocalRepository.path);
    await box.put(_surveyKey, jsonEncode(SurveyState.surveyStateDefault));

    if (!box.containsKey(_surveyKey)) return;
    final json = jsonDecode(box.get(_surveyKey));
    final isPresentation = json["isPresentation"];
    final currentQuestion = SurveyQuestionEnumExtension.fromValue(
      json["currentQuestion"],
    );
    final selectedOptions = json["selectedOptions"] != null
        ? (List<String>.from(json["selectedOptions"]))
            .map((e) => SurveyOptionEnumExtension.fromValue(e)!)
            .toList()
        : <SurveyOptionEnum>[];

    final surveyQuestions = <SurveyQuestionModel>[];
    for (var question in SurveyQuestionEnum.values) {
      final options = <SurveyOptionEnum>[];
      for (var option in selectedOptions) {
        if (question.options.contains(option)) {
          options.add(option);
        }
      }
      if (options.isNotEmpty) {
        surveyQuestions.add(SurveyQuestionModel(
          surveyQuestionEnum: question,
          surveyAnswer: options,
          isBackendSynced: false,
        ));
      }
    }
    if (surveyQuestions.isNotEmpty) {
      final surveyState = SurveyState.surveyStateDefault.copyWith(
        isPresentation: isPresentation,
        currentQuestion: currentQuestion,
        surveyQuestions: surveyQuestions,
      );
      await box.put(_surveyKey, jsonEncode(surveyState.toJson()));
    }
  }
}
