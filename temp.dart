import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter/src/widgets/placeholder.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:credit_score/customer/customer.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:credit_score/utilities/styling.dart';
import 'package:syncfusion_flutter_gauges/gauges.dart';

class customer extends StatefulWidget {
  const customer({super.key});

  @override
  State<customer> createState() => _customerState();
}

class _customerState extends State<customer> {
  final currentUser = FirebaseAuth.instance;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Text('Welcome'),
          backgroundColor: Colors.lightBlue,
        ),
        body: StreamBuilder(
            stream: FirebaseFirestore.instance
                .collection("customer")
                .where("Email", isEqualTo: currentUser.currentUser!.email)
                .snapshots(),
            builder: (context, AsyncSnapshot snapshot) {
              if (snapshot.hasData) {
                return ListView.builder(
                    itemCount: snapshot.data!.docs.length,
                    itemBuilder: (context, index) {
                      final DocumentSnapshot customerSnap =
                          snapshot.data.docs[index];
                      return Padding(
                        padding: const EdgeInsets.all(15.0),
                        child: SingleChildScrollView(
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: <Widget>[
                              SfRadialGauge(
                                axes: <RadialAxis>[
                                  RadialAxis(
                                    minimum: 300,
                                    maximum: 901,
                                    interval: 50,
                                    ranges: <GaugeRange>[
                                      GaugeRange(
                                        startValue: 300,
                                        endValue: 680,
                                        color: Colors.red,
                                      ),
                                      GaugeRange(
                                        startValue: 680,
                                        endValue: 730,
                                        color: Colors.orange,
                                      ),
                                      GaugeRange(
                                        startValue: 730,
                                        endValue: 770,
                                        color: Colors.yellow,
                                      ),
                                      GaugeRange(
                                        startValue: 770,
                                        endValue: 790,
                                        color: Colors.lightGreen,
                                      ),
                                      GaugeRange(
                                        startValue: 780,
                                        endValue: 900,
                                        color: Color.fromARGB(255, 3, 127, 7),
                                      ),
                                    ],
                                    pointers: <GaugePointer>[
                                      NeedlePointer(
                                        value: customerSnap['cibil'].toDouble(),
                                        enableAnimation: true,
                                        needleColor: Colors.blue,
                                        needleLength: 20,
                                        needleEndWidth: 10,
                                        animationDuration: 3000,
                                      )
                                    ],
                                    annotations: <GaugeAnnotation>[
                                      GaugeAnnotation(
                                        widget: Text(
                                            customerSnap['cibil'].toString(),
                                            style: TextStyle(
                                                color: Colors.black,
                                                fontWeight: FontWeight.bold)),
                                        positionFactor: 0.5,
                                        angle: 90,
                                      )
                                    ],
                                  )
                                ],
                              ),
                              Container(
                                width: double.infinity,
                                decoration: BoxDecoration(
                                    color: Color.fromARGB(255, 11, 179, 230)
                                        .withOpacity(1)),
                                child: Padding(
                                  padding: EdgeInsets.all(30),
                                  child: Column(
                                    mainAxisAlignment: MainAxisAlignment.center,
                                    children: [
                                      Row(
                                        children: [
                                          Text(
                                            'Hello, ',
                                            style: TextStyle(fontSize: 18),
                                          ),
                                          Text(
                                            customerSnap['Name'],
                                            style: TextStyle(
                                              fontSize: 18,
                                            ),
                                          ),
                                        ],
                                      ),
                                      SizedBox(
                                        height: 10,
                                      ),
                                      Row(
                                        children: [
                                          Text(
                                            'Customer Id: ',
                                            style: TextStyle(fontSize: 18),
                                          ),
                                          Text(
                                            customerSnap['CustomerId'],
                                            style: TextStyle(
                                              fontSize: 18,
                                            ),
                                          ),
                                        ],
                                      ),
                                      SizedBox(
                                        height: 10,
                                      ),
                                      Row(
                                        children: [
                                          Text(
                                            'Your Current Credit Score is ',
                                            style: TextStyle(fontSize: 18),
                                          ),
                                          Text(
                                            customerSnap['cibil'].toString(),
                                            style: TextStyle(
                                              fontSize: 18,
                                            ),
                                          ),
                                        ],
                                      ),
                                      SizedBox(
                                        height: 10,
                                      ),
                                    ],
                                  ),
                                ),
                              ),
                            ],
                          ),
                        ),
                      );
                    });
              }
              return StreamBuilder(
                  stream: FirebaseFirestore.instance
                      .collection("loans")
                      .where("email", isEqualTo: currentUser.currentUser!.email)
                      .snapshots(),
                  builder: (context, AsyncSnapshot snapshot) {
                    if (snapshot.hasData) {
                      return ListView.builder(
                          itemCount: snapshot.data!.docs.length,
                          itemBuilder: (context, index) {
                            final DocumentSnapshot loansSnap =
                                snapshot.data.docs[index];
                            return Padding(
                              padding: const EdgeInsets.all(15.0),
                              child: SingleChildScrollView(
                                child: Column(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceBetween,
                                  children: <Widget>[
                                    Container(
                                      width: double.infinity,
                                      decoration: BoxDecoration(
                                          borderRadius: AppTheme.borderRadius2,
                                          color:
                                              Color.fromARGB(255, 11, 179, 230)
                                                  .withOpacity(10)),
                                      child: Padding(
                                        padding: EdgeInsets.all(30),
                                        child: Column(
                                          mainAxisAlignment:
                                              MainAxisAlignment.center,
                                          children: [
                                            Row(
                                              children: [
                                                Text(
                                                  'Hello, ',
                                                  style:
                                                      TextStyle(fontSize: 18),
                                                ),
                                                Text(
                                                  loansSnap['Bank'],
                                                  style: TextStyle(
                                                    fontSize: 18,
                                                  ),
                                                ),
                                              ],
                                            ),
                                          ],
                                        ),
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                            );
                          });
                    }
                    return Container();
                  });
            }));
  }
}
