import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'userModel.dart';
import './service.dart';

class UserPage extends StatefulWidget {
  const UserPage({Key? key}) : super(key: key);

  @override
  _UserPageState createState() => _UserPageState();
}

class _UserPageState extends State<UserPage> {
  TextEditingController firstNameController = TextEditingController();
  TextEditingController lastNameController = TextEditingController();
  TextEditingController birthDateController = TextEditingController();
  TextEditingController genderController = TextEditingController();
  Service service = Service();
  List<String> enteredTexts = [];

  @override
  Widget build(BuildContext context) {
    final user = Provider.of<UserModel>(context);
    return Scaffold(
      appBar: AppBar(
        title: Text('User Page'),
      ),
      body: Container(
        padding: EdgeInsets.all(20),
        child: ListView(
          children: [
            Text('Firstname'),
            SizedBox(height: 5),
            TextField(
              controller: firstNameController,
              decoration: InputDecoration(
                border: OutlineInputBorder(),
                hintText: 'Enter name',
              ),
            ),
            SizedBox(height: 10),
            Text('Last name'),
            SizedBox(
              height: 5,
            ),
            TextField(
              controller: lastNameController,
              decoration: InputDecoration(
                border: OutlineInputBorder(),
                hintText: 'Enter secondname',
              ),
              obscureText: false, // Set this to true to hide the password
            ),
            SizedBox(height: 10),
            Text('Birthdate'),
            SizedBox(
              height: 5,
            ),
            TextField(
              controller: birthDateController,
              decoration: InputDecoration(
                border: OutlineInputBorder(),
                hintText: 'Enter ssn',
              ),
              obscureText: false, // Set this to true to hide the password
            ),
            Text('Gender'),
            SizedBox(
              height: 5,
            ),
            TextField(
              controller: genderController,
              decoration: InputDecoration(
                border: OutlineInputBorder(),
                hintText: 'Enter ssn',
              ),
              obscureText: false, // Set this to true to hide the password
            ),
            SizedBox(height: 10),
            ElevatedButton(
              onPressed: () async {
                var response = await service.updateUser(user.userName.toString(), firstNameController.text, lastNameController.text, birthDateController.text, genderController.text);
                if (response.statusCode == 200) {
                  // Add the entered text to the list
                  setState(() {
                    enteredTexts.add('${firstNameController.text} ${lastNameController.text} ${birthDateController.text} ${genderController.text}');
                  });
                  // show success message
                  ScaffoldMessenger.of(context).showSnackBar(
                    SnackBar(
                      content: Text('İşlem başarılı'),
                    ),
                  );
                } else {
                  // show an error message on failed login
                  ScaffoldMessenger.of(context).showSnackBar(SnackBar(
                    content: Text('İşlem başarısız'),
                  ));
                }
              },
              child: Text(
                'Save',
                style: TextStyle(
                  fontSize: 25,
                ),
              ),
            ),
            SizedBox(height: 10),
            // display entered text in a list
            Text('Entered Texts'),
            ListView.builder(
              shrinkWrap: true,
              itemCount: enteredTexts.length,
              itemBuilder: (context, index) {
                return ListTile(
                  title: Text(enteredTexts[index]),
                );
              },
            ),
          ],
        ),
      ),
    );
  }
}
