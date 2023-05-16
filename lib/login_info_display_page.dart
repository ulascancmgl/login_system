import 'package:flutter/material.dart';
import '/update_password.dart';
import '/user_model.dart';

class LoginInfoDisplayPage extends StatefulWidget {
  @override
  _LoginInfoDisplayPageState createState() => _LoginInfoDisplayPageState();
}

class _LoginInfoDisplayPageState extends State<LoginInfoDisplayPage> {
  final UserModel _userModel = UserModel();

  @override
  void initState() {
    super.initState();
    _fetchLoginInfo();
  }

  Future<void> _fetchLoginInfo() async {
    final username = await _userModel.getUserNames() ?? "";

    setState(() {
      _userModel.userName = username;
    });
  }

  void _navigateToUpdatePasswordPage(BuildContext context) {
    Navigator.push(
      context,
      MaterialPageRoute(builder: (context) => UpdatePasswordPage()),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Login Info Display'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              'Login Information',
              style: TextStyle(
                fontSize: 20,
                fontWeight: FontWeight.bold,
              ),
            ),
            Divider(),
            ListTile(
              title: Text('Username'),
              subtitle: Text(
                _userModel.userName ?? '',
                style: TextStyle(
                  fontSize: 18,
                ),
              ),
            ),
            ListTile(
              title: Text('Password'),
              subtitle: Text(
                '********',
                style: TextStyle(
                  fontSize: 18,
                ),
              ),
            ),
            SizedBox(height: 16),
            ElevatedButton(
              onPressed: () => _navigateToUpdatePasswordPage(context),
              child: Text('Update Password'),
            ),
          ],
        ),
      ),
    );
  }
}
