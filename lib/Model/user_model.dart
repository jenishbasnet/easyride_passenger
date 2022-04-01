import 'package:json_annotation/json_annotation.dart';

part 'user_model.g.dart';

@JsonSerializable()
class UserModel {
  String ? email;
  String ? password;
  int ? userID;
  String ? username;
  String ? phoneNumber;
  String ? profilePhoto;
  // String xyz;
  UserModel({this.email, this.password, this.userID, this.username, this.phoneNumber, this.profilePhoto});
  factory UserModel.fromJson(Map<String, dynamic> json) => _$UserModelFromJson(json);
  Map<String, dynamic> toJson() => _$UserModelToJson(this);
}