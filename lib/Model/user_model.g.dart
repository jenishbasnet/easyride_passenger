// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'user_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

UserModel _$UserModelFromJson(Map<String, dynamic> json) => UserModel(
      email: json['email'] as String?,
      password: json['password'] as String?,
      userID: json['userID'] as int?,
      username: json['username'] as String?,
      phoneNumber: json['phoneNumber'] as String?,
      profilePhoto: json['profilePhoto'] as String?,
    );

Map<String, dynamic> _$UserModelToJson(UserModel instance) => <String, dynamic>{
      'email': instance.email,
      'password': instance.password,
      'userID': instance.userID,
      'username': instance.username,
      'phoneNumber': instance.phoneNumber,
      'profilePhoto': instance.profilePhoto,
    };
