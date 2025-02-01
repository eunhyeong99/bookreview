import 'package:bookreview/src/common/components/book_review_header_widget.dart';
import 'package:bookreview/src/common/cubit/authentication_cubit.dart';
import 'package:bookreview/src/common/model/naver_book_info.dart';
import 'package:bookreview/src/common/utils/data_util.dart';
import 'package:bookreview/src/review/detail/cubit/review_detail_cubit.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/svg.dart';
import 'package:go_router/go_router.dart';

import '../../../common/components/app_divider.dart';
import '../../../common/components/app_font.dart';

class ReviewDetailPage extends StatelessWidget {
  final NaverBookInfo naverBookInfo;

  const ReviewDetailPage(
    this.naverBookInfo, {
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: GestureDetector(
          onTap: context.pop,
          child: Padding(
            padding: const EdgeInsets.all(15),
            child: SvgPicture.asset('assets/svg/icons/icon_arrow_back.svg'),
          ),
        ),
        title: AppFont(
          '리뷰',
          size: 18,
        ),
      ),
      body: SingleChildScrollView(
        child: Column(
          children: [
            BookReviewHeaderWidget(
              naverBookInfo: naverBookInfo,
              reviewCountDisplayWidget: Row(
                children: [
                  SvgPicture.asset(
                    'assets/svg/icons/icon_star.svg',
                    width: 22,
                  ),
                  SizedBox(width: 5),
                  BlocBuilder<ReviewDetailCubit, ReviewDetailState>(
                      builder: (context, state) {
                    return AppFont(
                      (state.review?.value ?? 0).toStringAsFixed(2),
                      color: Color(0xffF4aa2b),
                      size: 16,
                    );
                  }),
                ],
              ),
            ),
            const AppDivider(),
            Expanded(
              child: _ReviewInfoWidget(),
            ),
          ],
        ),
      ),
    );
  }
}

class _ReviewInfoWidget extends StatelessWidget {
  const _ReviewInfoWidget({super.key});

  Widget _profile(ReviewDetailState state,BuildContext context) {
    if (state.review == null) return Container();
    return GestureDetector(
      onTap: (){
        context.push("/profile/${state.userInfo!.uid}");
      },
      child: Row(
        children: [
          CircleAvatar(
            radius: 33,
            backgroundColor: Colors.grey,
            backgroundImage: state.userInfo?.profile == null
                ? Image.network('assets/images/default_avatar.png').image
                : Image.network(state.userInfo!.profile!).image,
          ),
          SizedBox(width: 15),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                AppFont(
                  state.userInfo?.name ?? '',
                  size: 18,
                  color: Color(0xffc9c9c9),
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    AppFont(
                      '공감 ${state.review!.likedUsers?.length ?? 0}개',
                      size: 15,
                      color: Color(0xffc9c9c9),
                      fontWeight: FontWeight.bold,
                    ),
                    AppFont(
                      AppDataUtil.dateFormat(
                          'yyyy.MM.dd', state.review!.createdAt!),
                      size: 12,
                      color: Color(0xff878787),
                      fontWeight: FontWeight.bold,
                    ),
                  ],
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    var myUid = context.read<AuthenticationCubit>().state.user!.uid!;
    return BlocBuilder<ReviewDetailCubit, ReviewDetailState>(
      builder: (context, state) {
        return Padding(
          padding: const EdgeInsets.symmetric(horizontal: 25, vertical: 10),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              _profile(state,context),
              const SizedBox(height: 30),
              AppFont(
                state.review?.review ?? '',
                size: 14,
                color: Color(0xffa7a7a7),
              ),
              GestureDetector(
                onTap: () {
                  context.read<ReviewDetailCubit>().toggleLikedReview(myUid);
                },
                child: Padding(
                  padding: const EdgeInsets.symmetric(vertical: 50),
                  child: SvgPicture.asset(
                    'assets/svg/icons/icon_liked.svg',
                    width: 30,
                    colorFilter: state.review?.likedUsers?.contains(myUid) ??
                            false
                        ? ColorFilter.mode(Color(0xfff4aa2b), BlendMode.srcIn)
                        : ColorFilter.mode(Colors.grey, BlendMode.srcIn),
                  ),
                ),
              ),
            ],
          ),
        );
      },
    );
  }
}
