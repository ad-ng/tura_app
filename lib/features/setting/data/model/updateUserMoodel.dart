// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'dart:convert';

class UpdateUserModel {
  String fullname;
  String gender;
  String dob;
  String phoneNumber;
  String address;

  UpdateUserModel(
      {required this.fullname,
      required this.phoneNumber,
      required this.dob,
      required this.gender,
      required this.address});

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      //'username': username,
      // 'email': email,
      'fullname': fullname,
      'gender': gender,
      'dob': dob,
      'phoneNumber': phoneNumber,
      'address': address,
    };
  }

  factory UpdateUserModel.fromMap(Map<String, dynamic> map) {
    return UpdateUserModel(
        fullname: map['fullname'] as String,
        gender: map['gender'] as String,
        dob: map['dob'] as String,
        phoneNumber: map['phoneNumber'] as String,
        address: map['address'] as String);
  }

  String toJson() => json.encode(toMap());

  factory UpdateUserModel.fromJson(String source) =>
      UpdateUserModel.fromMap(json.decode(source) as Map<String, dynamic>);
}
