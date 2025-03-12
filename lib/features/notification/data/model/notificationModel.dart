import 'dart:convert';

// ignore_for_file: public_member_api_docs, sort_constructors_first
class NotificationModel {
  int id;
  String title;
  String message;
  String createdAt;
  NotificationModel({
    required this.id,
    required this.title,
    required this.message,
    required this.createdAt,
  });

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'id': id,
      'title': title,
      'message': message,
      'createdAt': createdAt,
    };
  }

  factory NotificationModel.fromMap(Map<String, dynamic> map) {
    return NotificationModel(
      id: map['id'] as int,
      title: map['title'] as String,
      message: map['message'] as String,
      createdAt: map['createdAt'] as String,
    );
  }

  String toJson() => json.encode(toMap());

  factory NotificationModel.fromJson(String source) =>
      NotificationModel.fromMap(json.decode(source) as Map<String, dynamic>);
}
