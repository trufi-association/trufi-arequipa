import 'dart:async';

import 'package:flutter/foundation.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:intl/intl.dart' as intl;

import 'ab_feedback_localizations_de.dart';
import 'ab_feedback_localizations_en.dart';
import 'ab_feedback_localizations_es.dart';

/// Callers can lookup localized strings with an instance of ABFeedbackLocalization
/// returned by `ABFeedbackLocalization.of(context)`.
///
/// Applications need to include `ABFeedbackLocalization.delegate()` in their app's
/// `localizationDelegates` list, and the locales they support in the app's
/// `supportedLocales` list. For example:
///
/// ```dart
/// import 'translations/ab_feedback_localizations.dart';
///
/// return MaterialApp(
///   localizationsDelegates: ABFeedbackLocalization.localizationsDelegates,
///   supportedLocales: ABFeedbackLocalization.supportedLocales,
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
/// be consistent with the languages listed in the ABFeedbackLocalization.supportedLocales
/// property.
abstract class ABFeedbackLocalization {
  ABFeedbackLocalization(String locale) : localeName = intl.Intl.canonicalizedLocale(locale.toString());

  final String localeName;

  static ABFeedbackLocalization? of(BuildContext context) {
    return Localizations.of<ABFeedbackLocalization>(context, ABFeedbackLocalization);
  }

  static const LocalizationsDelegate<ABFeedbackLocalization> delegate = _ABFeedbackLocalizationDelegate();

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

  /// Menu item that shows the feedback page
  ///
  /// In es, this message translates to:
  /// **'Buzón de sugerencias'**
  String get menuFeedback;

  /// Title displayed on the feedback page
  ///
  /// In es, this message translates to:
  /// **'Envíanos una sugerencia'**
  String get feedbackTitle;

  /// Text displayed on the feedback page
  ///
  /// In es, this message translates to:
  /// **'¿Tienes sugerencias sobre nuestra aplicación o el servicio de transporte? ¡Queremos saber tu opinión! Por favor, agrega tu correo electrónico o teléfono para que podamos responderte.'**
  String get feedbackContent;
}

class _ABFeedbackLocalizationDelegate extends LocalizationsDelegate<ABFeedbackLocalization> {
  const _ABFeedbackLocalizationDelegate();

  @override
  Future<ABFeedbackLocalization> load(Locale locale) {
    return SynchronousFuture<ABFeedbackLocalization>(lookupABFeedbackLocalization(locale));
  }

  @override
  bool isSupported(Locale locale) => <String>['de', 'en', 'es'].contains(locale.languageCode);

  @override
  bool shouldReload(_ABFeedbackLocalizationDelegate old) => false;
}

ABFeedbackLocalization lookupABFeedbackLocalization(Locale locale) {


  // Lookup logic when only language code is specified.
  switch (locale.languageCode) {
    case 'de': return ABFeedbackLocalizationDe();
    case 'en': return ABFeedbackLocalizationEn();
    case 'es': return ABFeedbackLocalizationEs();
  }

  throw FlutterError(
    'ABFeedbackLocalization.delegate failed to load unsupported locale "$locale". This is likely '
    'an issue with the localizations generation tool. Please file an issue '
    'on GitHub with a reproducible sample app and the gen-l10n configuration '
    'that was used.'
  );
}
