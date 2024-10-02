import 'package:arequipa_bus/pages/survey/repository/survey_hive_local_repository.dart';
import 'package:arequipa_bus/pages/survey/services/survey_service.dart';
import 'package:arequipa_bus/pages/survey/survey_cubit/models/survey_enums.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:equatable/equatable.dart';

part 'survey_state.dart';

class SurveyCubit extends Cubit<SurveyState> {
  final _localRepository = SurveyHiveLocalRepository();

  final SurveyService _requestManager;

  SurveyCubit({
    required String surveyUpdate,
  })  : _requestManager = SurveyService(surveyUpdate: surveyUpdate),
        super(const SurveyState(selectedOptions: [])) {
    _load();
  }

  Future<void> _load() async {
    await _localRepository.loadRepository();
    final surveyLoaded = await _localRepository.getSurvey();
    if (surveyLoaded != null) {
      syncDataWithServer(surveyLoaded);
    }
    emit((surveyLoaded ??
        const SurveyState(
          selectedOptions: [],
        )));
  }

  Future<void> syncDataWithServer(SurveyState surveyState) async {
    surveyState;
    
  }

  Future<void> finishPreview() async {
    final newState = state.copyWith(
      isPresentation: false,
      currentQuestion: SurveyQuestionEnum.gender,
    );
    await _localRepository.saveSurvey(newState.toJson());
    emit(newState);
  }

  Future<void> backSurvey({
    required SurveyQuestionEnum surveyQuestion,
  }) async {
    final newState = state.copyWith(
      currentQuestion: surveyQuestion,
    );
    emit(newState);
  }

  Future<void> updateSurvey({
    required SurveyQuestionEnum surveyQuestion,
    required SurveyQuestionEnum? nextSurveyQuestion,
    required List<SurveyOptionEnum> surveyOptions,
  }) async {
    var tempSelectedOptions = [...state.selectedOptions];

    tempSelectedOptions = tempSelectedOptions
        .where((e) => !surveyQuestion.options.contains(e))
        .toList();

    final newState = state.copyWith(
      currentQuestion: nextSurveyQuestion ?? surveyQuestion,
      selectedOptions: [...tempSelectedOptions, ...surveyOptions],
    );
    await _localRepository.saveSurvey(newState.toJson());
    emit(newState);
    _requestManager.updateSurvey(
      questionId: surveyQuestion.toValue(),
      options: surveyOptions.map((e) => e.toValue()).toList(),
    );
  }
}
