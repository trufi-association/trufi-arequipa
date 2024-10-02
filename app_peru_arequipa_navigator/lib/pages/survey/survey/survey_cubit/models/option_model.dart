import 'package:equatable/equatable.dart';

class OptionModel extends Equatable {
  final String id;
  final String questionId;
  final String text;
  final int order;

  const OptionModel({
    required this.id,
    required this.questionId,
    required this.text,
    required this.order,
  });

  @override
  List<Object?> get props => [id, questionId, text, order];

  OptionModel copyWith({
    String? id,
    String? questionId,
    String? text,
    int? order,
  }) {
    return OptionModel(
      id: id ?? this.id,
      questionId: questionId ?? this.questionId,
      text: text ?? this.text,
      order: order ?? this.order,
    );
  }

  factory OptionModel.fromJson(Map<String, dynamic> json) {
    return OptionModel(
      id: json['id'],
      questionId: json['questionId'],
      text: json['text'],
      order: json['order'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'questionId': questionId,
      'text': text,
      'order': order,
    };
  }
}
