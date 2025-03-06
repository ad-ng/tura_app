class ChangePasswordModel {
  String oldPassword;
  String newPassword;

  ChangePasswordModel({
    required this.newPassword,
    required this.oldPassword,
  });

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'oldPassword': oldPassword,
      'newPassword': newPassword
    };
  }
}
