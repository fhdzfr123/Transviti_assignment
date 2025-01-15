import '../../../../domain/entities/git_trendings_repositories_entity.dart';

class GitTrendingReposState {
  GitTrendingReposState({required this.repositories,this.isErrorShow = false, this.isLoading = false});

  final List<Repository> repositories;
  final bool isLoading;
  final bool isErrorShow;

  factory GitTrendingReposState.init() =>
      GitTrendingReposState(isLoading: false, isErrorShow: false, repositories: []);

  GitTrendingReposState copyWith(
      {List<Repository>? repositories, bool? isLoading, bool? isErrorShow}) {
    return GitTrendingReposState(
      repositories: repositories ?? this.repositories,
      isLoading: isLoading ?? this.isLoading,
      isErrorShow: isErrorShow ?? this.isErrorShow,
    );
  }
}
