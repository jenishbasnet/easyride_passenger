// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'availableride_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

AvailableModel _$AvailableModelFromJson(Map<String, dynamic> json) =>
    AvailableModel(
      username: json['username'] as String?,
      email: json['email'] as String?,
      phoneNumber: json['phoneNumber'] as String?,
      license: json['license'] as String?,
    );

Map<String, dynamic> _$AvailableModelToJson(AvailableModel instance) =>
    <String, dynamic>{
      'username': instance.username,
      'email': instance.email,
      'phoneNumber': instance.phoneNumber,
      'license': instance.license,
    };
