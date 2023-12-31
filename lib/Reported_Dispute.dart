import 'dart:convert';
import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:login_project_sample/Models/ReportedDisputeModel.dart';
import 'package:login_project_sample/utils/response_handler.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:http/http.dart' as http;
import 'package:login_project_sample/utils/shared_preferences.dart';

void main() {
  runApp(Reported_Dispute());
}

class Reported_Dispute extends StatelessWidget {
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
  late TabController _tabController;
  List<String> tabTitles = ['REPORTED', 'PROCESSING', 'CLOSED'];
  String memberId = '', Name = '', UserName = '';
  @override
  void initState() {
    _loadmemberid();
    //String userid = Prefs.getStringValue(Prefs.PREFS_USER_ID);

    super.initState();
  }

  Future<void> _loadmemberid() async {
    try {
      memberId = await Prefs.getStringValue(Prefs.PREFS_USER_ID);
      log("memberfhhjykkId" + memberId);
      UserName = await Prefs.getStringValue(Prefs.PREFS_USER_NAME);
      log("memberfhhtyyjykkId" + UserName);
      Name = await Prefs.getStringValue(Prefs.PREFS_NAME);
      log("memberfhhNameId" + Name);
    } catch (e) {
      print("Error: $e");
      Fluttertoast.showToast(msg: "An error occurred");
    }
  }

  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
        length: 3,
        child: Scaffold(
          appBar: AppBar(
            backgroundColor: Colors.white,
            leading: IconButton(
              icon: Icon(
                Icons.arrow_back,
                color: Colors.black,
              ),
              onPressed: () {
                Navigator.pop(context);
              },
            ),
            bottom: TabBar(
              indicatorColor: Color(0xFF007E01),
              labelColor: Colors.black,
              tabs: [
                Tab(
                  text: ("REPORTED"),
                ),
                Tab(
                  text: ("PROCESSING"),
                ),
                Tab(
                  text: ("CLOSED"),
                )
              ],
              indicator: BoxDecoration(
                color:
                    Color(0xFFF5F5F5), // Background color of the selected tab
                border: Border(
                  bottom: BorderSide(
                    color: Color(0xFF007E01), // Indicator line color
                    width: 2.0, // Adjust the line thickness as needed
                  ),
                ),
              ),
              unselectedLabelStyle: TextStyle(
                color:
                    Colors.white, // Define the text color for unselected tabs
                fontSize: 16, // Define the text font size
                fontWeight: FontWeight.w500, // Define the text font weight
                // You can add other text style properties as needed
              ),
            ),
            title: Column(
              children: [
                Text(
                  UserName,
                  style: TextStyle(
                      color: Colors.black,
                      fontSize: 17,
                      fontWeight: FontWeight.bold),
                ),
                SizedBox(
                  height: 5,
                  width: 5,
                ),
                Text(
                  Name,
                  style: TextStyle(
                      color: Colors.black,
                      fontSize: 17,
                      fontWeight: FontWeight.bold),
                ),
              ],
            ), titleSpacing: 15,
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
              CLosedDisputes(),
            ],
          ),
        ));
  }
}

class PaymentHistoryTab extends StatefulWidget {
  @override
  _PaymentHistoryTabState createState() => _PaymentHistoryTabState();
}

class _PaymentHistoryTabState extends State<PaymentHistoryTab> {
  static Future<List<ReportedDisputeModel>?> getPayment() async {
    String userid = await Prefs.getStringValue(Prefs.PREFS_USER_ID);

    List<ReportedDisputeModel> bookingCardData = [];
    Future<http.Response>? __futureLabels =
        ResponseHandler.performPost("ReportedDispute", "UserId=$userid");

    return await __futureLabels.then((value) {
      String jsonResponse = ResponseHandler.parseData(value.body);
      log(jsonResponse);
      try {
        //Map<String, dynamic> map = json.decode(jsonResponse);
        List<dynamic> decodedJson = json.decode(jsonResponse);

        print('json : ${decodedJson}');

        for (int i = 0; i < decodedJson.length; i++) {
          ReportedDisputeModel fm =
              ReportedDisputeModel.fromJson(decodedJson[i]);
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

  Future<List<ReportedDisputeModel>?>? _Payments;

  @override
  void initState() {
    super.initState();
    _Payments = getPayment();
  }

  @override
  Widget build(BuildContext context) {
    return Center(
      child: FutureBuilder<List<ReportedDisputeModel>?>(
        future: _Payments,
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return CircularProgressIndicator();
          } else if (snapshot.hasError) {
            return Text('Error: ${snapshot.error}');
          } else if (snapshot.hasData) {
            List<ReportedDisputeModel>? data = snapshot.data;
            return ListView.builder(
              itemCount: data!.length,
              itemBuilder: (context, index) {
                return Padding(
                    padding: const EdgeInsets.all(1.0),
                    child: Card(
                        margin: EdgeInsets.only(right: 10, left: 10, top: 15),
                        elevation: 5,
                        color: Colors.white,
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Container(
                              padding: EdgeInsets.all(10),
                              child: Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                children: [
                                  Image(
                                    image: AssetImage(
                                        "assets/images/orderpng2.webp"),
                                    width: 70,
                                    height: 80,
                                    color: Colors.orange,
                                  ),
                                  Column(
                                    mainAxisAlignment: MainAxisAlignment.start,
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: [
                                      Row(
                                        children: [
                                          Text(snapshot.data![index].Name,
                                              textAlign: TextAlign.end,
                                              //Text(snapshot.data![index].username,
                                              style: TextStyle(
                                                  fontSize: 14,
                                                  fontWeight: FontWeight.bold)),
                                          SizedBox(
                                            width: 50,
                                          ),
                                          SizedBox(
                                            width: 70,
                                            height: 25,
                                            child: ElevatedButton(
                                              style: ElevatedButton.styleFrom(
                                                primary: Colors
                                                    .orange, // Button color
                                                onPrimary:
                                                    Colors.white, // Text color
                                              ),
                                              onPressed: () {
                                                Navigator.push(
                                                    context,
                                                    MaterialPageRoute(
                                                        builder: (BuildContext
                                                                context) =>
                                                            Reported_Dispute()));
                                              },
                                              child: GestureDetector(
                                                onTap: () {
                                                  // Handle the click event here
                                                  // You can navigate to a new screen, show a dialog, or perform any action you need.
                                                  print('Text Clicked!');
                                                },
                                                child: Text(
                                                  'Reply',
                                                  style: TextStyle(
                                                    fontWeight: FontWeight.bold,
                                                    fontSize: 12,
                                                  ),
                                                ),
                                              ),
                                            ),
                                          ),
                                        ],
                                      ),
                                      SizedBox(
                                        width: 100,
                                      ),
                                      SizedBox(
                                        height: 4,
                                      ),
                                      Row(
                                        children: [
                                          Image(
                                            image: AssetImage(
                                                "assets/images/id.png"),
                                            width: 16,
                                            height: 16,
                                          ),
                                          SizedBox(
                                            width: 5,
                                            height: 5,
                                          ),
                                          Text(
                                            snapshot.data![index].DisputeId,
                                            textAlign: TextAlign.center,
                                            // Text(snapshot.data![index].message,
                                            style: TextStyle(
                                                fontSize: 14,
                                                fontWeight: FontWeight.normal),
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
                                            child: Text(
                                              'REPORTED',
                                              style: TextStyle(
                                                  fontSize: 13,
                                                  color: Color(0xFF000080)),
                                            ),
                                          ),
                                          SizedBox(
                                            width: 50,
                                          ),
                                          Image.asset(
                                            "assets/images/tickiconpng.png",
                                            cacheWidth: 15,
                                            cacheHeight: 15,
                                          ),
                                          Text(
                                              textAlign: TextAlign.end,
                                              snapshot.data![index].PhoneNo,
                                              //Text(snapshot.data![index].username,
                                              style: TextStyle(
                                                  fontSize: 12,
                                                  color: Colors.green,
                                                  fontWeight: FontWeight.bold)),
                                        ],
                                      ),
                                      SizedBox(
                                        height: 4.5,
                                      ),
                                      Row(
                                        children: [
                                          Text(
                                            "Dispute" +
                                                " : " +
                                                snapshot.data![index]
                                                    .DisputeRelated,
                                            textAlign: TextAlign.center,
                                            // Text(snapshot.data![index].message,
                                            style: TextStyle(
                                                fontSize: 13,
                                                fontWeight: FontWeight.normal),
                                          ),
                                          SizedBox(
                                            width: 15,
                                          ),
                                          Image.asset(
                                            "assets/images/tickiconpng.png",
                                            cacheWidth: 15,
                                            cacheHeight: 15,
                                          ),
                                          Text(
                                              textAlign: TextAlign.end,
                                              snapshot.data![index].Date,
                                              //Text(snapshot.data![index].username,
                                              style: TextStyle(
                                                  fontSize: 12,
                                                  color: Colors.green,
                                                  fontWeight: FontWeight.bold)),
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
                                      265, // Make the Divider span the full width
                                  child: Divider(
                                      thickness: 2), // Divider after GridView
                                ),
                                Text(
                                  ' Net Amount',
                                  style: TextStyle(fontSize: 12),
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
                                    ' Order Status: ',
                                    style: TextStyle(fontSize: 14),
                                  ),
                                  SizedBox(
                                    width: 5,
                                  ),
                                  Text(
                                    snapshot.data![index].OrderStatus,
                                    style: TextStyle(fontSize: 14),
                                  ),
                                  SizedBox(width: 120),
                                  Text(
                                    snapshot.data![index].OrderAmount,
                                    style: TextStyle(
                                        fontSize: 17,
                                        fontWeight: FontWeight.bold),
                                  ),
                                  // User Type on the left side
                                ],
                              ),
                            ),
                          ],
                        )));
              },
            );
          } else {
            return Text('No data available');
          }
        },
      ),
    );
  }
}

class PendingPaymentsTab extends StatefulWidget {
  @override
  _PendingPaymentsTabState createState() => _PendingPaymentsTabState();
}

class _PendingPaymentsTabState extends State<PendingPaymentsTab> {
  static Future<List<ReportedDisputeModel>?> getPartPaymentData() async {
    String userid = await Prefs.getStringValue(Prefs.PREFS_USER_ID);
    List<ReportedDisputeModel> bookingCardData = [];
    Future<http.Response>? __futureLabels =
        ResponseHandler.performPost("UnderProcessingDispute", "UserId=$userid");

    return await __futureLabels?.then((value) {
      String jsonResponse = ResponseHandler.parseData(value.body);
      log(jsonResponse);
      try {
        //Map<String, dynamic> map = json.decode(jsonResponse);
        List<dynamic> decodedJson = json.decode(jsonResponse);

        print('json : ${decodedJson}');

        for (int i = 0; i < decodedJson.length; i++) {
          ReportedDisputeModel fm =
              ReportedDisputeModel.fromJson(decodedJson[i]);
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

  Future<List<ReportedDisputeModel>?>? _futurePayments;

  @override
  void initState() {
    super.initState();
    _futurePayments = getPartPaymentData();
  }

  @override
  Widget build(BuildContext context) {
    return Center(
      child: FutureBuilder<List<ReportedDisputeModel>?>(
        future: _futurePayments,
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return CircularProgressIndicator();
          } else if (snapshot.hasError) {
            return Text('Error: ${snapshot.error}');
          } else if (snapshot.hasData) {
            List<ReportedDisputeModel>? data = snapshot.data;
            return ListView.builder(
              itemCount: data!.length,
              itemBuilder: (context, index) {
                return Padding(
                    padding: const EdgeInsets.all(1.0),
                    child: Card(
                        margin: EdgeInsets.only(right: 10, left: 10, top: 15),
                        elevation: 5,
                        color: Colors.white,
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Container(
                              padding: EdgeInsets.all(10),
                              child: Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                children: [
                                  Image(
                                    image: AssetImage(
                                        "assets/images/orderpng2.webp"),
                                    width: 70,
                                    height: 80,
                                    color: Colors.orange,
                                  ),
                                  Column(
                                    mainAxisAlignment: MainAxisAlignment.start,
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: [
                                      Row(
                                        children: [
                                          Text(snapshot.data![index].Name,
                                              textAlign: TextAlign.end,
                                              //Text(snapshot.data![index].username,
                                              style: TextStyle(
                                                  fontSize: 14,
                                                  fontWeight: FontWeight.bold)),
                                          SizedBox(
                                            width: 50,
                                          ),
                                          SizedBox(
                                            width: 70,
                                            height: 25,
                                            child: ElevatedButton(
                                              style: ElevatedButton.styleFrom(
                                                primary: Colors
                                                    .orange, // Button color
                                                onPrimary:
                                                    Colors.white, // Text color
                                              ),
                                              onPressed: () {
                                                Navigator.push(
                                                    context,
                                                    MaterialPageRoute(
                                                        builder: (BuildContext
                                                                context) =>
                                                            Reported_Dispute()));
                                              },
                                              child: Text(
                                                'Reply',
                                                style: TextStyle(
                                                  fontWeight: FontWeight.bold,
                                                  fontSize: 12,
                                                ),
                                              ),
                                            ),
                                          ),
                                        ],
                                      ),
                                      SizedBox(
                                        width: 100,
                                      ),
                                      SizedBox(
                                        height: 4,
                                      ),
                                      Row(
                                        children: [
                                          Image(
                                            image: AssetImage(
                                                "assets/images/id.png"),
                                            width: 16,
                                            height: 16,
                                          ),
                                          Text(
                                            snapshot.data![index].UserId,
                                            textAlign: TextAlign.center,
                                            // Text(snapshot.data![index].message,
                                            style: TextStyle(
                                                fontSize: 14,
                                                fontWeight: FontWeight.normal),
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
                                            child: Text(
                                              'REPORTED',
                                              style: TextStyle(fontSize: 13),
                                            ),
                                          ),
                                          SizedBox(
                                            width: 50,
                                          ),
                                          Image.asset(
                                            "assets/images/tickiconpng.png",
                                            cacheWidth: 15,
                                            cacheHeight: 15,
                                          ),
                                          Text(
                                              textAlign: TextAlign.end,
                                              snapshot.data![index].PhoneNo,
                                              //Text(snapshot.data![index].username,
                                              style: TextStyle(
                                                  fontSize: 12,
                                                  color: Colors.green,
                                                  fontWeight: FontWeight.bold)),
                                        ],
                                      ),
                                      SizedBox(
                                        height: 4.5,
                                      ),
                                      Row(
                                        children: [
                                          Text(
                                            snapshot.data![index].DisputeStatus,
                                            textAlign: TextAlign.center,
                                            // Text(snapshot.data![index].message,
                                            style: TextStyle(
                                                fontSize: 13,
                                                fontWeight: FontWeight.normal),
                                          ),
                                          SizedBox(
                                            width: 50,
                                          ),
                                          Image.asset(
                                            "assets/images/tickiconpng.png",
                                            cacheWidth: 15,
                                            cacheHeight: 15,
                                          ),
                                          Text(
                                              textAlign: TextAlign.end,
                                              snapshot.data![index].Date,
                                              //Text(snapshot.data![index].username,
                                              style: TextStyle(
                                                  fontSize: 12,
                                                  color: Colors.green,
                                                  fontWeight: FontWeight.bold)),
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
                                      265, // Make the Divider span the full width
                                  child: Divider(
                                      thickness: 2), // Divider after GridView
                                ),
                                Text(
                                  ' Net Amount',
                                  style: TextStyle(fontSize: 12),
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
                                    ' Order Status: ',
                                    style: TextStyle(fontSize: 14),
                                  ),
                                  SizedBox(
                                    width: 5,
                                  ),
                                  Text(
                                    snapshot.data![index].OrderStatus,
                                    style: TextStyle(fontSize: 14),
                                  ),
                                  SizedBox(width: 128),
                                  Text(
                                    snapshot.data![index].OrderAmount,
                                    style: TextStyle(
                                        fontSize: 14,
                                        fontWeight: FontWeight.bold),
                                  ),
                                  // User Type on the left side
                                ],
                              ),
                            ),
                          ],
                        )));
              },
            );
          } else {
            return Text('No data available');
          }
        },
      ),
    );
  }
}

class CLosedDisputes extends StatefulWidget {
  @override
  CLosedDisputesState createState() => CLosedDisputesState();
}

class CLosedDisputesState extends State<CLosedDisputes> {
  static Future<List<ReportedDisputeModel>?> getPartData() async {
    String userid = await Prefs.getStringValue(Prefs.PREFS_USER_ID);
    List<ReportedDisputeModel> bookingCardData = [];
    Future<http.Response>? __futureLabels =
        ResponseHandler.performPost("ClosedDispute", "UserId=$userid");

    return await __futureLabels?.then((value) {
      String jsonResponse = ResponseHandler.parseData(value.body);
      log(jsonResponse);
      try {
        //Map<String, dynamic> map = json.decode(jsonResponse);
        List<dynamic> decodedJson = json.decode(jsonResponse);

        print('json : ${decodedJson}');

        for (int i = 0; i < decodedJson.length; i++) {
          ReportedDisputeModel fm =
              ReportedDisputeModel.fromJson(decodedJson[i]);
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

  Future<List<ReportedDisputeModel>?>? _futurePayments;

  @override
  void initState() {
    super.initState();
    _futurePayments = getPartData();
  }

  @override
  Widget build(BuildContext context) {
    return Center(
      child: FutureBuilder<List<ReportedDisputeModel>?>(
        future: _futurePayments,
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return CircularProgressIndicator();
          } else if (snapshot.hasError) {
            return Text('Error: ${snapshot.error}');
          } else if (snapshot.hasData) {
            List<ReportedDisputeModel>? data = snapshot.data;
            return ListView.builder(
              itemCount: data!.length,
              itemBuilder: (context, index) {
                return Padding(
                    padding: const EdgeInsets.all(1.0),
                    child: Card(
                        margin: EdgeInsets.only(right: 10, left: 10, top: 15),
                        elevation: 5,
                        color: Colors.white,
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Container(
                              padding: EdgeInsets.all(10),
                              child: Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                children: [
                                  Image(
                                    image: AssetImage(
                                        "assets/images/orderpng2.webp"),
                                    width: 70,
                                    height: 80,
                                    color: Colors.orange,
                                  ),
                                  Column(
                                    mainAxisAlignment: MainAxisAlignment.start,
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: [
                                      Row(
                                        children: [
                                          Text(snapshot.data![index].Name,
                                              textAlign: TextAlign.end,
                                              //Text(snapshot.data![index].username,
                                              style: TextStyle(
                                                  fontSize: 14,
                                                  fontWeight: FontWeight.bold)),
                                          SizedBox(
                                            width: 50,
                                          ),
                                          SizedBox(
                                            width: 70,
                                            height: 25,
                                            child: ElevatedButton(
                                              style: ElevatedButton.styleFrom(
                                                primary: Colors
                                                    .orange, // Button color
                                                onPrimary:
                                                    Colors.white, // Text color
                                              ),
                                              onPressed: () {
                                                Navigator.push(
                                                    context,
                                                    MaterialPageRoute(
                                                        builder: (BuildContext
                                                                context) =>
                                                            Reported_Dispute()));
                                              },
                                              child: Text(
                                                'Reply',
                                                style: TextStyle(
                                                  fontWeight: FontWeight.bold,
                                                  fontSize: 12,
                                                ),
                                              ),
                                            ),
                                          ),
                                        ],
                                      ),
                                      SizedBox(
                                        width: 100,
                                      ),
                                      SizedBox(
                                        height: 4,
                                      ),
                                      Row(
                                        children: [
                                          Image(
                                            image: AssetImage(
                                                "assets/images/id.png"),
                                            width: 16,
                                            height: 16,
                                          ),
                                          Text(
                                            snapshot.data![index].UserId,
                                            textAlign: TextAlign.center,
                                            // Text(snapshot.data![index].message,
                                            style: TextStyle(
                                                fontSize: 14,
                                                fontWeight: FontWeight.normal),
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
                                            child: Text(
                                              'REPORTED',
                                              style: TextStyle(fontSize: 13),
                                            ),
                                          ),
                                          SizedBox(
                                            width: 50,
                                          ),
                                          Image.asset(
                                            "assets/images/tickiconpng.png",
                                            cacheWidth: 15,
                                            cacheHeight: 15,
                                          ),
                                          Text(
                                              textAlign: TextAlign.end,
                                              snapshot.data![index].PhoneNo,
                                              //Text(snapshot.data![index].username,
                                              style: TextStyle(
                                                  fontSize: 12,
                                                  color: Colors.green,
                                                  fontWeight: FontWeight.bold)),
                                        ],
                                      ),
                                      SizedBox(
                                        height: 4.5,
                                      ),
                                      Row(
                                        children: [
                                          Text(
                                            snapshot.data![index].DisputeStatus,
                                            textAlign: TextAlign.center,
                                            // Text(snapshot.data![index].message,
                                            style: TextStyle(
                                                fontSize: 13,
                                                fontWeight: FontWeight.normal),
                                          ),
                                          SizedBox(
                                            width: 50,
                                          ),
                                          Image.asset(
                                            "assets/images/tickiconpng.png",
                                            cacheWidth: 15,
                                            cacheHeight: 15,
                                          ),
                                          Text(
                                              textAlign: TextAlign.end,
                                              snapshot.data![index].Date,
                                              //Text(snapshot.data![index].username,
                                              style: TextStyle(
                                                  fontSize: 12,
                                                  color: Colors.green,
                                                  fontWeight: FontWeight.bold)),
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
                                      265, // Make the Divider span the full width
                                  child: Divider(
                                      thickness: 2), // Divider after GridView
                                ),
                                Text(
                                  ' Net Amount',
                                  style: TextStyle(fontSize: 12),
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
                                    ' Order Status: ',
                                    style: TextStyle(fontSize: 14),
                                  ),
                                  SizedBox(
                                    width: 5,
                                  ),
                                  Text(
                                    snapshot.data![index].OrderStatus,
                                    style: TextStyle(fontSize: 14),
                                  ),
                                  SizedBox(width: 128),
                                  Text(
                                    snapshot.data![index].OrderAmount,
                                    style: TextStyle(
                                        fontSize: 14,
                                        fontWeight: FontWeight.bold),
                                  ),
                                  // User Type on the left side
                                ],
                              ),
                            ),
                          ],
                        )));
              },
            );
          } else {
            return Text('No data available');
          }
        },
      ),
    );
  }
}
