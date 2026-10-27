import 'dart:async';

import 'package:flutter/foundation.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:intl/intl.dart' as intl;

import 'ab_about_localizations_de.dart';
import 'ab_about_localizations_en.dart';
import 'ab_about_localizations_es.dart';

// ignore_for_file: type=lint

/// Callers can lookup localized strings with an instance of ABAboutLocalization
/// returned by `ABAboutLocalization.of(context)`.
///
/// Applications need to include `ABAboutLocalization.delegate()` in their app's
/// `localizationDelegates` list, and the locales they support in the app's
/// `supportedLocales` list. For example:
///
/// ```dart
/// import 'translations/ab_about_localizations.dart';
///
/// return MaterialApp(
///   localizationsDelegates: ABAboutLocalization.localizationsDelegates,
///   supportedLocales: ABAboutLocalization.supportedLocales,
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
/// be consistent with the languages listed in the ABAboutLocalization.supportedLocales
/// property.
abstract class ABAboutLocalization {
  ABAboutLocalization(String locale) : localeName = intl.Intl.canonicalizedLocale(locale.toString());

  final String localeName;

  static ABAboutLocalization? of(BuildContext context) {
    return Localizations.of<ABAboutLocalization>(context, ABAboutLocalization);
  }

  static const LocalizationsDelegate<ABAboutLocalization> delegate = _ABAboutLocalizationDelegate();

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

  /// A short marketing sentence that describes the app
  ///
  /// In de, this message translates to:
  /// **'Trufi Association is an international NGO that promotes easier access to public transport. Our apps help everyone find the best way to get from point A to point B within their cities.\n\nIn many cities there are no official maps, routes, apps or timetables. So we compile the available information, and sometimes even map routes from scratch working with local people who know the city.  An easy-to-use transportation system contributes to greater sustainability, cleaner air and a better quality of life.'**
  String get aboutCollapseContent;

  /// No description provided for @aboutCollapseContentFoot.
  ///
  /// In de, this message translates to:
  /// **'We need mappers, developers, planners, testers, and many other hands.'**
  String get aboutCollapseContentFoot;

  /// No description provided for @aboutCollapseTitle.
  ///
  /// In de, this message translates to:
  /// **'More About Trufi Association'**
  String get aboutCollapseTitle;

  /// Text displayed on the about page
  ///
  /// In de, this message translates to:
  /// **'Du musst irgendwo hin und weißt nicht, welchen Trufi oder Bus Du nehmen sollst?\nDie {appName} macht es einfach!\n\nDie Trufi Association ist ein Team aus Bolivien und aus aller Welt. Wir lieben La Llajta und die öffentlichen Verkehrsmittel, deshalb haben wir diese Anwendung entwickelt, um den ÖPNV zugänglicher zu machen. Unser Ziel ist es, Dir ein praktisches Werkzeug an die Hand zu geben, mit dem Du Dich sicher bewegen kannst.\n\nWir sind bestrebt, die {appName} ständig zu verbessern, um Dir immer richtige und nützliche Informationen bereitstellen zu können. Wir wissen, dass das Verkehrssystem in {city} aus verschiedenen Gründen ständig im Wandel ist und es so möglich ist, dass einige Routen nicht ganz aktuell sind.\n\nUm die {appName} zu einem effektiven Werkzeug zu machen, sind wir auf Deine Mitarbeit angewiesen. Wenn Dir Änderungen an einigen Routen oder Haltestellen bekannt sind, bitten wir Dich, diese Informationen mit uns zu teilen. Dein Beitrag trägt nicht nur dazu bei, die App auf dem neuesten Stand zu halten, sondern kommt auch anderen Nutzern zugute, die sich auf die {appName} verlassen.\n\nVielen Dank, dass Du die {appName} dazu nutzt, um Dich in {city} fortzubewegen. Wir hoffen, dass Du Deine Zeit mit uns genießt!'**
  String aboutContent(Object appName, Object city);

  /// Button label to show licenses
  ///
  /// In de, this message translates to:
  /// **'Lizenzen'**
  String get aboutLicenses;

  /// A note about open source
  ///
  /// In de, this message translates to:
  /// **'Diese App ist als Open Source auf GitHub veröffentlicht. Wir freuen uns, wenn Du zum Code beiträgst oder eine App für Deine eigene Stadt entwickelst.'**
  String get aboutOpenSource;

  /// Title of the disclaimer section in the About page
  ///
  /// In de, this message translates to:
  /// **'Zu den angezeigten Informationen'**
  String get disclaimerTitle;

  /// Body of the disclaimer section: estimates, deviations, closed streets
  ///
  /// In de, this message translates to:
  /// **'Die Fahrzeiten sind Schätzungen auf Basis der geplanten Routen.\nFahrzeuge können von ihrer Route abweichen oder Haltestellen auslassen.\nStraßen können ohne Vorankündigung gesperrt oder blockiert sein (Baustellen, Sperrungen durch Anwohner).\nNutze die Ergebnisse als Orientierung und plane einen Zeitpuffer ein.'**
  String get disclaimerContent;

  /// One-line notice under the list of itineraries
  ///
  /// In de, this message translates to:
  /// **'Geschätzte Zeiten. Routen können abweichen und Straßen gesperrt sein.'**
  String get resultsDisclaimer;

  /// Menu item that shows the about page
  ///
  /// In de, this message translates to:
  /// **'Über Uns'**
  String get menuAbout;

  /// A short marketing sentence that describes the app
  ///
  /// In de, this message translates to:
  /// **'Öffentliche Verkehrsmittel in {city}'**
  String tagline(Object city);

  /// No description provided for @trufiWebsite.
  ///
  /// In de, this message translates to:
  /// **'Trufi Association Website'**
  String get trufiWebsite;

  /// The application's version
  ///
  /// In de, this message translates to:
  /// **'Version {version}'**
  String version(Object version);

  /// No description provided for @volunteerTrufi.
  ///
  /// In de, this message translates to:
  /// **'Volunteer For Trufi'**
  String get volunteerTrufi;
}

class _ABAboutLocalizationDelegate extends LocalizationsDelegate<ABAboutLocalization> {
  const _ABAboutLocalizationDelegate();

  @override
  Future<ABAboutLocalization> load(Locale locale) {
    return SynchronousFuture<ABAboutLocalization>(lookupABAboutLocalization(locale));
  }

  @override
  bool isSupported(Locale locale) => <String>['de', 'en', 'es'].contains(locale.languageCode);

  @override
  bool shouldReload(_ABAboutLocalizationDelegate old) => false;
}

ABAboutLocalization lookupABAboutLocalization(Locale locale) {


  // Lookup logic when only language code is specified.
  switch (locale.languageCode) {
    case 'de': return ABAboutLocalizationDe();
    case 'en': return ABAboutLocalizationEn();
    case 'es': return ABAboutLocalizationEs();
  }

  throw FlutterError(
    'ABAboutLocalization.delegate failed to load unsupported locale "$locale". This is likely '
    'an issue with the localizations generation tool. Please file an issue '
    'on GitHub with a reproducible sample app and the gen-l10n configuration '
    'that was used.'
  );
}
