import 'dart:convert';

// ignore_for_file: public_member_api_docs, sort_constructors_first
class TokenModel {
  String token;

  TokenModel({
    required this.token,
  });

  factory TokenModel.fromMap(Map<String, dynamic> map) {
    return TokenModel(
      token: map['token'] as String,
    );
  }

  factory TokenModel.fromJson(String source) =>
      TokenModel.fromMap(json.decode(source) as Map<String, dynamic>);
}
