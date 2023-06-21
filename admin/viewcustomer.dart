import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:credit_score/admin/addcustomer.dart';
import 'package:credit_score/admin/adminprofile.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter/src/widgets/placeholder.dart';
import 'package:credit_score/admin/updatecustomer.dart';

class ViewCustomerScreen extends StatefulWidget {
  const ViewCustomerScreen({super.key});

  @override
  State<ViewCustomerScreen> createState() => _ViewCustomerScreenState();
}

class _ViewCustomerScreenState extends State<ViewCustomerScreen> {
  final CollectionReference customer =
      FirebaseFirestore.instance.collection('customer');

  void deleteCustomer(docId) {
    customer.doc(docId).delete();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('All Customers'),
        backgroundColor: Colors.blue,
        actions: [
          IconButton(
            onPressed: () {
              logout(context);
            },
            icon: Icon(
              Icons.home_filled,
            ),
          )
        ],
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          Navigator.push(context,
              MaterialPageRoute(builder: (context) => (AddCustomerScreen())));
        },
        backgroundColor: Colors.blue,
        child: Icon(
          Icons.add,
          size: 40,
        ),
      ),
      body: StreamBuilder(
          stream: customer.orderBy('cibil').snapshots(),
          builder: (context, AsyncSnapshot snapshot) {
            if (snapshot.hasData) {
              return ListView.builder(
                  itemCount: snapshot.data!.docs.length,
                  itemBuilder: (context, index) {
                    final DocumentSnapshot customerSnap =
                        snapshot.data.docs[index];
                    return Padding(
                      padding: const EdgeInsets.all(10.0),
                      child: Container(
                          height: 80,
                          decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(20),
                              color: Colors.white,
                              boxShadow: [
                                BoxShadow(
                                  color: Colors.grey,
                                  blurRadius: 10,
                                  spreadRadius: 15,
                                )
                              ]),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Padding(
                                padding: const EdgeInsets.all(8.0),
                                child: Container(
                                  child: CircleAvatar(
                                    backgroundColor: Colors.blue,
                                    radius: 30,
                                    child:
                                        Text(customerSnap['cibil'].toString()),
                                  ),
                                ),
                              ),
                              Column(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  Text(
                                    customerSnap['Name'],
                                    style: TextStyle(
                                        fontSize: 18,
                                        fontWeight: FontWeight.bold),
                                  ),
                                  Text(
                                    customerSnap['Pan'],
                                    style: TextStyle(fontSize: 18),
                                  ),
                                ],
                              ),
                              Row(
                                children: [
                                  IconButton(
                                    onPressed: () {
                                      Navigator.pushNamed(
                                        context,
                                        '/update',
                                        arguments: {
                                          'Noofloans':
                                              customerSnap['Noofloans'],
                                          'Loanfailure':
                                              customerSnap['Loanfailure'],
                                          'cibil': customerSnap['cibil'],
                                          'id': customerSnap.id,
                                        },
                                      );
                                    },
                                    icon: Icon(Icons.edit),
                                    iconSize: 30,
                                    color: Colors.blue,
                                  ),
                                  IconButton(
                                    onPressed: () async {
                                      await showDialog(
                                          context: context,
                                          builder: (BuildContext context) {
                                            return AlertDialog(
                                              title: Text("Please Confirm"),
                                              content: Text(
                                                  "Are you sure you want to delete this Customer?"),
                                              actions: [
                                                TextButton(
                                                    onPressed: () {
                                                      deleteCustomer(
                                                          customerSnap.id);
                                                      Navigator.pop(context);
                                                    },
                                                    child: Text("Yes")),
                                                TextButton(
                                                    onPressed: () {
                                                      Navigator.pop(context);
                                                    },
                                                    child: Text("No"))
                                              ],
                                            );
                                          });
                                    },
                                    icon: Icon(Icons.delete),
                                    iconSize: 30,
                                    color: Colors.red,
                                  ),
                                ],
                              )
                            ],
                          )),
                    );
                  });
            }
            return Container();
          }),
    );
  }

  Future<void> logout(BuildContext context) async {
    CircularProgressIndicator();
    await FirebaseAuth.instance.signOut();
    Navigator.pushReplacement(
      context,
      MaterialPageRoute(
        builder: (context) => AdminProfile(),
      ),
    );
  }
}
