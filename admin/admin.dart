import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:credit_score/admin/addcustomer.dart';
import 'package:credit_score/admin/adminprofile.dart';
import 'package:credit_score/admin/viewcustomer.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

import 'package:credit_score/login.dart';

class admin extends StatelessWidget {
  User user;
  admin(this.user);

  FirebaseFirestore firestore = FirebaseFirestore.instance;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Text("Admin"),
          actions: [
            IconButton(
              onPressed: () {
                logout(context);
              },
              icon: Icon(
                Icons.logout,
              ),
            )
          ],
        ),
        body: Padding(
          padding: const EdgeInsets.all(30.0),
          child: ListView(children: [
            SizedBox(
              width: 5,
              height: 80,
              child: ElevatedButton(
                onPressed: () {
                  Navigator.push(context,
                      MaterialPageRoute(builder: (context) => AdminProfile()));
                },
                child: Text(
                  'Admin Profile',
                  style: TextStyle(fontSize: 20),
                ),
              ),
            ),
            SizedBox(
              height: 20,
            ),
            SizedBox(
              width: 80,
              height: 80,
              child: ElevatedButton(
                onPressed: () {
                  Navigator.push(
                      context,
                      MaterialPageRoute(
                          builder: (context) => AddCustomerScreen()));
                },
                child: Text(
                  'Add Customer',
                  style: TextStyle(fontSize: 20),
                ),
              ),
            ),
            SizedBox(
              height: 20,
            ),
            SizedBox(
              width: 80,
              height: 80,
              child: ElevatedButton(
                  onPressed: () {
                    Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: (context) => ViewCustomerScreen()));
                  },
                  child: Text(
                    'Modify Customers',
                    style: TextStyle(fontSize: 20),
                  )),
            ),
            SizedBox(
              height: 20,
            ),
          ]),
        ));
  }

  Future<void> logout(BuildContext context) async {
    CircularProgressIndicator();
    await FirebaseAuth.instance.signOut();
    Navigator.pushReplacement(
      context,
      MaterialPageRoute(
        builder: (context) => LoginPage(),
      ),
    );
  }
}
