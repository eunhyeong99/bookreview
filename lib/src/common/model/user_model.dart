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
  final List<String>? followers;
  final int? followersCount;
  final int? followingsCount;
  final List<String>? followings;
  final int? reviewCount;

  const UserModel({
    this.uid,
    this.name,
    this.email,
    this.profile,
    this.description,
    this.followers,
    this.followingsCount,
    this.followersCount,
    this.followings,
    this.reviewCount,
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
    List<String>? followers,
    List<String>? followings,
    int? followersCount,
    int? followingsCount,
    int? reviewCount,
  }) {
    return UserModel(
      email: email ?? this.email,
      name: name ?? this.name,
      uid: uid ?? this.uid,
      profile: profile ?? this.profile,
      description: description ?? this.description,
      followers: followers ?? this.followers,
      followings: followings ?? this.followings,
      followersCount: followersCount ?? this.followersCount,
      followingsCount: followingsCount ?? this.followingsCount,
      reviewCount: reviewCount ?? this.reviewCount,
    );
  }

  @override
  List<Object?> get props => [
        uid,
        name,
        email,
        profile,
        description,
        followers,
        followings,
        followingsCount,
        followersCount,
        reviewCount,
      ];
}
