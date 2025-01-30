import 'package:bloc/bloc.dart';
import 'package:bookreview/src/common/enum/common_state_status.dart';
import 'package:bookreview/src/common/model/book_review_info.dart';
import 'package:bookreview/src/common/model/user_model.dart';
import 'package:bookreview/src/common/repository/book_review_info_repository.dart';
import 'package:bookreview/src/common/repository/user_repository.dart';
import 'package:equatable/equatable.dart';

class BookInfoCubit extends Cubit<BookInfoState> {
  final BookReviewInfoRepository _bookReviewInfoRepository;
  final UserRepository _userRepository;
  final String bookId;
  final String uid;

  BookInfoCubit(
    this._bookReviewInfoRepository,
    this._userRepository,
    this.bookId,
    this.uid,
  ) : super(BookInfoState()) {
    _loadBookReviewInfo();
  }

  void _loadBookReviewInfo() async {
    emit(state.copyWith(status: CommonStateStatus.loading));
    var data = await _bookReviewInfoRepository.loadBookReviewInfo(bookId);
    if (data != null) {
      if (data.reviewerUids!.isEmpty) return;
      var reviewList =
          await _userRepository.allUserInfos(data.reviewerUids ?? []);
      emit(state.copyWith(
        status: CommonStateStatus.loaded,
        bookReviewInfo: data,
        reviewers: reviewList,
      ));
    }else{
      emit(state.copyWith(status: CommonStateStatus.loaded));
    }
  }

  void refresh() {
    _loadBookReviewInfo();
  }
}

class BookInfoState extends Equatable {
  final CommonStateStatus status;
  final BookReviewInfo? bookReviewInfo;
  final List<UserModel>? reviewers;

  const BookInfoState({
    this.status = CommonStateStatus.init,
    this.bookReviewInfo,
    this.reviewers,
  });

  BookInfoState copyWith({
    CommonStateStatus? status,
    BookReviewInfo? bookReviewInfo,
    List<UserModel>? reviewers,
  }) {
    return BookInfoState(
      status: status ?? this.status,
      bookReviewInfo: bookReviewInfo ?? this.bookReviewInfo,
      reviewers: reviewers ?? this.reviewers,
    );
  }

  @override
  List<Object?> get props => [
        bookReviewInfo,
        reviewers,
        status,
      ];
}
