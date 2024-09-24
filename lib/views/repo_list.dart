import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:github_user_search/bloc/repo_bloc/repo_bloc.dart';
import 'package:github_user_search/bloc/repo_bloc/repo_event.dart';
import 'package:github_user_search/bloc/repo_bloc/repo_state.dart';
import 'package:github_user_search/views/loader.dart';

class RepoList extends StatefulWidget {
  final String reposUrl;
  const RepoList({super.key, required this.reposUrl});

  @override
  State<RepoList> createState() => _RepoListState();
}

class _RepoListState extends State<RepoList> {
  var fetchUserRepoBloc = RepoBloc(RepoBlocInitialState());

  @override
  void initState() {
    fetchUserRepoBloc.add(RepoListEvent(widget.reposUrl));
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Repositories"),
      ),
      body: BlocBuilder(
          bloc: fetchUserRepoBloc,
          builder: (context, state) {
            if (state is RepoListState) {
              var repos = state.value;
              if (repos.isEmpty) {
                return const Center(
                  child: Text("No repos"),
                );
              }
              return ListView.builder(
                itemCount: repos.length,
                itemBuilder: (context, index) => ListTile(
                  title: Text(repos[index].name ?? "Unknown"),
                ),
              );
            }
            return const Loader();
          }),
    );
  }
}
