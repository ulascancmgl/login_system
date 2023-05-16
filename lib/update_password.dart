import 'package:flutter/material.dart';
import '/service.dart';
import '/user_model.dart';

class UpdatePasswordPage extends StatelessWidget {
  final TextEditingController _currentPasswordController =
      TextEditingController();
  final TextEditingController _newPasswordController = TextEditingController();
  final UserModel _userModel = UserModel();
  final Service service = Service();

  void _updatePassword(BuildContext context) async {
    String currentPassword = _currentPasswordController.text;
    String newPassword = _newPasswordController.text;

    String username = await _userModel.getUserNames();

    // Call the service function to update the password
    var response = await service.updateUserPassword(
        username, currentPassword, newPassword);

    if (response == 'Password updated successfully') {
      // Password update successful
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Password updated successfully')),
      );

      // You can add navigation logic here to navigate back to the previous page
    } else {
      // Password update failed
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Failed to update password')),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Update Password'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              'Update Password',
              style: TextStyle(
                fontSize: 20,
                fontWeight: FontWeight.bold,
              ),
            ),
            Divider(),
            TextField(
              obscureText: true,
              controller: _currentPasswordController,
              decoration: InputDecoration(
                labelText: 'Current Password',
              ),
            ),
            TextField(
              obscureText: true,
              controller: _newPasswordController,
              decoration: InputDecoration(
                labelText: 'New Password',
              ),
            ),
            SizedBox(height: 16),
            ElevatedButton(
              onPressed: () => _updatePassword(context),
              child: Text('Update Password'),
            ),
          ],
        ),
      ),
    );
  }
}
