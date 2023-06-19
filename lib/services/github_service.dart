import 'package:dio/dio.dart';
import 'package:assignment/model/repository.dart';

class GitHubService {
  final Dio _dio = Dio();

  Future<List<Repository>> getRepositories(String username) async {
    final url = 'https://api.github.com/users/$username/repos';

    try {
      final response = await _dio.get(url);
      final data = response.data as List<dynamic>;

      return data.map((json) => Repository.fromJson(json)).toList();
    } catch (e) {
      throw Exception('Failed to fetch repos');
    }
  }
}
