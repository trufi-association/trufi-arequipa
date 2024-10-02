import 'package:arequipa_bus/pages/survey/survey_modal.dart';
import 'package:flutter/material.dart';
import 'package:trufi_core/base/translations/trufi_base_localizations.dart';

class SurveyButton extends StatelessWidget {
  const SurveyButton({super.key});

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final localization = TrufiBaseLocalization.of(context)!;
    final isEN = localization.localeName == 'en';
    return Positioned(
      bottom: 25,
      left: 10,
      child: SafeArea(
        child: Stack(
          children: [
            Padding(
              padding: const EdgeInsets.fromLTRB(0, 4, 4, 0),
              child: FloatingActionButton(
                backgroundColor: theme.colorScheme.primary,
                child: const Icon(
                  Icons.feed,
                  color: Colors.white,
                  size: 30,
                ),
                onPressed: () {
                  SurveyModal.showAdvancedModal(context);
                },
              ),
            ),
            Positioned(
              top: 0,
              right: 0,
              child: Tooltip(
                triggerMode: TooltipTriggerMode.tap,
                message: isEN
                    ? "We’ve saved your answers. Please finish them when you have a moment to help us!"
                    : "Hemos guardado tus respuestas. ¡Completa el resto cuando tengas un momento para ayudarnos!",
                showDuration: const Duration(seconds: 10),
                padding: const EdgeInsets.all(10),
                margin: const EdgeInsets.symmetric(horizontal: 50, vertical: 0),
                preferBelow: false,
                textStyle: TextStyle(
                  color: theme.colorScheme.primary,
                ),
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(8.0),
                  border: Border.all(
                    color: const Color(0xFF4fa6a6),
                    style: BorderStyle.solid,
                  ),
                  boxShadow: const [
                    BoxShadow(
                      color: Colors.grey,
                      blurRadius: 2.0,
                      spreadRadius: 1.0,
                      offset: Offset(0, 2),
                    ),
                  ],
                ),
                child: Container(
                  decoration: BoxDecoration(
                    color: theme.colorScheme.primary,
                    shape: BoxShape.circle,
                  ),
                  child: const Icon(
                    Icons.info,
                    size: 26,
                    color: Colors.white,
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
