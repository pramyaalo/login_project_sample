import 'dart:convert';
import 'dart:developer';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:login_project_sample/About.dart';
import 'package:login_project_sample/AddReview.dart';
import 'package:login_project_sample/BankDetails.dart';
import 'package:login_project_sample/ChangePassword.dart';
import 'package:login_project_sample/ChangeTransactionPassword.dart';
import 'package:login_project_sample/ComposeMessage.dart';
import 'package:login_project_sample/EditProfile.dart';
import 'package:login_project_sample/FundTransfer.dart';
import 'package:login_project_sample/FundTransferHistory.dart';
import 'package:login_project_sample/KYCApplication.dart';
import 'package:login_project_sample/KYCList.dart';
import 'package:login_project_sample/PendingOrders.dart';
import 'package:login_project_sample/ReferandEarn.dart';
import 'package:login_project_sample/Reported_Dispute.dart';
import 'package:login_project_sample/Testimonal.dart';
import 'package:login_project_sample/Wallet_n.dart';
import 'package:login_project_sample/WithDrawFund.dart';
import 'package:login_project_sample/WithdrawList.dart';
import 'package:login_project_sample/home.dart';
import 'package:login_project_sample/utils/response_handler.dart';
import 'package:login_project_sample/utils/shared_preferences.dart';
import 'package:fl_chart/fl_chart.dart';
import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';

class Dashboard extends StatefulWidget {
  final String data, data1;
  // Use the constructor to receive the data
  Dashboard({required this.data, required this.data1});

  @override
  _CorDashboardState createState() => _CorDashboardState();
}

class _CorDashboardState extends State<Dashboard> {
  Future<http.Response>? __futureLogin;
  GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey<ScaffoldState>();

  late String Balance = "",
      Balance1 = '',
      affiliate = "",
      TotalEarnings = "",
      AvailableBalance = "",
      DirectIncome = "",
      LevelIncome = "",
      BinaryIncome = "",
      Notification = "",
      Kyc = "",
      UnusedEpins = "",
      UsedEpins = "",
      TransferedEpins = "",
      ReceivedEpins = "",
      TotalWithdrawals = "",
      FundTrasnfered = "",
      FundReceived = "",
      MessageSent = "",
      Inbox = "",
      TotalOrders = "",
      NewOrders = "",
      CompletedOrders = "",
      PersonalMember = "",
      TeamMember = "";
  String? UserId;
  String? Name;
  String imageUrl = '';
  String? UserName;
  bool ispremium = false;

  @override
  void initState() {
    retrieveUsername();

    "Received Data: ${widget.data}";
    //String userid = Prefs.getStringValue(Prefs.PREFS_USER_ID);
    __futureLogin = ResponseHandler.performPost(
        "GetEwalletbalanceTranspwd", 'MemberId=${widget.data}');
    __futureLogin?.then((value) {
      print('Response body: ${value.body}');

      String jsonResponse = ResponseHandler.parseData(value.body);

      print('JSON Response: ${jsonResponse}');
      try {
        //Map<String, dynamic> map = json.decode(jsonResponse);
        List<dynamic> decodedJson = json.decode(jsonResponse);
        Map<String, dynamic> firstUser = decodedJson[0];

        print('CustomerId ${firstUser["CustomerId"]}');
        print('Balance ${firstUser["Balance"]}');
        setState(() {
          Balance =
              double.parse(firstUser["Balance"].toString()).toStringAsFixed(2);

          print('Balance:$Balance');
        });

        print('TransactionPassword: ${firstUser["TransactionPassword"]}');
        print('------------------');
      } catch (error) {
        Fluttertoast.showToast(msg: "Loginulll Failed");
        log(error.toString());
      }
    });

    __futureLogin = ResponseHandler.performPost(
        "GetFundwalletbalance", 'MemberId=${widget.data}');
    __futureLogin?.then((value) {
      print('Response body: ${value.body}');

      String jsonResponse = ResponseHandler.parseData(value.body);

      print('JSON Response: ${jsonResponse}');
      try {
        //Map<String, dynamic> map = json.decode(jsonResponse);
        List<dynamic> decodedJson = json.decode(jsonResponse);
        Map<String, dynamic> firstUser = decodedJson[0];

        print('CustomerId ${firstUser["CustomerId"]}');
        print('Balance ${firstUser["Balance"]}');
        setState(() {
          Balance1 = firstUser["Balance"].toString();

          print('Balancesdfg:$Balance1');
        });

        print('TransactionPassword: ${firstUser["TransactionPassword"]}');
        print('------------------');
      } catch (error) {
        Fluttertoast.showToast(msg: "Loginty Failed");
        log(error.toString());
      }
    });

    __futureLogin = ResponseHandler.performPost(
        "PremiumMember", 'username=${widget.data1}');
    __futureLogin?.then((value) {
      print('Responsejhg body: ${value.body}');

      String jsonResponse = ResponseHandler.parseData(value.body);

      print('JSON Response: ${jsonResponse}');
      try {
        //Map<String, dynamic> map = json.decode(jsonResponse);
        List<dynamic> decodedJson = json.decode(jsonResponse);
        Map<String, dynamic> firstUser = decodedJson[0];

        print('affiliate ${firstUser["affiliate"]}');

        setState(() {
          if (affiliate == 0) {
            ispremium = false;
          } else {
            ispremium = true;
          }

          print('ispremium:$ispremium');
        });

        print('----------fgth--------');
      } catch (error) {
        Fluttertoast.showToast(msg: "Loginrtwe Failed");
        log(error.toString());
      }
    });
    __futureLogin = ResponseHandler.performPost(
        "GetMemberdashboardApp", 'MemberId=${widget.data}&PageIndex=1');
    __futureLogin?.then((value) {
      print('Responsejhsaarg body: ${value.body}');

      String jsonResponse = ResponseHandler.parseData(value.body);

      print('JSON Response: ${jsonResponse}');
      try {
        List<dynamic> decodedJson = json.decode(jsonResponse);
        Map<String, dynamic> firstUser = decodedJson[0];

        print('TotalEarnings ${firstUser["TotalEarnings"]}');

        setState(() {
          TotalEarnings = firstUser["TotalEarnings"].toString();
          AvailableBalance = firstUser["AvailableBalance"].toString();

          DirectIncome = firstUser["DirectIncome"].toString();
          LevelIncome = firstUser["LevelIncome"].toString();
          BinaryIncome = firstUser["BinaryIncome"].toString();
          Notification = firstUser["Notification"].toString();
          Kyc = firstUser["Kyc"].toString();
          UnusedEpins = firstUser["UnusedEpins"].toString();
          UsedEpins = firstUser["UsedEpins"].toString();
          TransferedEpins = firstUser["TransferedEpins"].toString();
          ReceivedEpins = firstUser["ReceivedEpins"].toString();
          TotalWithdrawals = firstUser["TotalWithdrawals"].toString();
          FundTrasnfered = firstUser["FundTrasnfered"].toString();
          FundReceived = firstUser["FundReceived"].toString();
          MessageSent = firstUser["MessageSent"].toString();
          Inbox = firstUser["Inbox"].toString();
          TotalEarnings = firstUser["TotalEarnings"].toString();
          TotalOrders = firstUser["TotalOrders"].toString();
          TotalEarnings = firstUser["TotalEarnings"].toString();
          NewOrders = firstUser["NewOrders"].toString();
          CompletedOrders = firstUser["CompletedOrders"].toString();
          PersonalMember = firstUser["PersonalMember"].toString();
          TeamMember = firstUser["TeamMember"].toString();
          print('TotalEarnings:$TotalEarnings');
        });

        print('---TotalWithdrawals-----:$TotalWithdrawals');
      } catch (error) {
        Fluttertoast.showToast(msg: "Logincawq Failed");
        log(error.toString());
      }
    });

    super.initState();
  }

  void retrieveUsername() async {
    String? storedUserid = await Prefs.getStringValue(Prefs.PREFS_USER_ID);
    String? storedUserName = await Prefs.getStringValue(Prefs.PREFS_USER_NAME);
    String? storedName = await Prefs.getStringValue(Prefs.PREFS_NAME);
    String Photo = await Prefs.getStringValue(Prefs.PREFS_PHOTO);

    setState(() {
      UserId = storedUserid;
      UserName = storedUserName;
      Name = storedName;
      imageUrl = Photo;
      if (imageUrl.startsWith('..')) {
        imageUrl = imageUrl.substring(2);
      }
      print('Userid$UserId');
      print('Name$Name');
      print('UsrttterName$UserName');
      print('imageUrl$imageUrl');
    });
  }

  int currentIndex = 0;
  PageController pageController = PageController(initialPage: 0);

  @override
  void dispose() {
    pageController.dispose();
    super.dispose();
  }

  void onPageChanged(int index) {
    setState(() {
      currentIndex = index;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      key: _scaffoldKey,
      appBar: AppBar(
        backgroundColor: Colors.white,
        automaticallyImplyLeading: false,
        title: Row(
          children: [
            Padding(
              padding: const EdgeInsets.all(0),
              child: IconButton(
                icon: Icon(
                  Icons.menu,
                  color: Colors.black,
                  size: 35,
                ),
                onPressed: () {
                  _scaffoldKey.currentState!.openDrawer();
                },
              ),
            ),
            SizedBox(
              width: 10,
            ),
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  Name!,
                  style: TextStyle(
                    color: Colors.black,
                    fontSize: 17,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                Text(
                  UserName!,
                  style: TextStyle(
                    color: Colors.black,
                    fontSize: 14,
                  ),
                ),
              ],
            ),
            SizedBox(width: 20),
            Image.asset(
              'assets/images/logor.jpg',
              alignment: Alignment.topLeft,
              width: 100,
              height: 50,
            ),
            SizedBox(width: 20),
            Stack(
              children: [
                Image.asset(
                  'assets/images/cartgreen.png',
                  width: 30,
                  height: 40,
                ),
                Positioned(
                  right: -3,
                  top: 4,
                  child: CircleAvatar(
                    radius: 7,
                    backgroundImage:
                        NetworkImage('https://d4demo.com/cheapshop' + imageUrl),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.only(left: 22, top: 4),
                  child: Text(
                    '0',
                    style: TextStyle(
                      fontSize: 10,
                      color: Colors.white,
                      backgroundColor: Colors.transparent,
                    ),
                  ),
                )
              ],
            ),
          ],
        ),
      ),
      drawer: Drawer(
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Container(
                width: 360,
                height: 130,
                decoration: BoxDecoration(
                  border: Border.all(
                    color: Color(0xFF007E01),
                  ),
                  color: Color(0xFF007E01), // Add a border
                ),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: [
                    Padding(
                      padding: EdgeInsets.only(top: 30, left: 20),
                      child: CircleAvatar(
                        radius: 20,
                        backgroundColor: Colors.white,
                        backgroundImage: NetworkImage(
                            'https://d4demo.com/cheapshop' + imageUrl),
                      ),
                    ),
                    SizedBox(width: 10),
                    Padding(
                      padding: const EdgeInsets.only(top: 30, left: 10),
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            'Pios',
                            style: TextStyle(
                                fontSize: 19,
                                fontWeight: FontWeight.bold,
                                color: Colors.white),
                          ),
                          SizedBox(height: 3),
                          Text(
                            'CS10000',
                            style: TextStyle(
                                fontSize: 17,
                                fontWeight: FontWeight.bold,
                                color: Colors.white),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
              InkWell(
                onTap: () {
                  Navigator.of(context).pop();
                  Navigator.push(
                      context,
                      MaterialPageRoute(
                          builder: (context) => Dashboard(
                              data: widget.data, data1: widget.data1)));
                },
                child: Padding(
                  padding: EdgeInsets.only(left: 16, top: 16, bottom: 10),
                  child: Row(
                    children: <Widget>[
                      Icon(Icons.home, color: Color(0xFF007E01)),
                      SizedBox(width: 10),
                      Text(
                        'Dashboard',
                        style: TextStyle(fontSize: 18),
                      ),
                    ],
                  ),
                ),
              ),
              Divider(),
              InkWell(
                onTap: () {
                  Navigator.of(context).pop();
                  Navigator.push(context,
                      MaterialPageRoute(builder: (context) => EditProfile()));
                },
                child: Padding(
                  padding: EdgeInsets.only(left: 16, top: 7, bottom: 10),
                  child: Row(
                    children: <Widget>[
                      Image.asset(
                        "assets/images/name_icon.png",
                        alignment: Alignment.center,
                        height: 21,
                        width: 20,
                        color: Color(0xFF007E01),
                      ),
                      SizedBox(width: 10),
                      Text(
                        'Profile',
                        style: TextStyle(
                            fontSize: 18, fontWeight: FontWeight.w500),
                      ),
                    ],
                  ),
                ),
              ),
              Divider(),
              InkWell(
                onTap: () {
                  Navigator.of(context).pop();
                  Navigator.push(context,
                      MaterialPageRoute(builder: (context) => ReferandEarn()));
                },
                child: Padding(
                  padding: EdgeInsets.only(left: 16, top: 7, bottom: 10),
                  child: Row(
                    children: <Widget>[
                      Image.asset(
                        "assets/images/share_icon.webp",
                        alignment: Alignment.center,
                        height: 21,
                        width: 20,
                        color: Color(0xFF007E01),
                      ),
                      SizedBox(width: 10),
                      Text(
                        'Share and Earn',
                        style: TextStyle(
                            fontSize: 18, fontWeight: FontWeight.w500),
                      ),
                    ],
                  ),
                ),
              ),
              Divider(),
              InkWell(
                onTap: () {
                  // Handle the tap
                  Navigator.of(context).pop();
                  Navigator.push(
                      context,
                      MaterialPageRoute(
                          builder: (context) => ComposeMessage()));
                },
                child: Padding(
                  padding: EdgeInsets.only(left: 16, top: 7, bottom: 10),
                  child: Row(
                    children: <Widget>[
                      Image.asset(
                        "assets/images/wallet.webp",
                        alignment: Alignment.center,
                        height: 21,
                        width: 20,
                        color: Color(0xFF007E01),
                      ),
                      SizedBox(width: 10),
                      Text(
                        'Messages',
                        style: TextStyle(
                            fontSize: 18, fontWeight: FontWeight.w500),
                      ),
                    ],
                  ),
                ),
              ),
              Divider(),
              InkWell(
                onTap: () {
                  Navigator.of(context).pop();
                },
                child: Padding(
                  padding: EdgeInsets.only(left: 16, top: 7, bottom: 10),
                  child: Row(
                    children: <Widget>[
                      Image.asset(
                        "assets/images/messages_new.webp",
                        alignment: Alignment.center,
                        height: 21,
                        width: 20,
                        color: Color(0xFF007E01),
                      ),
                      SizedBox(width: 10),
                      Text(
                        'Notifications',
                        style: TextStyle(
                            fontSize: 18, fontWeight: FontWeight.w500),
                      ),
                    ],
                  ),
                ),
              ),
              Divider(),
              InkWell(
                onTap: () {
                  Navigator.of(context).pop();
                  Navigator.push(context,
                      MaterialPageRoute(builder: (context) => bankdetails()));
                },
                child: Padding(
                  padding: EdgeInsets.only(left: 16, top: 7, bottom: 10),
                  child: Row(
                    children: <Widget>[
                      Image.asset(
                        "assets/images/newsec.webp",
                        alignment: Alignment.center,
                        height: 21,
                        width: 20,
                        color: Color(0xFF007E01),
                      ),
                      SizedBox(width: 10),
                      Text(
                        'Bank Details',
                        style: TextStyle(
                            fontSize: 18, fontWeight: FontWeight.w500),
                      ),
                    ],
                  ),
                ),
              ),
              Divider(),
              InkWell(
                onTap: () {
                  Navigator.of(context).pop();
                },
                child: Padding(
                  padding: EdgeInsets.only(left: 16, top: 7, bottom: 10),
                  child: Row(
                    children: <Widget>[
                      Image.asset(
                        "assets/images/zipcode_icon.webp",
                        alignment: Alignment.center,
                        height: 21,
                        width: 20,
                        color: Color(0xFF007E01),
                      ),
                      SizedBox(width: 10),
                      Text(
                        'Qukart Premium',
                        style: TextStyle(
                            fontSize: 18, fontWeight: FontWeight.w500),
                      ),
                    ],
                  ),
                ),
              ),
              Divider(),
              InkWell(
                onTap: () {
                  Navigator.of(context).pop();
                  showAlertDialog(context);
                },
                child: Padding(
                  padding: EdgeInsets.only(left: 16, top: 7, bottom: 10),
                  child: Row(
                    children: <Widget>[
                      Image.asset(
                        "assets/images/pay.webp",
                        alignment: Alignment.center,
                        height: 21,
                        width: 20,
                        color: Color(0xFF007E01),
                      ),
                      SizedBox(width: 10),
                      Text(
                        'Logout',
                        style: TextStyle(
                            fontSize: 18, fontWeight: FontWeight.w500),
                      ),
                    ],
                  ),
                ),
              ),
              Divider(),
            ],
          ),
        ),
      ),
      body: PageView(
        controller: pageController,
        onPageChanged: onPageChanged,
        children: <Widget>[
          Center(
            child: SingleChildScrollView(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  Container(
                    height: 120,
                    color: Color(0xFF007E01),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.start,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Padding(
                          padding: const EdgeInsets.only(top: 10, left: 10),
                          child: CircleAvatar(
                            backgroundImage: NetworkImage(
                                'https://d4demo.com/cheapshop' + imageUrl),
                            radius: 40.0,
                          ),
                        ),
                        SizedBox(width: 16.0),
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          mainAxisAlignment: MainAxisAlignment.start,
                          children: [
                            Padding(
                              padding: const EdgeInsets.only(top: 10),
                              child: Row(
                                children: [
                                  Text(
                                    Name!,
                                    style: TextStyle(
                                        fontSize: 17.0,
                                        fontWeight: FontWeight.bold,
                                        color: Colors.white),
                                  ),
                                  SizedBox(width: 70.0),
                                  Text('Available',
                                      style: TextStyle(
                                          fontWeight: FontWeight.bold,
                                          fontSize: 15,
                                          color: Colors.white)),
                                ],
                              ),
                            ),
                            SizedBox(height: 8.0),
                            Row(
                              children: [
                                Text(
                                  UserName!,
                                  style: TextStyle(
                                      color: Colors.white,
                                      fontSize: 18.0,
                                      fontWeight: FontWeight.bold),
                                ),
                                SizedBox(width: 25.0),
                                Text("₹" + Balance,
                                    style: TextStyle(
                                        color: Colors.white,
                                        fontWeight: FontWeight.bold,
                                        fontSize: 22)),
                              ],
                            ),
                            SizedBox(height: 8.0),
                            Row(
                              children: [
                                Container(
                                  height: 25,
                                  width: 58,
                                  child: ElevatedButton(
                                      onPressed: () {
                                        Navigator.push(
                                            context,
                                            MaterialPageRoute(
                                                builder:
                                                    (BuildContext context) =>
                                                        EditProfile()));
                                      },
                                      style: ElevatedButton.styleFrom(
                                        primary: Colors.white, // Button color
                                        onPrimary: Colors.white,
                                        shape: RoundedRectangleBorder(
                                          borderRadius:
                                              BorderRadius.circular(10.0),
                                        ),
                                      ),
                                      child: Center(
                                        child: Text(
                                          'EDIT',
                                          style: TextStyle(
                                              fontSize: 12,
                                              color: Color(0xFF007E01)),
                                        ),
                                      )),
                                ),
                              ],
                            ),
                          ],
                        ),
                      ],
                    ),
                  ),
                  SizedBox(
                    height: 12,
                  ),
                  Row(
                    children: [
                      SizedBox(
                        width: 20,
                      ),
                      Padding(
                        padding: const EdgeInsets.only(top: 25),
                        child: GestureDetector(
                          onTap: () {
                            Navigator.push(
                                context,
                                MaterialPageRoute(
                                    builder: (context) => WithdrawFund()));
                          },
                          child: Column(
                            children: [
                              Image.asset(
                                'assets/images/withdraw2.png',
                                cacheHeight: 65,
                                cacheWidth: 65,
                              ),
                              SizedBox(
                                height: 3,
                              ),
                              Text(
                                'Withdraw',
                                style: TextStyle(
                                    fontSize: 17,
                                    color: Colors.black,
                                    fontWeight: FontWeight.w500),
                              )
                            ],
                          ),
                        ),
                      ),
                      SizedBox(
                        width: 70,
                      ),
                      Stack(
                        alignment: Alignment.bottomCenter,
                        children: [
                          Padding(
                            padding: const EdgeInsets.only(top: 17),
                            child: Column(
                              children: [
                                Text(
                                  'Orders',
                                  style: TextStyle(
                                      fontSize: 17,
                                      color: Colors.black,
                                      fontWeight: FontWeight.w500),
                                ),
                                Text(
                                  TotalOrders,
                                  style: TextStyle(
                                      fontSize: 17,
                                      color: Colors.lightBlue,
                                      fontWeight: FontWeight.w500),
                                ),
                              ],
                            ),
                          ),
                          Padding(
                            padding: const EdgeInsets.only(top: 40),
                            child: Center(
                              child: Container(
                                height: 30,
                                width: 30,
                                child: PieChart(
                                  PieChartData(
                                    sections: [
                                      PieChartSectionData(
                                        color: Colors.blue,
                                        value: 70,
                                        title: '40%',
                                        radius: 30,
                                        titleStyle: TextStyle(
                                            fontSize: 16,
                                            fontWeight: FontWeight.bold,
                                            color: Colors.blue),
                                      ),
                                      PieChartSectionData(
                                        color: Colors.green,
                                        value: 45,
                                        radius: 30,
                                        titleStyle: TextStyle(
                                            fontSize: 16,
                                            fontWeight: FontWeight.bold,
                                            color: Colors.green),
                                      ),
                                      PieChartSectionData(
                                        color: Colors.red,
                                        value: 30,
                                        radius: 30,
                                        titleStyle: TextStyle(
                                            fontSize: 16,
                                            fontWeight: FontWeight.bold,
                                            color: Colors.red),
                                      ),
                                    ],
                                    sectionsSpace: 3,
                                    centerSpaceRadius: 40,
                                  ),
                                ),
                              ),
                            ),
                          ),
                        ],
                      ),
                      SizedBox(
                        width: 70,
                      ),
                      Padding(
                        padding: const EdgeInsets.only(top: 25),
                        //FundTransfer
                        child: GestureDetector(
                          onTap: () {
                            Navigator.push(
                                context,
                                MaterialPageRoute(
                                    builder: (context) => FundTransfer()));
                          },
                          child: Column(
                            children: [
                              Image.asset(
                                'assets/images/transfer.png',
                                cacheHeight: 65,
                                cacheWidth: 65,
                              ),
                              SizedBox(
                                height: 3,
                              ),
                              Text(
                                'Transfer',
                                style: TextStyle(
                                    fontSize: 17,
                                    color: Colors.black,
                                    fontWeight: FontWeight.w500),
                              )
                            ],
                          ),
                        ),
                      ),
                    ],
                  ),
                  SizedBox(
                    height: 12,
                  ),
                  Padding(
                    padding: const EdgeInsets.only(top: 25, left: 10),
                    child: Align(
                      alignment: Alignment.topLeft,
                      child: Text(
                        Notification,
                        style: TextStyle(
                            fontSize: 18,
                            color: Colors.blue,
                            fontWeight: FontWeight.w500),
                      ),
                    ),
                  ),
                  SizedBox(
                    height: 12,
                  ),
                  Column(
                    children: [
                      Row(
                        children: [
                          Expanded(
                            child: Card(
                              color: Color(0xFF007E01),
                              elevation: 2,
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(5.0),
                              ),
                              child: GestureDetector(
                                onTap: () {
                                  Navigator.of(context).push(
                                    MaterialPageRoute(
                                        builder: (context) => Wallet_n()),
                                  );
                                },
                                child: Container(
                                  //walletn

                                  child: Column(
                                      mainAxisAlignment:
                                          MainAxisAlignment.center,
                                      children: [
                                        Text(
                                          "₹" + TotalEarnings,
                                          style: TextStyle(
                                              color: Colors.white,
                                              fontSize: 25,
                                              fontWeight: FontWeight.w700),
                                        ),
                                        SizedBox(
                                          height: 5,
                                        ),
                                        Text(
                                          'Total Earning',
                                          style: TextStyle(
                                              fontSize: 17,
                                              color: Colors.white,
                                              fontWeight: FontWeight.w500),
                                        )
                                      ]),

                                  height: 120,
                                ),
                              ),
                            ),
                          ),
                          SizedBox(width: 1.5),
                          Expanded(
                            child: Card(
                              color: Color(0xFF1DAD9F),
                              elevation: 2,
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(5.0),
                              ),
                              child: Container(
                                height: 120,
                                child: Column(
                                    mainAxisAlignment: MainAxisAlignment.center,
                                    children: [
                                      Text(
                                        "₹" + LevelIncome,
                                        style: TextStyle(
                                            color: Colors.white,
                                            fontSize: 25,
                                            fontWeight: FontWeight.w700),
                                      ),
                                      SizedBox(
                                        height: 5,
                                      ),
                                      Text(
                                        'QuKart Cash',
                                        style: TextStyle(
                                            fontSize: 17,
                                            color: Colors.white,
                                            fontWeight: FontWeight.w500),
                                      )
                                    ]),
                              ),
                            ),
                          ),
                        ],
                      ),
                      SizedBox(height: 5),
                      Row(
                        children: [
                          Expanded(
                            child: Card(
                              color: Colors.lightBlue,
                              elevation: 2,
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(5.0),
                              ),
                              child: Container(
                                height: 120,
                                child: Column(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  children: [
                                    Text(
                                      '₹' + Balance1,
                                      style: TextStyle(
                                          color: Colors.white,
                                          fontSize: 25,
                                          fontWeight: FontWeight.w700),
                                    ),
                                    SizedBox(height: 5),
                                    Text(
                                      'Fund Wallet',
                                      style: TextStyle(
                                          fontSize: 17,
                                          color: Colors.white,
                                          fontWeight: FontWeight.w500),
                                    ),
                                  ],
                                ),
                              ),
                            ),
                          ),
                          SizedBox(width: 1.5),
                          Expanded(
                            child: Card(
                              color: Color(0xFFF8709D),
                              elevation: 2,
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(5.0),
                              ),
                              child: GestureDetector(
                                onTap: () {
                                  Navigator.of(context).push(
                                    MaterialPageRoute(
                                        builder: (context) => WithdrawList()),
                                  );
                                },
                                child: Container(
                                  height: 120,
                                  child: Column(
                                    mainAxisAlignment: MainAxisAlignment.center,
                                    children: [
                                      Text(
                                        '₹' + TotalWithdrawals,
                                        style: TextStyle(
                                            color: Colors.white,
                                            fontSize: 25,
                                            fontWeight: FontWeight.w700),
                                      ),
                                      SizedBox(height: 5),
                                      //WithdrawList
                                      Text(
                                        'Total Withdrawals',
                                        style: TextStyle(
                                            fontSize: 17,
                                            color: Colors.white,
                                            fontWeight: FontWeight.w500),
                                      ),
                                    ],
                                  ),
                                ),
                              ),
                            ),
                          ),
                        ],
                      ),
                      SizedBox(height: 5),
                      Row(
                        children: [
                          Expanded(
                            child: Card(
                              color: Color(0xFF566DF1),
                              elevation: 2,
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(5.0),
                              ),
                              child: GestureDetector(
                                onTap: () {
                                  Navigator.of(context).push(
                                    MaterialPageRoute(
                                        builder: (context) =>
                                            FundTransferHistory()),
                                  );
                                },
                                child: Container(
                                  height: 120,
                                  child: Column(
                                    mainAxisAlignment: MainAxisAlignment.center,
                                    children: [
                                      Text(
                                        '₹' + FundTrasnfered,
                                        style: TextStyle(
                                            color: Colors.white,
                                            fontSize: 25,
                                            fontWeight: FontWeight.w700),
                                      ),
                                      SizedBox(height: 5),
                                      Text(
                                        'Fund Transferred',
                                        style: TextStyle(
                                            fontSize: 17,
                                            color: Colors.white,
                                            fontWeight: FontWeight.w500),
                                      ),
                                    ],
                                  ),
                                ),
                              ),
                            ),
                          ),
                          SizedBox(width: 1.5),
                          Expanded(
                            child: Card(
                              color: Colors.deepPurpleAccent,
                              elevation: 2,
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(5.0),
                              ),
                              child: Container(
                                height: 120,
                                child: Column(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  children: [
                                    Text(
                                      '₹' + FundReceived,
                                      style: TextStyle(
                                          color: Colors.white,
                                          fontSize: 25,
                                          fontWeight: FontWeight.w700),
                                    ),
                                    SizedBox(height: 5),
                                    Text(
                                      'Fund Received',
                                      style: TextStyle(
                                          fontSize: 17,
                                          color: Colors.white,
                                          fontWeight: FontWeight.w500),
                                    ),
                                  ],
                                ),
                              ),
                            ),
                          ),
                        ],
                      ),
                      SizedBox(height: 5),
                      Row(
                        children: [
                          Expanded(
                            child: Card(
                              color: Color(0xFFF07E01),
                              elevation: 2,
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(5.0),
                              ),
                              child: GestureDetector(
                                onTap: () {
                                  Navigator.of(context).push(
                                    MaterialPageRoute(
                                        builder: (context) => PendingOrders()),
                                  );
                                },
                                child: Container(
                                  height: 120,
                                  child: Column(
                                    mainAxisAlignment: MainAxisAlignment.center,
                                    children: [
                                      Text(
                                        TotalOrders,
                                        style: TextStyle(
                                            color: Colors.white,
                                            fontSize: 25,
                                            fontWeight: FontWeight.w700),
                                      ),
                                      SizedBox(height: 5),
                                      Text(
                                        'Total Orders',
                                        style: TextStyle(
                                            fontSize: 17,
                                            color: Colors.white,
                                            fontWeight: FontWeight.w500),
                                      ),
                                    ],
                                  ),
                                ),
                              ),
                            ),
                          ),
                        ],
                      ),
                      SizedBox(height: 5),
                      Row(
                        children: [
                          Expanded(
                            child: Card(
                              color: Color(0xFF1DAD9F),
                              elevation: 2,
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(5.0),
                              ),
                              child: GestureDetector(
                                onTap: () {
                                  Navigator.of(context).push(
                                    MaterialPageRoute(
                                        builder: (context) => PendingOrders()),
                                  );
                                },
                                child: Container(
                                  height: 120,
                                  child: Column(
                                    mainAxisAlignment: MainAxisAlignment.center,
                                    children: [
                                      Text(
                                        NewOrders,
                                        style: TextStyle(
                                            color: Colors.white,
                                            fontSize: 25,
                                            fontWeight: FontWeight.w700),
                                      ),
                                      SizedBox(height: 5),
                                      Text(
                                        'New Orders',
                                        style: TextStyle(
                                            fontSize: 17,
                                            color: Colors.white,
                                            fontWeight: FontWeight.w500),
                                      ),
                                    ],
                                  ),
                                ),
                              ),
                            ),
                          ),
                          SizedBox(width: 1.5),
                          Expanded(
                            child: Card(
                              color: Color(0xFFF8709D),
                              elevation: 2,
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(5.0),
                              ),
                              child: GestureDetector(
                                onTap: () {
                                  Navigator.of(context).push(
                                    MaterialPageRoute(
                                        builder: (context) => PendingOrders()),
                                  );
                                },
                                child: Container(
                                  height: 120,
                                  child: Column(
                                    mainAxisAlignment: MainAxisAlignment.center,
                                    children: [
                                      Text(
                                        CompletedOrders,
                                        style: TextStyle(
                                            color: Colors.white,
                                            fontSize: 25,
                                            fontWeight: FontWeight.w700),
                                      ),
                                      SizedBox(height: 5),
                                      Text(
                                        'Completed Orders',
                                        style: TextStyle(
                                            fontSize: 17,
                                            color: Colors.white,
                                            fontWeight: FontWeight.w500),
                                      ),
                                    ],
                                  ),
                                ),
                              ),
                            ),
                          ),
                        ],
                      ),
                      SizedBox(height: 5),
                      Row(
                        children: [
                          Expanded(
                            child: Card(
                              color: Colors.deepPurpleAccent,
                              elevation: 2,
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(5.0),
                              ),
                              child: Container(
                                height: 120,
                                child: Column(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  children: [
                                    Text(
                                      'KYC Status',
                                      style: TextStyle(
                                          color: Colors.white,
                                          fontSize: 15,
                                          fontWeight: FontWeight.w700),
                                    ),
                                    SizedBox(height: 12),
                                    Row(
                                      mainAxisAlignment:
                                          MainAxisAlignment.center,
                                      children: [
                                        Image.asset(
                                          'assets/images/greentick.png',
                                          cacheHeight: 20,
                                          cacheWidth: 20,
                                        ),
                                        SizedBox(
                                          width: 5,
                                        ),
                                        Text(
                                          Kyc,
                                          style: TextStyle(
                                              fontSize: 17,
                                              color: Colors.white,
                                              fontWeight: FontWeight.w500),
                                        ),
                                      ],
                                    ),
                                  ],
                                ),
                              ),
                            ),
                          ),
                          SizedBox(width: 1.5),
                          Expanded(
                            child: Card(
                              color: Color(0xFF566DF1),
                              elevation: 2,
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(5.0),
                              ),
                              child: Container(
                                height: 120,
                                child: Column(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  children: [
                                    Text(
                                      PersonalMember,
                                      style: TextStyle(
                                          color: Colors.white,
                                          fontSize: 25,
                                          fontWeight: FontWeight.w700),
                                    ),
                                    SizedBox(height: 5),
                                    Text(
                                      'Direct Members',
                                      style: TextStyle(
                                          fontSize: 17,
                                          color: Colors.white,
                                          fontWeight: FontWeight.w500),
                                    ),
                                  ],
                                ),
                              ),
                            ),
                          ),
                        ],
                      ),
                      SizedBox(height: 5),
                      Row(
                        children: [
                          Expanded(
                            child: Card(
                              color: Color(0xFF007E01),
                              elevation: 2,
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(5.0),
                              ),
                              child: GestureDetector(
                                onTap: () {
                                  Navigator.of(context).push(
                                    MaterialPageRoute(
                                        builder: (context) => ComposeMessage()),
                                  );
                                },
                                child: Container(
                                  height: 120,
                                  child: Column(
                                    mainAxisAlignment: MainAxisAlignment.center,
                                    children: [
                                      Text(
                                        MessageSent,
                                        style: TextStyle(
                                            color: Colors.white,
                                            fontSize: 25,
                                            fontWeight: FontWeight.w700),
                                      ),
                                      SizedBox(height: 5),
                                      Text(
                                        'Message Sent',
                                        style: TextStyle(
                                            fontSize: 17,
                                            color: Colors.white,
                                            fontWeight: FontWeight.w500),
                                      ),
                                    ],
                                  ),
                                ),
                              ),
                            ),
                          ),
                          SizedBox(width: 1.5),
                          Expanded(
                            child: Card(
                              color: Colors.lightBlue,
                              elevation: 2,
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(5.0),
                              ),
                              child: GestureDetector(
                                onTap: () {
                                  Navigator.of(context).push(
                                    MaterialPageRoute(
                                        builder: (context) => ComposeMessage()),
                                  );
                                },
                                child: Container(
                                  height: 120,
                                  child: Column(
                                    mainAxisAlignment: MainAxisAlignment.center,
                                    children: [
                                      Text(
                                        Inbox,
                                        style: TextStyle(
                                            color: Colors.white,
                                            fontSize: 25,
                                            fontWeight: FontWeight.w700),
                                      ),
                                      SizedBox(height: 5),
                                      Text(
                                        'Inbox Messages',
                                        style: TextStyle(
                                            fontSize: 17,
                                            color: Colors.white,
                                            fontWeight: FontWeight.w500),
                                      ),
                                    ],
                                  ),
                                ),
                              ),
                            ),
                          ),
                        ],
                      ),
                    ],
                  ),
                ],
              ),
            ),
          ),
          Center(child: Text('Buy Products Page')),
          Center(child: Text('My Orders Page')),
          Center(child: Settings()),
        ],
      ),
      bottomNavigationBar: BottomNavigationBar(
        currentIndex: currentIndex,
        backgroundColor: Color(0xFF0071bc), // Background color
        selectedItemColor: Colors.white,
        unselectedItemColor: Colors.white,
        type: BottomNavigationBarType.fixed,

        items: const [
          BottomNavigationBarItem(
            icon: Icon(Icons.home),
            label: "Home",
          ),
          BottomNavigationBarItem(
              icon: Icon(Icons.shopping_cart), label: "Buy Products"),
          BottomNavigationBarItem(
              icon: Icon(Icons.shopping_bag), label: "My Orders"),
          BottomNavigationBarItem(
              icon: Icon(Icons.account_circle), label: "Accounts"),
        ],
        onTap: (int index) {
          setState(() {
            currentIndex = index;
            pageController.animateToPage(
              index,
              duration: Duration(milliseconds: 300),
              curve: Curves.ease,
            );
          });
        },
      ),
    );
  }
}

class Settings extends StatefulWidget {
  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<Settings> {
  String? imageUrl = '',
      UserName = '',
      Address1 = '',
      Address2 = '',
      City = '',
      State = '',
      PinCode = '',
      memberId = '',
      Name = '';

  Future<void> _loadmemberid() async {
    Future<http.Response>? __futureLogin;
    try {
      memberId = await Prefs.getStringValue(Prefs.PREFS_USER_ID);
      log("memberfhhjykkId" + memberId!);

      Name = await Prefs.getStringValue(Prefs.PREFS_NAME);
      __futureLogin =
          ResponseHandler.performPost("MemberSearch", 'MemberId=${memberId}');
      print('memberdfgfdgghId: ${memberId}');

      __futureLogin?.then((value) {
        print('Response dgrgebody: ${value.body}');

        String jsonResponse = ResponseHandler.parseData(value.body);

        print('JSON Redghyjsponse: ${jsonResponse}');
        try {
          //Map<String, dynamic> map = json.decode(jsonResponse);
          List<dynamic> decodedJson = json.decode(jsonResponse);
          Map<String, dynamic> firstUser = decodedJson[0];
          Address1 = firstUser['AddressLine1'];
          Address2 = firstUser['AddressLine2'];
          City = firstUser['City'];
          State = firstUser['State'];
          PinCode = firstUser['Zipcode'];

          print('Firstname ${firstUser["Firstname"]}');
          setState(() {});

          print('TransactionPassword: ${firstUser["TransactionPassword"]}');
          print('------------------');
        } catch (error) {
          Fluttertoast.showToast(msg: "Login Failed");
          log(error.toString());
        }
      });
    } catch (e) {
      print("Error: $e");
      Fluttertoast.showToast(msg: "An error occurred");
    }
  }

  void retrieveUsername() async {
    String Photo = await Prefs.getStringValue(Prefs.PREFS_PHOTO);
    SharedPreferences prefs = await SharedPreferences.getInstance();
    UserName = prefs.getString('username');

    setState(() {
      imageUrl = Photo;
      print('Retrieved username: $UserName');
      if (imageUrl!.startsWith('..')) {
        imageUrl = imageUrl?.substring(2);
      }
      print('imagffffeUrl$imageUrl');
    });
  }

  @override
  void initState() {
    retrieveUsername();
    _loadmemberid();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
          Container(
            padding: EdgeInsets.all(16),
            child: Row(
              children: [
                Text(
                  Name!,
                  style: TextStyle(
                    fontSize: 18,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                SizedBox(width: 166),
                CircleAvatar(
                  radius: 20,
                  backgroundImage:
                      NetworkImage('https://d4demo.com/cheapshop' + imageUrl!),
                ),
              ],
            ),
          ),
          Padding(
            padding: EdgeInsets.symmetric(vertical: 1, horizontal: 16),
            child: Text(
              'Bank Details',
              style: TextStyle(
                  fontSize: 17,
                  fontWeight: FontWeight.bold,
                  color: Colors.black),
            ),
          ),
          Divider(),
          GestureDetector(
            onTap: () {
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => bankdetails(),
                ),
              );
            },
            child: Container(
              padding: EdgeInsets.symmetric(vertical: 1, horizontal: 16),
              child: Row(
                children: [
                  Text(
                    'Manage Bank Details',
                    style: TextStyle(fontSize: 17, fontWeight: FontWeight.w500),
                  ),
                  SizedBox(width: 130),
                  Image.asset(
                    'assets/images/right_arrow.png',
                    width: 16,
                    height: 16,
                  ),
                ],
              ),
            ),
          ),
          Divider(),
          GestureDetector(
            onTap: () {
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => Changepassword(),
                ),
              );
            },
            child: Container(
              padding: EdgeInsets.symmetric(vertical: 1, horizontal: 16),
              child: Row(
                children: [
                  Text(
                    'Change Password',
                    style: TextStyle(fontSize: 17, fontWeight: FontWeight.w500),
                  ),
                  SizedBox(width: 145),
                  Image.asset(
                    'assets/images/right_arrow.png',
                    width: 16,
                    height: 16,
                  ),
                ],
              ),
            ),
          ),
          Divider(),
          GestureDetector(
            onTap: () {
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => ChangeTransactionpassword(),
                ),
              );
            },
            child: Container(
              padding: EdgeInsets.symmetric(vertical: 1, horizontal: 16),
              child: Row(
                children: [
                  Text(
                    'Change Transaction Password',
                    style: TextStyle(fontSize: 17, fontWeight: FontWeight.w500),
                  ),
                  SizedBox(width: 40),
                  Image.asset(
                    'assets/images/right_arrow.png',
                    width: 16,
                    height: 16,
                  ),
                ],
              ),
            ),
          ),
          Divider(),
          GestureDetector(
            onTap: () {
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => SendTestimonal(),
                ),
              );
            },
            child: Container(
              padding: EdgeInsets.symmetric(vertical: 1, horizontal: 16),
              child: Row(
                children: [
                  Text(
                    'Send Testimonial',
                    style: TextStyle(fontSize: 17, fontWeight: FontWeight.w500),
                  ),
                  SizedBox(width: 150),
                  Image.asset(
                    'assets/images/right_arrow.png',
                    width: 16,
                    height: 16,
                  ),
                ],
              ),
            ),
          ),
          Padding(
            padding: EdgeInsets.symmetric(vertical: 16, horizontal: 16),
            child: Text(
              'KYC',
              style: TextStyle(
                  fontSize: 17,
                  color: Colors.black,
                  fontWeight: FontWeight.bold),
            ),
          ),
          GestureDetector(
            onTap: () {
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => KYCApplication(),
                ),
              );
            },
            child: Container(
              padding: EdgeInsets.symmetric(vertical: 1, horizontal: 16),
              child: Row(
                children: [
                  Text(
                    'KYC Application',
                    style: TextStyle(fontSize: 17, fontWeight: FontWeight.w500),
                  ),
                  SizedBox(width: 155),
                  Image.asset(
                    'assets/images/right_arrow.png',
                    width: 16,
                    height: 16,
                  ),
                ],
              ),
            ),
          ),
          Divider(),
          GestureDetector(
            onTap: () {
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => KYCList(),
                ),
              );
            },
            child: Container(
              padding: EdgeInsets.symmetric(vertical: 1, horizontal: 16),
              child: Row(
                children: [
                  Text(
                    'KYC Details',
                    style: TextStyle(fontSize: 17, fontWeight: FontWeight.w500),
                  ),
                  SizedBox(width: 190),
                  Image.asset(
                    'assets/images/right_arrow.png',
                    width: 16,
                    height: 16,
                  ),
                ],
              ),
            ),
          ),
          Padding(
            padding: EdgeInsets.symmetric(vertical: 16, horizontal: 16),
            child: Text(
              'Address',
              style: TextStyle(
                fontSize: 17,
                fontWeight: FontWeight.w500,
                color: Colors.black,
              ),
            ),
          ),
          Divider(),
          Padding(
            padding: EdgeInsets.symmetric(vertical: 6, horizontal: 16),
            child: Text(
              Address1!,
              style: TextStyle(
                  fontSize: 17,
                  color: Colors.black,
                  fontWeight: FontWeight.w500),
            ),
          ),
          Padding(
            padding: EdgeInsets.symmetric(vertical: 6, horizontal: 16),
            child: Text(
              Address2!,
              style: TextStyle(
                  fontSize: 17,
                  color: Colors.black,
                  fontWeight: FontWeight.w500),
            ),
          ),
          Padding(
            padding: EdgeInsets.symmetric(vertical: 6, horizontal: 16),
            child: Text(
              City! + "," + State! + "-" + PinCode!,
              style: TextStyle(
                  fontSize: 17,
                  color: Colors.black,
                  fontWeight: FontWeight.w500),
            ),
          ),
          Padding(
            padding: EdgeInsets.symmetric(vertical: 16, horizontal: 16),
            child: Text(
              'Settings',
              style: TextStyle(
                fontSize: 17,
                fontWeight: FontWeight.w500,
                color: Colors.black,
              ),
            ),
          ),
          Divider(),
          GestureDetector(
            onTap: () {
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => AddReview(),
                ),
              );
            },
            child: Container(
              padding: EdgeInsets.symmetric(vertical: 1, horizontal: 16),
              child: Row(
                children: [
                  Text(
                    'Write a feedback about app',
                    style: TextStyle(fontSize: 17, fontWeight: FontWeight.w500),
                  ),
                  SizedBox(width: 60),
                  Image.asset(
                    'assets/images/right_arrow.png',
                    width: 16,
                    height: 16,
                  ),
                ],
              ),
            ),
          ),
          Divider(),
          GestureDetector(
            onTap: () {
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => Reported_Dispute(),
                ),
              );
            },
            child: Container(
              padding: EdgeInsets.symmetric(vertical: 1, horizontal: 16),
              child: Row(
                children: [
                  Text(
                    'Disputes',
                    style: TextStyle(fontSize: 17, fontWeight: FontWeight.w500),
                  ),
                  SizedBox(width: 225),
                  Image.asset(
                    'assets/images/right_arrow.png',
                    width: 16,
                    height: 16,
                  ),
                ],
              ),
            ),
          ),
          Divider(),
          GestureDetector(
            onTap: () {
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => About(),
                ),
              );
            },
            child: Container(
              padding: EdgeInsets.symmetric(vertical: 1, horizontal: 16),
              child: Row(
                children: [
                  Text(
                    'About',
                    style: TextStyle(fontSize: 17, fontWeight: FontWeight.w500),
                  ),
                  SizedBox(width: 245),
                  Image.asset(
                    'assets/images/right_arrow.png',
                    width: 16,
                    height: 16,
                  ),
                ],
              ),
            ),
          ),
          Divider(),
          GestureDetector(
            onTap: () => showAlertDialog(context),
            child: Container(
              padding: EdgeInsets.symmetric(vertical: 1, horizontal: 16),
              child: Row(
                children: [
                  Text(
                    'Sign Out',
                    style: TextStyle(
                        fontSize: 17,
                        color: Colors.red,
                        fontWeight: FontWeight.w500),
                  ),
                  SizedBox(width: 225),
                  Image.asset(
                    'assets/images/right_arrow.png',
                    width: 16,
                    height: 16,
                  ),
                ],
              ),
            ),
          ),
        ]),
      ),
    );
  }
}

Widget buildCustomRow(String text) {
  return GestureDetector(
    onTap: () {},
    child: Container(
      padding: EdgeInsets.symmetric(vertical: 16, horizontal: 16),
      child: Row(
        children: [
          Text(
            text,
            style: TextStyle(fontSize: 16),
          ),
          SizedBox(width: 220),
          Image.asset(
            'assets/images/right_arrow.png',
            width: 16,
            height: 16,
          ),
        ],
      ),
    ),
  );
}

showAlertDialog(BuildContext context) {
  Widget cancelButton = TextButton(
    child: Text("No",
        style:
            TextStyle(color: Colors.deepOrange, fontWeight: FontWeight.w500)),
    onPressed: () {
      Navigator.pop(context);
    },
  );
  Widget continueButton = TextButton(
    child: Text("Yes",
        style:
            TextStyle(color: Colors.deepOrange, fontWeight: FontWeight.w500)),
    onPressed: () async {
      SharedPreferences prefs = await SharedPreferences.getInstance();
      prefs.remove('username');
      Navigator.pushReplacement(context,
          MaterialPageRoute(builder: (BuildContext ctx) => LoginApp()));
    },
  );

  AlertDialog alert = AlertDialog(
    title: Text("Logout"),
    content: Text("Do you want to Logout?",
        style: TextStyle(color: Colors.black, fontWeight: FontWeight.w500)),
    actions: [
      cancelButton,
      continueButton,
    ],
  );

  // show the dialog
  showDialog(
    context: context,
    builder: (BuildContext context) {
      return alert;
    },
  );
}
