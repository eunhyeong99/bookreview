import 'package:bookreview/src/common/model/naver_book_info.dart';
import 'package:equatable/equatable.dart';
import 'package:json_annotation/json_annotation.dart';

part 'review.g.dart';

@JsonSerializable(
  explicitToJson: true,
)
class Review extends Equatable {
  final String? bookId;
  final String? review;
  final String? reviewerUid;
  final double? value;
  final NaverBookInfo? naverBookInfo;
  final DateTime? createdAt;
  final DateTime? updatedAt;

  const Review({
    this.review,
    this.value,
    this.naverBookInfo,
    this.createdAt,
    this.updatedAt,
    this.bookId,
    this.reviewerUid,
  });

  factory Review.fromJson(Map<String, dynamic> json) => _$ReviewFromJson(json);

  Map<String, dynamic> toJson() => _$ReviewToJson(this);

  Review copyWith({
    String? bookId,
    String? review,
    String? reviewerUid,
    double? value,
    NaverBookInfo? naverBookInfo,
    DateTime? createdAt,
    DateTime? updatedAt,
  }) {
    return Review(
      bookId: bookId ?? this.bookId,
      review: review ?? this.review,
      reviewerUid: reviewerUid ?? this.reviewerUid,
      value: value ?? this.value,
      naverBookInfo: naverBookInfo ?? this.naverBookInfo,
      createdAt: createdAt ?? this.createdAt,
      updatedAt: updatedAt ?? this.updatedAt,
    );
  }

  @override
  List<Object?> get props => [
        review,
        value,
        createdAt,
        naverBookInfo,
        updatedAt,
        bookId,
        reviewerUid,
      ];
}
