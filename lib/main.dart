import 'package:bookreview/firebase_options.dart';
import 'package:bookreview/src/app.dart';
import 'package:bookreview/src/common/cubit/app_data_load_cubit.dart';
import 'package:bookreview/src/common/cubit/authentication_cubit.dart';
import 'package:bookreview/src/common/cubit/upload_cubit.dart';
import 'package:bookreview/src/common/interceptor/custom_interceptor.dart';
import 'package:bookreview/src/common/repository/authentication_repository.dart';
import 'package:bookreview/src/common/repository/book_review_info_repository.dart';
import 'package:bookreview/src/common/repository/naver_api_repository.dart';
import 'package:bookreview/src/common/repository/review_repository.dart';
import 'package:bookreview/src/common/repository/user_repository.dart';
import 'package:bookreview/src/init/cubit/init_cubit.dart';
import 'package:bookreview/src/splash/cubit/splash_cubit.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:dio/dio.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:hydrated_bloc/hydrated_bloc.dart';
import 'package:path_provider/path_provider.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(options: DefaultFirebaseOptions.currentPlatform);
  HydratedBloc.storage = await HydratedStorage.build(
    storageDirectory: kIsWeb
        ? HydratedStorageDirectory.web
        : HydratedStorageDirectory((await getTemporaryDirectory()).path),
  );
  Dio dio = Dio(BaseOptions(baseUrl: 'https://openapi.naver.com/'));
  dio.interceptors.add(CustomInterceptor());
  runApp(MyApp(dio: dio));
}

class MyApp extends StatelessWidget {
  final Dio dio;

  const MyApp({
    required this.dio,
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    var db = FirebaseFirestore.instance;
    var storage = FirebaseStorage.instance;
    return MultiRepositoryProvider(
      providers: [
        RepositoryProvider(
          create: (create) => NaverBookRepository(dio),
        ),
        RepositoryProvider(
          create: (create) => AuthenticationRepository(FirebaseAuth.instance),
        ),
        RepositoryProvider(
          create: (create) => UserRepository(db),
        ),
        RepositoryProvider(
          create: (create) => BookReviewInfoRepository(db),
        ),
        RepositoryProvider(
          create: (create) => ReviewRepository(db),
        ),
      ],
      child: MultiBlocProvider(
        providers: [
          BlocProvider(create: (_) => SplashCubit()),
          BlocProvider(create: (_) => AppDataLoadCubit()),
          BlocProvider(create: (_) => UploadCubit(storage)),
          BlocProvider(create: (_) => InitCubit()),
          BlocProvider(
              create: (context) => AuthenticationCubit(
                    context.read<AuthenticationRepository>(),
                    context.read<UserRepository>(),
                  ))
        ],
        child: const App(),
      ),
    );
  }
}
