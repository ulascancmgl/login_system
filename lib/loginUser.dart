import 'package:provider/provider.dart';
import 'register.dart';
import 'userModel.dart';
import './homePage.dart';
import 'package:flutter/material.dart';
import './service.dart';

class LoginPage extends StatefulWidget {
  const LoginPage({Key? key}) : super(key: key);

  @override
  _LoginPageState createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  TextEditingController userNameController = TextEditingController();
  TextEditingController passwordController = TextEditingController();

  Service service = Service();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Login Page'),
      ),
      body: Container(
        padding: EdgeInsets.all(20),
        child: ListView(
          children: [
            Text('Username'),
            SizedBox(height: 5),
            TextField(
              controller: userNameController,
              decoration: InputDecoration(
                border: OutlineInputBorder(),
                hintText: 'Enter Username',
              ),
            ),
            SizedBox(height: 10),
            Text('Password'),
            SizedBox(
              height: 5,
            ),
            TextField(
              controller: passwordController,
              decoration: InputDecoration(
                border: OutlineInputBorder(),
                hintText: 'Enter Password',
              ),
              obscureText: true, // Set this to true to hide the password
            ),
            SizedBox(height: 10),
            ElevatedButton(
              onPressed: () async {
                var response = await service.loginUser(userNameController.text, passwordController.text);
                if (response.statusCode == 200) {
                  Provider.of<UserModel>(context, listen: false).setUserCredentials(
                    userNameController.text,
                    passwordController.text,
                  );// navigate to the home screen on successful login
                  Navigator.push(
                    context,
                    MaterialPageRoute(builder: (context) => HomePage()),
                  );
                } else {
                  // show an error message on failed login
                  ScaffoldMessenger.of(context).showSnackBar(SnackBar(
                    content: Text('Invalid username or password.'),
                  ));
                }
              },
              child: Text(
                'Login',
                style: TextStyle(
                  fontSize: 25,
                ),
              ),
            ),
            SizedBox(height: 10),
            TextButton(
              onPressed: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => RegisterPage()),
                );
              },
              child: Text(
                "Don't have an account?",
                style: TextStyle(
                  color: Colors.blue,
                  fontSize: 18,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
