import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:get_it/get_it.dart';
import 'package:transvitiassignment/data/repo_implementation/git_trending_repo_impl.dart';
import 'package:transvitiassignment/domain/repo/git_trending_repo.dart';
import 'package:transvitiassignment/presentation/git_repositories/cubit/git_repositories_cubit/git_trending_repos_cubit.dart';


import 'package:transvitiassignment/presentation/git_repositories/view/git_repositories_screen.dart';

import 'data/http/api_call.dart';

final getIt = GetIt.instance;

void main() {
  WidgetsFlutterBinding.ensureInitialized();
  getIt.registerSingleton(ApiService());
  getIt.registerSingleton<GitTrendingRepo>(
    GitTrendingRepoImpl(),
  );
  runApp(MyApp());
}
class ThemeCubit extends Cubit<ThemeMode> {
  ThemeCubit() : super(ThemeMode.light);

  void toggleTheme() {
    emit(state == ThemeMode.light ? ThemeMode.dark : ThemeMode.light);
  }
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider(create: (context) => GitTrendingReposCubit(
        gitTrendingRepo: getIt(),
    )..fetchTrendingRepositories()),
    BlocProvider(create: (context) => ThemeCubit()),
      ],
      child: BlocBuilder<ThemeCubit, ThemeMode>(builder: (context,ThemeMode state){
        return MaterialApp(
        title: 'GitHub Trending',
        debugShowCheckedModeBanner: false,
        theme: ThemeData.light().copyWith(
          primaryColor: Colors.blue,
          buttonTheme: const ButtonThemeData(
            buttonColor: Colors.blue,
            textTheme: ButtonTextTheme.primary,
          ),
        ),
        darkTheme:ThemeData.dark().copyWith(
          primaryColor: Colors.blueGrey,
          buttonTheme: const ButtonThemeData(
            buttonColor: Colors.blueGrey,
            textTheme: ButtonTextTheme.primary,
          ),
        ),
        themeMode: state,
        home: const GitTrendingRepositoriesScreen(),
      );
      }),
    );
  }
}