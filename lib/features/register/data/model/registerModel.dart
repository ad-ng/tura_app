// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'dart:convert';

class Registermodel {
  String username;
  String email;
  String fullname;
  String gender;
  String dob;
  String phoneNumber;
  String password;

  Registermodel({
    required this.username,
    required this.fullname,
    required this.email,
    required this.phoneNumber,
    required this.dob,
    required this.gender,
    required this.password,
  });

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'username': username,
      'email': email,
      'fullname': fullname,
      'gender': gender,
      'dob': dob,
      'phoneNumber': phoneNumber,
      'password': password,
    };
  }

  factory Registermodel.fromMap(Map<String, dynamic> map) {
    return Registermodel(
      username: map['username'] as String,
      email: map['email'] as String,
      fullname: map['fullname'] as String,
      gender: map['gender'] as String,
      dob: map['dob'] as String,
      phoneNumber: map['phoneNumber'] as String,
      password: map['password'] as String,
    );
  }

  String toJson() => json.encode(toMap());

  factory Registermodel.fromJson(String source) =>
      Registermodel.fromMap(json.decode(source) as Map<String, dynamic>);
}
