import 'package:flutter/material.dart';
import 'package:gemographyMobileChallenge/Models/Core/RepoModel.dart';
import 'package:gemographyMobileChallenge/Models/Services/repositories.dart';
import 'package:gemographyMobileChallenge/Provider/RepositoryProvider.dart';
import 'package:gemographyMobileChallenge/Views/Components/RepoItem.dart';
import 'package:gemographyMobileChallenge/main.dart';
import 'package:provider/provider.dart';

class TrendingPage extends StatefulWidget {
  @override
  _TrendingPageState createState() => _TrendingPageState();
}

class _TrendingPageState extends State<TrendingPage> {
  ScrollController scrollController = ScrollController();
  Repositories repositories = Repositories();
  List<Repository> reposList = [];

  @override
  void initState() {
    super.initState();
    scrollController.addListener(() {
      if (scrollController.position.pixels ==
          scrollController.position.maxScrollExtent) {
        fetchNewRepos();
      }
    });
  }

  void fetchNewRepos() async {
    pageNumber += 1;
    await repositories.fetchRepos(context);
  }

  @override
  void dispose() {
    super.dispose();
    scrollController.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Consumer<RepoProvider>(
          builder: (context, repoProvider, child) {
            reposList = [
              ...reposList,
              ...repoProvider.repositoryModel.repositories
            ];
            return ListView.builder(
                controller: scrollController,
                itemCount: reposList.length,
                itemBuilder: (_, index) {
                  Repository repository = reposList[index];
                  return RepositoryItem(
                    repoName: repository.name,
                    description: repository.description,
                    ownerAvatar: repository.owner.avatarUrl,
                    ownerName: repository.owner.login,
                    score: repository.score,
                  );
                });
          },
        ),
      ),
    );
  }
}
