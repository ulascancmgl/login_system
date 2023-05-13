//
// import 'package:flutter/material.dart';
// import './service.dart';
//
// class userPage extends StatefulWidget {
//   const userPage({Key? key}) : super(key: key);
//
//   @override
//   _UserPageState createState() => _UserPageState();
// }
//
// class _UserPageState extends State<userPage> {
//   TextEditingController nameController = TextEditingController();
//   TextEditingController secondNameController = TextEditingController();
//   TextEditingController ssnController = TextEditingController();
//   Service service = Service();
//
//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: AppBar(
//         title: Text('User Page'),
//       ),
//       body: Container(
//         padding: EdgeInsets.all(20),
//         child: ListView(
//           children: [
//             Text('Name'),
//             SizedBox(height: 5),
//             TextField(
//               controller: nameController,
//               decoration: InputDecoration(
//                 border: OutlineInputBorder(),
//                 hintText: 'Enter name',
//               ),
//             ),
//             SizedBox(height: 10),
//             Text('Second name'),
//             SizedBox(
//               height: 5,
//             ),
//             TextField(
//               controller: secondNameController,
//               decoration: InputDecoration(
//                 border: OutlineInputBorder(),
//                 hintText: 'Enter secondname',
//               ),
//               obscureText: true, // Set this to true to hide the password
//             ),
//             SizedBox(height: 10),
//             Text('SSN'),
//             SizedBox(
//               height: 5,
//             ),
//             TextField(
//               controller: ssnController,
//               decoration: InputDecoration(
//                 border: OutlineInputBorder(),
//                 hintText: 'Enter ssn',
//               ),
//               obscureText: true, // Set this to true to hide the password
//             ),
//             SizedBox(height: 10),
//             ElevatedButton(
//               onPressed: () async {
//                 var response = await service.loginUser(userNameController.text, passwordController.text, ssnController.text);
//                 if (response.statusCode == 200) {
//                   // navigate to the home screen on successful login
//                   ScaffoldMessenger.of(context).showSnackBar(
//                     SnackBar(
//                       content: Text('İşlem başarılı'),
//                     ),
//                   );
//                 } else {
//                   // show an error message on failed login
//                   ScaffoldMessenger.of(context).showSnackBar(SnackBar(
//                     content: Text('İşlem başarısız'),
//                   ));
//                 }
//               },
//               child: Text(
//                 'Save',
//                 style: TextStyle(
//                   fontSize: 25,
//                 ),
//               ),
//             ),
//
//           ],
//         ),
//       ),
//     );
//   }
// }
