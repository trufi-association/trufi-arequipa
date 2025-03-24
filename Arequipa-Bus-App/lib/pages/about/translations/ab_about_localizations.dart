import 'dart:async';

import 'package:flutter/foundation.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:intl/intl.dart' as intl;

import 'ab_about_localizations_de.dart';
import 'ab_about_localizations_en.dart';
import 'ab_about_localizations_es.dart';

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
  /// In es, this message translates to:
  /// **'Trufi Association es una ONG internacional que promueve un acceso más fácil al transporte público. Nuestras aplicaciones ayudan a que todos puedan encontrar la mejor manera de ir de un punto A a un punto B dentro de sus ciudades.\n\nEn muchas ciudades no existen mapas, aplicaciones ni horarios oficiales. Nosotros nos encargamos de completarlos, y a veces incluso trazamos rutas desde cero. Un sistema de transporte bien diseñado contribuye a una mayor sostenibilidad, un aire más limpio y una mejor calidad de vida.'**
  String get aboutCollapseContent;

  /// No description provided for @aboutCollapseContentFoot.
  ///
  /// In es, this message translates to:
  /// **'Forma parte de nuestro equipo de voluntarios. Necesitamos mapeadores, desarrolladores, planificadores, testers y otras manos más.'**
  String get aboutCollapseContentFoot;

  /// No description provided for @aboutCollapseTitle.
  ///
  /// In es, this message translates to:
  /// **'Más sobre Trufi Association'**
  String get aboutCollapseTitle;

  /// Text displayed on the about page
  ///
  /// In es, this message translates to:
  /// **'¿Necesitas ir a algún lugar y no sabes qué ruta de bus tomar? ¡Con Arequipa Bus, es más fácil!\n\nArequipa Bus es un aplicativo desarrollado por la Municipalidad de Arequipa en colaboración con la Oficina de Cooperación Internacional GIZ y con datos proporcionados por la Gerencia de Transporte. Utilizamos la tecnología de la Asociación Trufi de Alemania para que moverse por nuestra ciudad sea sencillo y cómodo. Nuestro objetivo es ofrecerte una herramienta práctica que te permita navegar por Arequipa con confianza.\n\nEstamos comprometidos con la mejora continua de Arequipa Bus para brindarte información cada vez más precisa y útil. Sabemos que el sistema de transporte en Arequipa puede experimentar cambios debido a diversas razones, por lo que es posible que algunas rutas no estén completamente actualizadas.\n\nPara hacer de Arequipa Bus una herramienta aún más efectiva, confiamos en la colaboración de nuestros usuarios. Si conoces cambios en algunas rutas o paradas, te animamos a compartir esta información con nosotros. Tu contribución no solo ayudará a mantener la aplicación al día, sino que también beneficiará a otros usuarios que dependen de Arequipa Bus para moverse por la ciudad.\n\nGracias por elegir Arequipa Bus para tus desplazamientos en Arequipa. ¡Esperamos que disfrutes de la experiencia con nosotros!'**
  String aboutContent(Object appName, Object city);

  /// Button label to show licenses
  ///
  /// In es, this message translates to:
  /// **'Licencias'**
  String get aboutLicenses;

  /// A note about open source
  ///
  /// In es, this message translates to:
  /// **'Esta aplicación está publicada como código abierto en GitHub. Siéntase libre de contribuir  o utilizarlo para su propia ciudad.'**
  String get aboutOpenSource;

  /// Menu item that shows the about page
  ///
  /// In es, this message translates to:
  /// **'Sobre nosotros'**
  String get menuAbout;

  /// A short marketing sentence that describes the app
  ///
  /// In es, this message translates to:
  /// **'Transporte público en {city}'**
  String tagline(Object city);

  /// No description provided for @trufiWebsite.
  ///
  /// In es, this message translates to:
  /// **'Sitio web de Trufi Association'**
  String get trufiWebsite;

  /// The application's version
  ///
  /// In es, this message translates to:
  /// **'Versión {version}'**
  String version(Object version);

  /// No description provided for @volunteerTrufi.
  ///
  /// In es, this message translates to:
  /// **'Voluntariados para Trufi'**
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
