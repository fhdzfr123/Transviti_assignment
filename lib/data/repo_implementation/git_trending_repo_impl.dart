


import 'package:dio/dio.dart';
import 'package:transvitiassignment/domain/entities/git_trendings_repositories_entity.dart';

import '../../domain/repo/git_trending_repo.dart';

class GitTrendingRepoImpl implements GitTrendingRepo{
  final Dio dioRequest = Dio(BaseOptions(
    connectTimeout: Duration(seconds: 10),
    receiveTimeout: Duration(seconds: 10),
  ));

  @override
  Future<GitTrendingRepositoriesEntity> fetchTrendingRepos() async {
    try {
      final response = await dioRequest.get(
          'https://api.github.com/search/repositories?q=stars:%3E1000&sort=stars&order=desc');

      return GitTrendingRepositoriesEntity.fromJson(response.data);
    } catch (e) {
      throw Exception('Failed to fetch data');
    }
  }
}