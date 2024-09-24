import 'dart:convert';

import 'package:github_user_search/model/github_user.dart';
import 'package:github_user_search/model/repos_response.dart';
import 'package:http/http.dart' as http;

class Repository {
  static Future<FetchGithubUserResponse> fetchGithubUsers(
      String username) async {
    try {
      final response = await http
          .get(Uri.parse('https://api.github.com/search/users?q=$username'));
      if (response.statusCode == 200) {
        final data = jsonDecode(response.body);
        // final items = data['items'] as List<dynamic>;
        return FetchGithubUserResponse.fromMap(data);
      } else {
        print('Error fetching users: ${response.statusCode}');
        throw Exception(response.body);
      }
    } catch (e) {
      print('Error fetching users: $e');
      throw Exception(e);
    } finally {}
  }

  static Future<List<ReposResponse>> fetchUserRepos(String url) async {
    try {
      final response = await http.get(Uri.parse(url));
      if (response.statusCode == 200) {
        // final data = jsonDecode(response.body);
        // final items = data['items'] as List<dynamic>;
        return reposResponseFromJson(response.body);
      } else {
        print('Error fetching repos: ${response.statusCode}');
        throw Exception(response.body);
      }
    } catch (e) {
      print('Error fetching repos: $e');
      throw Exception(e);
    } finally {}
  }
}
