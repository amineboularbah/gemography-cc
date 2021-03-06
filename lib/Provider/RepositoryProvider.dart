import 'package:flutter/cupertino.dart';
import 'package:gemographyMobileChallenge/Models/Core/RepoModel.dart';
import 'package:gemographyMobileChallenge/Models/Services/githubRepoApi.dart';
import 'package:gemographyMobileChallenge/main.dart';

class RepoProvider extends ChangeNotifier {
  int pageNumber = 0;
  GithubRepoApi githubRepoApi = GithubRepoApi();
  // We will initialize the initialRepository to an object of RepositoryModel with empty array in its prop repositories
  RepositoryModel initialRepository = RepositoryModel(repositories: []);

  RepositoryModel get repositoryModel => initialRepository;

  set repositoryModel(RepositoryModel repository) {
    initialRepository = repository;
    // notifyListeners() will notify all the listeners with the changes that happened
    notifyListeners();
  }

  Future<void> fetchRepositories(FetchType type) async {
    type == FetchType.nextPage ? pageNumber++ : pageNumber = 1;
    print(pageNumber);
    repositoryModel = await githubRepoApi.getGithubRepos(pageNumber);
  }
}
