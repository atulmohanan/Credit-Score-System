import 'package:credit_score/admin/addloan.dart';
import 'package:credit_score/admin/admin.dart';
import 'package:credit_score/admin/adminprofile.dart';
import 'package:credit_score/customer/customer.dart';
import 'package:credit_score/admin/viewcustomer.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class UpdateCustomerScreen extends StatefulWidget {
  const UpdateCustomerScreen({super.key});

  @override
  State<UpdateCustomerScreen> createState() => _UpdateCustomerScreenState();
}

class _UpdateCustomerScreenState extends State<UpdateCustomerScreen> {
  final CollectionReference customer =
      FirebaseFirestore.instance.collection('customer');

  TextEditingController _noofloansController = TextEditingController();
  TextEditingController _loanpayfailureController = TextEditingController();
  int? cibil;

  void updateCustomer(docId) {
    final data = {
      'Noofloans': _noofloansController.text,
      'Loanfailure': _loanpayfailureController.text,
      'cibil': cibil,
    };
    customer.doc(docId).update(data);
  }

  @override
  Widget build(BuildContext context) {
    final args = ModalRoute.of(context)!.settings.arguments as Map;
    _noofloansController.text = args['Noofloans'];
    _loanpayfailureController.text = args['Loanfailure'];
    final docId = args['id'];

    return Scaffold(
      appBar: AppBar(
        title: Text('Update Customer'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(15.0),
        child: SingleChildScrollView(
          child: Column(
            children: [
              const SizedBox(
                height: 30,
              ),
              TextField(
                controller: _noofloansController,
                keyboardType: TextInputType.number,
                decoration: InputDecoration(
                    labelText: "No of Loans Taken",
                    border: OutlineInputBorder()),
              ),
              const SizedBox(
                height: 30,
              ),
              TextField(
                controller: _loanpayfailureController,
                keyboardType: TextInputType.number,
                decoration: InputDecoration(
                    labelText: "Loan Failures", border: OutlineInputBorder()),
              ),
              const SizedBox(
                height: 10,
              ),
              SizedBox(
                width: double.infinity,
                height: 40,
                child: ElevatedButton(
                  onPressed: () {
                    Navigator.push(context,
                        MaterialPageRoute(builder: (context) => AddLoan()));
                  },
                  child: Text(
                    'Add Loan(optional)',
                    style: TextStyle(fontSize: 20),
                  ),
                ),
              ),
              SizedBox(
                height: 20,
              ),
              SizedBox(
                width: double.infinity,
                height: 40,
                child: ElevatedButton(
                  onPressed: () {
                    showDialog(
                      context: context,
                      builder: (ctx) => AlertDialog(
                        title: const Text("Updated Successfully"),
                        content: const Text(
                            "Customer details have been updated successfully"),
                        actions: <Widget>[
                          TextButton(
                            onPressed: () {
                              Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                      builder: (context) =>
                                          ViewCustomerScreen()));
                            },
                            child: Container(
                              color: Colors.green,
                              padding: const EdgeInsets.all(14),
                              child: const Text(
                                "Okay",
                                style: TextStyle(color: Colors.white),
                              ),
                            ),
                          ),
                        ],
                      ),
                    );
                    int loans = int.parse(_noofloansController.text);
                    int delay = int.parse(_loanpayfailureController.text);
                    if (loans < 1) {
                      cibil = -1;
                    } else if (loans == 1) {
                      cibil = 306;
                    } else if (loans > 1 && loans < 16) {
                      cibil = 306 + (loans - 1) * 38;
                    } else {
                      cibil = 900;
                    }
                    if (delay == 0) {
                      cibil = cibil! - 0;
                    } else {
                      cibil = cibil! - delay * 19;
                    }
                    print(cibil);
                    updateCustomer(docId);
                  },
                  child: Text(
                    'Update',
                    style: TextStyle(fontSize: 25),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
