// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'dart:convert';

import 'package:tura_app/features/home/data/models/properties_model.dart';
import 'package:tura_app/features/login/data/models/user_model.dart';

class Sharemodel {
  int id;
  int propertyId;
  int? senderId;
  int? recipientId;
  int? parentShareId;
  DateTime createdAt;
  PropertiesModel property;
  UserModel? sender;
  UserModel? recipient;
  UserModel? parentShare;
  List<UserModel> children;

  Sharemodel({
    required this.id,
    required this.propertyId,
    this.senderId,
    this.recipientId,
    this.parentShareId,
    required this.createdAt,
    required this.property,
    this.sender,
    this.recipient,
    this.parentShare,
    required this.children,
  });

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'id': id,
      'propertyId': propertyId,
      'senderId': senderId,
      'recipientId': recipientId,
      'parentShareId': parentShareId,
      'createdAt': createdAt.millisecondsSinceEpoch,
      'property': property.toJson(), 
      'sender': sender?.toJson(), 
      'recipient': recipient?.toJson(), 
      'parentShare': parentShare?.toJson(), 
      'children': children.map((x) => x.toJson()).toList(), 
    };
  }

  factory Sharemodel.fromMap(Map<String, dynamic> map) {
    return Sharemodel(
      id: map['id'] as int,
      propertyId: map['propertyId'] as int,
      senderId: map['senderId'] != null ? map['senderId'] as int : null,
      recipientId:
          map['recipientId'] != null ? map['recipientId'] as int : null,
      parentShareId:
          map['parentShareId'] != null ? map['parentShareId'] as int : null,
      createdAt: DateTime.fromMillisecondsSinceEpoch(map['createdAt'] as int),
      property:
          PropertiesModel.fromJson(map['property'] as Map<String, dynamic>),
      sender: map['sender'] != null
          ? UserModel.fromJson(map['sender'] as Map<String, dynamic>)
          : null,
      recipient: map['recipient'] != null
          ? UserModel.fromJson(map['recipient'] as Map<String, dynamic>)
          : null,
      parentShare: map['parentShare'] != null
          ? UserModel.fromJson(map['parentShare'] as Map<String, dynamic>)
          : null,
      children: List<UserModel>.from(
        (map['children'] as List).map<UserModel>(
          (x) => UserModel.fromJson(x as Map<String, dynamic>),
        ),
      ),
    );
  }

  String toJson() => json.encode(toMap());

  factory Sharemodel.fromJson(String source) =>
      Sharemodel.fromMap(json.decode(source) as Map<String, dynamic>);
}
