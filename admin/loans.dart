import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter/src/widgets/placeholder.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:credit_score/customer/customer.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:credit_score/utilities/styling.dart';
import 'package:syncfusion_flutter_gauges/gauges.dart';

class MyLoans extends StatefulWidget {
  const MyLoans({super.key});

  @override
  State<MyLoans> createState() => _MyLoansState();
}

class _MyLoansState extends State<MyLoans> {
  final currentUser = FirebaseAuth.instance;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: StreamBuilder<QuerySnapshot>(
            stream: FirebaseFirestore.instance
                .collection("loans")
                .where("Email", isEqualTo: currentUser.currentUser!.email)
                .snapshots(),
            builder: (context, AsyncSnapshot snapshot) {
              if (!snapshot.hasData) {
                return CircularProgressIndicator();
              }
              if (snapshot.hasData) {
                Map<String, dynamic> data = snapshot.data.data();
                return ListView.builder(
                    itemCount: snapshot.data!.docs.length,
                    itemBuilder: (context, index) {
                      final List<DocumentSnapshot> loansSnap =
                          snapshot.data.docs[index];
                      return Padding(
                        padding: const EdgeInsets.all(15.0),
                        child: SingleChildScrollView(
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: <Widget>[
                              Container(
                                width: double.infinity,
                                decoration: BoxDecoration(
                                    borderRadius: AppTheme.borderRadius2,
                                    color: Color.fromARGB(255, 11, 179, 230)
                                        .withOpacity(1)),
                                child: Padding(
                                  padding: EdgeInsets.all(30),
                                  child: Column(
                                      mainAxisAlignment:
                                          MainAxisAlignment.center,
                                      children: [
                                        DataTable(
                                          columns: [
                                            DataColumn(label: Text('Loan Id')),
                                            DataColumn(
                                                label: Text('Loan Date')),
                                            // Add more columns as needed
                                          ],
                                          rows: loansSnap
                                              .map(
                                                (doc) => DataRow(
                                                  cells: [
                                                    DataCell(Text(data['LoanId']
                                                        .toString())),
                                                    DataCell(Text(
                                                        data['LoanDate']
                                                            .toString())),
                                                    // Add more cells as needed
                                                  ],
                                                ),
                                              )
                                              .toList(),
                                        )
                                      ]),
                                ),
                              ),
                            ],
                          ),
                        ),
                      );
                    });
              }
              return Container();
            }));
  }
}
