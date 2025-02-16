import 'dart:convert';

// ignore_for_file: public_member_api_docs, sort_constructors_first
class CreateShareModel {
  int propertyId;
  int recipientId;
  int? parentShareId;
  CreateShareModel({
    required this.propertyId,
    required this.recipientId,
    this.parentShareId,
  });

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'propertyId': propertyId,
      'recipientId': recipientId,
      'parentShareId': parentShareId,
    };
  }

  factory CreateShareModel.fromMap(Map<String, dynamic> map) {
    return CreateShareModel(
      propertyId: map['propertyId'] as int,
      recipientId: map['recipientId'] as int,
      parentShareId:
          map['parentShareId'] != null ? map['parentShareId'] as int : null,
    );
  }

  String toJson() => json.encode(toMap());

  factory CreateShareModel.fromJson(String source) =>
      CreateShareModel.fromMap(json.decode(source) as Map<String, dynamic>);
}
