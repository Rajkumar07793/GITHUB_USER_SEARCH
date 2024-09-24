import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:github_user_search/bloc/repo_bloc/repo_bloc.dart';
import 'package:github_user_search/bloc/repo_bloc/repo_event.dart';
import 'package:github_user_search/bloc/repo_bloc/repo_state.dart';
import 'package:github_user_search/model/github_user.dart';
import 'package:github_user_search/views/loader.dart';
import 'package:github_user_search/views/repo_list.dart';
import 'package:modal_progress_hud_nsn/modal_progress_hud_nsn.dart';

class GitHubSearchScreen extends StatefulWidget {
  const GitHubSearchScreen({super.key});

  @override
  State<GitHubSearchScreen> createState() => _GitHubSearchScreenState();
}

class _GitHubSearchScreenState extends State<GitHubSearchScreen> {
  final TextEditingController _searchController = TextEditingController();

  var fetchGithubUsersBloc = RepoBloc(RepoBlocInitialState());

  @override
  void initState() {
    // fetchGithubUsersBloc.add(FetchGithubUsersEvent("*"));
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('GitHub User Search'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: [
            TextField(
              controller: _searchController,
              decoration: const InputDecoration(
                  hintText: 'Search for a GitHub user',
                  labelText: "Search by username",
                  prefixIcon: Icon(Icons.search)),
              onChanged: (value) {
                if (value.isNotEmpty) {
                  // _searchUsers(value);
                  fetchGithubUsersBloc.add(FetchGithubUsersEvent(value));
                }
              },
            ),
            const SizedBox(height: 16.0),
            Expanded(
              child: BlocBuilder(
                  bloc: fetchGithubUsersBloc,
                  builder: (context, state) {
                    if (state is RepoErrorState) {
                      return Center(
                        child: Text(state.error.toString()),
                      );
                    }
                    if (state is FetchGithubUsersState) {
                      List<GitHubUser> users = state.value.items;
                      if (users.isEmpty) {
                        return const Center(
                          child: Text("No result"),
                        );
                      }
                      return ModalProgressHUD(
                        progressIndicator: const Loader(),
                        inAsyncCall: state is RepoLoadingState,
                        child: ListView.builder(
                          itemCount: users.length,
                          itemBuilder: (context, index) {
                            final user = users[index];
                            return ListTile(
                              leading: CircleAvatar(
                                backgroundImage: NetworkImage(user.avatarUrl),
                              ),
                              title: Text(user.login),
                              // subtitle:
                              //     Text('${user.publicRepos} repositories'),
                              onTap: () {
                                if (user.reposUrl?.isNotEmpty ?? false) {
                                  Navigator.push(
                                      context,
                                      MaterialPageRoute(
                                        builder: (context) => RepoList(
                                          reposUrl: user.reposUrl!,
                                        ),
                                      ));
                                } else {
                                  print("No repo url");
                                }
                              },
                            );
                          },
                        ),
                      );
                    }
                    return const Loader();
                  }),
            ),
          ],
        ),
      ),
    );
  }
}
