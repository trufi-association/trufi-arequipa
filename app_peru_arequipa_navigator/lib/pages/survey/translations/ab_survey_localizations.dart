import 'dart:async';

import 'package:flutter/foundation.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:intl/intl.dart' as intl;

import 'ab_survey_localizations_de.dart';
import 'ab_survey_localizations_en.dart';
import 'ab_survey_localizations_es.dart';

// ignore_for_file: type=lint

/// Callers can lookup localized strings with an instance of ABSurveyLocalization
/// returned by `ABSurveyLocalization.of(context)`.
///
/// Applications need to include `ABSurveyLocalization.delegate()` in their app's
/// `localizationDelegates` list, and the locales they support in the app's
/// `supportedLocales` list. For example:
///
/// ```dart
/// import 'translations/ab_survey_localizations.dart';
///
/// return MaterialApp(
///   localizationsDelegates: ABSurveyLocalization.localizationsDelegates,
///   supportedLocales: ABSurveyLocalization.supportedLocales,
///   home: MyApplicationHome(),
/// );
/// ```
///
/// ## Update pubspec.yaml
///
/// Please make sure to update your pubspec.yaml to include the following
/// packages:
///
/// ```yaml
/// dependencies:
///   # Internationalization support.
///   flutter_localizations:
///     sdk: flutter
///   intl: any # Use the pinned version from flutter_localizations
///
///   # Rest of dependencies
/// ```
///
/// ## iOS Applications
///
/// iOS applications define key application metadata, including supported
/// locales, in an Info.plist file that is built into the application bundle.
/// To configure the locales supported by your app, you’ll need to edit this
/// file.
///
/// First, open your project’s ios/Runner.xcworkspace Xcode workspace file.
/// Then, in the Project Navigator, open the Info.plist file under the Runner
/// project’s Runner folder.
///
/// Next, select the Information Property List item, select Add Item from the
/// Editor menu, then select Localizations from the pop-up menu.
///
/// Select and expand the newly-created Localizations item then, for each
/// locale your application supports, add a new item and select the locale
/// you wish to add from the pop-up menu in the Value field. This list should
/// be consistent with the languages listed in the ABSurveyLocalization.supportedLocales
/// property.
abstract class ABSurveyLocalization {
  ABSurveyLocalization(String locale) : localeName = intl.Intl.canonicalizedLocale(locale.toString());

  final String localeName;

  static ABSurveyLocalization of(BuildContext context) {
    return Localizations.of<ABSurveyLocalization>(context, ABSurveyLocalization)!;
  }

  static const LocalizationsDelegate<ABSurveyLocalization> delegate = _ABSurveyLocalizationDelegate();

  /// A list of this localizations delegate along with the default localizations
  /// delegates.
  ///
  /// Returns a list of localizations delegates containing this delegate along with
  /// GlobalMaterialLocalizations.delegate, GlobalCupertinoLocalizations.delegate,
  /// and GlobalWidgetsLocalizations.delegate.
  ///
  /// Additional delegates can be added by appending to this list in
  /// MaterialApp. This list does not have to be used at all if a custom list
  /// of delegates is preferred or required.
  static const List<LocalizationsDelegate<dynamic>> localizationsDelegates = <LocalizationsDelegate<dynamic>>[
    delegate,
    GlobalMaterialLocalizations.delegate,
    GlobalCupertinoLocalizations.delegate,
    GlobalWidgetsLocalizations.delegate,
  ];

  /// A list of this localizations delegate's supported locales.
  static const List<Locale> supportedLocales = <Locale>[
    Locale('de'),
    Locale('en'),
    Locale('es')
  ];

  /// No description provided for @commonClose.
  ///
  /// In es, this message translates to:
  /// **'Cerrar'**
  String get commonClose;

  /// No description provided for @commonMoreInformation.
  ///
  /// In es, this message translates to:
  /// **'Más información'**
  String get commonMoreInformation;

  /// No description provided for @commonMorePrevious.
  ///
  /// In es, this message translates to:
  /// **'Anterior'**
  String get commonMorePrevious;

  /// No description provided for @commonMoreNext.
  ///
  /// In es, this message translates to:
  /// **'Siguiente'**
  String get commonMoreNext;

  /// No description provided for @commonSaveAndNext.
  ///
  /// In es, this message translates to:
  /// **'Guardar y Siguiente'**
  String get commonSaveAndNext;

  /// No description provided for @introductionSurveyEnumWelcomeTitle.
  ///
  /// In es, this message translates to:
  /// **'📣 ¡Queremos saber tu opinión sobre el transporte público en tu ciudad!'**
  String get introductionSurveyEnumWelcomeTitle;

  /// No description provided for @introductionSurveyEnumWelcomeContent.
  ///
  /// In es, this message translates to:
  /// **'Tu respuesta es confidencial y solo te tomará unos minutos.'**
  String get introductionSurveyEnumWelcomeContent;

  /// No description provided for @introductionSurveyEnumInfoTitle.
  ///
  /// In es, this message translates to:
  /// **'¡Tu privacidad y tiempo son importantes para nosotros!'**
  String get introductionSurveyEnumInfoTitle;

  /// No description provided for @introductionSurveyEnumInfoContent.
  ///
  /// In es, this message translates to:
  /// **'Hay 10 preguntas de opción múltiple. Si necesitas un descanso, siéntete libre de guardar y continuar más tarde.'**
  String get introductionSurveyEnumInfoContent;

  /// No description provided for @surveyQuestionEnumGender.
  ///
  /// In es, this message translates to:
  /// **'Eres:'**
  String get surveyQuestionEnumGender;

  /// No description provided for @surveyQuestionEnumAgeGroup.
  ///
  /// In es, this message translates to:
  /// **'¿Cuál es tu grupo de edad?'**
  String get surveyQuestionEnumAgeGroup;

  /// No description provided for @surveyQuestionEnumDisability.
  ///
  /// In es, this message translates to:
  /// **'¿Tienes alguna discapacidad o eres cuidador(a) de una persona con discapacidad?'**
  String get surveyQuestionEnumDisability;

  /// No description provided for @surveyQuestionEnumFrequencyPublicTransport.
  ///
  /// In es, this message translates to:
  /// **'¿Con qué frecuencia utilizas el transporte público?'**
  String get surveyQuestionEnumFrequencyPublicTransport;

  /// No description provided for @surveyQuestionEnumUsagePublicTransport.
  ///
  /// In es, this message translates to:
  /// **'¿Para qué usas más el transporte público?'**
  String get surveyQuestionEnumUsagePublicTransport;

  /// No description provided for @surveyQuestionEnumTimePublicTransport.
  ///
  /// In es, this message translates to:
  /// **'¿En qué horario usas más el transporte público? (seleccione todas las que apliquen)'**
  String get surveyQuestionEnumTimePublicTransport;

  /// No description provided for @surveyQuestionEnumSafetyPublicTransport.
  ///
  /// In es, this message translates to:
  /// **'¿Te sientes segura utilizando el transporte público?'**
  String get surveyQuestionEnumSafetyPublicTransport;

  /// No description provided for @surveyQuestionEnumExperiencePublicTransport.
  ///
  /// In es, this message translates to:
  /// **'¿Ha experimentado alguna de las siguientes situaciones durante tus viajes? (seleccione todas las que apliquen)'**
  String get surveyQuestionEnumExperiencePublicTransport;

  /// No description provided for @surveyQuestionEnumSatisfactionSecurityMeasures.
  ///
  /// In es, this message translates to:
  /// **'¿Qué tan satisfecha estás con las medidas de seguridad actuales en el transporte público?'**
  String get surveyQuestionEnumSatisfactionSecurityMeasures;

  /// No description provided for @surveyQuestionEnumAdditionalSecurityMeasures.
  ///
  /// In es, this message translates to:
  /// **'¿Qué medidas de seguridad adicionales te gustaría que sean implementadas? (seleccione todas las que apliquen)'**
  String get surveyQuestionEnumAdditionalSecurityMeasures;

  /// No description provided for @surveyQuestionEnumRelationToDisability.
  ///
  /// In es, this message translates to:
  /// **'¿Cuál es tu relación con la discapacidad?'**
  String get surveyQuestionEnumRelationToDisability;

  /// No description provided for @surveyQuestionEnumTypeOfDisability.
  ///
  /// In es, this message translates to:
  /// **'¿Qué tipo de discapacidad está presente? (seleccione todas las que apliquen)'**
  String get surveyQuestionEnumTypeOfDisability;

  /// No description provided for @surveyQuestionEnumDisabilityRelatedFrequency.
  ///
  /// In es, this message translates to:
  /// **'¿Con qué frecuencia utilizas el transporte público?'**
  String get surveyQuestionEnumDisabilityRelatedFrequency;

  /// No description provided for @surveyQuestionEnumTimeToNearestStop.
  ///
  /// In es, this message translates to:
  /// **'¿Cuánto tardas en llegar al paradero más cercano?'**
  String get surveyQuestionEnumTimeToNearestStop;

  /// No description provided for @surveyQuestionEnumEaseOfUsePublicTransport.
  ///
  /// In es, this message translates to:
  /// **'¿Qué tan fácil te es usar el transporte público:'**
  String get surveyQuestionEnumEaseOfUsePublicTransport;

  /// No description provided for @surveyQuestionEnumDesiredFacilities.
  ///
  /// In es, this message translates to:
  /// **'¿Cuál de estas facilidades te gustaría encontrar en el transporte público? (selecciona todas las que apliquen)'**
  String get surveyQuestionEnumDesiredFacilities;

  /// No description provided for @surveyQuestionEnumAvailabilityOfInformation.
  ///
  /// In es, this message translates to:
  /// **'Disponibilidad de información sobre el transporte público (horarios, rutas, etc.):'**
  String get surveyQuestionEnumAvailabilityOfInformation;

  /// No description provided for @surveyOptionEnumGenderMale.
  ///
  /// In es, this message translates to:
  /// **'Hombre'**
  String get surveyOptionEnumGenderMale;

  /// No description provided for @surveyOptionEnumGenderFemale.
  ///
  /// In es, this message translates to:
  /// **'Mujer'**
  String get surveyOptionEnumGenderFemale;

  /// No description provided for @surveyOptionEnumGenderOther.
  ///
  /// In es, this message translates to:
  /// **'Otro'**
  String get surveyOptionEnumGenderOther;

  /// No description provided for @surveyOptionEnumAgeUnder18.
  ///
  /// In es, this message translates to:
  /// **'Menos de 18'**
  String get surveyOptionEnumAgeUnder18;

  /// No description provided for @surveyOptionEnumAge18_35.
  ///
  /// In es, this message translates to:
  /// **'18-35 años'**
  String get surveyOptionEnumAge18_35;

  /// No description provided for @surveyOptionEnumAge36_50.
  ///
  /// In es, this message translates to:
  /// **'36-50 años'**
  String get surveyOptionEnumAge36_50;

  /// No description provided for @surveyOptionEnumAge51_64.
  ///
  /// In es, this message translates to:
  /// **'51-64 años'**
  String get surveyOptionEnumAge51_64;

  /// No description provided for @surveyOptionEnumAge65Plus.
  ///
  /// In es, this message translates to:
  /// **'65 años o más'**
  String get surveyOptionEnumAge65Plus;

  /// No description provided for @surveyOptionEnumDisabilityYes.
  ///
  /// In es, this message translates to:
  /// **'Sí'**
  String get surveyOptionEnumDisabilityYes;

  /// No description provided for @surveyOptionEnumDisabilityNo.
  ///
  /// In es, this message translates to:
  /// **'No'**
  String get surveyOptionEnumDisabilityNo;

  /// No description provided for @surveyOptionEnumFrequencyDaily.
  ///
  /// In es, this message translates to:
  /// **'Diario'**
  String get surveyOptionEnumFrequencyDaily;

  /// No description provided for @surveyOptionEnumFrequencySeveralTimesPerWeek.
  ///
  /// In es, this message translates to:
  /// **'Varias veces a la semana'**
  String get surveyOptionEnumFrequencySeveralTimesPerWeek;

  /// No description provided for @surveyOptionEnumFrequencyOncePerWeek.
  ///
  /// In es, this message translates to:
  /// **'Una vez a la semana'**
  String get surveyOptionEnumFrequencyOncePerWeek;

  /// No description provided for @surveyOptionEnumFrequencyRarely.
  ///
  /// In es, this message translates to:
  /// **'Rara vez'**
  String get surveyOptionEnumFrequencyRarely;

  /// No description provided for @surveyOptionEnumUsageWork.
  ///
  /// In es, this message translates to:
  /// **'Trabajo'**
  String get surveyOptionEnumUsageWork;

  /// No description provided for @surveyOptionEnumUsageStudy.
  ///
  /// In es, this message translates to:
  /// **'Estudio'**
  String get surveyOptionEnumUsageStudy;

  /// No description provided for @surveyOptionEnumUsageHealthcare.
  ///
  /// In es, this message translates to:
  /// **'Cuidado de la salud'**
  String get surveyOptionEnumUsageHealthcare;

  /// No description provided for @surveyOptionEnumUsageLeisure.
  ///
  /// In es, this message translates to:
  /// **'Compras/ocio'**
  String get surveyOptionEnumUsageLeisure;

  /// No description provided for @surveyOptionEnumTimeMorning.
  ///
  /// In es, this message translates to:
  /// **'Mañana (4:30 AM - 9:00 AM)'**
  String get surveyOptionEnumTimeMorning;

  /// No description provided for @surveyOptionEnumTimeMidday.
  ///
  /// In es, this message translates to:
  /// **'Medio día (9:00 AM - 3:00 PM)'**
  String get surveyOptionEnumTimeMidday;

  /// No description provided for @surveyOptionEnumTimeAfternoon.
  ///
  /// In es, this message translates to:
  /// **'Noche (3:00 PM - 10:00 PM)'**
  String get surveyOptionEnumTimeAfternoon;

  /// No description provided for @surveyOptionEnumTimeNight.
  ///
  /// In es, this message translates to:
  /// **'Resto del día (10:00 PM - 4:30 AM)'**
  String get surveyOptionEnumTimeNight;

  /// No description provided for @surveyOptionEnumSafetyAlways.
  ///
  /// In es, this message translates to:
  /// **'Siempre'**
  String get surveyOptionEnumSafetyAlways;

  /// No description provided for @surveyOptionEnumSafetyMostOfTheTime.
  ///
  /// In es, this message translates to:
  /// **'La mayoría de las veces'**
  String get surveyOptionEnumSafetyMostOfTheTime;

  /// No description provided for @surveyOptionEnumSafetySometimes.
  ///
  /// In es, this message translates to:
  /// **'A veces'**
  String get surveyOptionEnumSafetySometimes;

  /// No description provided for @surveyOptionEnumSafetyRarely.
  ///
  /// In es, this message translates to:
  /// **'Rara vez'**
  String get surveyOptionEnumSafetyRarely;

  /// No description provided for @surveyOptionEnumSafetyNever.
  ///
  /// In es, this message translates to:
  /// **'Nunca'**
  String get surveyOptionEnumSafetyNever;

  /// No description provided for @surveyOptionEnumExperienceInappropriateLooks.
  ///
  /// In es, this message translates to:
  /// **'Miradas inapropiadas'**
  String get surveyOptionEnumExperienceInappropriateLooks;

  /// No description provided for @surveyOptionEnumExperienceOffensiveComments.
  ///
  /// In es, this message translates to:
  /// **'Comentarios ofensivos'**
  String get surveyOptionEnumExperienceOffensiveComments;

  /// No description provided for @surveyOptionEnumExperienceUnwantedPhysicalContact.
  ///
  /// In es, this message translates to:
  /// **'Contacto físico no deseado'**
  String get surveyOptionEnumExperienceUnwantedPhysicalContact;

  /// No description provided for @surveyOptionEnumExperienceBeingFollowed.
  ///
  /// In es, this message translates to:
  /// **'Seguimiento'**
  String get surveyOptionEnumExperienceBeingFollowed;

  /// No description provided for @surveyOptionEnumExperienceTheft.
  ///
  /// In es, this message translates to:
  /// **'Robo'**
  String get surveyOptionEnumExperienceTheft;

  /// No description provided for @surveyOptionEnumExperienceNone.
  ///
  /// In es, this message translates to:
  /// **'No he experimentado ninguna de estas situaciones'**
  String get surveyOptionEnumExperienceNone;

  /// No description provided for @surveyOptionEnumSatisfactionVerySatisfied.
  ///
  /// In es, this message translates to:
  /// **'Muy satisfecha'**
  String get surveyOptionEnumSatisfactionVerySatisfied;

  /// No description provided for @surveyOptionEnumSatisfactionSatisfied.
  ///
  /// In es, this message translates to:
  /// **'Satisfecha'**
  String get surveyOptionEnumSatisfactionSatisfied;

  /// No description provided for @surveyOptionEnumSatisfactionNeutral.
  ///
  /// In es, this message translates to:
  /// **'Neutral'**
  String get surveyOptionEnumSatisfactionNeutral;

  /// No description provided for @surveyOptionEnumSatisfactionDissatisfied.
  ///
  /// In es, this message translates to:
  /// **'Insatisfecha'**
  String get surveyOptionEnumSatisfactionDissatisfied;

  /// No description provided for @surveyOptionEnumSatisfactionVeryDissatisfied.
  ///
  /// In es, this message translates to:
  /// **'Muy insatisfecha'**
  String get surveyOptionEnumSatisfactionVeryDissatisfied;

  /// No description provided for @surveyOptionEnumSecurityPolicePresence.
  ///
  /// In es, this message translates to:
  /// **'Mayor presencia policial'**
  String get surveyOptionEnumSecurityPolicePresence;

  /// No description provided for @surveyOptionEnumSecurityCCTV.
  ///
  /// In es, this message translates to:
  /// **'Cámaras de vigilancia'**
  String get surveyOptionEnumSecurityCCTV;

  /// No description provided for @surveyOptionEnumSecurityWomenOnlyZones.
  ///
  /// In es, this message translates to:
  /// **'Zonas exclusivas para mujeres'**
  String get surveyOptionEnumSecurityWomenOnlyZones;

  /// No description provided for @surveyOptionEnumSecurityBetterLighting.
  ///
  /// In es, this message translates to:
  /// **'Mejor iluminación en estaciones'**
  String get surveyOptionEnumSecurityBetterLighting;

  /// No description provided for @surveyOptionEnumSecurityEmergencyLine.
  ///
  /// In es, this message translates to:
  /// **'Línea de emergencia'**
  String get surveyOptionEnumSecurityEmergencyLine;

  /// No description provided for @surveyOptionEnumRelationDisabilityNone.
  ///
  /// In es, this message translates to:
  /// **'Ninguna de las anteriores (para adultos mayores sin discapacidad)'**
  String get surveyOptionEnumRelationDisabilityNone;

  /// No description provided for @surveyOptionEnumRelationDisabilityPersonWithDisability.
  ///
  /// In es, this message translates to:
  /// **'Persona con discapacidad'**
  String get surveyOptionEnumRelationDisabilityPersonWithDisability;

  /// No description provided for @surveyOptionEnumRelationDisabilityCaregiver.
  ///
  /// In es, this message translates to:
  /// **'Cuidador de una persona con discapacidad'**
  String get surveyOptionEnumRelationDisabilityCaregiver;

  /// No description provided for @surveyOptionEnumDisabilityTypeMotor.
  ///
  /// In es, this message translates to:
  /// **'Motora'**
  String get surveyOptionEnumDisabilityTypeMotor;

  /// No description provided for @surveyOptionEnumDisabilityTypeVisual.
  ///
  /// In es, this message translates to:
  /// **'Visual'**
  String get surveyOptionEnumDisabilityTypeVisual;

  /// No description provided for @surveyOptionEnumDisabilityTypeAuditory.
  ///
  /// In es, this message translates to:
  /// **'Auditiva'**
  String get surveyOptionEnumDisabilityTypeAuditory;

  /// No description provided for @surveyOptionEnumDisabilityTypeCognitive.
  ///
  /// In es, this message translates to:
  /// **'Cognitiva'**
  String get surveyOptionEnumDisabilityTypeCognitive;

  /// No description provided for @surveyOptionEnumDisabilityTypeNotApplicable.
  ///
  /// In es, this message translates to:
  /// **'No aplica'**
  String get surveyOptionEnumDisabilityTypeNotApplicable;

  /// No description provided for @surveyOptionEnumDisabilityFrequencyDaily.
  ///
  /// In es, this message translates to:
  /// **'Diario'**
  String get surveyOptionEnumDisabilityFrequencyDaily;

  /// No description provided for @surveyOptionEnumDisabilityFrequencySeveralTimesPerWeek.
  ///
  /// In es, this message translates to:
  /// **'Varias veces a la semana'**
  String get surveyOptionEnumDisabilityFrequencySeveralTimesPerWeek;

  /// No description provided for @surveyOptionEnumDisabilityFrequencyOncePerWeek.
  ///
  /// In es, this message translates to:
  /// **'Una vez a la semana'**
  String get surveyOptionEnumDisabilityFrequencyOncePerWeek;

  /// No description provided for @surveyOptionEnumDisabilityFrequencyRarely.
  ///
  /// In es, this message translates to:
  /// **'Rara vez'**
  String get surveyOptionEnumDisabilityFrequencyRarely;

  /// No description provided for @surveyOptionEnumTimeToStopLessThan5Minutes.
  ///
  /// In es, this message translates to:
  /// **'Menos de 5 minutos'**
  String get surveyOptionEnumTimeToStopLessThan5Minutes;

  /// No description provided for @surveyOptionEnumTimeToStop5_10Minutes.
  ///
  /// In es, this message translates to:
  /// **'5-10 minutos'**
  String get surveyOptionEnumTimeToStop5_10Minutes;

  /// No description provided for @surveyOptionEnumTimeToStop10_20Minutes.
  ///
  /// In es, this message translates to:
  /// **'10-20 minutos'**
  String get surveyOptionEnumTimeToStop10_20Minutes;

  /// No description provided for @surveyOptionEnumTimeToStopMoreThan20Minutes.
  ///
  /// In es, this message translates to:
  /// **'Más de 20 minutos'**
  String get surveyOptionEnumTimeToStopMoreThan20Minutes;

  /// No description provided for @surveyOptionEnumEaseOfUseVeryEasy.
  ///
  /// In es, this message translates to:
  /// **'Muy fácil'**
  String get surveyOptionEnumEaseOfUseVeryEasy;

  /// No description provided for @surveyOptionEnumEaseOfUseEasy.
  ///
  /// In es, this message translates to:
  /// **'Fácil'**
  String get surveyOptionEnumEaseOfUseEasy;

  /// No description provided for @surveyOptionEnumEaseOfUseNeutral.
  ///
  /// In es, this message translates to:
  /// **'Neutral'**
  String get surveyOptionEnumEaseOfUseNeutral;

  /// No description provided for @surveyOptionEnumEaseOfUseDifficult.
  ///
  /// In es, this message translates to:
  /// **'Difícil'**
  String get surveyOptionEnumEaseOfUseDifficult;

  /// No description provided for @surveyOptionEnumEaseOfUseVeryDifficult.
  ///
  /// In es, this message translates to:
  /// **'Muy difícil'**
  String get surveyOptionEnumEaseOfUseVeryDifficult;

  /// No description provided for @surveyOptionEnumFacilitiesRampsOrElevators.
  ///
  /// In es, this message translates to:
  /// **'Rampas o ascensores'**
  String get surveyOptionEnumFacilitiesRampsOrElevators;

  /// No description provided for @surveyOptionEnumFacilitiesTrainedStaff.
  ///
  /// In es, this message translates to:
  /// **'Personal capacitado'**
  String get surveyOptionEnumFacilitiesTrainedStaff;

  /// No description provided for @surveyOptionEnumFacilitiesWheelchairSpace.
  ///
  /// In es, this message translates to:
  /// **'Espacio para sillas de ruedas'**
  String get surveyOptionEnumFacilitiesWheelchairSpace;

  /// No description provided for @surveyOptionEnumFacilitiesFrequencyAndPunctuality.
  ///
  /// In es, this message translates to:
  /// **'Frecuencia y puntualidad del servicio'**
  String get surveyOptionEnumFacilitiesFrequencyAndPunctuality;

  /// No description provided for @surveyOptionEnumFacilitiesReservedSeats.
  ///
  /// In es, this message translates to:
  /// **'Más asientos reservados'**
  String get surveyOptionEnumFacilitiesReservedSeats;

  /// No description provided for @surveyOptionEnumInformationVeryGood.
  ///
  /// In es, this message translates to:
  /// **'Muy buena'**
  String get surveyOptionEnumInformationVeryGood;

  /// No description provided for @surveyOptionEnumInformationGood.
  ///
  /// In es, this message translates to:
  /// **'Buena'**
  String get surveyOptionEnumInformationGood;

  /// No description provided for @surveyOptionEnumInformationNeutral.
  ///
  /// In es, this message translates to:
  /// **'Neutral'**
  String get surveyOptionEnumInformationNeutral;

  /// No description provided for @surveyOptionEnumInformationBad.
  ///
  /// In es, this message translates to:
  /// **'Mala'**
  String get surveyOptionEnumInformationBad;

  /// No description provided for @surveyOptionEnumInformationVeryBad.
  ///
  /// In es, this message translates to:
  /// **'Muy mala'**
  String get surveyOptionEnumInformationVeryBad;
}

class _ABSurveyLocalizationDelegate extends LocalizationsDelegate<ABSurveyLocalization> {
  const _ABSurveyLocalizationDelegate();

  @override
  Future<ABSurveyLocalization> load(Locale locale) {
    return SynchronousFuture<ABSurveyLocalization>(lookupABSurveyLocalization(locale));
  }

  @override
  bool isSupported(Locale locale) => <String>['de', 'en', 'es'].contains(locale.languageCode);

  @override
  bool shouldReload(_ABSurveyLocalizationDelegate old) => false;
}

ABSurveyLocalization lookupABSurveyLocalization(Locale locale) {


  // Lookup logic when only language code is specified.
  switch (locale.languageCode) {
    case 'de': return ABSurveyLocalizationDe();
    case 'en': return ABSurveyLocalizationEn();
    case 'es': return ABSurveyLocalizationEs();
  }

  throw FlutterError(
    'ABSurveyLocalization.delegate failed to load unsupported locale "$locale". This is likely '
    'an issue with the localizations generation tool. Please file an issue '
    'on GitHub with a reproducible sample app and the gen-l10n configuration '
    'that was used.'
  );
}
