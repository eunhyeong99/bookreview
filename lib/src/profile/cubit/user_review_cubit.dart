import 'package:bloc/bloc.dart';
import 'package:bookreview/src/common/model/review.dart';
import 'package:bookreview/src/common/repository/review_repository.dart';
import 'package:equatable/equatable.dart';

class UserReviewCubit extends Cubit<UserReviewState> {
  final ReviewRepository _reviewRepository;
  final String uid;

  UserReviewCubit(
    this._reviewRepository,
    this.uid,
  ) : super(UserReviewState()) {
    _loadMyAllReviews();
  }

  void _loadMyAllReviews() async {
    var result = await _reviewRepository.loadMyAllReview(uid);
    emit(state.copyWith(results: result));
  }
}

class UserReviewState extends Equatable {
  final List<Review> results;

  const UserReviewState({
    this.results = const [],
  });

  UserReviewState copyWith({
    List<Review>? results,
  }) {
    return UserReviewState(
      results: results ?? this.results,
    );
  }

  @override
  List<Object?> get props => [
        results,
      ];
}
