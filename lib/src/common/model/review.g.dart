// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'review.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

Review _$ReviewFromJson(Map<String, dynamic> json) => Review(
      review: json['review'] as String?,
      value: (json['value'] as num?)?.toDouble(),
      naverBookInfo: json['naverBookInfo'] == null
          ? null
          : NaverBookInfo.fromJson(
              json['naverBookInfo'] as Map<String, dynamic>),
      likedUsers: (json['likedUsers'] as List<dynamic>?)
          ?.map((e) => e as String)
          .toList(),
      createdAt: json['createdAt'] == null
          ? null
          : DateTime.parse(json['createdAt'] as String),
      updatedAt: json['updatedAt'] == null
          ? null
          : DateTime.parse(json['updatedAt'] as String),
      bookId: json['bookId'] as String?,
      reviewerUid: json['reviewerUid'] as String?,
    );

Map<String, dynamic> _$ReviewToJson(Review instance) => <String, dynamic>{
      'bookId': instance.bookId,
      'review': instance.review,
      'reviewerUid': instance.reviewerUid,
      'likedUsers': instance.likedUsers,
      'value': instance.value,
      'naverBookInfo': instance.naverBookInfo?.toJson(),
      'createdAt': instance.createdAt?.toIso8601String(),
      'updatedAt': instance.updatedAt?.toIso8601String(),
    };
