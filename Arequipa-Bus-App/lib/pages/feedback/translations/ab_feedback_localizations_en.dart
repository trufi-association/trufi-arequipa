import 'ab_feedback_localizations.dart';

/// The translations for English (`en`).
class ABFeedbackLocalizationEn extends ABFeedbackLocalization {
  ABFeedbackLocalizationEn([String locale = 'en']) : super(locale);

  @override
  String get menuFeedback => 'Feedback Box';

  @override
  String get feedbackTitle => 'Send us a suggestion';

  @override
  String get feedbackContent => 'Do you have suggestions about our app or the transport service? We want to hear your feedback! Please include your email address or phone number so we can get back to you.';
}
