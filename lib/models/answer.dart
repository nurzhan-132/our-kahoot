import '../repositories/repository.dart';

class Answer {
  final String id;
  String answerText;
  bool correctness;

  Answer({required this.id, this.answerText = '', this.correctness = false});

  Answer copy({
    String? id,
    String? answerText,
    bool? correctness,
  }) =>
      Answer(
        id: id ?? this.id,
        answerText: answerText ?? this.answerText,
        correctness: correctness ?? this.correctness,
      );

  static Answer fromJson(Map<String, dynamic> json) => Answer(
    id: json['id'],
    answerText: json['answerText'],
    correctness: json['correctness'],
  );

  Map<String, dynamic> toJson() => {
    'id': id,
    'answerText': answerText,
    'correctness': correctness,
  };
}
