import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:todos_getx/auth/auth.controller.dart';

class AppDrawer extends StatelessWidget {
  final AuthController authController = AuthController.to;
  @override
  Widget build(BuildContext context) {
    FirebaseUser user = authController.user.value;
    return Drawer(
        child: ListView(
      children: <Widget>[
        DrawerHeader(
          decoration: BoxDecoration(
            color: Colors.blueGrey[500],
          ),
          child: Column(
            children: <Widget>[
              Container(
                height: 100,
                width: 100,
                decoration: BoxDecoration(
                  color: Colors.blue,
                  shape: BoxShape.circle,
                ),
              ),
              Padding(
                padding: const EdgeInsets.all(5.0),
                child: Text(
                  user.email,
                  style: TextStyle(
                    fontSize: 10,
                    color: Colors.white,
                  ),
                ),
              )
            ],
          ),
        ),
        ListTile(
          onTap: () {
            Get.offAllNamed("/");
          },
          title: Text("Switch to Snap Sell"),
          trailing: Icon(Icons.camera),
        ),
        Divider(),
        ListTile(
          onTap: () {
            Get.offAllNamed("/todos");
          },
          title: Text("Switch to Todo App"),
          trailing: Icon(Icons.swap_horizontal_circle),
        ),
        Divider(),
        ListTile(
          onTap: () {
            authController.handleSignOut();
          },
          title: Text("Logout"),
          trailing: Icon(Icons.exit_to_app),
        ),
        Divider(),
      ],
    ));
  }
}
