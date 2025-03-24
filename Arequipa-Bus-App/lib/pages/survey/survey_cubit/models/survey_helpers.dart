import 'package:arequipa_bus/pages/survey/survey_cubit/models/survey_enums.dart';
import 'package:arequipa_bus/pages/survey/survey_cubit/models/survey_model.dart';

abstract class SurveyHelpers {
  static SurveyQuestionModel? findSurveyQuestionModel({
    required SurveyQuestionEnum surveyQuestionEnum,
    required List<SurveyQuestionModel> surveyQuestions,
  }) {
    final index = surveyQuestions
        .indexWhere((e) => e.surveyQuestionEnum == surveyQuestionEnum);
    return index != -1 ? surveyQuestions[index] : null;
  }
}
