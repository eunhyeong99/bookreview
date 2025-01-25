import 'package:bookreview/src/common/components/app_font.dart';
import 'package:bookreview/src/common/cubit/authentication_cubit.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/flutter_svg.dart';

class LoginPage extends StatelessWidget {
  const LoginPage({super.key});

  Widget _googleLoginBtn(BuildContext context) {
    return Builder(
      builder: (newContext) {
        return GestureDetector(
          onTap: newContext.read<AuthenticationCubit>().googleLogin,
          child: Container(
            margin: const EdgeInsets.symmetric(horizontal: 50),
            padding: const EdgeInsets.symmetric(horizontal: 30, vertical: 15),
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(7),
              color: Colors.white,
            ),
            child: Row(
              children: [
                SvgPicture.asset('assets/svg/icons/google_logo.svg'),
                const SizedBox(width: 30),
                AppFont(
                  'Google로 계속하기',
                  color: Colors.black,
                  size: 14,
                ),
              ],
            ),
          ),
        );
      },
    );
  }

  Widget _appleLoginBtn(BuildContext context) {
    return Builder(
      builder: (newContext) {
        return GestureDetector(
          onTap: newContext.read<AuthenticationCubit>().appleLogin,
          child: Container(
            margin: const EdgeInsets.symmetric(horizontal: 50),
            padding: const EdgeInsets.symmetric(horizontal: 30, vertical: 7),
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(7),
              color: Colors.black,
            ),
            child: Row(
              children: [
                SvgPicture.asset('assets/svg/icons/apple_logo.svg'),
                const SizedBox(width: 30),
                AppFont(
                  'Apple로 계속하기',
                  color: Colors.white,
                  size: 14,
                ),
              ],
            ),
          ),
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        fit: StackFit.expand,
        children: [
          Image.asset(
            'assets/images/splash_bg.png',
            fit: BoxFit.cover,
          ),
          Container(
            color: Colors.black.withOpacity(0.6),
            child: SafeArea(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                children: [
                  Column(
                    children: [
                      AppFont(
                        '책 리뷰',
                        size: 30,
                        fontWeight: FontWeight.bold,
                      ),
                      const SizedBox(height: 30),
                      AppFont(
                        '로그인하여 직접 리뷰를 남겨보세요.\n많은 이들이 책을 고르기에 도움이 될 것입니다.',
                        size: 13,
                        color: Color(0xff878787),
                        textAlign: TextAlign.center,
                      ),
                    ],
                  ),
                  Column(
                    children: [
                      AppFont(
                        '회원가입 / 로그인',
                        size: 14,
                        textAlign: TextAlign.center,
                        fontWeight: FontWeight.bold,
                      ),
                      const SizedBox(height: 30),
                      _googleLoginBtn(context),
                      const SizedBox(height: 20),
                      _appleLoginBtn(context),
                    ],
                  ),
                  const SizedBox(height: 150),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
