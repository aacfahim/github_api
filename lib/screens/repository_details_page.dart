import 'package:flutter/material.dart';
import 'package:assignment/model/repository.dart';

class RepositoryDetailsPage extends StatelessWidget {
  final Repository repository;

  RepositoryDetailsPage(this.repository);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Repository Details'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              repository.name,
              style: TextStyle(
                fontSize: 20.0,
                fontWeight: FontWeight.bold,
              ),
            ),
            SizedBox(height: 16.0),
            Text(
              'Description: ${repository.description ?? "N/A"}',
              style: TextStyle(fontSize: 16.0),
            ),
            SizedBox(height: 8.0),
            Text(
              'Stars: ${repository.stargazersCount}',
              style: TextStyle(fontSize: 16.0),
            ),
            SizedBox(height: 8.0),
            Text(
              'Forks: ${repository.forksCount}',
              style: TextStyle(fontSize: 16.0),
            ),
            SizedBox(height: 8.0),
          ],
        ),
      ),
    );
  }
}
