# Arequipa Bus – Frontend Customization Guide

## Introduction

Arequipa Bus is an open-source public transport mobile application for **Android** and **iOS**, developed using the [Trufi Core](https://github.com/trufi-association/trufi-core) framework. The frontend is based on the `v4.0.0-arequipa-lts` tag of Trufi Core and includes specific configurations to adapt the app to the city of Arequipa, Peru.

This guide provides information relevant to **open-source contributors**, specifically covering the theme setup, localization strategy, and Trufi Core configuration. For technical details on packages, state management, and architecture, refer to the official Trufi Core documentation.

---

## Getting Started

### Requirements

- Flutter SDK (e.g. `>=3.10.0`)
- Dart SDK
- Android Studio or VS Code
- Git

### Running the App

```bash
# Clone the repository
git clone https://github.com/trufi-association/trufi-arequipa.git
cd trufi-arequipa/Arequipa-Bus-App

# Install dependencies
flutter pub get

# Run the app
flutter run
```

---

## Theme Customization

The app's theme is configured in [`lib/arequipa_bus_theme.dart`](lib/arequipa_bus_theme.dart), defining styles for both **light** and **dark** modes.

- Uses Flutter’s `ThemeData` system.
- Any future branding or visual changes should be done by modifying this file.
- The theme is applied globally through `TrufiBaseTheme` in the app’s initialization.

---

## Localization

The default language is **Spanish (es)**, with support for **English (en)**. Translations are handled via the [`intl`](https://pub.dev/packages/intl) package.

### Adding or Removing Languages

To add or remove a language:

1. Edit `tools/generate_translations.sh` and update the `list` variable:
   ```bash
   list='trufiapp_en.arb trufiapp_es.arb'
   ```
2. In `translations/`, each translation domain (e.g., survey) has its own folder.
   - Example: `translations/survey_localizations`
3. For a new language like German, add `trufiapp_de.arb` to each relevant folder and provide key-value pairs.

### Adding New Translation Keys

- Add the key-value pair to all language `.arb` files.
- Use the new key in code like this:
  ```dart
  ABFeedbackLocalization.of(context).yourTranslationKey
  ```

---

## Trufi Core Configuration

The app is initialized using the `TrufiCore` widget, with Arequipa-specific values provided via `ArequipaBusDefaultValues`.

- **App name and default locale**:Arequipa Bus
- **Routing services**:
  - [OpenTripPlanner (OTP)](https://github.com/opentripplanner/OpenTripPlanner) for routing with next url "https://arequipabus.muniarequipa.gob.pe/otp/routers/default/index/graphql"
  - [Photon](https://github.com/komoot/photon) for place search, the service is provided in https://arequipabus.muniarequipa.gob.pe/photon
  - [OpenStreetMap](https://www.openstreetmap.org/) for maps, the service provided in http://arequipabus.muniarequipa.gob.pe/static-maps/trufi-liberty/{z}/{x}/{y}@2x.jpg
- **Center of map**: Arequipa coordinates with Lat(-16.4090) and Long(-71.5375)
- **Survey support** with localized forms
- **Feedback and About pages** fully customized
- **Share feature** allows sharing trip plans via link

These are injected via the `blocProviders`, `trufiRouter`, and other parameters in the main configuration.

---

## iOS and Android Customization

- Splash screens and logos are configured per platform.
- Android and iOS builds follow Flutter’s default structure with platform-specific assets.

---

## Contribution

Feel free to fork, open issues, or submit pull requests. For questions related to the base framework, please refer to the [Trufi Core repository](https://github.com/trufi-association/trufi-core).

---

Made with ❤️ for Arequipa.
