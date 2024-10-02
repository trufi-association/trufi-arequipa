import 'package:arequipa_bus/pages/survey/survey/survey_cubit/survey_cubit.dart';
import 'package:arequipa_bus/pages/survey/survey_enums.dart';
import 'package:arequipa_bus/pages/survey/translations/ab_survey_localizations.dart';
import "package:flutter/material.dart";
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
        builder: (buildContext) => SurveyModal(),
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
      title: "${currentQuestion.getTranslate(localizationABS)} (${index+1}/${questions.length})",
      // content: Text(
      //   "Tu respuesta es confidencial y solo te tomará unos minutos.",
      // ),
      errorText: errorText,
      content: Wrap(
        spacing: 16,
        children: currentQuestion.options.map(
          (e) {
            final isSelected = selectedOptions.contains(e);
            return CustomChip(
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
          // Chip(
          //   avatar: Icon(e.icon),
          //   label: Text(
          //     e.getTranslate(localizationABS),
          //   ),
          //   shape: RoundedRectangleBorder(
          //     borderRadius: BorderRadius.circular(8),
          //     side: BorderSide(),
          //   ),

          //   backgroundColor: Colors.transparent,
          // ),
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

class CustomChip extends StatelessWidget {
  const CustomChip({
    super.key,
    required this.surveyOption,
    required this.onPressed,
    required this.isSelected,
  });
  final SurveyOptionEnum surveyOption;
  final bool isSelected;
  final VoidCallback onPressed;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final localizationABS = ABSurveyLocalization.of(context);
    return OutlinedButton(
      onPressed: onPressed,
      style: OutlinedButton.styleFrom(
        backgroundColor: isSelected
            ? theme.colorScheme.secondary
            : theme.colorScheme.surface,
        foregroundColor: isSelected
            ? theme.colorScheme.onSecondary
            : theme.colorScheme.onSurface,
        padding: EdgeInsets.symmetric(horizontal: 8, vertical: 4),
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8)),
        side: BorderSide(
          color: theme.colorScheme.onSurface,
          width: isSelected ? 0 : 1,
        ),
      ),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          Container(child: Icon(surveyOption.icon)),
          SizedBox(width: 4),
          Flexible(
            child: Text(
              surveyOption.getTranslate(localizationABS),
              style: TextStyle(
                color: isSelected
                    ? theme.colorScheme.onSecondary
                    : theme.colorScheme.onSurface,
              ),
              maxLines: 2,
            ),
          ),
          SizedBox(width: 4),
        ],
      ),
    );
  }
}

class SurveyBaseModal extends StatelessWidget {
  const SurveyBaseModal({
    super.key,
    required this.title,
    required this.content,
    this.errorText,
    this.cancelText,
    required this.cancelOnPressed,
    this.expandCancelButton = true,
    this.acceptText,
    required this.acceptOnPressed,
    this.expandAcceptButton = true,
  });
  final String title;
  final Widget content;
  final String? errorText;
  final String? cancelText;
  final VoidCallback cancelOnPressed;
  final bool expandCancelButton;
  final String? acceptText;
  final VoidCallback acceptOnPressed;
  final bool expandAcceptButton;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final isPortrait =
        MediaQuery.of(context).orientation == Orientation.portrait;
    return Scaffold(
      backgroundColor: Colors.transparent,
      body: Center(
        child: Container(
          margin: EdgeInsets.symmetric(
            horizontal: isPortrait ? 30 : 60,
            vertical: isPortrait ? 60 : 10,
          ),
          constraints: const BoxConstraints(
            minHeight: 50,
            maxHeight: 800,
          ),
          decoration: BoxDecoration(
            color: theme.colorScheme.surface,
            boxShadow: [
              BoxShadow(
                color: theme.brightness == Brightness.dark
                    ? Colors.white.withOpacity(0.2)
                    : Colors.black.withOpacity(0.2),
                offset: const Offset(0, 4),
                blurRadius: 20,
              ),
            ],
            borderRadius: BorderRadius.circular(8),
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            mainAxisSize: MainAxisSize.min,
            children: [
              Container(
                padding: const EdgeInsets.only(
                  left: 16,
                  right: 4,
                ),
                child: Row(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Expanded(
                      child: Padding(
                        padding: const EdgeInsets.only(top: 14),
                        child: Text(
                          title,
                          style: theme.textTheme.bodyLarge?.copyWith(
                            fontWeight: FontWeight.w600,
                          ),
                        ),
                      ),
                    ),
                    Align(
                      alignment: Alignment.topRight,
                      child: Padding(
                        padding: const EdgeInsets.only(top: 4),
                        child: IconButton(
                          tooltip: "close",
                          onPressed: () {
                            Navigator.of(context).pop();
                          },
                          icon: const Icon(Icons.close),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
              Flexible(
                child: Container(
                  margin: const EdgeInsets.only(left: 16, right: 16, top: 12),
                  child: SingleChildScrollView(
                    child: Column(
                      mainAxisSize: MainAxisSize.min,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        content,
                      ],
                    ),
                  ),
                ),
              ),
              Container(
                margin: const EdgeInsets.symmetric(horizontal: 16, vertical: 0),
                child: Text(
                  errorText != null ? errorText! : "",
                  style: TextStyle(color: theme.colorScheme.error),
                  textAlign: TextAlign.center,
                ),
              ),
              Container(
                padding: const EdgeInsets.only(
                  left: 16,
                  right: 16,
                  bottom: 8,
                ),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.end,
                  children: [
                    Expanded(
                      flex: expandCancelButton ? 1 : 0,
                      child: OutlinedButton(
                        onPressed: cancelOnPressed,
                        child: Text(
                          cancelText ?? "Cancel",
                          style: TextStyle(
                            color: theme.colorScheme.onSurface,
                          ),
                          textAlign: TextAlign.end,
                        ),
                      ),
                    ),
                    SizedBox(width: 4),
                    Expanded(
                      flex: expandAcceptButton ? 1 : 0,
                      child: ElevatedButton(
                        onPressed: acceptOnPressed,
                        style: ElevatedButton.styleFrom(
                          backgroundColor: theme.colorScheme.secondary,
                        ),
                        child: Text(
                          acceptText ?? "Accept",
                          style: TextStyle(
                            color: theme.colorScheme.onSecondary,
                          ),
                          textAlign: TextAlign.end,
                        ),
                      ),
                    ),
                  ],
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}
