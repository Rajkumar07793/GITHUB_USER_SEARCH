import 'dart:async';

import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:github_user_search/bloc/repo_bloc/repo_event.dart';
import 'package:github_user_search/bloc/repo_bloc/repo_state.dart';
import 'package:github_user_search/repository/repository.dart';

class RepoBloc extends Bloc<RepoEvent, RepoState> {
  RepoBloc(super.initialState) {
    on(eventHandler);
  }

  FutureOr<void> eventHandler(RepoEvent event, Emitter<RepoState> emit) async {
    if (event is FetchGithubUsersEvent) {
      emit(RepoLoadingState());
      await Repository.fetchGithubUsers(event.username)
          .then((value) => emit(FetchGithubUsersState(value)))
          .onError((error, stackTrace) => emit(RepoErrorState(error)));
    }

    if (event is RepoListEvent) {
      emit(RepoLoadingState());
      await Repository.fetchUserRepos(event.url)
          .then((value) => emit(RepoListState(value)))
          .onError((error, stackTrace) => emit(RepoErrorState(error)));
    }
  }
}
