import 'dart:async';
import 'dart:convert';
import 'package:http/http.dart' as http;
import './token_manager.dart';



class Service {
  final TokenManager _tokenManager = TokenManager();
  //create the method to save user

  Future<http.Response> saveUser(
      String userName, String password, String role) async {
    //create uri
    var uri = Uri.parse("http://{your-api-address}/api/register/user");
    //header
    Map<String, String> headers = {"Content-Type": "application/json"};
    //body
    Map data = {
      'userName': '$userName',
      'password': '$password',
      'role': '$role',
    };
    //convert the above data into json
    var body = json.encode(data);
    var response = await http.post(uri, headers: headers, body: body);

    //print the response body
    print("${response.body}");

    return response;
  }

  Future<http.Response> loginUser(String userName, String password) async {
    var uri = Uri.parse(
        "http://{your-api-address}/api/login?userName=$userName&password=$password");
    Map<String, String> headers = {"Content-Type": "application/json"};
    Map data = {
      'userName': '$userName',
      'password': '$password',
    };
    var body = json.encode(data);
    var response = await http.post(uri, headers: headers, body: body);

    if (response.statusCode == 200) {
      // Extract the JWT token from the response body
      String token = response.body;

      // Store the JWT token in the TokenManager
      await _tokenManager.storeToken(token);
    }

    return response;
  }


  Future<http.Response> updateUser(String userName, String firstName, String lastName, String birthDate, String gender) async {

    var uri = Uri.parse(
        "http://{your-api-address}/api/$userName/info");
    Map<String, String> headers = {"Content-Type": "application/json"};
    Map data = {
      "firstName": '$firstName',
      "lastName": '$lastName',
      "birthDate": '$birthDate',
      "gender": '$gender'
    };
    var body = json.encode(data);
    var response = await http.post(uri, headers: headers, body: body);

    print("${response.body}");

    return response;
  }



}

