part of 'survey_cubit.dart';

@immutable
class SurveyState extends Equatable {
  static const String _isPresentation = "isPresentation";
  static const String _currentQuestion = "currentQuestion";
  static const String _surveyQuestions = "surveyQuestions";

  static const surveyStateDefault = SurveyState(
    isPresentation: true,
    currentQuestion: SurveyQuestionEnum.gender,
    surveyQuestions: [],
  );

  static final List<SurveyQuestionEnum> surveyForOthers = [
    SurveyQuestionEnum.gender,
    SurveyQuestionEnum.age_group,
    SurveyQuestionEnum.disability
  ];
  static final List<SurveyQuestionEnum> surveyForWoman = [
    SurveyQuestionEnum.gender,
    SurveyQuestionEnum.age_group,
    SurveyQuestionEnum.disability,
    SurveyQuestionEnum.frequency_public_transport,
    SurveyQuestionEnum.usage_public_transport,
    SurveyQuestionEnum.time_public_transport,
    SurveyQuestionEnum.safety_public_transport,
    SurveyQuestionEnum.experience_public_transport,
    SurveyQuestionEnum.satisfaction_security_measures,
    SurveyQuestionEnum.additional_security_measures,
  ];
  static final List<SurveyQuestionEnum> surveyForDisability = [
    SurveyQuestionEnum.gender,
    SurveyQuestionEnum.age_group,
    SurveyQuestionEnum.disability,
    SurveyQuestionEnum.relation_to_disability,
    SurveyQuestionEnum.type_of_disability,
    SurveyQuestionEnum.disability_related_frequency,
    SurveyQuestionEnum.time_to_nearest_stop,
    SurveyQuestionEnum.ease_of_use_public_transport,
    SurveyQuestionEnum.desired_facilities,
    SurveyQuestionEnum.availability_of_information,
  ];

  const SurveyState({
    required this.isPresentation,
    required this.currentQuestion,
    required this.surveyQuestions,
  });

  final bool isPresentation;
  final SurveyQuestionEnum currentQuestion;
  final List<SurveyQuestionModel> surveyQuestions;

  SurveyState copyWith({
    bool? isPresentation,
    SurveyQuestionEnum? currentQuestion,
    List<SurveyQuestionModel>? surveyQuestions,
  }) {
    return SurveyState(
      isPresentation: isPresentation ?? this.isPresentation,
      currentQuestion: currentQuestion ?? this.currentQuestion,
      surveyQuestions: surveyQuestions ?? this.surveyQuestions,
    );
  }

  factory SurveyState.fromJson(Map<String, dynamic> json) {
    return SurveyState(
      isPresentation: json[_isPresentation],
      currentQuestion:
          SurveyQuestionEnumExtension.fromValue(json[_currentQuestion])!,
      surveyQuestions: json[_surveyQuestions] != null
          ? (List<dynamic>.from(json[_surveyQuestions]))
              .map((e) => SurveyQuestionModel.fromJson(e))
              .toList()
          : <SurveyQuestionModel>[],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      _isPresentation: isPresentation,
      _currentQuestion: currentQuestion.toValue(),
      _surveyQuestions: surveyQuestions.map((e) => e.toJson()).toList(),
    };
  }

  @override
  List<Object?> get props => [
        isPresentation,
        currentQuestion,
        surveyQuestions,
      ];
}