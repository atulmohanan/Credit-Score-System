import 'package:credit_score/admin/admin.dart';
import 'package:credit_score/admin/adminprofile.dart';
import 'package:credit_score/customer/customer.dart';
import 'package:credit_score/admin/viewcustomer.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class AddLoan extends StatefulWidget {
  const AddLoan({super.key});

  @override
  State<AddLoan> createState() => _AddLoanstate();
}

class _AddLoanstate extends State<AddLoan> {
  final banks = [
    'State Bank of India',
    'ICICI Bank',
    'HDFC Bank',
    'Kotak Bank',
    'Axis Bank',
    'Canara Bank',
    'Bank of Baroda',
    'Other'
  ];
  String? selectedbank;
  final loantypes = [
    'Gold Loan',
    'Housing Loan',
    'Vehicle Loan',
    'Personal Loan',
    'Others'
  ];
  String? selectedloan;

  final CollectionReference loans =
      FirebaseFirestore.instance.collection('loans');

  TextEditingController _loanid = TextEditingController();
  TextEditingController _bank = TextEditingController();
  TextEditingController _loandate = TextEditingController();
  TextEditingController _principal = TextEditingController();
  TextEditingController _pending = TextEditingController();
  TextEditingController _loantype = TextEditingController();
  TextEditingController _custid = TextEditingController();

  void AddLoan() {
    final data = {
      'CustomerId': _custid.text,
      'Bank': selectedbank,
      'LoanDate': _loandate.text,
      'Principal': _principal.text,
      'Pending': _pending.text,
      'LoanType': selectedloan,
      'LoanId': _loanid.text,
    };
    loans.add(data);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Add Loan'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(15.0),
        child: SingleChildScrollView(
          child: Column(
            children: [
              const SizedBox(
                height: 4,
              ),
              TextField(
                controller: _custid,
                decoration: InputDecoration(
                    labelText: "Customer Id", border: OutlineInputBorder()),
              ),
              SizedBox(
                height: 30,
              ),
              TextField(
                controller: _loanid,
                decoration: InputDecoration(
                    labelText: "Loan Id", border: OutlineInputBorder()),
              ),
              const SizedBox(height: 30),
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: DropdownButtonFormField(
                    decoration: InputDecoration(label: Text("Select Bank")),
                    items: banks
                        .map((e) => DropdownMenuItem(
                              child: Text(e),
                              value: e,
                            ))
                        .toList(),
                    onChanged: (val) {
                      selectedbank = val as String?;
                    }),
              ),
              const SizedBox(
                height: 30,
              ),
              TextField(
                controller: _loandate,
                decoration: InputDecoration(
                  icon: Icon(Icons.calendar_today_rounded),
                  labelText: "Date",
                  border: OutlineInputBorder(),
                ),
                onTap: () async {
                  DateTime? pickeddate = await showDatePicker(
                      context: context,
                      initialDate: DateTime.now(),
                      firstDate: DateTime(2010),
                      lastDate: DateTime(2029));

                  if (pickeddate != null) {
                    String formattedDate =
                        DateFormat("yyyy-MM-dd").format(pickeddate);
                    setState(() {
                      _loandate.text = formattedDate.toString();
                    });
                  }
                },
              ),
              const SizedBox(
                height: 30,
              ),
              TextField(
                controller: _principal,
                decoration: InputDecoration(
                    labelText: "Principal Amount",
                    border: OutlineInputBorder()),
              ),
              const SizedBox(
                height: 30,
              ),
              TextField(
                controller: _pending,
                decoration: InputDecoration(
                    labelText: "Pending Amount", border: OutlineInputBorder()),
              ),
              const SizedBox(
                height: 30,
              ),
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: DropdownButtonFormField(
                    decoration: InputDecoration(label: Text("Loan Purpose")),
                    items: loantypes
                        .map((e) => DropdownMenuItem(
                              child: Text(e),
                              value: e,
                            ))
                        .toList(),
                    onChanged: (val) {
                      selectedloan = val as String?;
                    }),
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
                      content: const Text("New Loan have been added"),
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
                  AddLoan();
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
