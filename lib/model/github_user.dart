import 'dart:convert';

class FetchGithubUserResponse {
  final List<GitHubUser> items;

  FetchGithubUserResponse({required this.items});

  factory FetchGithubUserResponse.fromMap(Map<String, dynamic> map) {
    return FetchGithubUserResponse(
      items: List<GitHubUser>.from(
          map['items']?.map((x) => GitHubUser.fromJson(x))),
    );
  }

  factory FetchGithubUserResponse.fromJson(String source) =>
      FetchGithubUserResponse.fromMap(json.decode(source));
}

class GitHubUser {
  final String login;
  final String avatarUrl;
  final int? publicRepos;
  final String? reposUrl;

  GitHubUser(
      {required this.login,
      required this.avatarUrl,
      required this.publicRepos,
      this.reposUrl});

  factory GitHubUser.fromJson(Map<String, dynamic> json) {
    return GitHubUser(
        login: json['login'],
        avatarUrl: json['avatar_url'],
        publicRepos: json['public_repos'] ?? 0,
        reposUrl: json['repos_url']);
  }
}
