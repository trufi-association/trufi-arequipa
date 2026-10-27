import 'dart:convert';

import 'package:arequipa_bus/pages/survey/survey_cubit/models/survey_enums.dart';
import 'package:arequipa_bus/pages/survey/survey_cubit/models/survey_model.dart';
import 'package:arequipa_bus/pages/survey/survey_cubit/survey_cubit.dart';
import 'package:hive/hive.dart';

class SurveyHiveLocalRepository {
  static const _surveyKey = '_surveyKey';
  static const _countKey = '_count';
  static const _completedKey = '_completed';
  static const String path = "SurveyHiveLocalRepository";

  /// How many cold starts open the survey modal on their own. The first start
  /// never asks; the next [maxSurveyPrompts] starts do; after that the survey
  /// is only reachable from its button. This is a default: change it here if
  /// the municipality wants the survey offered more or fewer times.
  static const int maxSurveyPrompts = 3;

  /// The box is opened once in main() (initHiveForFlutter); every instance
  /// reads it on demand. A `late` field assigned by a loadRepository() call
  /// threw LateInitializationError on each cold start, because the post-frame
  /// callback that reads the survey counter never called it (#71).
  Box get _box => Hive.box(path);

  /// Whether the start-up reactor should open the survey modal on this start.
  /// [startCount] is the number of cold starts including the current one (the
  /// reactor increments it before asking); [completed] is [isCompleted].
  /// Pure, so the rule can be tested without Hive.
  static bool shouldShowSurvey({
    required int startCount,
    required bool completed,
  }) {
    if (completed) return false;
    return startCount >= 2 && startCount <= maxSurveyPrompts + 1;
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

  /// True once the last question reached the server (SurveyCubit.updateSurvey
  /// sets it); from then on the reactor never opens the modal again.
  Future<bool> isCompleted() async {
    if (!_box.containsKey(_completedKey)) return false;
    return _box.get(_completedKey) as bool;
  }

  Future<void> markCompleted() async {
    await _box.put(_completedKey, true);
  }

  static Future<void> migrationSurveyOldData() async {
    final box = Hive.box(SurveyHiveLocalRepository.path);

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
