import 'package:arequipa_bus/pages/survey/repository/survey_hive_local_repository.dart';
import 'package:arequipa_bus/pages/survey/services/survey_service.dart';
import 'package:arequipa_bus/pages/survey/survey_cubit/models/survey_enums.dart';
import 'package:arequipa_bus/pages/survey/survey_cubit/models/survey_model.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:equatable/equatable.dart';

part 'survey_state.dart';

class SurveyCubit extends Cubit<SurveyState> {
  final _localRepository = SurveyHiveLocalRepository();
  final SurveyService _requestManager;

  SurveyCubit({
    required String surveyUpdate,
  })  : _requestManager = SurveyService(
          surveyUpdate: surveyUpdate,
        ),
        super(SurveyState.surveyStateDefault) {
    _load();
  }

  Future<void> _load() async {
    await _localRepository.loadRepository();
    final surveyLoaded = await _localRepository.getSurvey();
    emit((surveyLoaded ?? SurveyState.surveyStateDefault));
    if (surveyLoaded != null && surveyLoaded.surveyQuestions.isNotEmpty) {
      syncDataWithServer(surveyLoaded);
    }
  }

  Future<void> syncDataWithServer(SurveyState surveyStateLoaded) async {
    var tempSelectedOptions = [...surveyStateLoaded.surveyQuestions];
    for (var i = 0; i < tempSelectedOptions.length; i++) {
      final surveyQuestion = tempSelectedOptions[i];
      if (!surveyQuestion.isBackendSynced) {
        try {
          await _requestManager.updateSurvey(
            questionId: surveyQuestion.surveyQuestionEnum.toValue(),
            options:
                surveyQuestion.surveyAnswer.map((e) => e.toValue()).toList(),
          );
          tempSelectedOptions[i] = tempSelectedOptions[i].copyWith(
            isBackendSynced: true,
          );
          final newState = surveyStateLoaded.copyWith(surveyQuestions: tempSelectedOptions);
          _localRepository.saveSurvey(newState.toJson());
        } catch (e) {
          if (kDebugMode) {
            print(e);
          }
        }
      }
    }
    final newState = surveyStateLoaded.copyWith(surveyQuestions: tempSelectedOptions);
    _localRepository.saveSurvey(newState.toJson());
    emit(newState);
  }

  Future<void> finishPreview() async {
    final newState = state.copyWith(
      isPresentation: false,
    );
    await _localRepository.saveSurvey(newState.toJson());
    emit(newState);
  }

  Future<void> backSurvey({
    required SurveyQuestionEnum currentSurveyQuestion,
  }) async {
    final newState = state.copyWith(
      currentQuestion: currentSurveyQuestion,
    );
    emit(newState);
  }

  Future<void> updateSurvey({
    required SurveyQuestionEnum surveyQuestion,
    required SurveyQuestionEnum nextSurveyQuestion,
    required List<SurveyOptionEnum> surveyOptions,
  }) async {
    var tempSelectedOptions = [...state.surveyQuestions];
    final index = tempSelectedOptions
        .indexWhere((e) => e.surveyQuestionEnum == surveyQuestion);
    if (index == -1) {
      tempSelectedOptions.add(SurveyQuestionModel(
        surveyQuestionEnum: surveyQuestion,
        surveyAnswer: surveyOptions,
        isBackendSynced: false,
      ));
    } else {
      tempSelectedOptions[index] = tempSelectedOptions[index].copyWith(
        surveyAnswer: surveyOptions,
        isBackendSynced: false,
      );
    }
    final newState = state.copyWith(
      currentQuestion: nextSurveyQuestion,
      surveyQuestions: tempSelectedOptions,
    );
    _localRepository.saveSurvey(newState.toJson());

    emit(newState);
    try {
      await _requestManager.updateSurvey(
        questionId: surveyQuestion.toValue(),
        options: surveyOptions.map((e) => e.toValue()).toList(),
      );
      final index = tempSelectedOptions
          .indexWhere((e) => e.surveyQuestionEnum == surveyQuestion);
      tempSelectedOptions[index] = tempSelectedOptions[index].copyWith(
        isBackendSynced: true,
      );
      final newState = state.copyWith(
        surveyQuestions: tempSelectedOptions,
      );
      _localRepository.saveSurvey(newState.toJson());
      emit(newState);
    } catch (e) {
      if (kDebugMode) {
        print(e);
      }
    }
  }
}
