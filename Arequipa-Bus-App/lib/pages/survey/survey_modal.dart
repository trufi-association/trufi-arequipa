import 'package:arequipa_bus/pages/survey/survey_cubit/models/survey_helpers.dart';
import 'package:arequipa_bus/pages/survey/survey_cubit/survey_cubit.dart';
import 'package:arequipa_bus/pages/survey/survey_cubit/models/survey_enums.dart';
import 'package:arequipa_bus/pages/survey/translations/ab_survey_localizations.dart';
import 'package:arequipa_bus/pages/survey/widgets/survey_base_modal.dart';
import 'package:arequipa_bus/pages/survey/widgets/survey_option_chip.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'dart:math';
import 'package:trufi_core/base/widgets/screen/screen_helpers.dart';

class SurveyModal extends StatefulWidget {
  static Future<T?> showAdvancedModal<T>(
    BuildContext buildContext,
  ) async =>
      showTrufiDialog<T?>(
        context: buildContext,
        barrierColor: Colors.black54,
        builder: (buildContext) {
          return const SurveyModal();
        },
      );

  const SurveyModal({
    super.key,
  });

  @override
  State<SurveyModal> createState() => _SurveyModalState();
}

class _SurveyModalState extends State<SurveyModal> {
  SurveyPreviewEnum previewEnum = SurveyPreviewEnum.welcome;
  List<SurveyOptionEnum> selectedOptions = [];
  List<SurveyQuestionEnum> questions = SurveyState.surveyForOthers;
  String? errorText;

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback(
      (_) {
        final surveyState = context.read<SurveyCubit>().state;
        changeQuestion(
          currentQuestion: surveyState.currentQuestion,
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    final localizationABS = ABSurveyLocalization.of(context);
    final surveyCubit = context.watch<SurveyCubit>();
    final surveyState = surveyCubit.state;

    if (surveyState.isPresentation) {
      return SurveyBaseModal(
        title: previewEnum.getTranslateTitle(localizationABS),
        content: Text(previewEnum.getTranslateContent(localizationABS)),
        cancelText: "Cerrar",
        acceptText: previewEnum != SurveyPreviewEnum.info
            ? "Más información"
            : "Siguiente",
        expandAcceptButton:
            previewEnum != SurveyPreviewEnum.info ? false : true,
        cancelOnPressed: () {
          Navigator.of(context).pop();
        },
        acceptOnPressed: () async {
          if (previewEnum != SurveyPreviewEnum.info) {
            setState(() {
              previewEnum = SurveyPreviewEnum.info;
            });
          } else {
            await surveyCubit.finishPreview();
            if (context.mounted) {
              Navigator.of(context).pop();
              SurveyModal.showAdvancedModal(context);
            }
          }
        },
      );
    }
    final currentQuestion = surveyState.currentQuestion;
    final index = questions.indexOf(currentQuestion);
    final afterSurveyQuestion = questions[max(0, index - 1)];
    final isLast = index == questions.length - 1;
    final isFemale = SurveyHelpers.findSurveyQuestionModel(
          surveyQuestionEnum: SurveyQuestionEnum.gender,
          surveyQuestions: surveyState.surveyQuestions,
        )?.surveyAnswer.contains(SurveyOptionEnum.gender_female) ??
        false;
    return SurveyBaseModal(
      title:
          "${currentQuestion.getTranslate(localizationABS)} (${index + 1}/${questions.length})",
      errorText: errorText,
      cancelText: index == 0 ? "Cerrar" : "Anterior",
      acceptText: currentQuestion == SurveyQuestionEnum.disability &&
              selectedOptions.contains(SurveyOptionEnum.disability_yes)
          ? "Guardar y Siguiente"
          : isLast
              ? "Guardar"
              : "Guardar y Siguiente",
      expandAcceptButton: (currentQuestion == SurveyQuestionEnum.disability &&
                  selectedOptions.contains(SurveyOptionEnum.disability_yes)) ||
              (currentQuestion == SurveyQuestionEnum.disability && isFemale)
          ? false
          : isLast
              ? true
              : false,
      content: Wrap(
        spacing: 16,
        children: currentQuestion.options.map(
          (e) {
            final isSelected = selectedOptions.contains(e);
            return SurveyOptionChip(
              surveyOption: e,
              isSelected: isSelected,
              onPressed: () {
                if (currentQuestion.isMultiSelect) {
                  if (isSelected) {
                    selectedOptions.remove(e);
                  } else {
                    selectedOptions.add(e);
                  }
                } else {
                  selectedOptions = [];
                  selectedOptions.add(e);
                }
                updateQuestions(currentQuestion: currentQuestion);
              },
            );
          },
        ).toList(),
      ),
      cancelOnPressed: () {
        if (index == 0) {
          Navigator.of(context).pop();
        } else {
          surveyCubit.backSurvey(
            currentSurveyQuestion: afterSurveyQuestion,
          );
          changeQuestion(
            currentQuestion: afterSurveyQuestion,
          );
        }
      },
      acceptOnPressed: () {
        validateForm();
        if (errorText != null) return;
        surveyCubit.updateSurvey(
          surveyQuestion: currentQuestion,
          nextSurveyQuestion: isLast ? currentQuestion : questions[index + 1],
          surveyOptions: selectedOptions,
        );
        if (isLast) {
          Navigator.of(context).pop();
        } else {
          changeQuestion(
            currentQuestion: questions[index + 1],
          );
        }
      },
    );
  }

  void validateForm() {
    setState(() {
      errorText =
          selectedOptions.isEmpty ? "Please select at least one option" : null;
    });
  }

  void changeQuestion({
    required SurveyQuestionEnum currentQuestion,
  }) {
    final surveyQuestions = context.read<SurveyCubit>().state.surveyQuestions;

    errorText = null;
    selectedOptions = SurveyHelpers.findSurveyQuestionModel(
          surveyQuestionEnum: currentQuestion,
          surveyQuestions: surveyQuestions,
        )?.surveyAnswer ??
        [];
    updateQuestions(currentQuestion: currentQuestion);
  }

  void updateQuestions({
    required SurveyQuestionEnum currentQuestion,
  }) {
    final surveyQuestions = context.read<SurveyCubit>().state.surveyQuestions;
    bool isFemale = false;

    if (currentQuestion == SurveyQuestionEnum.gender) {
      isFemale = selectedOptions.contains(SurveyOptionEnum.gender_female);
    } else {
      isFemale = SurveyHelpers.findSurveyQuestionModel(
            surveyQuestionEnum: SurveyQuestionEnum.gender,
            surveyQuestions: surveyQuestions,
          )?.surveyAnswer.contains(SurveyOptionEnum.gender_female) ??
          false;
    }

    bool isDisability = false;

    if (currentQuestion == SurveyQuestionEnum.disability) {
      isDisability = selectedOptions.contains(SurveyOptionEnum.disability_yes);
    } else {
      isDisability = SurveyHelpers.findSurveyQuestionModel(
            surveyQuestionEnum: SurveyQuestionEnum.disability,
            surveyQuestions: surveyQuestions,
          )?.surveyAnswer.contains(SurveyOptionEnum.disability_yes) ??
          false;
    }

    if (isFemale) {
      setState(() {
        questions = SurveyState.surveyForWoman;
      });
    } else if (isDisability) {
      setState(() {
        questions = SurveyState.surveyForDisability;
      });
    } else {
      setState(() {
        questions = SurveyState.surveyForOthers;
      });
    }
  }
}
