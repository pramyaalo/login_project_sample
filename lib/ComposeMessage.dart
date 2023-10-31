import 'dart:convert';
import 'dart:developer';

import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:login_project_sample/DashBoard.dart';
import 'package:login_project_sample/Models/InboxMessageModel.dart';
import 'package:login_project_sample/Models/OutboxMessageModel.dart';
import 'package:login_project_sample/Wallet_n.dart';
import 'package:http/http.dart' as http;
import 'package:login_project_sample/utils/response_handler.dart';
import 'package:login_project_sample/utils/shared_preferences.dart';

void main() {
  runApp(ComposeMessage());
}

class ComposeMessage extends StatelessWidget {
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
  String memberId = '', UserName = '', Name = '';
  @override
  void initState() {
    super.initState();

    _loadmemberid();
  }

  Future<void> _loadmemberid() async {
    try {
      memberId = await Prefs.getStringValue(Prefs.PREFS_USER_ID);
      log("memberId" + memberId);
      UserName = await Prefs.getStringValue(Prefs.PREFS_USER_NAME);
      Name = await Prefs.getStringValue(Prefs.PREFS_NAME);
    } catch (e) {
      print("Error: $e");
      Fluttertoast.showToast(msg: "An error occurred");
    }
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
        debugShowCheckedModeBanner: false,
        home: DefaultTabController(
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
                    text: ("COMPOSE"),
                  ),
                  Tab(
                    text: ("INBOX"),
                  ),
                  Tab(
                    text: ("OUTBOX"),
                  )
                ],
                indicator: BoxDecoration(
                  color: Color(0xFFF5F5F5),
                  border: Border(
                    bottom: BorderSide(
                      color: Color(0xFF007E01),
                      width: 2.0,
                    ),
                  ),
                ),
                unselectedLabelStyle: TextStyle(
                  color: Colors.white,
                  fontSize: 16,
                  fontWeight: FontWeight.w500,
                ),
              ),
              title: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    UserName,
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
                    Name,
                    style: TextStyle(fontSize: 14, color: Colors.black),
                  ),
                ],
              ),
              titleSpacing: 15,
              leadingWidth: 30,
              actions: [
                Padding(
                  padding: EdgeInsets.only(right: 16.0, bottom: 1),
                  child: Image.asset(
                    'assets/images/logor.jpg',
                    width: 90,
                    height: 35,
                  ),
                ),
              ],
            ),
            body: TabBarView(
              children: [
                Compose(),
                Inbox(),
                Outbox(),
              ],
            ),
          ),
        ));
  }
}

class Compose extends StatefulWidget {
  @override
  _PaymentHistoryTabState createState() => _PaymentHistoryTabState();
}

class _PaymentHistoryTabState extends State<Compose> {
  final TextEditingController _subjectcontroller = TextEditingController();
  final TextEditingController _messagecontroller = TextEditingController();

  Future<http.Response>? __futureLogin;
  String memberId = '', Username = '', Name = '';
  Future<void> _loadmemberid() async {
    try {
      memberId = await Prefs.getStringValue(Prefs.PREFS_USER_ID);
      log("memberfhhjykkId" + memberId);
      Username = await Prefs.getStringValue(Prefs.PREFS_USER_NAME);
      Name = await Prefs.getStringValue(Prefs.PREFS_NAME);
    } catch (e) {
      print("Error: $e");
      Fluttertoast.showToast(msg: "An error occurred");
    }
  }

  @override
  void initState() {
    _loadmemberid();

    super.initState();
  }

  void _SaveMessage() async {
    String Subject = _subjectcontroller.text.trim();
    String Message = _messagecontroller.text.trim();

    __futureLogin = ResponseHandler.performPost("MessageSave",
        'ID=0&senderid=$memberId&receiverid=1000&subject=$Subject&message=$Message&UserId=$memberId');
    __futureLogin?.then((value) {
      print('Response body: ${value.body}');

      String jsonResponse = ResponseHandler.parseData(value.body);
      if (jsonResponse == "1") {
        Fluttertoast.showToast(
          msg: "Message Send Sucessfully",
          gravity: ToastGravity.BOTTOM,
          textColor: Colors.white,
        );
      }
      print('JSON Response: ${jsonResponse}');
    });
    /* log('buttonPress' + _AmountController.text);*/
  }

  @override
  Widget build(BuildContext context) {
    return Container(
        child: SingleChildScrollView(
      child: Container(
        child: Container(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Card(
                elevation: 6,
                child: SizedBox(
                  width: 340,
                  child: Padding(
                    padding: const EdgeInsets.all(16.0),
                    child: Column(
                      children: [
                        SizedBox(
                          height: 45,
                          child: Container(
                            padding: EdgeInsets.all(10),
                            decoration: BoxDecoration(
                              border: Border.all(color: Colors.grey),
                              borderRadius: BorderRadius.circular(3),
                            ),
                            child: Row(
                              children: [
                                Image.asset(
                                  'assets/images/name_icon.png',
                                  cacheHeight: 20,
                                  color: Color(0xFF007E01),
                                  cacheWidth: 20,
                                ),
                                SizedBox(
                                  width: 25,
                                ),
                                Text('Admin',
                                    style: TextStyle(
                                        fontSize: 17,
                                        fontWeight: FontWeight.w500)),
                              ],
                            ),
                          ),
                        ),
                        SizedBox(height: 16),
                        SizedBox(
                          height: 45,
                          child: TextField(
                            textCapitalization: TextCapitalization.words,
                            controller: _subjectcontroller,
                            decoration: InputDecoration(
                                border: OutlineInputBorder(),
                                prefixIcon: Image.asset(
                                    'assets/images/notification_icon.png',
                                    alignment: Alignment.center,
                                    cacheHeight: 20,
                                    cacheWidth: 20,
                                    color: Color(0xFF007E01)),
                                hintText: 'Subject',
                                contentPadding: EdgeInsets.only(bottom: 5)),
                            style: TextStyle(
                                fontSize: 17, fontWeight: FontWeight.w500),
                          ),
                        ),
                        SizedBox(height: 16),
                        Container(
                          height: 160,
                          padding: EdgeInsets.all(5),
                          decoration: BoxDecoration(
                            border: Border.all(
                              color: Colors.grey,
                            ),
                            borderRadius: BorderRadius.circular(5),
                          ),
                          child: TextField(
                            textCapitalization: TextCapitalization.words,
                            controller: _messagecontroller,
                            decoration: InputDecoration(
                              hintText: '   Message',
                              border: InputBorder.none,
                            ),
                            style: TextStyle(
                                fontSize: 17, fontWeight: FontWeight.w500),
                          ),
                        ),
                        SizedBox(height: 16),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                          children: [
                            ElevatedButton(
                              onPressed: () {
                                _SaveMessage();
                              },
                              style: ElevatedButton.styleFrom(
                                primary: Colors.indigoAccent, // Button color
                                onPrimary: Colors.white,
                                shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(
                                      10), // Adjust the radius as needed
                                ), //// Text color
                              ),
                              child: const SizedBox(
                                  width: 120,
                                  height: 45,
                                  child: Center(
                                    child: Text(
                                      'Send Message',
                                      style: TextStyle(
                                        fontSize: 16,
                                      ),
                                    ),
                                  )),
                            ),
                            SizedBox(
                              width: 4,
                            ),
                            ElevatedButton(
                              onPressed: () {
                                Navigator.push(
                                    context,
                                    MaterialPageRoute(
                                        builder: (BuildContext context) =>
                                            Dashboard(
                                              data: memberId,
                                              data1: Username,
                                            )));
                              },
                              style: ElevatedButton.styleFrom(
                                primary: Colors.green, // Button color
                                onPrimary: Colors.white,
                                shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(
                                      10), // Adjust the radius as needed
                                ), // // Text color
                              ),
                              child: SizedBox(
                                  width: 120,
                                  height: 45,
                                  child: Center(
                                    child: Text(
                                      'Cancel',
                                      style: TextStyle(
                                        fontSize: 16,
                                      ),
                                    ),
                                  )),
                            ),
                          ],
                        ),
                      ],
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    ));
  }
}

class Inbox extends StatefulWidget {
  @override
  _PendingPaymentsTabState createState() => _PendingPaymentsTabState();
}

class _PendingPaymentsTabState extends State<Inbox> {
  static Future<List<InboxMessageModel>?> getPartPaymentData() async {
    String memberId = await Prefs.getStringValue(Prefs.PREFS_USER_ID);
    List<InboxMessageModel> bookingCardData = [];
    Future<http.Response>? __futureLabels = ResponseHandler.performPost(
        "MessageInbox", "MemberId=${memberId}&PageIndex=1&GroupId=1");

    return await __futureLabels?.then((value) {
      String jsonResponse = ResponseHandler.parseData(value.body);
      log(jsonResponse);
      try {
        //Map<String, dynamic> map = json.decode(jsonResponse);
        List<dynamic> decodedJson = json.decode(jsonResponse);

        print('json : ${decodedJson}');

        for (int i = 0; i < decodedJson.length; i++) {
          InboxMessageModel fm = InboxMessageModel.fromJson(decodedJson[i]);
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

  Future<List<InboxMessageModel>?>? _futurePayments;

  @override
  void initState() {
    super.initState();
    _futurePayments = getPartPaymentData();
  }

  @override
  Widget build(BuildContext context) {
    return Center(
        child: FutureBuilder<List<InboxMessageModel>?>(
      future: _futurePayments,
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting) {
          return CircularProgressIndicator();
        } else if (snapshot.hasError) {
          return Text('Error: ${snapshot.error}');
        } else if (snapshot.hasData) {
          List<InboxMessageModel>? data = snapshot.data;
          return ListView.builder(
            itemCount: data!.length,
            itemBuilder: (context, index) {
              return SingleChildScrollView(
                  child: Padding(
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
                                  children: [
                                    Image(
                                      image: AssetImage(
                                        "assets/images/chat.png",
                                      ),
                                      width: 70,
                                      height: 40,
                                      color: Colors.red,
                                    ),
                                    SizedBox(
                                      width: 9,
                                      height: 9,
                                    ),
                                    Column(
                                      mainAxisAlignment:
                                          MainAxisAlignment.start,
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      children: [
                                        Text(
                                            "Sender:" +
                                                snapshot
                                                    .data![index].Sendername,
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
                                              snapshot.data![index].subject,
                                              textAlign: TextAlign.center,
                                              // Text(snapshot.data![index].message,
                                              style: TextStyle(
                                                  fontSize: 14,
                                                  fontWeight:
                                                      FontWeight.normal),
                                            ),
                                          ],
                                        ),
                                        SizedBox(
                                          height: 4.5,
                                        ),
                                        Row(
                                          children: [
                                            Text(snapshot.data![index].Message,
                                                style: TextStyle(fontSize: 13)),
                                            SizedBox(
                                              width: 20,
                                            ),
                                            Image.asset(
                                              "assets/images/tickiconpng.png",
                                              cacheWidth: 15,
                                              cacheHeight: 15,
                                            ),
                                            Text(
                                                snapshot
                                                    .data![index].CreatedDate,
                                                textAlign: TextAlign.end,

                                                //Text(snapshot.data![index].username,
                                                style: TextStyle(
                                                    fontSize: 12,
                                                    color: Colors.green,
                                                    fontWeight:
                                                        FontWeight.bold)),
                                            SizedBox(
                                              height: 19,
                                            )
                                          ],
                                        ),
                                      ],
                                    ),
                                  ],
                                ),
                              ),
                            ],
                          ))));
            },
          );
        } else {
          return Text('No data available');
        }
      },
    ));
    /* child: Container(
            child: Column(
                mainAxisAlignment: MainAxisAlignment.start,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [

          Card(
              margin: EdgeInsets.only(right: 10, left: 10, top: 15),
              elevation: 5,
              color: Colors.white,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Container(
                    padding: EdgeInsets.all(10),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Image(
                          image: AssetImage(
                            "assets/images/chat.png",
                          ),
                          width: 70,
                          height: 40,
                          color: Colors.red,
                        ),
                        Column(
                          mainAxisAlignment: MainAxisAlignment.start,
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text("Sender: Jenifer Aniston",
                                textAlign: TextAlign.end,
                                //Text(snapshot.data![index].username,
                                style: TextStyle(
                                    fontFamily: "Montserrat",
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
                                  "Sub",
                                  textAlign: TextAlign.center,
                                  // Text(snapshot.data![index].message,
                                  style: TextStyle(
                                      fontFamily: "Montserrat",
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
                                Text('Test Message',
                                    style: TextStyle(fontSize: 13)),
                                SizedBox(
                                  width: 30,
                                ),
                                Image.asset(
                                  "assets/images/tickiconpng.png",
                                  cacheWidth: 15,
                                  cacheHeight: 15,
                                ),
                                Text(
                                    textAlign: TextAlign.end,
                                    "27/01/2019;4:40 PM",
                                    //Text(snapshot.data![index].username,
                                    style: TextStyle(
                                        fontFamily: "Montserrat",
                                        fontSize: 12,
                                        color: Colors.green,
                                        fontWeight: FontWeight.bold)),
                                SizedBox(
                                  height: 19,
                                )
                              ],
                            ),
                          ],
                        ),
                      ],
                    ),
                  ),
                ],
              )),
        ])));*/
  }
}

class Outbox extends StatefulWidget {
  @override
  _Outboxtabstate createState() => _Outboxtabstate();
}

class _Outboxtabstate extends State<Outbox> {
  static Future<List<OutboxMessageModel>?> getPartPaymentData() async {
    String memberId = await Prefs.getStringValue(Prefs.PREFS_USER_ID);
    List<OutboxMessageModel> bookingCardData = [];
    Future<http.Response>? __futureLabels = ResponseHandler.performPost(
        "MessageOutbox", "MemberId=${memberId}&PageIndex=1&GroupId=1");

    return await __futureLabels?.then((value) {
      String jsonResponse = ResponseHandler.parseData(value.body);
      log(jsonResponse);
      try {
        //Map<String, dynamic> map = json.decode(jsonResponse);
        List<dynamic> decodedJson = json.decode(jsonResponse);

        print('json : ${decodedJson}');

        for (int i = 0; i < decodedJson.length; i++) {
          OutboxMessageModel fm = OutboxMessageModel.fromJson(decodedJson[i]);
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

  Future<List<OutboxMessageModel>?>? _futurePayments;

  @override
  void initState() {
    super.initState();
    _futurePayments = getPartPaymentData();
  }

  @override
  Widget build(BuildContext context) {
    return Center(
        child: FutureBuilder<List<OutboxMessageModel>?>(
      future: _futurePayments,
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting) {
          return CircularProgressIndicator();
        } else if (snapshot.hasError) {
          return Text('Error: ${snapshot.error}');
        } else if (snapshot.hasData) {
          List<OutboxMessageModel>? data = snapshot.data;
          return ListView.builder(
            itemCount: data!.length,
            itemBuilder: (context, index) {
              return SingleChildScrollView(
                  child: Padding(
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
                                  children: [
                                    Image(
                                      image: AssetImage(
                                        "assets/images/chat.png",
                                      ),
                                      width: 70,
                                      height: 40,
                                      color: Colors.red,
                                    ),
                                    SizedBox(
                                      width: 9,
                                      height: 9,
                                    ),
                                    Column(
                                      mainAxisAlignment:
                                          MainAxisAlignment.start,
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      children: [
                                        Text(
                                            "Sender:" +
                                                snapshot
                                                    .data![index].Sendername,
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
                                              snapshot.data![index].subject,
                                              textAlign: TextAlign.center,
                                              // Text(snapshot.data![index].message,
                                              style: TextStyle(
                                                  fontSize: 14,
                                                  fontWeight:
                                                      FontWeight.normal),
                                            ),
                                          ],
                                        ),
                                        SizedBox(
                                          height: 4.5,
                                        ),
                                        Row(
                                          children: [
                                            Text(snapshot.data![index].Message,
                                                style: TextStyle(fontSize: 13)),
                                            SizedBox(
                                              width: 20,
                                            ),
                                            Image.asset(
                                              "assets/images/tickiconpng.png",
                                              cacheWidth: 15,
                                              cacheHeight: 15,
                                            ),
                                            Text(
                                                snapshot
                                                    .data![index].CreatedDate,
                                                textAlign: TextAlign.end,

                                                //Text(snapshot.data![index].username,
                                                style: TextStyle(
                                                    fontSize: 12,
                                                    color: Colors.green,
                                                    fontWeight:
                                                        FontWeight.bold)),
                                            SizedBox(
                                              height: 19,
                                            )
                                          ],
                                        ),
                                      ],
                                    ),
                                  ],
                                ),
                              ),
                            ],
                          ))));
            },
          );
        } else {
          return Text('No data available');
        }
      },
    ));
  }
}
