import 'package:equatable/equatable.dart';
import 'package:github_user_search/model/github_user.dart';
import 'package:github_user_search/model/repos_response.dart';

abstract class RepoState extends Equatable {
  @override
  List<Object?> get props => [];
}

class RepoBlocInitialState extends RepoState {}

class RepoLoadingState extends RepoState {}

class RepoErrorState extends RepoState {
  final Object? error;
  RepoErrorState(this.error);

  @override
  List<Object?> get props => [error];
}

class FetchGithubUsersState extends RepoState {
  final FetchGithubUserResponse value;
  FetchGithubUsersState(this.value);
  @override
  List<Object?> get props => [value];
}

class RepoListState extends RepoState {
  final List<ReposResponse> value;
  RepoListState(this.value);
  @override
  List<Object?> get props => [value];
}
