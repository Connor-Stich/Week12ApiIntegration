import 'package:flutter/material.dart';

import '../Models/User.dart';

import '../Repositories/UserClient.dart';

import 'usersView.dart';



class CreateUserPage extends StatefulWidget {
  
  @override
  _CreateUserPageState createState() => _CreateUserPageState();
}

class _CreateUserPageState extends State<CreateUserPage> {

  UserClient userClient = UserClient();

  final TextEditingController usernameController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();
  final TextEditingController emailController = TextEditingController();
  final TextEditingController authLevelController = TextEditingController();

  void createUser() async {
    try {
      String username = usernameController.text;
      String password = passwordController.text;
      String email = emailController.text;
      String authLevel = authLevelController.text;

      
      bool success = await userClient.createUser(username, password, email, authLevel);

      if (success) {
        print('User Created');
        Navigator.pop(context);
      } else {
        print('User Creation Failed');
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text("User Created")),
        );
      }
    } catch (error) {
      print('Error in User Creation: $error');
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text("Error")),
      );
    }
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Create User'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            TextField(
              controller: usernameController,
              decoration: InputDecoration(hintText: 'Username'),
            ),
            TextField(
              controller: passwordController,
              decoration: InputDecoration(hintText: 'Password'),
            ),
            TextField(
              controller: emailController,
              decoration: InputDecoration(hintText: 'Email'),
            ),
            TextField(
              controller: authLevelController,
              decoration: InputDecoration(hintText: 'Auth Level'),
            ),
            ElevatedButton(
              onPressed: createUser,
              child: Text('Create User'),
            ),
          ],
        ),
      ),
    );
  }
}