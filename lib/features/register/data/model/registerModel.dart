// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'dart:convert';

class RegisterModel {
  String username;
  String email;
  String fullname;
  String gender;
  String dob;
  String phoneNumber;
  String password;
  String role;
  bool isVerified;
  String profileImg;
  String coverImg;
  String address;

  RegisterModel(
      {required this.username,
      required this.fullname,
      required this.email,
      required this.phoneNumber,
      required this.dob,
      required this.gender,
      required this.password,
      required this.role,
      required this.isVerified,
      required this.profileImg,
      required this.coverImg,
      required this.address});

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'username': username,
      'email': email,
      'fullname': fullname,
      'gender': gender,
      'dob': dob,
      'phoneNumber': phoneNumber,
      'password': password,
      'role': role,
      'isVerified': isVerified,
      'profileImg': profileImg,
      'coverImg': coverImg,
      'address': address,
    };
  }

  factory RegisterModel.fromMap(Map<String, dynamic> map) {
    return RegisterModel(
        username: map['username'] as String,
        email: map['email'] as String,
        fullname: map['fullname'] as String,
        gender: map['gender'] as String,
        dob: map['dob'] as String,
        phoneNumber: map['phoneNumber'] as String,
        password: map['password'] as String,
        role: map['role'] as String,
        isVerified: map['isVerified'] as bool,
        profileImg: map['profileImg'] as String,
        coverImg: map['coverImg'] as String,
        address: map['address'] as String);
  }

  String toJson() => json.encode(toMap());

  factory RegisterModel.fromJson(String source) =>
      RegisterModel.fromMap(json.decode(source) as Map<String, dynamic>);
}
