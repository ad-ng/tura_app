class UserModel {
  int id;
  String fullname;
  String username;
  String email;
  String gender;
  String address;
  DateTime dob;
  String phoneNumber;
  String profileImg;
  String coverImg;
  String role;
  bool isVerified;
  DateTime createdAt;
  DateTime updatedAt;

  UserModel({
    required this.id,
    required this.fullname,
    required this.username,
    required this.email,
    required this.gender,
    required this.address,
    required this.dob,
    required this.phoneNumber,
    required this.profileImg,
    required this.coverImg,
    required this.role,
    required this.isVerified,
    required this.createdAt,
    required this.updatedAt,
  });

  // Convert JSON to User
  factory UserModel.fromJson(Map<String, dynamic> json) {
    return UserModel(
        id: json['id'],
        fullname: json['fullname'],
        username: json['username'],
        email: json['email'],
        gender: json['gender'],
        address: json['address'],
        dob: json['dob'],
        phoneNumber: json['phoneNumber'],
        profileImg: json['profileImg'],
        coverImg: json['coverImg'],
        role: json['role'],
        isVerified: json['isVerified'],
        createdAt: json['createdAt'],
        updatedAt: json['updatedAt']);
  }

  // Convert User to JSON (optional, if needed)
  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'fullname': fullname,
      'username': username,
      'email': email,
      'gender': gender,
      'address': address,
      'dob': dob,
      'phoneNumber': phoneNumber,
      'profileImg': profileImg,
      'coverImg': coverImg,
      'role': role,
      'isVerified': isVerified
    };
  }
}
