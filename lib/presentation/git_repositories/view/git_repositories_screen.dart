import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shimmer/shimmer.dart';
import 'package:transvitiassignment/presentation/git_repositories/cubit/git_repositories_cubit/git_trending_repos_cubit.dart';
import 'package:transvitiassignment/presentation/git_repositories/cubit/git_repositories_cubit_state/git_trending_repos_state.dart';

import '../../../main.dart';

class GitTrendingRepositoriesScreen extends StatelessWidget {
  const GitTrendingRepositoriesScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: const Text("Trending"),
          actions: [
            PopupMenuButton<String>(
              onSelected: (value) {
                BlocProvider.of<ThemeCubit>(context).toggleTheme();
              },
              itemBuilder: (BuildContext context) {
                return [
                  const PopupMenuItem<String>(
                    value: 'toggle',
                    child: Row(
                      children: [
                        Icon(Icons.brightness_6),
                        SizedBox(width: 8),
                        Text('Toggle Theme'),
                      ],
                    ),
                  ),
                ];
              },
              icon: const Icon(Icons.more_vert),
            ),
          ],
        ),
      body: BlocBuilder<GitTrendingReposCubit, GitTrendingReposState>(
        bloc: BlocProvider.of<GitTrendingReposCubit>(context)..fetchTrendingRepositories(),
          builder: (context, GitTrendingReposState state){
            return state.isErrorShow ? Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Center(child: Image.asset('assets/animation.gif', fit: BoxFit.fill ,height: MediaQuery.of(context).size.height *0.3,width: MediaQuery.of(context).size.width *0.7,)),
                SizedBox(height: MediaQuery.of(context).size.height *0.1),
                Container(
                  width: MediaQuery.of(context).size.width *0.7,
                  child: ElevatedButton(
                    onPressed: (){
                      BlocProvider.of<GitTrendingReposCubit>(context).fetchTrendingRepositories();
                    },
                    style: ElevatedButton.styleFrom(
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(4),
                        //borderRadius: BorderRadius.zero, //Rectangular border
                      ),
                      side: const BorderSide(
                        width: 1.0,
                        color: Colors.green,
                      ),
                    ),
                    child: const Text('RETRY', style: TextStyle(color: Colors.green),),
                  ),
                ),
              ],
            ) : state.isLoading ?
            ListView.builder(
              itemCount: 10,
              itemBuilder: (context, index) {
                return Shimmer.fromColors(
                  baseColor: Colors.grey[300]!,
                  highlightColor: Colors.grey[100]!,
                  child: Column(
                    children: [
                      Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Padding(
                            padding: const EdgeInsets.all(20),
                            child: Row(
                              children: [
                                CircleAvatar(
                                  radius: 20,
                                  backgroundColor: Colors.grey[300],
                                ),
                                const SizedBox(width: 16),
                                Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                  Container(
                                    width: MediaQuery.of(context).size.width* 0.3,
                                    height: 10,
                                    decoration: BoxDecoration(
                                        color: Colors.grey[300],

                                        borderRadius: BorderRadius.circular(8)
                                    ),
                                  ),
                                  SizedBox(height: MediaQuery.of(context).size.height* 0.01),
                                  // Subtitle shimmer effect (container for subtitle)
                                  Container(
                                    width: MediaQuery.of(context).size.width* 0.75,
                                    height: 10,
                                    decoration: BoxDecoration(
                                        color: Colors.grey[300],
                                        borderRadius: BorderRadius.circular(8)
                                    ),
                                  ),
                                ],),
                              ],
                            ),
                          )
                        ],
                      ),
                    ],
                  ),
                );
              },
            ) :
            ListView.builder(
              itemCount: state.repositories.length,
              itemBuilder: (context, index) {
                return Column(
                  children: [
                    Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Padding(
                          padding: const EdgeInsets.all(20),
                          child: Row(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              CircleAvatar(
                                radius: 20,
                                backgroundColor: Colors.grey[300],
                                backgroundImage: NetworkImage(state.repositories[index].owner?.avatarUrl ?? ''),
                              ),
                              const SizedBox(width: 16),
                              Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                Container(
                                  width: MediaQuery.of(context).size.width* 0.3,
                                  // height: 10,
                                  // decoration:
                                  child: Text(state.repositories[index].name ?? 'no name'),
                                ),
                                SizedBox(height: MediaQuery.of(context).size.height* 0.01),
                                // Subtitle shimmer effect (container for subtitle)
                                Container(
                                  width: MediaQuery.of(context).size.width* 0.75,
                                  child: Text(state.repositories[index].fullName ?? ''),

                                ),
                                  Row(
                                    children: [
                                      const Icon(Icons.fiber_manual_record, size: 10, color: Colors.blue),
                                      const SizedBox(width: 4),
                                      Text(state.repositories[index].language ?? ''),
                                      const SizedBox(width: 20),

                                      const Icon(Icons.star, size: 10, color: Colors.yellow),
                                      const SizedBox(width: 4),
                                      Text(state.repositories[index].stargazersCount.toString() ?? ''),
                                    ],
                                  ),
                              ],),
                            ],
                          ),
                        )
                      ],
                    ),
                  ],
                );
              },
            );
          })
    );
  }
}
