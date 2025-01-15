import 'package:dio/dio.dart';

class ApiService {
  final Dio _dio = Dio();

  Future<List<dynamic>> fetchTrendingRepositories() async {
    try {
      final response = await _dio.get(
          'https://github-trending-api.now.sh/repositories?language=&since=daily');
      return response.data;
    } catch (e) {
      throw Exception('Failed to fetch data');
    }
  }
}