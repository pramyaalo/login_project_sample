import 'dart:convert';
import 'dart:developer';

 import 'package:http/http.dart' as http;
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:login_project_sample/Models/CompletedOrderModel.dart';
import 'package:login_project_sample/Models/PendingOrderModel.dart';
import 'package:login_project_sample/utils/response_handler.dart';
import 'package:login_project_sample/utils/shared_preferences.dart';

void main() {
  runApp(PendingOrders());
}

class PendingOrders extends StatelessWidget {
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

  List<String> tabTitles = ['PENDING ORDERS', 'COMPLETED ORDERS'];

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
              Navigator.pop(context);
            },
          ),
          bottom: TabBar(
            indicatorColor: Color(0xFF007E01),
            labelColor: Colors.black,
            tabs: [
              Tab(
                text: ("PENDING ORDERS"),
              ),
              Tab(
                text: ("COMPLETED ORDERS"),
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
          title: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                _PaymentHistoryTabState.Username,
                style: TextStyle(
                  fontSize: 16,
                  color: Colors.black,
                  fontWeight: FontWeight.bold,
                ),
              ),
              SizedBox(
                height: 3,
                width: 3,
              ),
              Text(
                _PaymentHistoryTabState.Name,
                style: TextStyle(fontSize: 14, color: Colors.black),
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
            Pendingorders(),
            CompletedOrders(),
          ],
        ),
      ),
    );
  }
}

class Pendingorders extends StatefulWidget {
  @override
  _PaymentHistoryTabState createState() => _PaymentHistoryTabState();
}

class _PaymentHistoryTabState extends State<Pendingorders> {
  static String memberId = '', Username = '', Name = '';
  @override
  void initState() {
    super.initState();

    _Payments = getPayment();
  }

  static Future<List<PendingOrderModel>?> getPayment() async {
    memberId = await Prefs.getStringValue(Prefs.PREFS_USER_ID);
    Username = await Prefs.getStringValue(Prefs.PREFS_USER_NAME);
    Name = await Prefs.getStringValue(Prefs.PREFS_NAME);
    log('Name :' + Name!);
    List<PendingOrderModel> bookingCardData = [];
    Future<http.Response>? __futureLabels = ResponseHandler.performPost(
        "MyOrderDetail", "MemberId=${memberId}&PageIndex=1");
    log('MemberId :' + memberId!);

    return await __futureLabels?.then((value) {
      String jsonResponse = ResponseHandler.parseData(value.body);
      log('jsonResponse :' + jsonResponse);
      try {
        //Map<String, dynamic> map = json.decode(jsonResponse);
        List<dynamic> decodedJson = json.decode(jsonResponse);

        print('json : ${decodedJson}');

        for (int i = 0; i < decodedJson.length; i++) {
          PendingOrderModel fm = PendingOrderModel.fromJson(decodedJson[i]);
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

  Future<List<PendingOrderModel>?>? _Payments;

  @override
  Widget build(BuildContext context) {
    return Center(
      child: FutureBuilder<List<PendingOrderModel>?>(
        future: _Payments,
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return CircularProgressIndicator();
          } else if (snapshot.hasError) {
            return Text('Error: ${snapshot.error}');
          } else if (snapshot.hasData) {
            List<PendingOrderModel>? data = snapshot.data;
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
                                mainAxisAlignment: MainAxisAlignment.start,
                                children: [
                                  Image(
                                    image: AssetImage(
                                        "assets/images/orderpng2.webp"),
                                    width: 70,
                                    height: 80,
                                    color: Colors.orange,
                                  ),
                                  SizedBox(
                                    width: 30,
                                  ),
                                  Column(
                                    mainAxisAlignment: MainAxisAlignment.start,
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: [
                                      Text(
                                          snapshot.data![index].Name +
                                              "(" +
                                              snapshot.data![index].username +
                                              ")",
                                          textAlign: TextAlign.end,
                                          //Text(snapshot.data![index].username,
                                          style: TextStyle(
                                              fontSize: 14,
                                              fontWeight: FontWeight.bold)),
                                      SizedBox(
                                        width: 40,
                                      ),
                                      SizedBox(
                                        height: 4,
                                      ),
                                      Row(
                                        children: [
                                          Image(
                                            image: AssetImage(
                                                "assets/images/locationjpg.jpg"),
                                            width: 10,
                                            height: 16,
                                          ),
                                          Text(
                                            snapshot.data![index].shipadd1 +
                                                snapshot.data![index].shipadd2 +
                                                snapshot.data![index].shipcity,
                                            textAlign: TextAlign.center,
                                            // Text(snapshot.data![index].message,
                                            style: TextStyle(
                                                fontSize: 12,
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
                                              snapshot.data![index].ostatus,
                                              style: TextStyle(fontSize: 13),
                                            ),
                                          ),
                                          SizedBox(
                                            width: 70,
                                          ),
                                          Image.asset(
                                            "assets/images/tickiconpng.png",
                                            cacheWidth: 15,
                                            cacheHeight: 15,
                                          ),
                                          Text(
                                              textAlign: TextAlign.end,
                                              snapshot
                                                  .data![index].PaymentMethod,
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
                                            snapshot.data![index].TotalQty +
                                                " " +
                                                "Items",
                                            textAlign: TextAlign.center,
                                            // Text(snapshot.data![index].message,
                                            style: TextStyle(
                                                fontSize: 13,
                                                fontWeight: FontWeight.normal),
                                          ),
                                          SizedBox(
                                            width: 55,
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
                                      215, // Make the Divider span the full width
                                  child: Divider(
                                      thickness: 2), // Divider after GridView
                                ),
                                Text(
                                  'Order Total(Incl.TAX)',
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
                                    ' Order ID: ',
                                    style: TextStyle(fontSize: 14),
                                  ),
                                  SizedBox(
                                    width: 5,
                                  ),
                                  Text(
                                    snapshot.data![index].OrderId,
                                    style: TextStyle(fontSize: 14),
                                  ),
                                  SizedBox(width: 168),
                                  Text(
                                    snapshot.data![index].Total,
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

class CompletedOrders extends StatefulWidget {
  @override
  _PendingPaymentsTabState createState() => _PendingPaymentsTabState();
}

class _PendingPaymentsTabState extends State<CompletedOrders> {
  static Future<List<CompletedOrderModel>?> getPartPaymentData() async {
    String memberId = await Prefs.getStringValue(Prefs.PREFS_USER_ID);
    List<CompletedOrderModel> bookingCardData = [];
    Future<http.Response>? __futureLabels = ResponseHandler.performPost(
        "MyCompletedOrder", "MemberId=${memberId}&PageIndex=1");

    return await __futureLabels?.then((value) {
      String jsonResponse = ResponseHandler.parseData(value.body);
      log(jsonResponse);
      try {
        //Map<String, dynamic> map = json.decode(jsonResponse);
        List<dynamic> decodedJson = json.decode(jsonResponse);

        print('json : ${decodedJson}');

        for (int i = 0; i < decodedJson.length; i++) {
          CompletedOrderModel fm = CompletedOrderModel.fromJson(decodedJson[i]);
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

  Future<List<CompletedOrderModel>?>? _futurePayments;

  @override
  void initState() {
    super.initState();
    _futurePayments = getPartPaymentData();
  }

  @override
  Widget build(BuildContext context) {
    return Center(
      child: FutureBuilder<List<CompletedOrderModel>?>(
        future: _futurePayments,
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return CircularProgressIndicator();
          } else if (snapshot.hasError) {
            return Text('Error: ${snapshot.error}');
          } else if (snapshot.hasData) {
            List<CompletedOrderModel>? data = snapshot.data;
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
                                    color: Colors.green,
                                  ),
                                  Column(
                                    mainAxisAlignment: MainAxisAlignment.start,
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: [
                                      Text(
                                          snapshot.data![index].Name +
                                              "(" +
                                              snapshot.data![index].username +
                                              ")",
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
                                          Image(
                                            image: AssetImage(
                                                "assets/images/locationjpg.jpg"),
                                            width: 10,
                                            height: 16,
                                          ),
                                          Text(
                                            snapshot.data![index].shipadd1 +
                                                snapshot.data![index].shipadd2 +
                                                snapshot.data![index].shipcity,
                                            textAlign: TextAlign.center,
                                            // Text(snapshot.data![index].message,
                                            style: TextStyle(
                                                fontSize: 12,
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
                                              snapshot.data![index].Ostatus,
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
                                              snapshot
                                                  .data![index].PaymentMethod,
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
                                            snapshot.data![index].TotalQty +
                                                " " +
                                                "Items",
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
                                              snapshot
                                                  .data![index].DeliveryDate,
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
                                      225, // Make the Divider span the full width
                                  child: Divider(
                                      thickness: 2), // Divider after GridView
                                ),
                                Text(
                                  'Order Total(Incl.TAX)',
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
                                    ' Order ID: ',
                                    style: TextStyle(fontSize: 14),
                                  ),
                                  SizedBox(
                                    width: 5,
                                  ),
                                  Text(
                                    snapshot.data![index].OrderId,
                                    style: TextStyle(fontSize: 14),
                                  ),
                                  SizedBox(width: 185),
                                  Text(
                                    snapshot.data![index].Total,
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
