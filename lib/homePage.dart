import 'package:flutter/material.dart';
import 'token_manager.dart';
import 'loginUser.dart';

class HomePage extends StatelessWidget {
  final TokenManager _tokenManager = TokenManager();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Home Page'),
      ),
      body: Center(
        child: Text('Welcome to the home screen!'),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () async {
          await _tokenManager.deleteToken();

          // LoginPage sayfasına geri dönün
          Navigator.pushReplacement(
            context,
            MaterialPageRoute(builder: (context) => LoginPage()),
          );
        },
        child: Icon(Icons.logout),
      ),
    );
  }
}