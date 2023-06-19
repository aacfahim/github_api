import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:assignment/screens/home_page.dart';

class FirstPage extends StatelessWidget {
  final TextEditingController _usernameController = TextEditingController();

  void navigateToHomePage(BuildContext context) {
    final username = _usernameController.text.trim();
    if (username.isNotEmpty) {
      Get.to(() => HomePage(username));
    } else {
      print("Something went wrong");
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Enter Username'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: [
            TextField(
              controller: _usernameController,
              decoration: InputDecoration(
                labelText: 'Username',
              ),
            ),
            SizedBox(height: 16.0),
            ElevatedButton(
              onPressed: () => navigateToHomePage(context),
              child: Text('Submit'),
            ),
          ],
        ),
      ),
    );
  }
}
