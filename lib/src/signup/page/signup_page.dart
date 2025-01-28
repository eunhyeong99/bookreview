import 'dart:io';

import 'package:bookreview/src/common/components/app_font.dart';
import 'package:bookreview/src/common/components/btn.dart';
import 'package:bookreview/src/common/cubit/authentication_cubit.dart';
import 'package:bookreview/src/common/cubit/upload_cubit.dart';
import 'package:bookreview/src/signup/cubit/signup_cubit.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:go_router/go_router.dart';
import 'package:image_picker/image_picker.dart';

import '../../common/components/loading.dart';

class SignupPage extends StatelessWidget {
  const SignupPage({super.key});

  Widget _signupView(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        actions: [
          Padding(
            padding: const EdgeInsets.symmetric(vertical: 7, horizontal: 20),
            child: GestureDetector(
              onTap: () {},
              child: SvgPicture.asset(
                'assets/svg/icons/icon_close.svg',
              ),
            ),
          ),
        ],
      ),
      body: Padding(
        padding: const EdgeInsets.all(20.0),
        child: Column(
          children: [
            _UserProfileImageField(),
            const SizedBox(height: 50),
            const _NicknameField(),
            const SizedBox(height: 30),
            const _DiscriptionField(),
          ],
        ),
      ),
      bottomNavigationBar: Padding(
        padding: EdgeInsets.only(
          left: 20.0,
          right: 20,
          top: 20,
          bottom: 35 + MediaQuery.of(context).padding.bottom,
        ),
        child: Row(
          children: [
            Expanded(
              child: Btn(
                onTap: context.read<SignupCubit>().save,
                text: '가입',
              ),
            ),
            const SizedBox(width: 10),
            Expanded(
              child: Btn(
                onTap: () {},
                backgroundColor: Color(0xff212121),
                text: '취소',
              ),
            ),
          ],
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return MultiBlocListener(
      listeners: [
        BlocListener<SignupCubit, SignupState>(
          listenWhen: (previous, current) => previous.status != current.status,
          listener: (context, state) {
            switch (state.status) {
              case SignupStatus.init:
                break;
              case SignupStatus.loading:
                break;
              case SignupStatus.uploading:
                context.read<UploadCubit>().uploadUserProfile(
                    state.profileFile!, state.userModel!.uid!);
                break;
              case SignupStatus.success:
                context.read<AuthenticationCubit>().reloadAuth();
                break;
              case SignupStatus.fail:
                break;
            }
          },
        ),
        BlocListener<UploadCubit, UploadState>(
          listener: (context, state) {
            switch (state.status) {
              case UploadStatus.init:
                break;
              case UploadStatus.uploading:
                context
                    .read<SignupCubit>()
                    .uploadPercent(state.percent!.toStringAsFixed(2));
                break;
              case UploadStatus.success:
                context.read<SignupCubit>().updateProfileImageUrl(state.url);
                break;
              case UploadStatus.fail:
                break;
            }
          },
        ),
      ],
      child: Stack(
        children: [
          _signupView(context),
          BlocBuilder<SignupCubit, SignupState>(
            buildWhen: (previous, current) =>
                previous.percent != current.percent ||
                previous.status != current.status,
            builder: (context, state) {
              if (state.percent != null &&
                  state.status == SignupStatus.uploading) {
                return Loading(loadingMessage: '${state.percent}%');
              } else {
                return Container();
              }
            },
          ),
        ],
      ),
    );
  }
}

class _UserProfileImageField extends StatelessWidget {
  _UserProfileImageField({super.key});

  final ImagePicker _picker = ImagePicker();

  @override
  Widget build(BuildContext context) {
    var profileFile =
        context.select<SignupCubit, File?>((cubit) => cubit.state.profileFile);
    return Center(
      child: GestureDetector(
        onTap: () async {
          var image = await _picker.pickImage(source: ImageSource.gallery);
          context.read<SignupCubit>().changeProfileImage(image);
        },
        child: CircleAvatar(
          backgroundColor: Colors.grey,
          radius: 50,
          backgroundImage: profileFile == null
              ? Image.asset('assets/images/default_avatar.png').image
              : Image.file(profileFile).image,
        ),
      ),
    );
  }
}

class _NicknameField extends StatelessWidget {
  const _NicknameField({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: [
        const AppFont(
          '닉네임',
          size: 16,
          fontWeight: FontWeight.bold,
        ),
        const SizedBox(height: 15),
        TextField(
          onChanged: context.read<SignupCubit>().changeNickName,
          style: TextStyle(
            color: Colors.white,
            fontSize: 18,
          ),
          textAlign: TextAlign.center,
          decoration: InputDecoration(
            filled: true,
            fillColor: const Color(0xff232323),
            enabledBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(6),
              gapPadding: 0,
              borderSide: BorderSide.none,
            ),
            focusedBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(6),
              gapPadding: 0,
              borderSide: BorderSide.none,
            ),
          ),
        ),
      ],
    );
  }
}

class _DiscriptionField extends StatelessWidget {
  const _DiscriptionField({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: [
        const AppFont(
          '한줄 소개',
          size: 16,
          fontWeight: FontWeight.bold,
        ),
        const SizedBox(height: 12),
        TextField(
          onChanged: context.read<SignupCubit>().changeDiscription,
          maxLength: 50,
          style: TextStyle(
            color: Colors.white,
            fontSize: 18,
          ),
          textAlign: TextAlign.center,
          decoration: InputDecoration(
            counterStyle: TextStyle(
              color: Colors.white,
              fontSize: 15,
            ),
            filled: true,
            fillColor: const Color(0xff232323),
            enabledBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(6),
              gapPadding: 0,
              borderSide: BorderSide.none,
            ),
            focusedBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(6),
              gapPadding: 0,
              borderSide: BorderSide.none,
            ),
          ),
        ),
      ],
    );
  }
}
