import 'package:arequipa_bus/pages/survey/translations/ab_survey_localizations.dart';
import 'package:flutter/material.dart';

enum SurveyPreviewEnum {
  welcome,
  info,
}

extension SurveyPreviewEnumExtension on SurveyPreviewEnum {
  static final Map<SurveyPreviewEnum, String> _toValueMap = {
    SurveyPreviewEnum.welcome: "welcome",
    SurveyPreviewEnum.info: "info",
  };

  static final Map<String, SurveyPreviewEnum> _fromValueMap = _toValueMap.map(
    (key, value) => MapEntry(value, key),
  );

  static String? _translateTitle(
      SurveyPreviewEnum mode, ABSurveyLocalization localization) {
    return {
      SurveyPreviewEnum.welcome:
          localization.introductionSurveyEnumWelcomeTitle,
      SurveyPreviewEnum.info: localization.introductionSurveyEnumInfoTitle,
    }[mode];
  }

  static String? _translateContent(
      SurveyPreviewEnum mode, ABSurveyLocalization localization) {
    return {
      SurveyPreviewEnum.welcome:
          localization.introductionSurveyEnumWelcomeContent,
      SurveyPreviewEnum.info: localization.introductionSurveyEnumInfoContent,
    }[mode];
  }

  String toValue() => _toValueMap[this]!;

  static SurveyPreviewEnum? fromValue(String? value) => _fromValueMap[value];

  String getTranslateTitle(ABSurveyLocalization localization) =>
      _translateTitle(this, localization) ?? 'No translate';

  String getTranslateContent(ABSurveyLocalization localization) =>
      _translateContent(this, localization) ?? 'No translate';
}

enum SurveyQuestionEnum {
  gender,
  age_group,
  disability,
  frequency_public_transport,
  usage_public_transport,
  time_public_transport,
  safety_public_transport,
  experience_public_transport,
  satisfaction_security_measures,
  additional_security_measures,
  relation_to_disability,
  type_of_disability,
  disability_related_frequency,
  time_to_nearest_stop,
  ease_of_use_public_transport,
  desired_facilities,
  availability_of_information
}

extension SurveyQuestionEnumExtension on SurveyQuestionEnum {
  static final Map<SurveyQuestionEnum, String> _toValueMap = {
    SurveyQuestionEnum.gender: "00000000-0000-0000-0000-000000000001",
    SurveyQuestionEnum.age_group: "00000000-0000-0000-0000-000000000002",
    SurveyQuestionEnum.disability: "00000000-0000-0000-0000-000000000003",
    SurveyQuestionEnum.frequency_public_transport:
        "00000000-0000-0000-0000-000000000004",
    SurveyQuestionEnum.usage_public_transport:
        "00000000-0000-0000-0000-000000000005",
    SurveyQuestionEnum.time_public_transport:
        "00000000-0000-0000-0000-000000000006",
    SurveyQuestionEnum.safety_public_transport:
        "00000000-0000-0000-0000-000000000007",
    SurveyQuestionEnum.experience_public_transport:
        "00000000-0000-0000-0000-000000000008",
    SurveyQuestionEnum.satisfaction_security_measures:
        "00000000-0000-0000-0000-000000000009",
    SurveyQuestionEnum.additional_security_measures:
        "00000000-0000-0000-0000-000000000010",
    SurveyQuestionEnum.relation_to_disability:
        "00000000-0000-0000-0000-000000000011",
    SurveyQuestionEnum.type_of_disability:
        "00000000-0000-0000-0000-000000000012",
    SurveyQuestionEnum.disability_related_frequency:
        "00000000-0000-0000-0000-000000000013",
    SurveyQuestionEnum.time_to_nearest_stop:
        "00000000-0000-0000-0000-000000000014",
    SurveyQuestionEnum.ease_of_use_public_transport:
        "00000000-0000-0000-0000-000000000015",
    SurveyQuestionEnum.desired_facilities:
        "00000000-0000-0000-0000-000000000016",
    SurveyQuestionEnum.availability_of_information:
        "00000000-0000-0000-0000-000000000017",
  };

  static final Map<SurveyQuestionEnum, bool> _isMultiSelect = {
    SurveyQuestionEnum.gender: false,
    SurveyQuestionEnum.age_group: false,
    SurveyQuestionEnum.disability: false,
    SurveyQuestionEnum.frequency_public_transport: false,
    SurveyQuestionEnum.usage_public_transport: false,
    SurveyQuestionEnum.time_public_transport: true,
    SurveyQuestionEnum.safety_public_transport: false,
    SurveyQuestionEnum.experience_public_transport: true,
    SurveyQuestionEnum.satisfaction_security_measures: false,
    SurveyQuestionEnum.additional_security_measures: true,
    SurveyQuestionEnum.relation_to_disability: false,
    SurveyQuestionEnum.type_of_disability: true,
    SurveyQuestionEnum.disability_related_frequency: false,
    SurveyQuestionEnum.time_to_nearest_stop: false,
    SurveyQuestionEnum.ease_of_use_public_transport: false,
    SurveyQuestionEnum.desired_facilities: true,
    SurveyQuestionEnum.availability_of_information: false,
  };

  static final Map<String, SurveyQuestionEnum> _fromValueMap = _toValueMap.map(
    (key, value) => MapEntry(value, key),
  );

  static String? _translates(
    SurveyQuestionEnum mode,
    ABSurveyLocalization localization,
  ) {
    return {
      SurveyQuestionEnum.gender: localization.surveyQuestionEnumGender,
      SurveyQuestionEnum.age_group: localization.surveyQuestionEnumAgeGroup,
      SurveyQuestionEnum.disability: localization.surveyQuestionEnumDisability,
      SurveyQuestionEnum.frequency_public_transport:
          localization.surveyQuestionEnumFrequencyPublicTransport,
      SurveyQuestionEnum.usage_public_transport:
          localization.surveyQuestionEnumUsagePublicTransport,
      SurveyQuestionEnum.time_public_transport:
          localization.surveyQuestionEnumTimePublicTransport,
      SurveyQuestionEnum.safety_public_transport:
          localization.surveyQuestionEnumSafetyPublicTransport,
      SurveyQuestionEnum.experience_public_transport:
          localization.surveyQuestionEnumExperiencePublicTransport,
      SurveyQuestionEnum.satisfaction_security_measures:
          localization.surveyQuestionEnumSatisfactionSecurityMeasures,
      SurveyQuestionEnum.additional_security_measures:
          localization.surveyQuestionEnumAdditionalSecurityMeasures,
      SurveyQuestionEnum.relation_to_disability:
          localization.surveyQuestionEnumRelationToDisability,
      SurveyQuestionEnum.type_of_disability:
          localization.surveyQuestionEnumTypeOfDisability,
      SurveyQuestionEnum.disability_related_frequency:
          localization.surveyQuestionEnumDisabilityRelatedFrequency,
      SurveyQuestionEnum.time_to_nearest_stop:
          localization.surveyQuestionEnumTimeToNearestStop,
      SurveyQuestionEnum.ease_of_use_public_transport:
          localization.surveyQuestionEnumEaseOfUsePublicTransport,
      SurveyQuestionEnum.desired_facilities:
          localization.surveyQuestionEnumDesiredFacilities,
      SurveyQuestionEnum.availability_of_information:
          localization.surveyQuestionEnumAvailabilityOfInformation,
    }[mode];
  }

  static final Map<SurveyQuestionEnum, List<SurveyOptionEnum>> _options = {
    SurveyQuestionEnum.gender: [
      SurveyOptionEnum.gender_male,
      SurveyOptionEnum.gender_female,
      SurveyOptionEnum.gender_other
    ],
    SurveyQuestionEnum.age_group: [
      SurveyOptionEnum.age_under_18,
      SurveyOptionEnum.age_18_35,
      SurveyOptionEnum.age_36_50,
      SurveyOptionEnum.age_51_64,
      SurveyOptionEnum.age_65_plus
    ],
    SurveyQuestionEnum.disability: [
      SurveyOptionEnum.disability_yes,
      SurveyOptionEnum.disability_no
    ],
    SurveyQuestionEnum.frequency_public_transport: [
      SurveyOptionEnum.frequency_daily,
      SurveyOptionEnum.frequency_several_times_per_week,
      SurveyOptionEnum.frequency_once_per_week,
      SurveyOptionEnum.frequency_rarely
    ],
    SurveyQuestionEnum.usage_public_transport: [
      SurveyOptionEnum.usage_work,
      SurveyOptionEnum.usage_study,
      SurveyOptionEnum.usage_healthcare,
      SurveyOptionEnum.usage_leisure
    ],
    SurveyQuestionEnum.time_public_transport: [
      SurveyOptionEnum.time_morning,
      SurveyOptionEnum.time_midday,
      SurveyOptionEnum.time_afternoon,
      SurveyOptionEnum.time_night
    ],
    SurveyQuestionEnum.safety_public_transport: [
      SurveyOptionEnum.safety_always,
      SurveyOptionEnum.safety_most_of_the_time,
      SurveyOptionEnum.safety_sometimes,
      SurveyOptionEnum.safety_rarely,
      SurveyOptionEnum.safety_never
    ],
    SurveyQuestionEnum.experience_public_transport: [
      SurveyOptionEnum.experience_inappropriate_looks,
      SurveyOptionEnum.experience_offensive_comments,
      SurveyOptionEnum.experience_unwanted_physical_contact,
      SurveyOptionEnum.experience_being_followed,
      SurveyOptionEnum.experience_theft,
      SurveyOptionEnum.experience_none
    ],
    SurveyQuestionEnum.satisfaction_security_measures: [
      SurveyOptionEnum.satisfaction_very_satisfied,
      SurveyOptionEnum.satisfaction_satisfied,
      SurveyOptionEnum.satisfaction_neutral,
      SurveyOptionEnum.satisfaction_dissatisfied,
      SurveyOptionEnum.satisfaction_very_dissatisfied
    ],
    SurveyQuestionEnum.additional_security_measures: [
      SurveyOptionEnum.security_police_presence,
      SurveyOptionEnum.security_cctv,
      SurveyOptionEnum.security_women_only_zones,
      SurveyOptionEnum.security_better_lighting,
      SurveyOptionEnum.security_emergency_line
    ],
    SurveyQuestionEnum.relation_to_disability: [
      SurveyOptionEnum.relation_disability_person_with_disability,
      SurveyOptionEnum.relation_disability_caregiver,
      SurveyOptionEnum.relation_disability_none,
    ],
    SurveyQuestionEnum.type_of_disability: [
      SurveyOptionEnum.disability_type_motor,
      SurveyOptionEnum.disability_type_visual,
      SurveyOptionEnum.disability_type_auditory,
      SurveyOptionEnum.disability_type_cognitive,
      SurveyOptionEnum.disability_type_not_applicable
    ],
    SurveyQuestionEnum.disability_related_frequency: [
      SurveyOptionEnum.disability_frequency_daily,
      SurveyOptionEnum.disability_frequency_several_times_per_week,
      SurveyOptionEnum.disability_frequency_once_per_week,
      SurveyOptionEnum.disability_frequency_rarely
    ],
    SurveyQuestionEnum.time_to_nearest_stop: [
      SurveyOptionEnum.time_to_stop_less_than_5_minutes,
      SurveyOptionEnum.time_to_stop_5_10_minutes,
      SurveyOptionEnum.time_to_stop_10_20_minutes,
      SurveyOptionEnum.time_to_stop_more_than_20_minutes
    ],
    SurveyQuestionEnum.ease_of_use_public_transport: [
      SurveyOptionEnum.ease_of_use_very_easy,
      SurveyOptionEnum.ease_of_use_easy,
      SurveyOptionEnum.ease_of_use_neutral,
      SurveyOptionEnum.ease_of_use_difficult,
      SurveyOptionEnum.ease_of_use_very_difficult
    ],
    SurveyQuestionEnum.desired_facilities: [
      SurveyOptionEnum.facilities_ramps_or_elevators,
      SurveyOptionEnum.facilities_trained_staff,
      SurveyOptionEnum.facilities_wheelchair_space,
      SurveyOptionEnum.facilities_frequency_and_punctuality,
      SurveyOptionEnum.facilities_reserved_seats
    ],
    SurveyQuestionEnum.availability_of_information: [
      SurveyOptionEnum.information_very_good,
      SurveyOptionEnum.information_good,
      SurveyOptionEnum.information_neutral,
      SurveyOptionEnum.information_bad,
      SurveyOptionEnum.information_very_bad
    ]
  };

  String toValue() => _toValueMap[this]!;

  static SurveyQuestionEnum? fromValue(String? value) => _fromValueMap[value];

  String getTranslate(ABSurveyLocalization localization) =>
      _translates(this, localization) ?? 'No translate';

  List<SurveyOptionEnum> get options => _options[this] ?? [];

  bool get isMultiSelect => _isMultiSelect[this] ?? false;
}

// Step 1: Define the enum
enum SurveyOptionEnum {
  // Survey 1: Question 1 - "You are:"
  gender_male,
  gender_female,
  gender_other,

  // Survey 1: Question 2 - "What is your age group?"
  age_under_18,
  age_18_35,
  age_36_50,
  age_51_64,
  age_65_plus,

  // Survey 1: Question 3 - "Do you have a disability?"
  disability_yes,
  disability_no,

  // Survey 2: Question 1 - "How often do you use public transport?"
  frequency_daily,
  frequency_several_times_per_week,
  frequency_once_per_week,
  frequency_rarely,

  // Survey 2: Question 2 - "For what do you mostly use public transport?"
  usage_work,
  usage_study,
  usage_healthcare,
  usage_leisure,

  // Survey 2: Question 3 - "When do you mostly use public transport?"
  time_morning,
  time_midday,
  time_afternoon,
  time_night,

  // Survey 2: Question 4 - "Do you feel safe using public transport?"
  safety_always,
  safety_most_of_the_time,
  safety_sometimes,
  safety_rarely,
  safety_never,

  // Survey 2: Question 5 - "Have you experienced any of the following?"
  experience_inappropriate_looks,
  experience_offensive_comments,
  experience_unwanted_physical_contact,
  experience_being_followed,
  experience_theft,
  experience_none,

  // Survey 2: Question 6 - "How satisfied are you with current security measures?"
  satisfaction_very_satisfied,
  satisfaction_satisfied,
  satisfaction_neutral,
  satisfaction_dissatisfied,
  satisfaction_very_dissatisfied,

  // Survey 2: Question 7 - "What additional security measures would you like?"
  security_police_presence,
  security_cctv,
  security_women_only_zones,
  security_better_lighting,
  security_emergency_line,

  // Survey 3: Question 1 - "What is your relationship to disability?"
  relation_disability_none,
  relation_disability_person_with_disability,
  relation_disability_caregiver,

  // Survey 3: Question 2 - "What type of disability is present?"
  disability_type_motor,
  disability_type_visual,
  disability_type_auditory,
  disability_type_cognitive,
  disability_type_not_applicable,

  // Survey 3: Question 3 - "How often do you use public transport?"
  disability_frequency_daily,
  disability_frequency_several_times_per_week,
  disability_frequency_once_per_week,
  disability_frequency_rarely,

  // Survey 3: Question 4 - "How long does it take to reach the nearest stop?"
  time_to_stop_less_than_5_minutes,
  time_to_stop_5_10_minutes,
  time_to_stop_10_20_minutes,
  time_to_stop_more_than_20_minutes,

  // Survey 3: Question 5 - "How easy is it for you to use public transport?"
  ease_of_use_very_easy,
  ease_of_use_easy,
  ease_of_use_neutral,
  ease_of_use_difficult,
  ease_of_use_very_difficult,

  // Survey 3: Question 6 - "What facilities would you like to see in public transport?"
  facilities_ramps_or_elevators,
  facilities_trained_staff,
  facilities_wheelchair_space,
  facilities_frequency_and_punctuality,
  facilities_reserved_seats,

  // Survey 3: Question 7 - "Availability of information on public transport?"
  information_very_good,
  information_good,
  information_neutral,
  information_bad,
  information_very_bad,
}

extension SurveyOptionEnumExtension on SurveyOptionEnum {
  static final Map<SurveyOptionEnum, String> _toValueMap = {
    // Survey 1: Question 1 - "You are:"
    SurveyOptionEnum.gender_male: "00000000-0000-0000-0000-000000000001",
    SurveyOptionEnum.gender_female: "00000000-0000-0000-0000-000000000002",
    SurveyOptionEnum.gender_other: "00000000-0000-0000-0000-000000000003",

    // Survey 1: Question 2 - "What is your age group?"
    SurveyOptionEnum.age_under_18: "00000000-0000-0000-0000-000000000004",
    SurveyOptionEnum.age_18_35: "00000000-0000-0000-0000-000000000005",
    SurveyOptionEnum.age_36_50: "00000000-0000-0000-0000-000000000006",
    SurveyOptionEnum.age_51_64: "00000000-0000-0000-0000-000000000007",
    SurveyOptionEnum.age_65_plus: "00000000-0000-0000-0000-000000000008",

    // Survey 1: Question 3 - "Do you have a disability?"
    SurveyOptionEnum.disability_yes: "00000000-0000-0000-0000-000000000009",
    SurveyOptionEnum.disability_no: "00000000-0000-0000-0000-000000000010",

    // Survey 2: Question 1 - "How often do you use public transport?"
    SurveyOptionEnum.frequency_daily: "00000000-0000-0000-0000-000000000011",
    SurveyOptionEnum.frequency_several_times_per_week:
        "00000000-0000-0000-0000-000000000012",
    SurveyOptionEnum.frequency_once_per_week:
        "00000000-0000-0000-0000-000000000013",
    SurveyOptionEnum.frequency_rarely: "00000000-0000-0000-0000-000000000014",

    // Survey 2: Question 2 - "For what do you mostly use public transport?"
    SurveyOptionEnum.usage_work: "00000000-0000-0000-0000-000000000015",
    SurveyOptionEnum.usage_study: "00000000-0000-0000-0000-000000000016",
    SurveyOptionEnum.usage_healthcare: "00000000-0000-0000-0000-000000000017",
    SurveyOptionEnum.usage_leisure: "00000000-0000-0000-0000-000000000018",

    // Survey 2: Question 3 - "When do you mostly use public transport?"
    SurveyOptionEnum.time_morning: "00000000-0000-0000-0000-000000000019",
    SurveyOptionEnum.time_midday: "00000000-0000-0000-0000-000000000020",
    SurveyOptionEnum.time_afternoon: "00000000-0000-0000-0000-000000000021",
    SurveyOptionEnum.time_night: "00000000-0000-0000-0000-000000000022",

    // Survey 2: Question 4 - "Do you feel safe using public transport?"
    SurveyOptionEnum.safety_always: "00000000-0000-0000-0000-000000000023",
    SurveyOptionEnum.safety_most_of_the_time:
        "00000000-0000-0000-0000-000000000024",
    SurveyOptionEnum.safety_sometimes: "00000000-0000-0000-0000-000000000025",
    SurveyOptionEnum.safety_rarely: "00000000-0000-0000-0000-000000000026",
    SurveyOptionEnum.safety_never: "00000000-0000-0000-0000-000000000027",

    // Survey 2: Question 5 - "Have you experienced any of the following?"
    SurveyOptionEnum.experience_inappropriate_looks:
        "00000000-0000-0000-0000-000000000028",
    SurveyOptionEnum.experience_offensive_comments:
        "00000000-0000-0000-0000-000000000029",
    SurveyOptionEnum.experience_unwanted_physical_contact:
        "00000000-0000-0000-0000-000000000030",
    SurveyOptionEnum.experience_being_followed:
        "00000000-0000-0000-0000-000000000031",
    SurveyOptionEnum.experience_theft: "00000000-0000-0000-0000-000000000032",
    SurveyOptionEnum.experience_none: "00000000-0000-0000-0000-000000000033",

    // Survey 2: Question 6 - "How satisfied are you with current security measures?"
    SurveyOptionEnum.satisfaction_very_satisfied:
        "00000000-0000-0000-0000-000000000034",
    SurveyOptionEnum.satisfaction_satisfied:
        "00000000-0000-0000-0000-000000000035",
    SurveyOptionEnum.satisfaction_neutral:
        "00000000-0000-0000-0000-000000000036",
    SurveyOptionEnum.satisfaction_dissatisfied:
        "00000000-0000-0000-0000-000000000037",
    SurveyOptionEnum.satisfaction_very_dissatisfied:
        "00000000-0000-0000-0000-000000000038",

    // Survey 2: Question 7 - "What additional security measures would you like?"
    SurveyOptionEnum.security_police_presence:
        "00000000-0000-0000-0000-000000000039",
    SurveyOptionEnum.security_cctv: "00000000-0000-0000-0000-000000000040",
    SurveyOptionEnum.security_women_only_zones:
        "00000000-0000-0000-0000-000000000041",
    SurveyOptionEnum.security_better_lighting:
        "00000000-0000-0000-0000-000000000042",
    SurveyOptionEnum.security_emergency_line:
        "00000000-0000-0000-0000-000000000043",

    // Survey 3: Question 1 - "What is your relationship to disability?"
    SurveyOptionEnum.relation_disability_none:
        "00000000-0000-0000-0000-000000000044",
    SurveyOptionEnum.relation_disability_person_with_disability:
        "00000000-0000-0000-0000-000000000045",
    SurveyOptionEnum.relation_disability_caregiver:
        "00000000-0000-0000-0000-000000000056",

    // Survey 3: Question 2 - "What type of disability is present?"
    SurveyOptionEnum.disability_type_motor:
        "00000000-0000-0000-0000-000000000047",
    SurveyOptionEnum.disability_type_visual:
        "00000000-0000-0000-0000-000000000048",
    SurveyOptionEnum.disability_type_auditory:
        "00000000-0000-0000-0000-000000000049",
    SurveyOptionEnum.disability_type_cognitive:
        "00000000-0000-0000-0000-000000000050",
    SurveyOptionEnum.disability_type_not_applicable:
        "00000000-0000-0000-0000-000000000051",

    // Survey 3: Question 3 - "How often do you experience disability-related events?"
    SurveyOptionEnum.disability_frequency_daily:
        "00000000-0000-0000-0000-000000000052",
    SurveyOptionEnum.disability_frequency_several_times_per_week:
        "00000000-0000-0000-0000-000000000053",
    SurveyOptionEnum.disability_frequency_once_per_week:
        "00000000-0000-0000-0000-000000000054",
    SurveyOptionEnum.disability_frequency_rarely:
        "00000000-0000-0000-0000-000000000055",

    // Survey 3: Question 4 - "How long does it take to reach the nearest stop?"
    SurveyOptionEnum.time_to_stop_less_than_5_minutes:
        "00000000-0000-0000-0000-000000000056",
    SurveyOptionEnum.time_to_stop_5_10_minutes:
        "00000000-0000-0000-0000-000000000057",
    SurveyOptionEnum.time_to_stop_10_20_minutes:
        "00000000-0000-0000-0000-000000000058",
    SurveyOptionEnum.time_to_stop_more_than_20_minutes:
        "00000000-0000-0000-0000-000000000059",

    // Survey 3: Question 5 - "How easy is it for you to use public transport?"
    SurveyOptionEnum.ease_of_use_very_easy:
        "00000000-0000-0000-0000-000000000060",
    SurveyOptionEnum.ease_of_use_easy: "00000000-0000-0000-0000-000000000061",
    SurveyOptionEnum.ease_of_use_neutral:
        "00000000-0000-0000-0000-000000000062",
    SurveyOptionEnum.ease_of_use_difficult:
        "00000000-0000-0000-0000-000000000063",
    SurveyOptionEnum.ease_of_use_very_difficult:
        "00000000-0000-0000-0000-000000000064",

    // Survey 3: Question 6 - "What facilities would you like to see in public transport?"
    SurveyOptionEnum.facilities_ramps_or_elevators:
        "00000000-0000-0000-0000-000000000065",
    SurveyOptionEnum.facilities_trained_staff:
        "00000000-0000-0000-0000-000000000066",
    SurveyOptionEnum.facilities_wheelchair_space:
        "00000000-0000-0000-0000-000000000067",
    SurveyOptionEnum.facilities_frequency_and_punctuality:
        "00000000-0000-0000-0000-000000000068",
    SurveyOptionEnum.facilities_reserved_seats:
        "00000000-0000-0000-0000-000000000069",

    // Survey 3: Question 7 - "Availability of information on public transport?"
    SurveyOptionEnum.information_very_good:
        "00000000-0000-0000-0000-000000000070",
    SurveyOptionEnum.information_good: "00000000-0000-0000-0000-000000000071",
    SurveyOptionEnum.information_neutral:
        "00000000-0000-0000-0000-000000000072",
    SurveyOptionEnum.information_bad: "00000000-0000-0000-0000-000000000073",
    SurveyOptionEnum.information_very_bad:
        "00000000-0000-0000-0000-000000000074"
  };

  static String? _translates(
      SurveyOptionEnum mode, ABSurveyLocalization localization) {
    return {
      // Survey 1: Question 1 - "You are:"
      SurveyOptionEnum.gender_male: localization.surveyOptionEnumGenderMale,
      SurveyOptionEnum.gender_female: localization.surveyOptionEnumGenderFemale,
      SurveyOptionEnum.gender_other: localization.surveyOptionEnumGenderOther,

      // Survey 1: Question 2 - "What is your age group?"
      SurveyOptionEnum.age_under_18: localization.surveyOptionEnumAgeUnder18,
      SurveyOptionEnum.age_18_35: localization.surveyOptionEnumAge18_35,
      SurveyOptionEnum.age_36_50: localization.surveyOptionEnumAge36_50,
      SurveyOptionEnum.age_51_64: localization.surveyOptionEnumAge51_64,
      SurveyOptionEnum.age_65_plus: localization.surveyOptionEnumAge65Plus,

      // Survey 1: Question 3 - "Do you have a disability?"
      SurveyOptionEnum.disability_yes:
          localization.surveyOptionEnumDisabilityYes,
      SurveyOptionEnum.disability_no: localization.surveyOptionEnumDisabilityNo,

      // Survey 2: Question 1 - "How often do you use public transport?"
      SurveyOptionEnum.frequency_daily:
          localization.surveyOptionEnumFrequencyDaily,
      SurveyOptionEnum.frequency_several_times_per_week:
          localization.surveyOptionEnumFrequencySeveralTimesPerWeek,
      SurveyOptionEnum.frequency_once_per_week:
          localization.surveyOptionEnumFrequencyOncePerWeek,
      SurveyOptionEnum.frequency_rarely:
          localization.surveyOptionEnumFrequencyRarely,

      // Survey 2: Question 2 - "For what do you mostly use public transport?"
      SurveyOptionEnum.usage_work: localization.surveyOptionEnumUsageWork,
      SurveyOptionEnum.usage_study: localization.surveyOptionEnumUsageStudy,
      SurveyOptionEnum.usage_healthcare:
          localization.surveyOptionEnumUsageHealthcare,
      SurveyOptionEnum.usage_leisure: localization.surveyOptionEnumUsageLeisure,

      // Survey 2: Question 3 - "When do you mostly use public transport?"
      SurveyOptionEnum.time_morning: localization.surveyOptionEnumTimeMorning,
      SurveyOptionEnum.time_midday: localization.surveyOptionEnumTimeMidday,
      SurveyOptionEnum.time_afternoon:
          localization.surveyOptionEnumTimeAfternoon,
      SurveyOptionEnum.time_night: localization.surveyOptionEnumTimeNight,

      // Survey 2: Question 4 - "Do you feel safe using public transport?"
      SurveyOptionEnum.safety_always: localization.surveyOptionEnumSafetyAlways,
      SurveyOptionEnum.safety_most_of_the_time:
          localization.surveyOptionEnumSafetyMostOfTheTime,
      SurveyOptionEnum.safety_sometimes:
          localization.surveyOptionEnumSafetySometimes,
      SurveyOptionEnum.safety_rarely: localization.surveyOptionEnumSafetyRarely,
      SurveyOptionEnum.safety_never: localization.surveyOptionEnumSafetyNever,

      // Survey 2: Question 5 - "Have you experienced any of the following?"
      SurveyOptionEnum.experience_inappropriate_looks:
          localization.surveyOptionEnumExperienceInappropriateLooks,
      SurveyOptionEnum.experience_offensive_comments:
          localization.surveyOptionEnumExperienceOffensiveComments,
      SurveyOptionEnum.experience_unwanted_physical_contact:
          localization.surveyOptionEnumExperienceUnwantedPhysicalContact,
      SurveyOptionEnum.experience_being_followed:
          localization.surveyOptionEnumExperienceBeingFollowed,
      SurveyOptionEnum.experience_theft:
          localization.surveyOptionEnumExperienceTheft,
      SurveyOptionEnum.experience_none:
          localization.surveyOptionEnumExperienceNone,

      // Survey 2: Question 6 - "How satisfied are you with current security measures?"
      SurveyOptionEnum.satisfaction_very_satisfied:
          localization.surveyOptionEnumSatisfactionVerySatisfied,
      SurveyOptionEnum.satisfaction_satisfied:
          localization.surveyOptionEnumSatisfactionSatisfied,
      SurveyOptionEnum.satisfaction_neutral:
          localization.surveyOptionEnumSatisfactionNeutral,
      SurveyOptionEnum.satisfaction_dissatisfied:
          localization.surveyOptionEnumSatisfactionDissatisfied,
      SurveyOptionEnum.satisfaction_very_dissatisfied:
          localization.surveyOptionEnumSatisfactionVeryDissatisfied,

      // Survey 2: Question 7 - "What additional security measures would you like?"
      SurveyOptionEnum.security_police_presence:
          localization.surveyOptionEnumSecurityPolicePresence,
      SurveyOptionEnum.security_cctv: localization.surveyOptionEnumSecurityCCTV,
      SurveyOptionEnum.security_women_only_zones:
          localization.surveyOptionEnumSecurityWomenOnlyZones,
      SurveyOptionEnum.security_better_lighting:
          localization.surveyOptionEnumSecurityBetterLighting,
      SurveyOptionEnum.security_emergency_line:
          localization.surveyOptionEnumSecurityEmergencyLine,

      // Survey 3: Question 1 - "What is your relationship to disability?"
      SurveyOptionEnum.relation_disability_none:
          localization.surveyOptionEnumRelationDisabilityNone,
      SurveyOptionEnum.relation_disability_person_with_disability:
          localization.surveyOptionEnumRelationDisabilityPersonWithDisability,
      SurveyOptionEnum.relation_disability_caregiver:
          localization.surveyOptionEnumRelationDisabilityCaregiver,

      // Survey 3: Question 2 - "What type of disability is present?"
      SurveyOptionEnum.disability_type_motor:
          localization.surveyOptionEnumDisabilityTypeMotor,
      SurveyOptionEnum.disability_type_visual:
          localization.surveyOptionEnumDisabilityTypeVisual,
      SurveyOptionEnum.disability_type_auditory:
          localization.surveyOptionEnumDisabilityTypeAuditory,
      SurveyOptionEnum.disability_type_cognitive:
          localization.surveyOptionEnumDisabilityTypeCognitive,
      SurveyOptionEnum.disability_type_not_applicable:
          localization.surveyOptionEnumDisabilityTypeNotApplicable,

      // Survey 3: Question 3 - "How often do you experience disability-related events?"
      SurveyOptionEnum.disability_frequency_daily:
          localization.surveyOptionEnumDisabilityFrequencyDaily,
      SurveyOptionEnum.disability_frequency_several_times_per_week:
          localization.surveyOptionEnumDisabilityFrequencySeveralTimesPerWeek,
      SurveyOptionEnum.disability_frequency_once_per_week:
          localization.surveyOptionEnumDisabilityFrequencyOncePerWeek,
      SurveyOptionEnum.disability_frequency_rarely:
          localization.surveyOptionEnumDisabilityFrequencyRarely,

      // Survey 3: Question 4 - "How long does it take to reach the nearest stop?"
      SurveyOptionEnum.time_to_stop_less_than_5_minutes:
          localization.surveyOptionEnumTimeToStopLessThan5Minutes,
      SurveyOptionEnum.time_to_stop_5_10_minutes:
          localization.surveyOptionEnumTimeToStop5_10Minutes,
      SurveyOptionEnum.time_to_stop_10_20_minutes:
          localization.surveyOptionEnumTimeToStop10_20Minutes,
      SurveyOptionEnum.time_to_stop_more_than_20_minutes:
          localization.surveyOptionEnumTimeToStopMoreThan20Minutes,

      // Survey 3: Question 5 - "How easy is it for you to use public transport?"
      SurveyOptionEnum.ease_of_use_very_easy:
          localization.surveyOptionEnumEaseOfUseVeryEasy,
      SurveyOptionEnum.ease_of_use_easy:
          localization.surveyOptionEnumEaseOfUseEasy,
      SurveyOptionEnum.ease_of_use_neutral:
          localization.surveyOptionEnumEaseOfUseNeutral,
      SurveyOptionEnum.ease_of_use_difficult:
          localization.surveyOptionEnumEaseOfUseDifficult,
      SurveyOptionEnum.ease_of_use_very_difficult:
          localization.surveyOptionEnumEaseOfUseVeryDifficult,

      // Survey 3: Question 6 - "What facilities would you like to see in public transport?"
      SurveyOptionEnum.facilities_ramps_or_elevators:
          localization.surveyOptionEnumFacilitiesRampsOrElevators,
      SurveyOptionEnum.facilities_trained_staff:
          localization.surveyOptionEnumFacilitiesTrainedStaff,
      SurveyOptionEnum.facilities_wheelchair_space:
          localization.surveyOptionEnumFacilitiesWheelchairSpace,
      SurveyOptionEnum.facilities_frequency_and_punctuality:
          localization.surveyOptionEnumFacilitiesFrequencyAndPunctuality,
      SurveyOptionEnum.facilities_reserved_seats:
          localization.surveyOptionEnumFacilitiesReservedSeats,

      // Survey 3: Question 7 - "Availability of information on public transport?"
      SurveyOptionEnum.information_very_good:
          localization.surveyOptionEnumInformationVeryGood,
      SurveyOptionEnum.information_good:
          localization.surveyOptionEnumInformationGood,
      SurveyOptionEnum.information_neutral:
          localization.surveyOptionEnumInformationNeutral,
      SurveyOptionEnum.information_bad:
          localization.surveyOptionEnumInformationBad,
      SurveyOptionEnum.information_very_bad:
          localization.surveyOptionEnumInformationVeryBad,
    }[mode];
  }

  static const _icons = <SurveyOptionEnum, IconData?>{
    // Survey 1: Question 1 - "You are:"
    SurveyOptionEnum.gender_male: Icons.male,
    SurveyOptionEnum.gender_female: Icons.female,
    SurveyOptionEnum.gender_other: Icons.transgender,

    // Survey 1: Question 2 - "What is your age group?"
    SurveyOptionEnum.age_under_18: Icons.child_care,
    SurveyOptionEnum.age_18_35: Icons.person,
    SurveyOptionEnum.age_36_50: Icons.person_outline,
    SurveyOptionEnum.age_51_64: Icons.person_add_alt_1,
    SurveyOptionEnum.age_65_plus: Icons.elderly,

    // Survey 1: Question 3 - "Do you have a disability?"
    SurveyOptionEnum.disability_yes: Icons.accessible,
    SurveyOptionEnum.disability_no: Icons.accessibility,

    // Survey 2: Question 1 - "How often do you use public transport?"
    SurveyOptionEnum.frequency_daily: Icons.calendar_today,
    SurveyOptionEnum.frequency_several_times_per_week: Icons.date_range,
    SurveyOptionEnum.frequency_once_per_week: Icons.event,
    SurveyOptionEnum.frequency_rarely: Icons.schedule,

    // Survey 2: Question 2 - "For what do you mostly use public transport?"
    SurveyOptionEnum.usage_work: Icons.work,
    SurveyOptionEnum.usage_study: Icons.school,
    SurveyOptionEnum.usage_healthcare: Icons.local_hospital,
    SurveyOptionEnum.usage_leisure: Icons.local_movies,

    // Survey 2: Question 3 - "When do you mostly use public transport?"
    SurveyOptionEnum.time_morning: Icons.wb_sunny,
    SurveyOptionEnum.time_midday: Icons.wb_cloudy,
    SurveyOptionEnum.time_afternoon: Icons.sunny,
    SurveyOptionEnum.time_night: Icons.nights_stay,

    // Survey 2: Question 4 - "Do you feel safe using public transport?"
    SurveyOptionEnum.safety_always: Icons.security,
    SurveyOptionEnum.safety_most_of_the_time: Icons.shield,
    SurveyOptionEnum.safety_sometimes: Icons.shield_moon,
    SurveyOptionEnum.safety_rarely: Icons.shield_outlined,
    SurveyOptionEnum.safety_never: Icons.warning,

    // Survey 2: Question 5 - "Have you experienced any of the following?"
    SurveyOptionEnum.experience_inappropriate_looks: Icons.visibility,
    SurveyOptionEnum.experience_offensive_comments: Icons.record_voice_over,
    SurveyOptionEnum.experience_unwanted_physical_contact: Icons.touch_app,
    SurveyOptionEnum.experience_being_followed: Icons.directions_walk,
    SurveyOptionEnum.experience_theft: Icons.report,
    SurveyOptionEnum.experience_none: Icons.check_circle_outline,

    // Survey 2: Question 6 - "How satisfied are you with current security measures?"
    SurveyOptionEnum.satisfaction_very_satisfied:
        Icons.sentiment_very_satisfied,
    SurveyOptionEnum.satisfaction_satisfied: Icons.sentiment_satisfied,
    SurveyOptionEnum.satisfaction_neutral: Icons.sentiment_neutral,
    SurveyOptionEnum.satisfaction_dissatisfied: Icons.sentiment_dissatisfied,
    SurveyOptionEnum.satisfaction_very_dissatisfied:
        Icons.sentiment_very_dissatisfied,

    // Survey 2: Question 7 - "What additional security measures would you like?"
    SurveyOptionEnum.security_police_presence: Icons.local_police,
    SurveyOptionEnum.security_cctv: Icons.videocam,
    SurveyOptionEnum.security_women_only_zones: Icons.female,
    SurveyOptionEnum.security_better_lighting: Icons.lightbulb,
    SurveyOptionEnum.security_emergency_line: Icons.phone_in_talk,

    // Survey 3: Question 1 - "What is your relationship to disability?"
    SurveyOptionEnum.relation_disability_none: Icons.person_off,
    SurveyOptionEnum.relation_disability_person_with_disability:
        Icons.accessible,
    SurveyOptionEnum.relation_disability_caregiver: Icons.volunteer_activism,

    // Survey 3: Question 2 - "What type of disability is present?"
    SurveyOptionEnum.disability_type_motor: Icons.accessible,
    SurveyOptionEnum.disability_type_visual: Icons.remove_red_eye,
    SurveyOptionEnum.disability_type_auditory: Icons.hearing,
    SurveyOptionEnum.disability_type_cognitive: Icons.psychology,
    SurveyOptionEnum.disability_type_not_applicable: Icons.not_interested,

    // Survey 3: Question 3 - "How often do you experience disability-related events?"
    SurveyOptionEnum.disability_frequency_daily: Icons.calendar_today,
    SurveyOptionEnum.disability_frequency_several_times_per_week:
        Icons.date_range,
    SurveyOptionEnum.disability_frequency_once_per_week: Icons.event,
    SurveyOptionEnum.disability_frequency_rarely: Icons.schedule,

    // Survey 3: Question 4 - "How long does it take to reach the nearest stop?"
    SurveyOptionEnum.time_to_stop_less_than_5_minutes: Icons.timer_3,
    SurveyOptionEnum.time_to_stop_5_10_minutes: Icons.schedule,
    SurveyOptionEnum.time_to_stop_10_20_minutes: Icons.schedule,
    SurveyOptionEnum.time_to_stop_more_than_20_minutes: Icons.timer_off,

    // Survey 3: Question 5 - "How easy is it for you to use public transport?"
    SurveyOptionEnum.ease_of_use_very_easy: Icons.thumb_up,
    SurveyOptionEnum.ease_of_use_easy: Icons.thumbs_up_down,
    SurveyOptionEnum.ease_of_use_neutral: Icons.thumbs_up_down,
    SurveyOptionEnum.ease_of_use_difficult: Icons.thumb_down,
    SurveyOptionEnum.ease_of_use_very_difficult: Icons.thumb_down_off_alt,

    // Survey 3: Question 6 - "What facilities would you like to see in public transport?"
    SurveyOptionEnum.facilities_ramps_or_elevators: Icons.elevator,
    SurveyOptionEnum.facilities_trained_staff: Icons.support,
    SurveyOptionEnum.facilities_wheelchair_space: Icons.wheelchair_pickup,
    SurveyOptionEnum.facilities_frequency_and_punctuality:
        Icons.departure_board,
    SurveyOptionEnum.facilities_reserved_seats: Icons.event_seat,

    // Survey 3: Question 7 - "Availability of information on public transport?"
    SurveyOptionEnum.information_very_good: Icons.info,
    SurveyOptionEnum.information_good: Icons.info_outline,
    SurveyOptionEnum.information_neutral: Icons.help_outline,
    SurveyOptionEnum.information_bad: Icons.error_outline,
    SurveyOptionEnum.information_very_bad: Icons.report_problem
  };

  static final Map<String, SurveyOptionEnum> _fromValueMap =
      _toValueMap.map((key, value) => MapEntry(value, key));

  static SurveyOptionEnum? fromValue(String? value) => _fromValueMap[value];

  String toValue() => _toValueMap[this]!;

  String getTranslate(ABSurveyLocalization localization) =>
      _translates(this, localization) ?? 'No translate';

  IconData get icon => _icons[this] ?? Icons.error;
}
