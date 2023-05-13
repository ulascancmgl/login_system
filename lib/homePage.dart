import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'register.dart';
import 'token_manager.dart';
import 'userModel.dart';
import 'userpage2.dart';
import 'loginUser.dart';

class HomePage extends StatelessWidget {
  final TokenManager _tokenManager = TokenManager();
  @override
  Widget build(BuildContext context) {
    final user = Provider.of<UserModel>(context);
    return Scaffold(
      appBar: AppBar(
        title: Text('Home Page'),
        actions: [
          Padding(
            padding: EdgeInsets.only(right: 5.0),
            child: IconButton(
              icon: Icon(Icons.settings),
              onPressed: () {
                // Ayarlar sayfasına yönlendirme
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => RegisterPage()),
                );
              },
            ),
          ),
        ],
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            ElevatedButton(
              onPressed: () {

                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => UserPage()),
                );
              },
              style: ElevatedButton.styleFrom(
                padding: EdgeInsets.symmetric(horizontal: 150),
              ),
              child: Text('User Page'),
            ),
            SizedBox(height: 25),
            ElevatedButton(
              onPressed: () {
                // Üçüncü sayfaya yönlendirme
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => RegisterPage()),
                );
              },
              style: ElevatedButton.styleFrom(
                padding: EdgeInsets.symmetric(horizontal: 150),
              ),
              child: Text('Sayfa 2'),
            ),
            SizedBox(height: 25),
            ElevatedButton(
              onPressed: () {
                // Üçüncü sayfaya yönlendirme
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => RegisterPage()),
                );
              },
              style: ElevatedButton.styleFrom(
                padding: EdgeInsets.symmetric(horizontal: 150),
              ),
              child: Text('Sayfa 3'),
            ),
          ],
        ),
      ),
      floatingActionButton: SizedBox(
        height: 50,
        child: FloatingActionButton(
          onPressed: () async {
            await _tokenManager.deleteToken();

            Navigator.pushReplacement(
              context,
              MaterialPageRoute(builder: (context) => LoginPage()),
            );
          },
          child: Icon(Icons.logout),
        ),
      ),
    );
  }
}
