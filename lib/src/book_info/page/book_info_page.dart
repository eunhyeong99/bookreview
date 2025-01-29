import 'package:bookreview/src/common/components/app_divider.dart';
import 'package:bookreview/src/common/components/app_font.dart';
import 'package:bookreview/src/common/components/btn.dart';
import 'package:bookreview/src/common/model/naver_book_info.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:go_router/go_router.dart';

class BookInfoPage extends StatelessWidget {
  final NaverBookInfo bookInfo;

  const BookInfoPage(
    this.bookInfo, {
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
        title: AppFont('책 소개', size: 18),
      ),
      body: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            SizedBox(height: 20),
            _BookDisplayLayer(bookInfo),
            const AppDivider(),
            _BookSimpleInfoLayer(bookInfo),
            const AppDivider(),
            _ReviewerLayer(),
          ],
        ),
      ),
      bottomNavigationBar: Padding(
        padding: EdgeInsets.only(
          left: 20,
          right: 20,
          top: 20,
          bottom: 20 + MediaQuery.of(context).padding.bottom,
        ),
        child: Btn(onTap: () {
          context.push('/review',extra: bookInfo,);
        }, text: '리뷰하기'),
      ),
    );
  }
}

class _ReviewerLayer extends StatelessWidget {
  const _ReviewerLayer({super.key});

  Widget _noneReviewer() {
    return Center(
      child: AppFont(
        '아직 리뷰가 없습니다.',
        size: 17,
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 25, vertical: 10),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          AppFont(
            '리뷰어',
            size: 18,
            fontWeight: FontWeight.bold,
          ),
          const SizedBox(height: 20),
          SizedBox(
            height: 70,
            child: _noneReviewer(),
          ),
        ],
      ),
    );
  }
}

class _BookSimpleInfoLayer extends StatelessWidget {
  final NaverBookInfo bookInfo;

  const _BookSimpleInfoLayer(
    this.bookInfo, {
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 25.0, vertical: 10),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          AppFont(
            '간단 소개',
            size: 16,
            fontWeight: FontWeight.bold,
          ),
          const SizedBox(height: 20),
          AppFont(
            bookInfo.description ?? '',
            size: 13,
            color: Color(0xff898989),
            lineHeight: 1.5,
          ),
        ],
      ),
    );
  }
}

class _BookDisplayLayer extends StatelessWidget {
  final NaverBookInfo bookInfo;

  const _BookDisplayLayer(
    this.bookInfo, {
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        ClipRRect(
          borderRadius: BorderRadius.circular(7),
          child: SizedBox(
            width: 152,
            height: 227,
            child: Image.network(
              bookInfo.image ?? '',
              fit: BoxFit.cover,
            ),
          ),
        ),
        Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            SvgPicture.asset('assets/svg/icons/icon_star.svg'),
            const SizedBox(width: 5),
            AppFont(
              '8.88',
              size: 16,
              color: Color(0xfff4aa2b),
            ),
          ],
        ),
        SizedBox(height: 10),
        AppFont(
          bookInfo.title ?? '',
          size: 16,
          fontWeight: FontWeight.bold,
          maxLine: 2,
          overflow: TextOverflow.ellipsis,
        ),
        SizedBox(width: 5),
        AppFont(
          bookInfo.author ?? '',
          size: 12,
          color: Color(0xff878787),
        ),
      ],
    );
  }
}
