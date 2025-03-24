import 'ab_about_localizations.dart';

/// The translations for Spanish Castilian (`es`).
class ABAboutLocalizationEs extends ABAboutLocalization {
  ABAboutLocalizationEs([String locale = 'es']) : super(locale);

  @override
  String get aboutCollapseContent => 'Trufi Association es una ONG internacional que promueve un acceso más fácil al transporte público. Nuestras aplicaciones ayudan a que todos puedan encontrar la mejor manera de ir de un punto A a un punto B dentro de sus ciudades.\n\nEn muchas ciudades no existen mapas, aplicaciones ni horarios oficiales. Nosotros nos encargamos de completarlos, y a veces incluso trazamos rutas desde cero. Un sistema de transporte bien diseñado contribuye a una mayor sostenibilidad, un aire más limpio y una mejor calidad de vida.';

  @override
  String get aboutCollapseContentFoot => 'Forma parte de nuestro equipo de voluntarios. Necesitamos mapeadores, desarrolladores, planificadores, testers y otras manos más.';

  @override
  String get aboutCollapseTitle => 'Más sobre Trufi Association';

  @override
  String aboutContent(Object appName, Object city) {
    return '¿Necesitas ir a algún lugar y no sabes qué ruta de bus tomar? ¡Con Arequipa Bus, es más fácil!\n\nArequipa Bus es un aplicativo desarrollado por la Municipalidad de Arequipa en colaboración con la Oficina de Cooperación Internacional GIZ y con datos proporcionados por la Gerencia de Transporte. Utilizamos la tecnología de la Asociación Trufi de Alemania para que moverse por nuestra ciudad sea sencillo y cómodo. Nuestro objetivo es ofrecerte una herramienta práctica que te permita navegar por Arequipa con confianza.\n\nEstamos comprometidos con la mejora continua de Arequipa Bus para brindarte información cada vez más precisa y útil. Sabemos que el sistema de transporte en Arequipa puede experimentar cambios debido a diversas razones, por lo que es posible que algunas rutas no estén completamente actualizadas.\n\nPara hacer de Arequipa Bus una herramienta aún más efectiva, confiamos en la colaboración de nuestros usuarios. Si conoces cambios en algunas rutas o paradas, te animamos a compartir esta información con nosotros. Tu contribución no solo ayudará a mantener la aplicación al día, sino que también beneficiará a otros usuarios que dependen de Arequipa Bus para moverse por la ciudad.\n\nGracias por elegir Arequipa Bus para tus desplazamientos en Arequipa. ¡Esperamos que disfrutes de la experiencia con nosotros!';
  }

  @override
  String get aboutLicenses => 'Licencias';

  @override
  String get aboutOpenSource => 'Esta aplicación está publicada como código abierto en GitHub. Siéntase libre de contribuir  o utilizarlo para su propia ciudad.';

  @override
  String get menuAbout => 'Sobre nosotros';

  @override
  String tagline(Object city) {
    return 'Transporte público en $city';
  }

  @override
  String get trufiWebsite => 'Sitio web de Trufi Association';

  @override
  String version(Object version) {
    return 'Versión $version';
  }

  @override
  String get volunteerTrufi => 'Voluntariados para Trufi';
}
