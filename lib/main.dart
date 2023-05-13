import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'register.dart';
import 'userModel.dart';
import 'token_manager.dart';
import 'package:shared_preferences/shared_preferences.dart';
import './loginUser.dart';
import 'homePage.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  // Get the token stored in the SharedPreferences
  SharedPreferences prefs = await SharedPreferences.getInstance();
  TokenManager tokenManager = TokenManager();
  String? token = await tokenManager.getToken();

  // Set the initial page based on whether the token exists or not
  Widget initialPage;
  if (token != null && token.isNotEmpty) {
    initialPage = HomePage();
    print(token);
  } else {
    initialPage = LoginPage();
  }

  runApp(
    ChangeNotifierProvider(
      create: (context) => UserModel(),
      child: MyApp(initialPage: initialPage),
    ),
  );
}

class MyApp extends StatelessWidget {
  final Widget initialPage;

  const MyApp({Key? key, required this.initialPage}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
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
