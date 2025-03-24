import 'package:arequipa_bus/pages/survey/survey_cubit/models/survey_enums.dart';
import 'package:arequipa_bus/pages/survey/translations/ab_survey_localizations.dart';
import 'package:flutter/material.dart';

class SurveyOptionChip extends StatelessWidget {
  const SurveyOptionChip({
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
        padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8)),
        side: BorderSide(
          color: theme.colorScheme.onSurface,
          width: isSelected ? 0 : 1,
        ),
      ),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          Icon(surveyOption.icon),
          const SizedBox(width: 4),
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
          const SizedBox(width: 4),
        ],
      ),
    );
  }
}
