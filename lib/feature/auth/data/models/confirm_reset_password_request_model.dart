class ConfirmResetPasswordRequest {
  ConfirmResetPasswordRequest({
      this.email, 
      this.otp, 
      this.newPassword, 
      this.confirmNewPassword,});


  String? email;
  String? otp;
  String? newPassword;
  String? confirmNewPassword;
ConfirmResetPasswordRequest copyWith({  String? email,
  String? otp,
  String? newPassword,
  String? confirmNewPassword,
}) => ConfirmResetPasswordRequest(  email: email ?? this.email,
  otp: otp ?? this.otp,
  newPassword: newPassword ?? this.newPassword,
  confirmNewPassword: confirmNewPassword ?? this.confirmNewPassword,
);
  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['email'] = email;
    map['otp'] = otp;
    map['new_password'] = newPassword;
    map['confirm_new_password'] = confirmNewPassword;
    return map;
  }

}