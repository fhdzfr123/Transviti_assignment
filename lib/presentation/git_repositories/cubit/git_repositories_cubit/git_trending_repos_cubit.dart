import 'dart:developer';

import 'package:flutter_bloc/flutter_bloc.dart';
import '../../../../domain/repo/git_trending_repo.dart';
import '../git_repositories_cubit_state/git_trending_repos_state.dart';

class GitTrendingReposCubit extends Cubit<GitTrendingReposState> {

  GitTrendingReposCubit({required this.gitTrendingRepo}) : super(GitTrendingReposState.init());
  final GitTrendingRepo gitTrendingRepo;

    fetchTrendingRepositories()async{
      log('message');
      emit(state.copyWith(isLoading: true, isErrorShow: false));
      await gitTrendingRepo.fetchTrendingRepos().then((value){
        print('');

        emit(state.copyWith(isLoading: false, repositories: value.repositories));
      } , onError: (e){
        emit(state.copyWith(isLoading: false, isErrorShow: true));
      });
    }

}