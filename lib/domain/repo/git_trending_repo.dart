
import '../entities/git_trendings_repositories_entity.dart';

abstract class GitTrendingRepo {
  Future<GitTrendingRepositoriesEntity> fetchTrendingRepos();
}