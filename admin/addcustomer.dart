import 'package:credit_score/admin/admin.dart';
import 'package:credit_score/admin/adminprofile.dart';
import 'package:credit_score/customer/customer.dart';
import 'package:credit_score/admin/viewcustomer.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class AddCustomerScreen extends StatefulWidget {
  const AddCustomerScreen({super.key});

  @override
  State<AddCustomerScreen> createState() => _AddCustomerScreenState();
}

class _AddCustomerScreenState extends State<AddCustomerScreen> {
  final CollectionReference customer =
      FirebaseFirestore.instance.collection('customer');

  TextEditingController _custidController = TextEditingController();
  TextEditingController _nameController = TextEditingController();
  TextEditingController _dobController = TextEditingController();
  TextEditingController _addressController = TextEditingController();
  TextEditingController _phonenoController = TextEditingController();
  TextEditingController _emailController = TextEditingController();
  TextEditingController _aadharController = TextEditingController();
  TextEditingController _pannoController = TextEditingController();
  TextEditingController _noofloansController = TextEditingController();
  TextEditingController _loanpayfailureController = TextEditingController();
  int? cibil;

  void addCustomer() {
    final data = {
      'Aadhar': _aadharController.text,
      'Address': _addressController.text,
      'CustomerId': _custidController.text,
      'DOB': _dobController.text,
      'Email': _emailController.text,
      'Loanfailure': _loanpayfailureController.text,
      'Name': _nameController.text,
      'Noofloans': _noofloansController.text,
      'Pan': _pannoController.text,
      'cibil': cibil,
    };
    customer.add(data);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Add Customer'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(15.0),
        child: SingleChildScrollView(
          child: Column(
            children: [
              TextField(
                controller: _custidController,
                decoration: InputDecoration(
                    labelText: "Customer ID", border: OutlineInputBorder()),
              ),
              const SizedBox(height: 30),
              TextField(
                controller: _nameController,
                decoration: InputDecoration(
                    labelText: "Name", border: OutlineInputBorder()),
              ),
              const SizedBox(
                height: 30,
              ),
              TextField(
                controller: _dobController,
                decoration: InputDecoration(
                  icon: Icon(Icons.calendar_today_rounded),
                  labelText: "DOB",
                  border: OutlineInputBorder(),
                ),
                onTap: () async {
                  DateTime? pickeddate = await showDatePicker(
                      context: context,
                      initialDate: DateTime.now(),
                      firstDate: DateTime(1920),
                      lastDate: DateTime(2029));

                  if (pickeddate != null) {
                    String formattedDate =
                        DateFormat("yyyy-MM-dd").format(pickeddate);
                    setState(() {
                      _dobController.text = formattedDate.toString();
                    });
                  }
                },
              ),
              const SizedBox(
                height: 30,
              ),
              TextFormField(
                minLines: 2,
                maxLines: 5,
                keyboardType: TextInputType.multiline,
                controller: _addressController,
                decoration: InputDecoration(
                    labelText: "Address", border: OutlineInputBorder()),
              ),
              const SizedBox(
                height: 30,
              ),
              TextField(
                controller: _emailController,
                decoration: InputDecoration(
                    labelText: "Email", border: OutlineInputBorder()),
              ),
              const SizedBox(
                height: 30,
              ),
              TextField(
                controller: _aadharController,
                decoration: InputDecoration(
                    labelText: "Aadhar", border: OutlineInputBorder()),
              ),
              const SizedBox(
                height: 30,
              ),
              TextField(
                controller: _pannoController,
                decoration: InputDecoration(
                    labelText: "Pan No", border: OutlineInputBorder()),
              ),
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
                height: 30,
              ),
              ElevatedButton(
                onPressed: () {
                  showDialog(
                    context: context,
                    builder: (ctx) => AlertDialog(
                      title: const Text("Added Successfully"),
                      content: const Text("New Customer have been added"),
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
                    cibil = 602;
                  } else if (loans > 1 && loans < 16) {
                    cibil = 602 + (loans - 1) * 18;
                  } else {
                    cibil = 900;
                  }
                  if (delay == 0) {
                    cibil = cibil! - 0;
                  } else {
                    cibil = cibil! - delay * 19;
                  }
                  print(cibil);
                  addCustomer();
                },
                child: Text('Submit'),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
