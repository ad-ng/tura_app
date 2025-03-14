// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'dart:convert';

import 'package:tura_app/features/home/data/models/properties_model.dart';

class Favoritesmodel {
  int id;
  String createdAt;
  String updatedAt;
  int userId;
  int propertyId;
  PropertiesModel property;

  Favoritesmodel({
    required this.id,
    required this.createdAt,
    required this.updatedAt,
    required this.userId,
    required this.propertyId,
    required this.property,
  });

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'id': id,
      'createdAt': createdAt,
      'updatedAt': updatedAt,
      'userId': userId,
      'propertyId': propertyId,
      'property': property.toJson(),
    };
  }

  factory Favoritesmodel.fromMap(Map<String, dynamic> map) {
    return Favoritesmodel(
      id: map['id'] as int,
      createdAt: map['createdAt'] as String,
      updatedAt: map['updatedAt'] as String,
      userId: map['userId'] as int,
      propertyId: map['propertyId'] as int,
      property:
          PropertiesModel.fromJson(map['property'] as Map<String, dynamic>),
    );
  }

  String toJson() => json.encode(toMap());

  factory Favoritesmodel.fromJson(String source) =>
      Favoritesmodel.fromMap(json.decode(source) as Map<String, dynamic>);
}
