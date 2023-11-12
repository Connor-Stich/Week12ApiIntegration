import 'package:flutter/material.dart';
import '../Repositories/UserClient.dart';
import 'addUserView.dart';

import '../Models/User.dart';

class UsersView extends StatefulWidget {
  
  final List<User> inUsers;
  UsersView({Key? key, required this.inUsers}) : super(key: key);

  @override
  State<UsersView> createState() => _UsersViewState(inUsers);
}

bool _loading = false;

class _UsersViewState extends State<UsersView> {
  _UsersViewState(users);

  final UserClient userClient = UserClient();

  void buttonAddPress() {
    Navigator.push(
            context,
            MaterialPageRoute(
                builder: ((context) => CreateUserPage())));
  }

  void buttonDeleteConfirm() async {
    try {
      //bool success = await userClient.deleteUser(id);
    }
    catch (error) {
      print(error);
      return null;
    }
  }

  late List<User> users = widget.inUsers;

  @override
  Widget build(BuildContext context) {
    return Container(
      child: Scaffold(
        appBar: AppBar(
          backgroundColor: Theme.of(context).colorScheme.inversePrimary,
          title: const Text("View Users"),
        ),
        body: SingleChildScrollView(
            child: Column(
          children: users.map((user) {
            return Padding(
              padding: EdgeInsets.all(3),
              child: Card(
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  children: <Widget>[
                    ListTile(
                      leading: Icon(Icons.person),
                      title: Text("Username: ${user.Username}"),
                      subtitle: Text("Auth Level: ${user.AuthLevel}"),
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.end,
                      children: <Widget>[
                        const SizedBox(width: 8),
                        TextButton(
                          child: DialogExample(),
                          onPressed: () {},
                        ),
                        const SizedBox(width: 8),
                      ],
                    ),
                  ],
                ),
              ),
            );
          }).toList(),
        ),),
        floatingActionButton: FloatingActionButton(
          onPressed: buttonAddPress,
          child: Text("Add"),
        ), 
      ),
    );
  }
}



class DialogExample extends StatelessWidget {
  const DialogExample({super.key});

  @override
  Widget build(BuildContext context) {
    return TextButton(
      onPressed: () => showDialog<String>(
        context: context,
        builder: (BuildContext context) => AlertDialog(
          title: const Text('Delete Confirmation'),
          content: const Text('Are you sure you want to delete this user?'),
          actions: <Widget>[
            TextButton(
              onPressed: () => Navigator.pop(context, 'Cancel'),
              child: const Text('Cancel'),              
            ),
            TextButton(
              onPressed: () => Navigator.pop(context, 'OK'),
              child: const Text('OK'),
            ),
          ],
        ),
      ),
      child: const Text('DELETE'),
    );
  }
}
