import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:assignment/screens/repository_details_page.dart';
import 'package:assignment/services/github_service.dart' as service;
import 'package:assignment/model/repository.dart';

class HomePage extends StatefulWidget {
  final String username;

  HomePage(this.username);

  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  final service.GitHubService _gitHubService = service.GitHubService();
  final RxList<Repository> repositories = <Repository>[].obs;
  final RxBool isGridView = true.obs;
  final RxString filter = ''.obs;
  final GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey<ScaffoldState>();
  final RxBool isDarkMode = false.obs; // Add the RxBool for dark mode

  @override
  void initState() {
    super.initState();
    fetchRepositories();
  }

  Future<void> fetchRepositories() async {
    try {
      final List<Repository> repos =
          await _gitHubService.getRepositories(widget.username);
      repositories.assignAll(repos);
    } catch (e) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text('Failed to fetch repos'),
        ),
      );
    }
  }

  void navigateToRepositoryDetails(Repository repository) {
    Get.to(() => RepositoryDetailsPage(repository));
  }

  void toggleTheme() {
    isDarkMode.value = !isDarkMode.value; // Toggle the dark mode value
    Get.changeThemeMode(isDarkMode.value
        ? ThemeMode.dark
        : ThemeMode.light); // Apply the updated theme mode
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      key: _scaffoldKey,
      appBar: AppBar(
        title: Text('GitHub Repositories'),
      ),
      body: Column(
        children: [
          Padding(
            padding: const EdgeInsets.all(16.0),
            child: Row(
              children: [
                Text('View Mode:'),
                Obx(
                  () => Switch(
                    value: isGridView.value,
                    onChanged: (value) => isGridView.value = value,
                  ),
                ),
              ],
            ),
          ),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 16.0),
            child: TextField(
              onChanged: (value) => filter.value = value,
              decoration: InputDecoration(
                labelText: 'Filter',
              ),
            ),
          ),
          SizedBox(height: 16.0),
          Expanded(
            child: Obx(
              () {
                final filteredRepos = repositories
                    .where((repo) =>
                        repo.name.toLowerCase().contains(filter.value))
                    .toList();

                return isGridView.value
                    ? GridView.builder(
                        gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                          crossAxisCount: 2,
                        ),
                        itemCount: filteredRepos.length,
                        itemBuilder: (context, index) {
                          final repository = filteredRepos[index];
                          return GestureDetector(
                            onTap: () =>
                                navigateToRepositoryDetails(repository),
                            child: Card(
                              child: Center(
                                child: Text(
                                  repository.name,
                                  style: TextStyle(
                                    color: isDarkMode.value
                                        ? Colors.white
                                        : Colors.black,
                                  ),
                                ),
                              ),
                            ),
                          );
                        },
                      )
                    : ListView.builder(
                        itemCount: filteredRepos.length,
                        itemBuilder: (context, index) {
                          final repository = filteredRepos[index];
                          return ListTile(
                            onTap: () =>
                                navigateToRepositoryDetails(repository),
                            title: Text(
                              repository.name,
                              style: TextStyle(
                                color: isDarkMode.value
                                    ? Colors.white
                                    : Colors.black,
                              ),
                            ),
                          );
                        },
                      );
              },
            ),
          ),
        ],
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: toggleTheme, // Call the toggleTheme method
        child: Icon(Icons.brightness_4), // Use the theme toggle icon
      ),
    );
  }
}
