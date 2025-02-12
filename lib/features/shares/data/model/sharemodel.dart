import 'package:tura_app/features/home/data/models/properties_model.dart';
import 'package:tura_app/features/login/data/models/user_model.dart';

class Sharemodel {
  final int id;
  final int propertyId;
  final int? senderId;
  final int? recipientId;
  final int? parentShareId;
  final DateTime createdAt;
  final PropertiesModel property;
  final UserModel? sender;
  final UserModel? recipient;
  final UserModel? parentShare;
  final List<UserModel> children;

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
    this.children = const [],
  });

  factory Sharemodel.fromJson(Map<String, dynamic> json) {
    return Sharemodel(
      id: json['id'] as int,
      propertyId: json['propertyId'] as int,
      senderId: json['senderId'] as int?,
      recipientId: json['recipientId'] as int?,
      parentShareId: json['parentShareId'] as int?,
      createdAt: DateTime.parse(json['createdAt'] as String),
      property:
          PropertiesModel.fromJson(json['property'] as Map<String, dynamic>),
      sender: json['sender'] != null
          ? UserModel.fromJson(json['sender'] as Map<String, dynamic>)
          : null,
      recipient: json['recipient'] != null
          ? UserModel.fromJson(json['recipient'] as Map<String, dynamic>)
          : null,
      parentShare: json['parentShare'] != null
          ? UserModel.fromJson(json['parentShare'] as Map<String, dynamic>)
          : null,
      children: List<UserModel>.from(
        (json['children'] as List).map((x) => UserModel.fromJson(x)),
      ),
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'propertyId': propertyId,
      'senderId': senderId,
      'recipientId': recipientId,
      'parentShareId': parentShareId,
      'createdAt': createdAt.toIso8601String(),
      'property': property.toJson(),
      'sender': sender?.toJson(),
      'recipient': recipient?.toJson(),
      'parentShare': parentShare?.toJson(),
      'children': children.map((x) => x.toJson()).toList(),
    };
  }
}
