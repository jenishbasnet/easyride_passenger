import 'package:json_annotation/json_annotation.dart';

part 'availableride_model.g.dart';

@JsonSerializable()
class AvailableModel {
  String ? username;
  String ? email;
  String ? phoneNumber;
  String ? license;
  // String xyz;
  AvailableModel({this.username, this.email, this.phoneNumber, this.license});
  factory AvailableModel.fromJson(Map<String, dynamic> json) => _$AvailableModelFromJson(json);
  Map<String, dynamic> toJson() => _$AvailableModelToJson(this);
}