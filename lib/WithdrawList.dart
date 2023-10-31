import 'dart:convert';
import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:login_project_sample/Models/PaymentHistoryModel.dart';
import 'package:login_project_sample/Models/PendingPaymentsModel.dart';
import 'package:login_project_sample/Wallet_n.dart';
import 'package:login_project_sample/utils/response_handler.dart';
import 'package:http/http.dart' as http;
import 'package:login_project_sample/utils/shared_preferences.dart';

void main() {
  runApp(WithdrawList());
}

class WithdrawList extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: TabViewExample(),
    );
  }
}

class TabViewExample extends StatefulWidget {
  @override
  _TabViewExampleState createState() => _TabViewExampleState();
}

class _TabViewExampleState extends State<TabViewExample>
    with SingleTickerProviderStateMixin {
  List<String> tabTitles = ['PAYMENT HISTORY', 'PENDING PAYMENT'];

  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: 2,
      child: Scaffold(
        appBar: AppBar(
          backgroundColor: Colors.white,
          leading: IconButton(
            icon: Icon(
              Icons.arrow_back,
              color: Colors.black,
            ),
            onPressed: () {
              Navigator.push(
                  context,
                  MaterialPageRoute(
                      builder: (BuildContext context) => Wallet_n()));
            },
          ),
          bottom: TabBar(
            indicatorColor: Color(0xFF007E01),
            labelColor: Colors.black,
            tabs: [
              Tab(
                text: ("PAYMENT HISTORY"),
              ),
              Tab(
                text: ("PENDING PAYMENT"),
              ),
            ],
            indicator: BoxDecoration(
              color: Color(0xFFF5F5F5), // Background color of the selected tab
              border: Border(
                bottom: BorderSide(
                  color: Color(0xFF007E01), // Indicator line color
                  width: 2.0, // Adjust the line thickness as needed
                ),
              ),
            ),
            unselectedLabelStyle: TextStyle(
              color: Colors.white, // Define the text color for unselected tabs
              fontSize: 16, // Define the text font size
              fontWeight: FontWeight.w500, // Define the text font weight
              // You can add other text style properties as needed
            ),
          ),
          title: Text(
            'Withdraw History',
            style: TextStyle(
                color: Colors.black, fontSize: 17, fontWeight: FontWeight.bold),
          ),
          titleSpacing: 15,
          leadingWidth: 30,
          actions: [
            Padding(
              padding: EdgeInsets.only(right: 16.0, bottom: 10),
              child: Image.asset(
                'assets/images/logor.jpg', // Replace 'your_image.png' with your image asset path
                width: 90,
                height: 35,
              ),
            ),
          ],
        ),
        body: TabBarView(
          children: [
            PaymentHistoryTab(),
            PendingPaymentsTab(),
          ],
        ),
      ),
    );
  }
}

class PaymentHistoryTab extends StatefulWidget {
  @override
  _PaymentHistoryTabState createState() => _PaymentHistoryTabState();
}

class _PaymentHistoryTabState extends State<PaymentHistoryTab> {
  static List<dynamic> decodedJson = [];
  @override
  static Future<List<PaymentHistoryModel>?> getPayment() async {
    String? memberId = await Prefs.getStringValue(Prefs.PREFS_USER_ID);
    List<PaymentHistoryModel> bookingCardData = [];
    Future<http.Response>? __futureLabels =
        ResponseHandler.performPost("GetPaymentHistory", "MemberId=$memberId");
    log('MemberId :' + memberId!);

    return await __futureLabels?.then((value) {
      String jsonResponse = ResponseHandler.parseData(value.body);
      log('jsonResponse :' + jsonResponse);
      try {
        //Map<String, dynamic> map = json.decode(jsonResponse);
        decodedJson = json.decode(jsonResponse);

        print('json : ${decodedJson}');

        for (int i = 0; i < decodedJson.length; i++) {
          PaymentHistoryModel fm = PaymentHistoryModel.fromJson(decodedJson[i]);
          bookingCardData.add(fm);
          //print('my FM: ${fm.Username}');
          //vanthu vanthu vanthuuuuu ta int strng thn thppa
        }
      } catch (error) {
        print('my error : ${error.toString()}');
        Fluttertoast.showToast(msg: error.toString());
      }
      return bookingCardData;
    });
  }

  Future<List<PaymentHistoryModel>?>? _Payments;
  void initState() {
    super.initState();

    _Payments = getPayment();
  }

  @override
  Widget build(BuildContext context) {
    return Center(
        child: FutureBuilder<List<PaymentHistoryModel>?>(
            future: _Payments,
            builder: (context, snapshot) {
              if (snapshot.connectionState == ConnectionState.waiting) {
                return CircularProgressIndicator(); // Show a loading indicator while data is loading.
              } else if (snapshot.hasError) {
                return Text("Error: ${snapshot.error}");
              } else if (snapshot.hasData && snapshot.data!.isNotEmpty) {
                // Data is available and not empty, display the list of records.
                return ListView.builder(
                  itemCount: snapshot.data!.length,
                  itemBuilder: (context, index) {
                    return Padding(
                        padding: const EdgeInsets.all(1.0),
                        child: Card(
                          margin: EdgeInsets.only(right: 10, left: 10, top: 7),
                          elevation: 5,
                          color: Colors.white,
                          child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Container(
                                  padding: EdgeInsets.all(10),
                                  child: Row(
                                    mainAxisAlignment: MainAxisAlignment.start,
                                    children: [
                                      Image(
                                        image: AssetImage(
                                          "assets/images/incomeiconpng.png",
                                        ),
                                        width: 70,
                                        height: 80,
                                        color: Colors.green,
                                      ),
                                      SizedBox(
                                        width: 5,
                                      ),
                                      Column(
                                        mainAxisAlignment:
                                            MainAxisAlignment.start,
                                        crossAxisAlignment:
                                            CrossAxisAlignment.start,
                                        children: [
                                          Text(snapshot.data![index].username,
                                              textAlign: TextAlign.end,
                                              //Text(snapshot.data![index].username,
                                              style: TextStyle(
                                                  fontSize: 16,
                                                  fontWeight: FontWeight.bold)),
                                          SizedBox(
                                            width: 100,
                                          ),
                                          SizedBox(
                                            height: 4,
                                          ),
                                          Row(
                                            children: [
                                              Text(
                                                snapshot.data![index].Message,
                                                textAlign: TextAlign.center,
                                                // Text(snapshot.data![index].message,
                                                style: TextStyle(
                                                    fontSize: 13,
                                                    fontWeight:
                                                        FontWeight.w500),
                                              ),
                                            ],
                                          ),
                                          SizedBox(
                                            height: 4.5,
                                          ),
                                          Row(
                                            children: [
                                              Container(
                                                decoration: BoxDecoration(
                                                  border: Border.all(
                                                      color: Colors.black),
                                                  borderRadius:
                                                      BorderRadius.circular(4),
                                                ),
                                                padding: EdgeInsets.symmetric(
                                                    horizontal: 6, vertical: 2),
                                                child: Text('WALLET',
                                                    style: TextStyle(
                                                        fontSize: 15,
                                                        fontWeight:
                                                            FontWeight.w500,
                                                        color:
                                                            Color(0xFF000C66))),
                                              ),
                                              SizedBox(
                                                width: 40,
                                              ),
                                              Image.asset(
                                                "assets/images/tickiconpng.png",
                                                cacheWidth: 15,
                                                cacheHeight: 15,
                                              ),
                                              Text(
                                                  textAlign: TextAlign.end,
                                                  snapshot
                                                      .data![index].Datecreated,
                                                  //Text(snapshot.data![index].username,
                                                  style: TextStyle(
                                                      fontSize: 15,
                                                      color: Colors.green,
                                                      fontWeight:
                                                          FontWeight.w500)),
                                            ],
                                          ),
                                          SizedBox(
                                            height: 4.5,
                                          ),
                                          Row(
                                            children: [
                                              Text(
                                                snapshot.data![index]
                                                    .CustomerName, // Text(snapshot.data![index].message,
                                                style: TextStyle(
                                                    fontSize: 15,
                                                    fontWeight:
                                                        FontWeight.w500),
                                              ),
                                            ],
                                          ),
                                        ],
                                      ),
                                    ],
                                  ),
                                ),
                                Row(
                                  children: [
                                    Container(
                                      height: 0,
                                      width:
                                          280, // Make the Divider span the full width
                                      child: Divider(
                                          thickness:
                                              2), // Divider after GridView
                                    ),
                                    Text(
                                      '  Amount',
                                      style: TextStyle(
                                          fontSize: 12,
                                          fontWeight: FontWeight.w500),
                                    ),
                                  ],
                                ),
                                Padding(
                                  padding:
                                      const EdgeInsets.only(bottom: 10, top: 4),
                                  child: Row(
                                    mainAxisAlignment: MainAxisAlignment.start,
                                    children: [
                                      SizedBox(
                                        width: 10,
                                      ),
                                      Image.asset(
                                        "assets/images/orderpng.png",
                                        cacheHeight: 12,
                                        cacheWidth: 12,
                                      ),
                                      Text(
                                        ' User ID: ',
                                        style: TextStyle(
                                            fontSize: 14,
                                            fontWeight: FontWeight.w500),
                                      ),
                                      SizedBox(
                                        width: 5,
                                      ),
                                      Text(
                                        snapshot.data![index].username,
                                        style: TextStyle(
                                            fontSize: 14,
                                            fontWeight: FontWeight.w500),
                                      ),
                                      SizedBox(width: 118),
                                      Text(
                                        snapshot.data![index].Debit,
                                        style: TextStyle(
                                            fontSize: 18,
                                            fontWeight: FontWeight.bold),
                                      ),
                                      // User Type on the left side
                                    ],
                                  ),
                                ),
                              ]),
                        ));
                  },
                );
              } else {
                // No data found, display "No Transfer Found" text.
                return Center(
                  child: Text("No Transfer Found"),
                );
              }
            }));
  }
}

class PendingPaymentsTab extends StatefulWidget {
  @override
  _PendingPaymentsTabState createState() => _PendingPaymentsTabState();
}

class _PendingPaymentsTabState extends State<PendingPaymentsTab> {
  static List<dynamic> decodedJson = [];
  static Future<List<PendingPaymentsModel>?> getPartPaymentData() async {
    String memberId = await Prefs.getStringValue(Prefs.PREFS_USER_ID);
    List<PendingPaymentsModel> bookingCardData = [];
    Future<http.Response>? __futureLabels = ResponseHandler.performPost(
        "GetPendingWithdrawfund", "MemberId=$memberId");

    return await __futureLabels?.then((value) {
      String jsonResponse = ResponseHandler.parseData(value.body);
      log(jsonResponse);
      try {
        //Map<String, dynamic> map = json.decode(jsonResponse);
        decodedJson = json.decode(jsonResponse);

        print('json : ${decodedJson}');

        for (int i = 0; i < decodedJson.length; i++) {
          PendingPaymentsModel fm =
              PendingPaymentsModel.fromJson(decodedJson[i]);
          bookingCardData.add(fm);
          //print('my FM: ${fm.Username}');
          //vanthu vanthu vanthuuuuu ta int strng thn thppa
        }
      } catch (error) {
        print('my error : ${error.toString()}');
        Fluttertoast.showToast(msg: error.toString());
      }
      return bookingCardData;
    });
  }

  Future<List<PendingPaymentsModel>?>? _futurePayments;

  @override
  void initState() {
    super.initState();
    _futurePayments = getPartPaymentData();
  }

  @override
  Widget build(BuildContext context) {
    return Center(
        child: FutureBuilder<List<PendingPaymentsModel>?>(
            future: _futurePayments,
            builder: (context, snapshot) {
              if (snapshot.connectionState == ConnectionState.waiting) {
                return CircularProgressIndicator(); // Show a loading indicator while data is loading.
              } else if (snapshot.hasError) {
                return Text("Error: ${snapshot.error}");
              } else if (snapshot.hasData && snapshot.data!.isNotEmpty) {
                // Data is available and not empty, display the list of records.
                return ListView.builder(
                  itemCount: snapshot.data!.length,
                  itemBuilder: (context, index) {
                    return Padding(
                        padding: const EdgeInsets.all(1.0),
                        child: Card(
                          margin: EdgeInsets.only(right: 10, left: 10, top: 10),
                          elevation: 5,
                          color: Colors.white,
                          child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Container(
                                  padding: EdgeInsets.all(8),
                                  child: Row(
                                    mainAxisAlignment: MainAxisAlignment.start,
                                    children: [
                                      Image(
                                        image: AssetImage(
                                          "assets/images/incomeiconpng.png",
                                        ),
                                        width: 70,
                                        height: 80,
                                        color: Colors.red,
                                      ),
                                      SizedBox(
                                        width: 14,
                                      ),
                                      Column(
                                        mainAxisAlignment:
                                            MainAxisAlignment.start,
                                        crossAxisAlignment:
                                            CrossAxisAlignment.start,
                                        children: [
                                          Text(snapshot.data![index].username,
                                              textAlign: TextAlign.end,
                                              //Text(snapshot.data![index].username,
                                              style: TextStyle(
                                                  fontSize: 14,
                                                  fontWeight: FontWeight.bold)),
                                          SizedBox(
                                            width: 100,
                                          ),
                                          SizedBox(
                                            height: 4,
                                          ),
                                          Row(
                                            children: [
                                              Text(
                                                snapshot
                                                    .data![index].CustomerName,
                                                textAlign: TextAlign.center,
                                                // Text(snapshot.data![index].message,
                                                style: TextStyle(
                                                    fontSize: 14,
                                                    fontWeight:
                                                        FontWeight.w500),
                                              ),
                                            ],
                                          ),
                                          SizedBox(
                                            height: 4.5,
                                          ),
                                          Row(
                                            children: [
                                              Container(
                                                decoration: BoxDecoration(
                                                  border: Border.all(
                                                      color: Colors.black),
                                                  borderRadius:
                                                      BorderRadius.circular(4),
                                                ),
                                                padding: EdgeInsets.symmetric(
                                                    horizontal: 6, vertical: 2),
                                                child: Text('PENDING',
                                                    style: TextStyle(
                                                        fontSize: 14,
                                                        fontWeight:
                                                            FontWeight.w500)),
                                              ),
                                              SizedBox(
                                                width: 40,
                                              ),
                                              Image.asset(
                                                "assets/images/tickiconpng.png",
                                                cacheWidth: 15,
                                                cacheHeight: 15,
                                              ),
                                              Text(
                                                  textAlign: TextAlign.end,
                                                  snapshot
                                                      .data![index].Datecreated,
                                                  //Text(snapshot.data![index].username,
                                                  style: TextStyle(
                                                      fontSize: 14,
                                                      color: Colors.green,
                                                      fontWeight:
                                                          FontWeight.w500)),
                                            ],
                                          ),
                                          SizedBox(
                                            height: 4.5,
                                          ),
                                          Row(
                                            children: [
                                              Text(
                                                snapshot.data![index]
                                                    .Message, // Text(snapshot.data![index].message,
                                                style: TextStyle(
                                                    fontSize: 14,
                                                    fontWeight:
                                                        FontWeight.w500),
                                              ),
                                            ],
                                          ),
                                        ],
                                      ),
                                    ],
                                  ),
                                ),
                                Row(
                                  children: [
                                    Container(
                                      height: 1,
                                      width:
                                          230, // Make the Divider span the full width
                                      child: Divider(
                                          thickness:
                                              2), // Divider after GridView
                                    ),
                                    Text(
                                      ' Withdraw Amount',
                                      style: TextStyle(
                                          fontSize: 12,
                                          fontWeight: FontWeight.w500),
                                    ),
                                  ],
                                ),
                                Padding(
                                  padding:
                                      const EdgeInsets.only(bottom: 10, top: 4),
                                  child: Row(
                                    mainAxisAlignment: MainAxisAlignment.start,
                                    children: [
                                      SizedBox(
                                        width: 10,
                                      ),
                                      Image.asset(
                                        "assets/images/orderpng.png",
                                        cacheHeight: 12,
                                        cacheWidth: 12,
                                      ),
                                      Text(
                                        ' User ID: ',
                                        style: TextStyle(
                                            fontSize: 14,
                                            fontWeight: FontWeight.w500),
                                      ),
                                      SizedBox(
                                        width: 5,
                                      ),
                                      Text(
                                        snapshot.data![index].username,
                                        style: TextStyle(
                                            fontSize: 14,
                                            fontWeight: FontWeight.w500),
                                      ),
                                      SizedBox(width: 100),
                                      Text(
                                        snapshot.data![index].Debit,
                                        style: TextStyle(
                                            fontSize: 18,
                                            fontWeight: FontWeight.bold),
                                      ),
                                      // User Type on the left side
                                    ],
                                  ),
                                ),
                              ]),
                        ));
                  },
                );
              } else {
                // No data found, display "No Transfer Found" text.
                return Center(
                  child: Text("No Transfer Found"),
                );
              }
            }));
  }
}
