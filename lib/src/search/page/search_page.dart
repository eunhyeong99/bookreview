import 'package:bookreview/src/common/components/app_font.dart';
import 'package:bookreview/src/common/components/input_widget.dart';
import 'package:bookreview/src/common/enum/common_state_status.dart';
import 'package:bookreview/src/common/model/naver_book_info.dart';
import 'package:bookreview/src/search/cubit/search_book_cubit.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:go_router/go_router.dart';

class SearchPage extends StatelessWidget {
  const SearchPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: GestureDetector(
          onTap: context.pop,
          behavior: HitTestBehavior.translucent,
          child: Padding(
            padding: const EdgeInsets.all(15.0),
            child: SvgPicture.asset('assets/svg/icons/icon_arrow_back.svg'),
          ),
        ),
        title: const AppFont(
          '책 검색',
          size: 18,
        ),
      ),
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 20.0, vertical: 15.0),
        child: Column(
          children: [
            InputWidget(
              onSearch: context.read<SearchBookCubit>().search,
            ),
            Expanded(
              child: _SearchResultView(),
            ),
          ],
        ),
      ),
    );
  }
}

class _SearchResultView extends StatefulWidget {
  const _SearchResultView({super.key});

  @override
  State<_SearchResultView> createState() => _SearchResultViewState();
}

class _SearchResultViewState extends State<_SearchResultView> {
  late SearchBookCubit cubit;

  @override
  void initState() {
    super.initState();
    controller.addListener(() {
      if (controller.offset > controller.position.maxScrollExtent - 100 &&
          cubit.state.status == CommonStateStatus.loaded) {
        cubit.nextPage();
      }
    });
  }

  ScrollController controller = ScrollController();

  Widget _messageView(String message) {
    return Center(
      child: AppFont(
        message,
        size: 20,
        fontWeight: FontWeight.bold,
        color: Colors.grey,
      ),
    );
  }

  Widget _result() {
    return ListView.separated(
      controller: controller,
      itemBuilder: (context, index) {
        NaverBookInfo bookInfo = cubit.state.result!.items![index];
        return GestureDetector(
          onTap: () {
            context.push('/info', extra: bookInfo);
          },
          behavior: HitTestBehavior.translucent,
          child: Row(
            children: [
              SizedBox(
                width: 75,
                height: 115,
                child: Image.network(
                  bookInfo.image ?? '',
                ),
              ),
              const SizedBox(width: 15),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.stretch,
                  children: [
                    AppFont(
                      bookInfo.title ?? '',
                      maxLine: 2,
                      overflow: TextOverflow.ellipsis,
                      size: 16,
                    ),
                    SizedBox(height: 7),
                    AppFont(
                      bookInfo.author ?? '',
                      size: 13,
                      color: Color(0xff878787),
                    ),
                    SizedBox(height: 13),
                    AppFont(
                      bookInfo.description ?? '',
                      size: 13,
                      maxLine: 2,
                      overflow: TextOverflow.ellipsis,
                      color: Color(0xff838383),
                    ),
                  ],
                ),
              ),
            ],
          ),
        );
      },
      separatorBuilder: (context, index) => Padding(
        padding: const EdgeInsets.symmetric(vertical: 8.0),
        child: Divider(color: Color(0xff262626)),
      ),
      itemCount: cubit.state.result?.items?.length ?? 0,
    );
  }

  @override
  Widget build(BuildContext context) {
    cubit = context.watch<SearchBookCubit>();
    if (cubit.state.status == CommonStateStatus.init) {
      return _messageView("리뷰할 책을 찾아보세요.");
    }
    if (cubit.state.status == CommonStateStatus.loaded &&
        (cubit.state.result == null || cubit.state.result!.items!.isEmpty)) {
      return _messageView("검색된 결과가 없습니다.");
    }
    return _result();
  }
}
