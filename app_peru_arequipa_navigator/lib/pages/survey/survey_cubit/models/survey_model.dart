import 'package:arequipa_bus/pages/survey/survey_cubit/models/survey_enums.dart';
import 'package:equatable/equatable.dart';

class SurveyQuestionModel extends Equatable {
  final SurveyQuestionEnum surveyQuestionEnum;
  final List<SurveyOptionEnum> surveyAnswer;
  final bool isBackendSynced;

  const SurveyQuestionModel({
    required this.surveyQuestionEnum,
    required this.surveyAnswer,
    required this.isBackendSynced,
  });

  SurveyQuestionModel copyWith({
    SurveyQuestionEnum? surveyQuestionEnum,
    List<SurveyOptionEnum>? surveyAnswer,
    bool? isBackendSynced,
  }) {
    return SurveyQuestionModel(
      surveyQuestionEnum: surveyQuestionEnum ?? this.surveyQuestionEnum,
      surveyAnswer: surveyAnswer ?? this.surveyAnswer,
      isBackendSynced: isBackendSynced ?? this.isBackendSynced,
    );
  }

  factory SurveyQuestionModel.fromJson(Map<String, dynamic> json) {
    return SurveyQuestionModel(
      surveyQuestionEnum: SurveyQuestionEnumExtension.fromValue(
        json['surveyQuestionEnum'],
      )!,
      surveyAnswer: List<SurveyOptionEnum>.from((json['surveyAnswer'] ?? [])
          .map((x) => SurveyOptionEnumExtension.fromValue(x))),
      isBackendSynced: json['isBackendSynced'] ?? false,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'surveyQuestionEnum': surveyQuestionEnum.toValue(),
      'surveyAnswer': surveyAnswer.map((x) => x.toValue()).toList(),
      'isBackendSynced': isBackendSynced,
    };
  }

  @override
  List<Object?> get props => [
        surveyQuestionEnum,
        surveyAnswer,
        isBackendSynced,
      ];
}
