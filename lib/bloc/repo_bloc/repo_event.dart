import 'package:equatable/equatable.dart';

abstract class RepoEvent extends Equatable {
  @override
  List<Object?> get props => [];
}

class FetchGithubUsersEvent extends RepoEvent {
  final String username;
  FetchGithubUsersEvent(this.username);
  @override
  List<Object?> get props => [username];
}

class RepoListEvent extends RepoEvent {
  final String url;
  RepoListEvent(this.url);
  @override
  List<Object?> get props => [url];
}
