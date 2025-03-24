import 'ab_feedback_localizations.dart';

/// The translations for German (`de`).
class ABFeedbackLocalizationDe extends ABFeedbackLocalization {
  ABFeedbackLocalizationDe([String locale = 'de']) : super(locale);

  @override
  String get menuFeedback => 'Feedback Box';

  @override
  String get feedbackTitle => 'Sende uns einen Vorschlag';

  @override
  String get feedbackContent => 'Hast du Vorschläge zu unserer App oder dem Transportdienst? Wir möchten dein Feedback hören! Bitte füge deine E-Mail-Adresse oder Telefonnummer hinzu, damit wir dir antworten können.';
}
