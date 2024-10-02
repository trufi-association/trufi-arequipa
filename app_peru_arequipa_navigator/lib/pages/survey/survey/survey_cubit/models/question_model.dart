import 'package:arequipa_bus/pages/survey/survey/survey_cubit/models/option_model.dart';
import 'package:equatable/equatable.dart';

class QuestionModel extends Equatable {
  final String id;
  final String surveyId;
  final String text;
  final int order;
  final List<OptionModel> options;

  const QuestionModel({
    required this.id,
    required this.surveyId,
    required this.text,
    required this.order,
    required this.options,
  });

  @override
  List<Object?> get props => [id, surveyId, text, order, options];

  QuestionModel copyWith({
    String? id,
    String? surveyId,
    String? text,
    int? order,
    List<OptionModel>? options,
  }) {
    return QuestionModel(
      id: id ?? this.id,
      surveyId: surveyId ?? this.surveyId,
      text: text ?? this.text,
      order: order ?? this.order,
      options: options ?? this.options,
    );
  }

  factory QuestionModel.fromJson(Map<String, dynamic> json) {
    return QuestionModel(
      id: json['id'],
      surveyId: json['surveyId'],
      text: json['text'],
      order: json['order'],
      options: List<OptionModel>.from(
          json['options'].map((x) => OptionModel.fromJson(x))),
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'surveyId': surveyId,
      'text': text,
      'order': order,
      'options': List<dynamic>.from(options.map((x) => x.toJson())),
    };
  }
}
