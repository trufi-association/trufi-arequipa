import 'ab_feedback_localizations.dart';

/// The translations for Spanish Castilian (`es`).
class ABFeedbackLocalizationEs extends ABFeedbackLocalization {
  ABFeedbackLocalizationEs([String locale = 'es']) : super(locale);

  @override
  String get menuFeedback => 'Buzón de sugerencias';

  @override
  String get feedbackTitle => 'Envíanos una sugerencia';

  @override
  String get feedbackContent => '¿Tienes sugerencias sobre nuestra aplicación o el servicio de transporte? ¡Queremos saber tu opinión! Por favor, agrega tu correo electrónico o teléfono para que podamos responderte.';
}
