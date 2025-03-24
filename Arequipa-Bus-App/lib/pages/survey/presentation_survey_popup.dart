// import 'package:arequipa_bus/pages/survey/survey_cubit/survey_cubit.dart';
// import 'package:arequipa_bus/pages/survey/survey_cubit/models/survey_enums.dart';
// import 'package:arequipa_bus/pages/survey/survey_modal.dart';
// import 'package:arequipa_bus/pages/survey/translations/ab_survey_localizations.dart';
// import 'package:arequipa_bus/pages/survey/widgets/survey_base_modal.dart';
// import 'package:flutter/material.dart';
// import 'package:flutter_bloc/flutter_bloc.dart';

// class PresentationSurveyPopup extends StatefulWidget {
//   const PresentationSurveyPopup({super.key});

//   @override
//   State<PresentationSurveyPopup> createState() =>
//       _PresentationSurveyPopupState();
// }

// class _PresentationSurveyPopupState extends State<PresentationSurveyPopup> {
//   SurveyPreviewEnum previewEnum = SurveyPreviewEnum.welcome;

//   @override
//   Widget build(BuildContext context) {
//     final localizationABS = ABSurveyLocalization.of(context);
//     final surveyCubit = context.watch<SurveyCubit>();
//     return SurveyBaseModal(
//       title: previewEnum.getTranslateTitle(localizationABS),
//       content: Text(previewEnum.getTranslateContent(localizationABS)),
//       cancelText: "Cerrar",
//       acceptText: previewEnum != SurveyPreviewEnum.info
//           ? "Más información"
//           : "Siguiente",
//       expandAcceptButton: previewEnum != SurveyPreviewEnum.info ? false : true,
//       cancelOnPressed: () {
//         Navigator.of(context).pop();
//       },
//       acceptOnPressed: () async {
//         if (previewEnum != SurveyPreviewEnum.info) {
//           setState(() {
//             previewEnum = SurveyPreviewEnum.info;
//           });
//         } else {
//           await surveyCubit.finishPreview();
//           if (context.mounted) {
//             Navigator.of(context).pop();
//             SurveyModal.showAdvancedModal(context);
//           }
//         }
//       },
//     );
//   }
// }
