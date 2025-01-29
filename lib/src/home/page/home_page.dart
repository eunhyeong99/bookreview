import 'package:bookreview/src/common/components/app_font.dart';
import 'package:bookreview/src/common/components/input_widget.dart';
import 'package:bookreview/src/common/cubit/authentication_cubit.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';

class HomePage extends StatelessWidget {
  const HomePage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: false,
        title: Container(
          padding: const EdgeInsets.all(10),
          child: BlocBuilder<AuthenticationCubit, AuthenticationState>(
              builder: (context, state) {
            return GestureDetector(
              onTap: context.read<AuthenticationCubit>().logout,
              child: Row(
                children: [
                  CircleAvatar(
                    backgroundColor: Colors.grey,
                    backgroundImage: state.user?.profile == null
                        ? Image.asset('assets/images/default_avatar.png').image
                        : Image.network(state.user!.profile!).image,
                  ),
                  const SizedBox(width: 15),
                  AppFont(state.user?.name ?? '', size: 16),
                ],
              ),
            );
          }),
        ),
      ),
      body: Padding(
        padding: const EdgeInsets.all(25),
        child: Column(
          children: [
            InputWidget(
              isEnabled: false,
              onTap: () {
                context.push('/search');
              },
            ),
          ],
        ),
      ),
    );
  }
}
