import 'package:flutter/material.dart';
import 'homePage.dart';
import 'register.dart';
import 'token_manager.dart';
import 'package:shared_preferences/shared_preferences.dart';

import 'loginUser.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  // Get the token stored in the SharedPreferences
  SharedPreferences prefs = await SharedPreferences.getInstance();
  String? token = await TokenManager().getToken();

  // Set the initial page based on whether the token exists or not
  Widget initialPage;
  if (token != null && token.isNotEmpty) {
    initialPage = HomePage();
    print(token);
  } else {
    initialPage = LoginPage();
  }

  runApp(MyApp(initialPage: initialPage));
}


class MyApp extends StatelessWidget {
  final Widget initialPage;

  const MyApp({Key? key, required this.initialPage}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'My App',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: initialPage,
      routes: {
        '/register': (context) => RegisterPage(),
        '/loginUser': (context) => LoginPage(),
      },
    );
  }
}