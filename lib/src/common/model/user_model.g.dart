// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'user_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

UserModel _$UserModelFromJson(Map<String, dynamic> json) => UserModel(
      uid: json['uid'] as String?,
      name: json['name'] as String?,
      email: json['email'] as String?,
      profile: json['profile'] as String?,
      description: json['description'] as String?,
      followers: (json['followers'] as List<dynamic>?)
          ?.map((e) => e as String)
          .toList(),
      followingsCount: (json['followingsCount'] as num?)?.toInt(),
      followersCount: (json['followersCount'] as num?)?.toInt(),
      followings: (json['followings'] as List<dynamic>?)
          ?.map((e) => e as String)
          .toList(),
      reviewCount: (json['reviewCount'] as num?)?.toInt(),
    );

Map<String, dynamic> _$UserModelToJson(UserModel instance) => <String, dynamic>{
      'uid': instance.uid,
      'name': instance.name,
      'email': instance.email,
      'profile': instance.profile,
      'description': instance.description,
      'followers': instance.followers,
      'followersCount': instance.followersCount,
      'followingsCount': instance.followingsCount,
      'followings': instance.followings,
      'reviewCount': instance.reviewCount,
    };
