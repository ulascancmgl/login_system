import 'package:flutter/material.dart';
import '/login_widget.dart';
import '/token_manager.dart';
import '/user-info_page.dart';
import '/user_info_display_page.dart';
import '/user_model.dart';

import 'login_info_display_page.dart';

class HomePage extends StatelessWidget {
  final TokenManager _tokenManager = TokenManager();
  final UserModel _userModel = UserModel();

  Future<void> _logout(BuildContext context) async {
    // Show confirmation dialog
    bool confirmLogout = await showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text('Logout'),
          content: Text('Are you sure ?'),
          actions: [
            TextButton(
              onPressed: () {
                Navigator.of(context)
                    .pop(false); // Dismiss dialog and return false
              },
              child: Text('Cancel'),
            ),
            TextButton(
              onPressed: () {
                Navigator.of(context)
                    .pop(true); // Dismiss dialog and return true
              },
              child: Text('Logout'),
            ),
          ],
        );
      },
    );

    if (confirmLogout == true) {
      // Delete the token
      await _tokenManager.deleteToken();
      String userName = await _userModel.getUserNames();
      await _userModel.deleteUserName(userName);
      print(userName);

      // Navigate to the login page
      Navigator.pushReplacement(
        context,
        MaterialPageRoute(
          builder: (context) => Scaffold(
            body: LoginWidget(
              onLogin: (username, password) {},
              onSuccess: () {},
            ),
          ),
        ),
      );
    }
  }

  void _redirectToUserInfo(BuildContext context) {
    // Navigate to the UserInfo page
    // Replace `UserInfoPage()` with the actual UserInfo page widget
    Navigator.push(
      context,
      MaterialPageRoute(builder: (context) => UserInfoPage()),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Home'),
        automaticallyImplyLeading: false, // Disable the back button
        actions: [
          PopupMenuButton(
            itemBuilder: (BuildContext context) => [
              PopupMenuItem(
                value: 'userInfo',
                child: Text('User Info'),
              ),
              PopupMenuItem(
                value: 'userDisplay',
                child: Text('User Display'),
              ),
              PopupMenuItem(
                value: 'loginDisplay',
                child: Text('Login Display'),
              ),
              PopupMenuItem(
                value: 'logout',
                child: Text('Logout'),
              ),
            ],
            onSelected: (value) async {
              if (value == 'logout') {
                _logout(context);
              } else if (value == 'userInfo') {
                _redirectToUserInfo(context);
              } else if (value == 'userDisplay') {
                String userName = await _userModel.getUserNames() ?? '';
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) =>
                        UserInfoDisplayPage(userName: userName),
                  ),
                );
              } else if (value == 'loginDisplay') {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => LoginInfoDisplayPage(),
                  ),
                );
              }
            },
          ),
        ],
      ),
      body: Center(
        child: Text(
          'Welcome',
          style: TextStyle(fontSize: 24),
        ),
      ),
    );
  }
}
