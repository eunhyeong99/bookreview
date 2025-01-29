import 'package:bloc/bloc.dart';
import 'package:bookreview/src/common/enum/common_state_status.dart';
import 'package:bookreview/src/common/model/book_review_info.dart';
import 'package:bookreview/src/common/model/naver_book_info.dart';
import 'package:bookreview/src/common/model/review.dart';
import 'package:bookreview/src/common/repository/book_review_info_repository.dart';
import 'package:bookreview/src/common/repository/review_repository.dart';
import 'package:equatable/equatable.dart';

class ReviewCubit extends Cubit<ReviewState> {
  final BookReviewInfoRepository _bookReviewInfoRepository;
  final ReviewRepository _reviewRepository;

  ReviewCubit(
    this._bookReviewInfoRepository,
    this._reviewRepository,
    String uid,
    NaverBookInfo naverBookInfo,
  ) : super(
          ReviewState(
            reviewInfo: Review(
              bookId: naverBookInfo.isbn,
              reviewerUid: uid,
              naverBookInfo: naverBookInfo,
            ),
          ),
        ) {
    _loadReviewInfo();
  }

  _loadReviewInfo() async {
    var reviewInfo = await _reviewRepository.loadReviewInfo(
      state.reviewInfo!.bookId!,
      state.reviewInfo!.reviewerUid!,
    );

    emit(state.copyWith(
      isEditMode: reviewInfo != null,
      reviewInfo: reviewInfo,
      beforeValue: reviewInfo?.value,
    ));
  }

  changeValue(double value) {
    emit(state.copyWith(reviewInfo: state.reviewInfo!.copyWith(value: value)));
  }

  changeReview(String review) {
    emit(
        state.copyWith(reviewInfo: state.reviewInfo!.copyWith(review: review)));
  }

  Future<void> insert() async {
    var now = DateTime.now();
    emit(state.copyWith(
        reviewInfo:
            state.reviewInfo!.copyWith(createdAt: now, updatedAt: now)));
    await _reviewRepository.createReview(state.reviewInfo!);
    var bookId = state.reviewInfo!.bookId!;
    var bookReviewInfo =
        await _bookReviewInfoRepository.loadBookReviewInfo(bookId);
    if (bookReviewInfo == null) {
      var bookReviewInfo = BookReviewInfo(
        bookId: bookId,
        totalCounts: state.reviewInfo!.value,
        naverBookInfo: state.reviewInfo!.naverBookInfo,
        createdAt: DateTime.now(),
        updatedAt: DateTime.now(),
        reviewerUids: [state.reviewInfo!.reviewerUid!],
      );

      _bookReviewInfoRepository.createBookReviewInfo(bookReviewInfo);
    } else {
      bookReviewInfo.reviewerUids!.add(state.reviewInfo!.reviewerUid!);
      bookReviewInfo = bookReviewInfo.copyWith(
        totalCounts: bookReviewInfo.totalCounts! -
            (state.beforeValue ?? 0) +
            state.reviewInfo!.value!,
        reviewerUids: bookReviewInfo.reviewerUids!.toSet().toList(),
        updatedAt: DateTime.now(),
      );
      _bookReviewInfoRepository.updateBookReviewInfo(bookReviewInfo);
    }
  }

  Future<void> update() async {
    var updateData = state.reviewInfo!.copyWith(updatedAt: DateTime.now());
    await _reviewRepository.updateReview(updateData);
    var bookReviewInfo =
        await _bookReviewInfoRepository.loadBookReviewInfo(updateData.bookId!);

    if (bookReviewInfo != null) {
      bookReviewInfo = bookReviewInfo.copyWith(
        updatedAt: DateTime.now(),
        totalCounts: bookReviewInfo.totalCounts! -
            (state.beforeValue ?? 0) +
            state.reviewInfo!.value!,
      );
      await _bookReviewInfoRepository.updateBookReviewInfo(bookReviewInfo);
    }
  }

  save() async {
    emit(state.copyWith(status: CommonStateStatus.loading));
    var message = '';
    if (state.isEditMode!) {
      await update();
      message = '리뷰가 수정됐습니다.';
    } else {
      await insert();
      message = '리뷰가 등록됐습니다.';
    }
    emit(state.copyWith(status: CommonStateStatus.loaded,message: message));
  }
}

class ReviewState extends Equatable {
  final CommonStateStatus status;
  final Review? reviewInfo;
  final bool? isEditMode;
  final double? beforeValue;
  final String? message;

  const ReviewState({
    this.status = CommonStateStatus.init,
    this.reviewInfo,
    this.isEditMode,
    this.beforeValue,
    this.message,
  });

  ReviewState copyWith({
    CommonStateStatus? status,
    Review? reviewInfo,
    bool? isEditMode,
    double? beforeValue,
    String? message,
  }) {
    return ReviewState(
      status: status ?? this.status,
      reviewInfo: reviewInfo ?? this.reviewInfo,
      isEditMode: isEditMode ?? this.isEditMode,
      beforeValue: beforeValue ?? this.beforeValue,
      message: message ?? this.message,
    );
  }

  @override
  List<Object?> get props => [
        reviewInfo,
        isEditMode,
        beforeValue,
        message,
        status,
      ];
}
