import 'dart:async';
import 'dart:convert';
import 'package:http/http.dart' as http;
import '/user_model.dart';
import './token_manager.dart';
import 'constants.dart';

class Service {
  final TokenManager _tokenManager = TokenManager();
  final UserModel _userModel = UserModel();
  //create the method to save user

  Future<http.Response> saveUser(
      String userName, String password, String role) async {
    //create uri
    var uri = Uri.parse("$baseUrl/api/register/user");
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
    var uri =
        Uri.parse("$baseUrl/api/login?userName=$userName&password=$password");
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
      await _userModel.storeUserName(userName);
    }

    return response;
  }

  Future<http.Response> updateUser(String userName, String firstName,
      String lastName, String birthDate, String gender) async {
    var uri = Uri.parse("$baseUrl/api/$userName/info");
    Map<String, String> headers = {"Content-Type": "application/json"};
    Map<String, String> data = {
      "firstName": firstName,
      "lastName": lastName,
      "birthDate": birthDate,
      "gender": gender
    };
    var body = json.encode(data);

    // Send a PATCH request to update the user info
    var patchResponse = await http.patch(uri, headers: headers, body: body);

    if (patchResponse.statusCode != 200) {
      // User info doesn't exist, send a POST request to create it
      var postResponse = await http.post(uri, headers: headers, body: body);
      print("${postResponse.body}");
      return postResponse;
    } else {
      // User info updated successfully
      print("${patchResponse.body}");
      return patchResponse;
    }
  }

  Future<UserInfoDto?> getUserInfo(String userName) async {
    var uri = Uri.parse("$baseUrl/api/$userName/info");
    var response = await http.get(uri);

    if (response.statusCode == 200) {
      var jsonResponse = json.decode(response.body);
      var userInfoDto = UserInfoDto.fromJson(jsonResponse);
      userInfoDto.age = calculateAge(
          userInfoDto.birthDate); // Set the age using a helper function
      return userInfoDto;
    } else if (response.statusCode == 404) {
      return null;
    } else {
      throw Exception('Failed to retrieve user info');
    }
  }

  Future<http.Response> deleteUser(String userName) async {
    // Create URI
    var uri = Uri.parse("$baseUrl/api/deleteUser/$userName");
    // Send the request
    var response = await http.delete(uri);

    // Print the response body
    print("${response.body}");

    return response;
  }

  Future<String> updateUserPassword(
      String userName, String currentPassword, String newPassword) async {
    var uri = Uri.parse('$baseUrl/api/updatePassword/$userName');
    Map<String, String> headers = {'Content-Type': 'application/json'};
    Map<String, String> data = {
      'currentPassword': currentPassword,
      'newPassword': newPassword,
    };
    var body = jsonEncode(data);

    var response = await http.put(uri, headers: headers, body: body);

    if (response.statusCode == 200) {
      // Password updated successfully
      return 'Password updated successfully';
    } else {
      // Failed to update password
      return 'Failed to update password';
    }
  }

  int calculateAge(String birthDate) {
    DateTime now = DateTime.now();
    DateTime dateOfBirth = DateTime.parse(birthDate);

    int age = now.year - dateOfBirth.year;

    // Check if the birthday hasn't occurred yet this year
    if (now.month < dateOfBirth.month ||
        (now.month == dateOfBirth.month && now.day < dateOfBirth.day)) {
      age--;
    }

    return age;
  }
}

class UserInfoDto {
  String firstName;
  String lastName;
  String birthDate;
  String gender;
  int age;

  UserInfoDto({
    required this.firstName,
    required this.lastName,
    required this.birthDate,
    required this.gender,
    required this.age,
  });

  factory UserInfoDto.fromJson(Map<String, dynamic> json) {
    return UserInfoDto(
      firstName: json['firstName'],
      lastName: json['lastName'],
      birthDate: json['birthDate'],
      gender: json['gender'],
      age: 0, // Set a default value for age
    );
  }
}
