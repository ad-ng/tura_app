import 'dart:convert';

// ignore_for_file: public_member_api_docs, sort_constructors_first
class FaqModel {
  int id;
  String question;
  String answer;
  String subject;
  FaqModel({
    required this.id,
    required this.question,
    required this.answer,
    required this.subject,
  });

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'id': id,
      'question': question,
      'answer': answer,
      'subject': subject,
    };
  }

  factory FaqModel.fromMap(Map<String, dynamic> map) {
    return FaqModel(
      id: map['id'] as int,
      question: map['question'] as String,
      answer: map['answer'] as String,
      subject: map['subject'] as String,
    );
  }

  String toJson() => json.encode(toMap());

  factory FaqModel.fromJson(String source) => FaqModel.fromMap(json.decode(source) as Map<String, dynamic>);
}
