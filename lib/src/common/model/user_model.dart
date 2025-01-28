import 'package:equatable/equatable.dart';
import 'package:json_annotation/json_annotation.dart';

part 'user_model.g.dart';

@JsonSerializable()
class UserModel extends Equatable {
  final String? uid;
  final String? name;
  final String? email;
  final String? profile;
  final String? description;

  const UserModel({
    this.uid,
    this.name,
    this.email,
    this.profile,
    this.description,
  });

  factory UserModel.fromJson(Map<String, dynamic> json) =>
      _$UserModelFromJson(json);

  Map<String, dynamic> toMap() => _$UserModelToJson(this);

  copyWith({
    String? email,
    String? name,
    String? uid,
    String? profile,
    String? description,
  }) {
    return UserModel(
      email: email ?? this.email,
      name: name ?? this.name,
      uid: uid ?? this.uid,
      profile: profile ?? this.profile,
      description: description ?? this.description,
    );
  }

  @override
  List<Object?> get props => [
        uid,
        name,
        email,
        profile,
        description,
      ];
}
