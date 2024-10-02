## Generates all files for the given translation
list='trufiapp_en.arb trufiapp_es.arb'

# Feedback command translations
# for i in $list; do
#     flutter gen-l10n --arb-dir=translations/feedback_localizations --template-arb-file=$i --output-localization-file=ab_feedback_localizations.dart --output-class=ABFeedbackLocalization --output-dir=lib/pages/feedback/translations --no-synthetic-package
# done

# Aboud command translations
# for i in $list; do
#     flutter gen-l10n --arb-dir=translations/about_localizations --template-arb-file=$i --output-localization-file=ab_about_localizations.dart --output-class=ABAboutLocalization --output-dir=lib/pages/about/translations --no-synthetic-package
# done

# Survey command translations
for i in $list; do
    flutter gen-l10n --arb-dir=translations/survey_localizations --template-arb-file=$i --output-localization-file=ab_survey_localizations.dart --output-class=ABSurveyLocalization --output-dir=lib/pages/survey/translations --no-synthetic-package
done
