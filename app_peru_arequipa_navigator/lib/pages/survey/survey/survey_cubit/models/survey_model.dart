import 'package:arequipa_bus/pages/survey/survey/survey_cubit/models/question_model.dart';
import 'package:equatable/equatable.dart';

class SurveyModel extends Equatable {
  final String id;
  final String title;
  final String description;
  final String introductionText;
  final String conclusionText;
  final List<QuestionModel> questions;

  const SurveyModel({
    required this.id,
    required this.title,
    required this.description,
    required this.introductionText,
    required this.conclusionText,
    required this.questions,
  });

  @override
  List<Object?> get props =>
      [id, title, description, introductionText, conclusionText, questions];

  SurveyModel copyWith({
    String? id,
    String? title,
    String? description,
    String? introductionText,
    String? conclusionText,
    List<QuestionModel>? questions,
  }) {
    return SurveyModel(
      id: id ?? this.id,
      title: title ?? this.title,
      description: description ?? this.description,
      introductionText: introductionText ?? this.introductionText,
      conclusionText: conclusionText ?? this.conclusionText,
      questions: questions ?? this.questions,
    );
  }

  factory SurveyModel.fromJson(Map<String, dynamic> json) {
    return SurveyModel(
      id: json['id'],
      title: json['title'],
      description: json['description'],
      introductionText: json['introductionText'],
      conclusionText: json['conclusionText'],
      questions: List<QuestionModel>.from(
          json['questions'].map((x) => QuestionModel.fromJson(x))),
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'title': title,
      'description': description,
      'introductionText': introductionText,
      'conclusionText': conclusionText,
      'questions': List<dynamic>.from(questions.map((x) => x.toJson())),
    };
  }
}
