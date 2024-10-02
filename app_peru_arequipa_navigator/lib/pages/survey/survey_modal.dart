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
        builder: (buildContext) => const SurveyModal(),
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
        surveyState.selectedOptions;
        final selectedOptionsCubit = surveyState.selectedOptions;
        final currentQuestion = surveyState.currentQuestion;
        if (!surveyState.isPresentation) {
          selectedOptions = selectedOptionsCubit
              .where((e) => currentQuestion?.options.contains(e) ?? false)
              .toList();
        }
        final isFemale = surveyState.selectedOptions
            .contains(SurveyOptionEnum.gender_female);
        final isDisability = surveyState.selectedOptions
            .contains(SurveyOptionEnum.disability_yes);
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
        acceptOnPressed: () {
          if (previewEnum != SurveyPreviewEnum.info) {
            setState(() {
              previewEnum = SurveyPreviewEnum.info;
            });
          } else {
            surveyCubit.finishPreview();
          }
        },
      );
    }
    final currentQuestion = surveyState.currentQuestion!;
    final index = questions.indexOf(currentQuestion);
    final isLast = index == questions.length - 1;
    return SurveyBaseModal(
      title:
          "${currentQuestion.getTranslate(localizationABS)} (${index + 1}/${questions.length})",
      errorText: errorText,
      content: Wrap(
        spacing: 16,
        children: currentQuestion.options.map(
          (e) {
            final isSelected = selectedOptions.contains(e);
            return SurveyOptionChip(
              surveyOption: e,
              onPressed: () {
                if (currentQuestion.isMultiSelect) {
                  setState(() {
                    if (isSelected) {
                      selectedOptions.remove(e);
                    } else {
                      selectedOptions.add(e);
                    }
                  });
                } else {
                  setState(() {
                    selectedOptions = [];
                    selectedOptions.add(e);
                  });
                }
                final isFemale = surveyState.selectedOptions
                    .contains(SurveyOptionEnum.gender_female);
                final isDisability = [...selectedOptions]
                    .contains(SurveyOptionEnum.disability_yes);
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
              },
              isSelected: isSelected,
            );
          },
        ).toList(),
      ),
      cancelText: currentQuestion.index == 0 ? "Cerrar" : "Anterior",
      acceptText: currentQuestion == SurveyQuestionEnum.disability &&
              selectedOptions.contains(SurveyOptionEnum.disability_yes)
          ? "Guardar y Siguiente"
          : isLast
              ? "Guardar"
              : "Guardar y Siguiente",
      expandAcceptButton: (currentQuestion == SurveyQuestionEnum.disability &&
                  selectedOptions.contains(SurveyOptionEnum.disability_yes)) ||
              (currentQuestion == SurveyQuestionEnum.disability &&
                  surveyState.selectedOptions.contains(
                    SurveyOptionEnum.gender_female,
                  ))
          ? false
          : isLast
              ? true
              : false,
      cancelOnPressed: () {
        if (currentQuestion.index == 0) {
          Navigator.of(context).pop();
        } else {
          final index = questions.indexOf(currentQuestion);
          surveyCubit.backSurvey(
            surveyQuestion: questions[max(0, index - 1)],
          );
          setState(() {
            selectedOptions = surveyState.selectedOptions
                .where((e) => questions[max(0, index - 1)].options.contains(e))
                .toList();
            errorText = null;
          });
        }
      },
      acceptOnPressed: () {
        setState(() {
          errorText = selectedOptions.isEmpty
              ? "Please select at least one option"
              : null;
        });
        if (errorText != null) return;
        final isFemale = surveyState.selectedOptions
            .contains(SurveyOptionEnum.gender_female);
        final isDisability = [
          ...(currentQuestion == SurveyQuestionEnum.disability
              ? selectedOptions
              : surveyState.selectedOptions)
        ].contains(SurveyOptionEnum.disability_yes);
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

        final index = questions.indexOf(currentQuestion);
        final isLast = index == questions.length - 1;

        surveyCubit.updateSurvey(
          surveyQuestion: currentQuestion,
          nextSurveyQuestion: isLast ? null : questions[index + 1],
          surveyOptions: selectedOptions,
        );
        setState(() {
          selectedOptions = surveyState.selectedOptions
              .where((e) =>
                  questions[isLast ? index : index + 1].options.contains(e))
              .toList();
        });

        if (isLast) {
          Navigator.of(context).pop();
        }
      },
    );
  }
}
