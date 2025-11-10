import 'package:bookly_app/core/utils/app_router.dart';
import 'package:bookly_app/core/utils/service_locator.dart';
import 'package:bookly_app/core/utils/simpleBlocOpserver.dart';
import 'package:bookly_app/core/utils/models/repos/home_repo_impl.dart';
import 'package:bookly_app/feature/home/domain/entities/book_entity.dart';
import 'package:bookly_app/feature/home/presentation/manger/featued_books/featured_books_cubit.dart';
import 'package:bookly_app/feature/home/presentation/manger/featued_books/newest_books_cubit/newest_books_cubit.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:hive/hive.dart';

import 'constant.dart';

void main() async {
  setUp();
  Bloc.observer = SimpleBlocObserver();

  runApp(const BookApp());
  Hive.registerAdapter(BookEntityAdapter());
  await Hive.openBox(kFeatureBox);
}

class BookApp extends StatelessWidget {
  const BookApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider(
          create: (context) =>
              FeaturedBooksCubit(getIt.get<HomeRepoImpl>())
                ..fetchFeaturedBooks(),
        ),
        BlocProvider(
          create: (context) =>
              NewestBooksCubit(getIt.get<HomeRepoImpl>())..fetchNewestBooks(),
        ),
      ],
      child: MaterialApp.router(
        routerConfig: AppRouter.router,
        debugShowCheckedModeBanner: false,
        theme: ThemeData.dark().copyWith(
          scaffoldBackgroundColor: kPrimaryColor,
          textTheme: GoogleFonts.montserratTextTheme(
            ThemeData.dark().textTheme,
          ),
        ),
      ),
    );
  }
}
