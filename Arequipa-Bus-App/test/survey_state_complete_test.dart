import 'package:arequipa_bus/pages/survey/survey_cubit/models/survey_enums.dart';
import 'package:arequipa_bus/pages/survey/survey_cubit/models/survey_model.dart';
import 'package:arequipa_bus/pages/survey/survey_cubit/survey_cubit.dart';
import 'package:flutter_test/flutter_test.dart';

// trufi-arequipa#71: a survey finished before the completion flag existed
// counts as completed, branch by branch.
SurveyState _state(Map<SurveyQuestionEnum, List<SurveyOptionEnum>> answers) =>
    SurveyState(
      isPresentation: false,
      currentQuestion: SurveyQuestionEnum.gender,
      surveyQuestions: [
        for (final e in answers.entries)
          SurveyQuestionModel(
            surveyQuestionEnum: e.key,
            surveyAnswer: e.value,
            isBackendSynced: true,
          ),
      ],
    );

void main() {
  test('no answers: not complete', () {
    expect(_state({}).isComplete, isFalse);
  });

  test('the short branch completes at the disability question', () {
    expect(
      _state({
        SurveyQuestionEnum.gender: [SurveyOptionEnum.gender_male],
        SurveyQuestionEnum.age_group: [SurveyOptionEnum.age_18_35],
        SurveyQuestionEnum.disability: [SurveyOptionEnum.disability_no],
      }).isComplete,
      isTrue,
    );
  });

  test('a woman or a disabled rider stopping at question 3 is not complete',
      () {
    expect(
      _state({
        SurveyQuestionEnum.gender: [SurveyOptionEnum.gender_female],
        SurveyQuestionEnum.disability: [SurveyOptionEnum.disability_no],
      }).isComplete,
      isFalse,
    );
    expect(
      _state({
        SurveyQuestionEnum.gender: [SurveyOptionEnum.gender_male],
        SurveyQuestionEnum.disability: [SurveyOptionEnum.disability_yes],
      }).isComplete,
      isFalse,
    );
  });

  test('the long branches complete at their last question', () {
    expect(
      _state({
        SurveyQuestionEnum.gender: [SurveyOptionEnum.gender_female],
        SurveyQuestionEnum.additional_security_measures: const [],
      }).isComplete,
      isTrue,
    );
    expect(
      _state({
        SurveyQuestionEnum.disability: [SurveyOptionEnum.disability_yes],
        SurveyQuestionEnum.availability_of_information: const [],
      }).isComplete,
      isTrue,
    );
  });
}
