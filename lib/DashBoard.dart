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
import 'package:login_project_sample/KYCProcessing.dart';
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
      String balance = "";
      try {
        //Map<String, dynamic> map = json.decode(jsonResponse);
        List<dynamic> decodedJson = json.decode(jsonResponse);
        Map<String, dynamic> firstUser = decodedJson[0];

        print('CustomerId ${firstUser["CustomerId"]}');
        print('Balance ${firstUser["Balance"]}');
        setState(() {
          Balance = firstUser["Balance"].toString();

          print('Balance:$Balance');
        });

        print('TransactionPassword: ${firstUser["TransactionPassword"]}');
        print('------------------');
      } catch (error) {
        Fluttertoast.showToast(msg: "Login Failed");
        log(error.toString());
      }
    });

    __futureLogin = ResponseHandler.performPost(
        "PremiumMember", 'username=${widget.data1}');
    __futureLogin?.then((value) {
      print('Responsejhg body: ${value.body}');

      String jsonResponse = ResponseHandler.parseData(value.body);

      print('JSON Response: ${jsonResponse}');
      String balance = "";
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
        Fluttertoast.showToast(msg: "Login Failed");
        log(error.toString());
      }
    });
    __futureLogin = ResponseHandler.performPost(
        "GetMemberdashboardApp", 'MemberId=${widget.data}&PageIndex=1');
    __futureLogin?.then((value) {
      print('Responsejhsaarg body: ${value.body}');

      String jsonResponse = ResponseHandler.parseData(value.body);

      print('JSON Response: ${jsonResponse}');
      String balance = "";
      try {
        //Map<String, dynamic> map = json.decode(jsonResponse);
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
        Fluttertoast.showToast(msg: "Login Failed");
        log(error.toString());
      }
    });

    super.initState();
  }

  void retrieveUsername() async {
    String? storedUserid = await Prefs.getStringValue(Prefs.PREFS_USER_ID);
    String? storedUserName = await Prefs.getStringValue(Prefs.PREFS_USER_NAME);
    String? storedName = await Prefs.getStringValue(Prefs.PREFS_NAME);

    setState(() {
      UserId = storedUserid;
      UserName = storedUserName;
      Name = storedName;
      print('Userid$UserId');
      print('Name$Name');
      print('UserName$UserName');
    });
  }

  int currentIndex = 0;
  PageController pageController = PageController(initialPage: 0);
  final List<Widget> _pages = [
    /* HomePage(),
    ProductsPage(),
    OrdersPage(),*/
    Settings(),
  ];

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

  Map<String, double> dataMap = {
    "Food Items": 18.47,
    "Clothes": 17.70,
    "Technology": 4.25,
    "Cosmetics": 3.51,
    "Other": 2.83,
  };

  // Colors for each segment
  // of the pie chart

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
              padding: const EdgeInsets.all(0), // Remove any leading padding
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
                  'Pios Uriyil',
                  style: TextStyle(
                    color: Colors.black,
                    fontSize: 17,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                Text(
                  'CS1000000',
                  style: TextStyle(
                    color: Colors.black,
                    fontSize: 14,
                  ),
                ),
              ],
            ),
            SizedBox(width: 40), // Add some space between elements
            Image.asset(
              'assets/images/logor.jpg', alignment: Alignment.topLeft,
              width: 100, // Adjust the width as needed
              height: 50, // Adjust the height as needed
            ),
            SizedBox(width: 20),
            Stack(
              children: [
                Image.asset(
                  'assets/images/cartgreen.png',
                  width: 30, // Adjust the width as needed
                  height: 40, // Adjust the height as needed
                ),
                Positioned(
                  right: -3,
                  top: 4,
                  child: CircleAvatar(
                    radius: 7,
                    backgroundImage: AssetImage('assets/circle_image.jpg'),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.only(left: 22, top: 4),
                  child: Text(
                    '0',
                    style: TextStyle(
                      fontSize: 10,
                      color: Colors.white,
                      backgroundColor:
                          Colors.transparent, // Make the background transparent
                    ),
                  ),
                )
              ],
            ),
            // Add some space between elements
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
                  mainAxisAlignment: MainAxisAlignment
                      .start, // Align items to the start (left)
                  children: [
                    Padding(
                      padding: EdgeInsets.only(
                          top: 30,
                          left: 20), // Add some padding around the image
                      child: CircleAvatar(
                        radius: 20,
                        backgroundColor: Colors.white,
                        child: Icon(
                          Icons.person,
                          size: 30,
                          color: Colors.black54,
                        ),
                      ),
                    ),
                    SizedBox(
                        width: 10), // Add some space between the image and text
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
                  // Handle the tap
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
                  // Handle the tap
                  Navigator.of(context).pop(); // Close the drawer
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
                        style: TextStyle(fontSize: 18),
                      ),
                    ],
                  ),
                ),
              ),
              Divider(),
              InkWell(
                onTap: () {
                  // Handle the tap
                  Navigator.of(context).pop(); // Close the drawer
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
                        style: TextStyle(fontSize: 18),
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
                  //ComposeMessage.dart
                  // Navigate to the desired screen or perform an action
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
                        style: TextStyle(fontSize: 18),
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
                  //BankDetails.dart// Close the drawer
                  // Navigate to the desired screen or perform an action
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
                        style: TextStyle(fontSize: 18),
                      ),
                    ],
                  ),
                ),
              ),
              Divider(),
              InkWell(
                onTap: () {
                  // Handle the tap
                  Navigator.of(context).pop(); // Close the drawer
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
                        style: TextStyle(fontSize: 18),
                      ),
                    ],
                  ),
                ),
              ),
              Divider(),
              InkWell(
                onTap: () {
                  // Handle the tap
                  Navigator.of(context).pop(); // Close the drawer
                  // Navigate to the desired screen or perform an action
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
                        style: TextStyle(fontSize: 18),
                      ),
                    ],
                  ),
                ),
              ),
              Divider(),
              InkWell(
                onTap: () {
                  // Handle the tap
                  Navigator.of(context).pop(); // Close the drawer
                  // Navigate to the desired screen or perform an action
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
                        style: TextStyle(fontSize: 18),
                      ),
                    ],
                  ),
                ),
              ),
              Divider(),
              /*   ListTile(
                  onTap: () {
                    setState(() {
                      index = 0;
                    });
                    Navigator.pop(context);
                  },
                  leading: Icon(Icons.home),
                  title:
                      Text("Home", style: TextStyle(fontFamily: "Montserrat")),
                ),*/
              // ListTile(onTap: (){}, leading: Icon(Icons.book_online_outlined), title:  Text("Bookings", style: TextStyle(fontFamily: "Montserrat")),),
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
                            backgroundImage: AssetImage(
                              'assets/images/blankprofile.webp',
                            ),
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
                                    //"Received Data: ${widget.data}",
                                    style: TextStyle(
                                        fontSize: 17.0,
                                        fontWeight: FontWeight.bold,
                                        color: Colors.white),
                                  ),
                                  SizedBox(width: 90.0),
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
                                SizedBox(width: 70.0),
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
                                          borderRadius: BorderRadius.circular(
                                              10.0), // Change radius here
                                        ), // Text color
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
                        /*  Spacer(),
            ElevatedButton(
              onPressed: () {
                // Handle Edit Button click
              },
              child: Text('Edit'),
            ),*/
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
                              Text('WithDraw')
                            ],
                          ),
                        ),
                      ),
                      SizedBox(
                        width: 80,
                      ),
                      Stack(
                        alignment: Alignment.bottomCenter,
                        children: [
                          Column(
                            children: [
                              Text(
                                'Orders', // Replace with your desired text
                                style: TextStyle(
                                  fontSize:
                                      15, // Adjust the font size as needed
                                ),
                              ),
                              Text(
                                TotalOrders, // Replace with your desired text
                                style: TextStyle(
                                  color: Colors.lightBlue,
                                  fontWeight: FontWeight.bold,
                                  fontSize:
                                      15, // Adjust the font size as needed
                                ),
                              ),
                            ],
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
                        width: 75,
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
                              Text('Transfer')
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
                        style: TextStyle(color: Colors.blue, fontSize: 18),
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
                              color:
                                  Color(0xFF007E01), // Change color as needed
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
                                              fontSize: 17,
                                              fontFamily: "Montserrat"),
                                        ),
                                        SizedBox(
                                          height: 4.5,
                                        ),
                                        Text(
                                          'Total Earning',
                                          style: TextStyle(
                                              color: Colors.white,
                                              fontSize: 17,
                                              fontFamily: "Montserrat"),
                                        )
                                      ]),

                                  height: 120,

                                  // Card content for the first card
                                ),
                              ),
                            ),
                          ),
                          SizedBox(width: 1.5), // Adjust spacing between cards
                          Expanded(
                            child: Card(
                              color:
                                  Color(0xFF1DAD9F), // Change color as needed
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
                                            fontSize: 17,
                                            fontFamily: "Montserrat"),
                                      ),
                                      SizedBox(
                                        height: 4.5,
                                      ),
                                      Text(
                                        'QuKart Cash',
                                        style: TextStyle(
                                            color: Colors.white,
                                            fontSize: 17,
                                            fontFamily: "Montserrat"),
                                      )
                                    ]),
                                // Card content for the second card
                              ),
                            ),
                          ),
                        ],
                      ),
                      SizedBox(height: 5), // Adjust spacing between rows
                      Row(
                        children: [
                          Expanded(
                            child: Card(
                              color: Colors.lightBlue, // Change color as needed
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
                                      '₹0.00',
                                      style: TextStyle(
                                          color: Colors.white,
                                          fontSize: 17,
                                          fontFamily: "Montserrat"),
                                    ),
                                    SizedBox(height: 4.5),
                                    Text(
                                      'Fund Wallet',
                                      style: TextStyle(
                                          color: Colors.white,
                                          fontSize: 17,
                                          fontFamily: "Montserrat"),
                                    ),
                                  ],
                                ),
                                // Card content for the third card
                              ),
                            ),
                          ),
                          SizedBox(width: 1.5), // Adjust spacing between cards
                          Expanded(
                            child: Card(
                              color:
                                  Color(0xFFF8709D), // Change color as needed
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
                                            fontSize: 17,
                                            fontFamily: "Montserrat"),
                                      ),
                                      SizedBox(height: 4.5),
                                      //WithdrawList
                                      Text(
                                        'Total Withdrawals',
                                        style: TextStyle(
                                            color: Colors.white,
                                            fontSize: 17,
                                            fontFamily: "Montserrat"),
                                      ),
                                    ],
                                  ),
                                  // Card content for the fourth card
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
                              color:
                                  Color(0xFF566DF1), // Change color as needed
                              elevation: 2,
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(5.0),
                              ),
//FundTransferHistory
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
                                            fontSize: 17,
                                            fontFamily: "Montserrat"),
                                      ),
                                      SizedBox(height: 4.5),
                                      Text(
                                        'Fund Transferred',
                                        style: TextStyle(
                                            color: Colors.white,
                                            fontSize: 17,
                                            fontFamily: "Montserrat"),
                                      ),
                                    ],
                                  ),
                                  // Card content for the third card
                                ),
                              ),
                            ),
                          ),
                          SizedBox(width: 1.5), // Adjust spacing between cards
                          Expanded(
                            child: Card(
                              color: Colors
                                  .deepPurpleAccent, // Change color as needed
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
                                          fontSize: 17,
                                          fontFamily: "Montserrat"),
                                    ),
                                    SizedBox(height: 4.5),
                                    Text(
                                      'Fund Received',
                                      style: TextStyle(
                                          color: Colors.white,
                                          fontSize: 17,
                                          fontFamily: "Montserrat"),
                                    ),
                                  ],
                                ),
                                // Card content for the fourth card
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
                              color:
                                  Color(0xFFF07E01), // Change color as needed
                              elevation: 2,
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(5.0),
                              ),
//PendingOrders
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
                                            fontSize: 17,
                                            fontFamily: "Montserrat"),
                                      ),
                                      SizedBox(height: 4.5),
                                      Text(
                                        'Total Orders',
                                        style: TextStyle(
                                            color: Colors.white,
                                            fontSize: 17,
                                            fontFamily: "Montserrat"),
                                      ),
                                    ],
                                  ),
                                  // Card content for the third card
                                ),
                              ),
                            ),
                          ),
                          // Add more rows with different background colors and card contents if needed
                        ],
                      ),
                      SizedBox(height: 5),
                      Row(
                        children: [
                          Expanded(
                            child: Card(
                              color:
                                  Color(0xFF1DAD9F), // Change color as needed
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
                                            fontSize: 17,
                                            fontFamily: "Montserrat"),
                                      ),
                                      SizedBox(height: 4.5),
                                      Text(
                                        'New Orders',
                                        style: TextStyle(
                                            color: Colors.white,
                                            fontSize: 17,
                                            fontFamily: "Montserrat"),
                                      ),
                                    ],
                                  ),
                                  // Card content for the third card
                                ),
                              ),
                            ),
                          ),
                          SizedBox(width: 1.5), // Adjust spacing between cards
                          Expanded(
                            child: Card(
                              color:
                                  Color(0xFFF8709D), // Change color as needed
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
                                            fontSize: 17,
                                            fontFamily: "Montserrat"),
                                      ),
                                      SizedBox(height: 4.5),
                                      Text(
                                        'Completed Orders',
                                        style: TextStyle(
                                            color: Colors.white,
                                            fontSize: 17,
                                            fontFamily: "Montserrat"),
                                      ),
                                    ],
                                  ),
                                  // Card content for the fourth card
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
                              color: Colors
                                  .deepPurpleAccent, // Change color as needed
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
                                          fontFamily: "Montserrat"),
                                    ),
                                    SizedBox(height: 7.5),
                                    Row(
                                      mainAxisAlignment:
                                          MainAxisAlignment.center,
                                      children: [
                                        Image.asset(
                                          'assets/images/greentick.png',
                                          cacheHeight: 20,
                                          cacheWidth: 20,
                                        ),
                                        Text(
                                          Kyc,
                                          style: TextStyle(
                                              color: Colors.white,
                                              fontSize: 17,
                                              fontFamily: "Montserrat"),
                                        ),
                                      ],
                                    ),
                                  ],
                                ),
                                // Card content for the third card
                              ),
                            ),
                          ),
                          SizedBox(width: 1.5), // Adjust spacing between cards
                          Expanded(
                            child: Card(
                              color:
                                  Color(0xFF566DF1), // Change color as needed
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
                                          fontSize: 17,
                                          fontFamily: "Montserrat"),
                                    ),
                                    SizedBox(height: 4.5),
                                    Text(
                                      'Direct Members',
                                      style: TextStyle(
                                          color: Colors.white,
                                          fontSize: 17,
                                          fontFamily: "Montserrat"),
                                    ),
                                  ],
                                ),
                                // Card content for the fourth card
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
                              color:
                                  Color(0xFF007E01), // Change color as needed
                              elevation: 2,
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(5.0),
                              ),
//ComposeMessage
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
                                            fontSize: 17,
                                            fontFamily: "Montserrat"),
                                      ),
                                      SizedBox(height: 4.5),
                                      Text(
                                        'Message Sent',
                                        style: TextStyle(
                                            color: Colors.white,
                                            fontSize: 17,
                                            fontFamily: "Montserrat"),
                                      ),
                                    ],
                                  ),
                                  // Card content for the third card
                                ),
                              ),
                            ),
                          ),
                          SizedBox(width: 1.5), // Adjust spacing between cards
                          Expanded(
                            child: Card(
                              color: Colors.lightBlue, // Change color as needed
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
                                            fontSize: 17,
                                            fontFamily: "Montserrat"),
                                      ),
                                      SizedBox(height: 4.5),
                                      Text(
                                        'Inbox Messages',
                                        style: TextStyle(
                                            color: Colors.white,
                                            fontSize: 17,
                                            fontFamily: "Montserrat"),
                                      ),
                                    ],
                                  ),
                                  // Card content for the fourth card
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
          // Add your separate body content for the "Accounts" tab here
          Center(child: Settings()),
        ],
      ),
      bottomNavigationBar: BottomNavigationBar(
        currentIndex: currentIndex,
        backgroundColor: Color(0xFF0071bc), // Background color
        selectedItemColor: Colors.white,
        unselectedItemColor: Colors.white,
        type: BottomNavigationBarType.fixed,
        unselectedLabelStyle: const TextStyle(fontFamily: "Montserrat"),
        selectedLabelStyle: const TextStyle(fontFamily: "Montserrat"),
        items: const [
          BottomNavigationBarItem(
            icon: Icon(Icons.home),
            label: "Home",
          ),
          BottomNavigationBarItem(
              icon: Icon(Icons.shopping_cart), label: "But Products"),
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

class YourAccountsBody extends StatefulWidget {
  @override
  _YourAccountsBodyState createState() => _YourAccountsBodyState();
  late final String data, data1;
  // Use the constructor to receive the data
  YourAccountsBody({required this.data, required this.data1});
}

class _YourAccountsBodyState extends State<YourAccountsBody> {
  Future<http.Response>? __futureLogin;
  GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey<ScaffoldState>();

  late String Balance = "",
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
      String balance = "";
      try {
        //Map<String, dynamic> map = json.decode(jsonResponse);
        List<dynamic> decodedJson = json.decode(jsonResponse);
        Map<String, dynamic> firstUser = decodedJson[0];

        print('CustomerId ${firstUser["CustomerId"]}');
        print('Balance ${firstUser["Balance"]}');
        setState(() {
          Balance = firstUser["Balance"].toString();

          print('Balance:$Balance');
        });

        print('TransactionPassword: ${firstUser["TransactionPassword"]}');
        print('------------------');
      } catch (error) {
        Fluttertoast.showToast(msg: "Login Failed");
        log(error.toString());
      }
    });

    __futureLogin = ResponseHandler.performPost(
        "PremiumMember", 'username=${widget.data1}');
    __futureLogin?.then((value) {
      print('Responsejhg body: ${value.body}');

      String jsonResponse = ResponseHandler.parseData(value.body);

      print('JSON Response: ${jsonResponse}');
      String balance = "";
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
        Fluttertoast.showToast(msg: "Login Failed");
        log(error.toString());
      }
    });
    __futureLogin = ResponseHandler.performPost(
        "GetMemberdashboardApp", 'MemberId=${widget.data}&PageIndex=1');
    __futureLogin?.then((value) {
      print('Responsejhsaarg body: ${value.body}');

      String jsonResponse = ResponseHandler.parseData(value.body);

      print('JSON Response: ${jsonResponse}');
      String balance = "";
      try {
        //Map<String, dynamic> map = json.decode(jsonResponse);
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
        Fluttertoast.showToast(msg: "Login Failed");
        log(error.toString());
      }
    });

    super.initState();
  }

  // Add your state variables and logic here
  void retrieveUsername() async {
    String? storedUserid = await Prefs.getStringValue(Prefs.PREFS_USER_ID);
    String? storedUserName = await Prefs.getStringValue(Prefs.PREFS_USER_NAME);
    String? storedName = await Prefs.getStringValue(Prefs.PREFS_NAME);

    setState(() {
      UserId = storedUserid;
      UserName = storedUserName;
      Name = storedName;
      print('Userid$UserId');
      print('Name$Name');
      print('UserName$UserName');
    });
  }

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisAlignment: MainAxisAlignment.start,
        children: [
          Container(
            height: 150,
            color: Colors.green,
            child: Row(
              children: [
                CircleAvatar(
                  backgroundImage: AssetImage(
                    'assets/images/blankprofile.webp',
                  ),
                  radius: 40.0,
                ),
                SizedBox(width: 16.0),
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Padding(
                      padding: const EdgeInsets.only(top: 10),
                      child: Row(
                        children: [
                          Text(
                            Name!,
                            //"Received Data: ${widget.data}",
                            style: TextStyle(
                                fontSize: 17.0,
                                fontWeight: FontWeight.bold,
                                color: Colors.white),
                          ),
                          SizedBox(width: 90.0),
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
                        SizedBox(width: 70.0),
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
                                        builder: (BuildContext context) =>
                                            EditProfile()));
                              },
                              style: ElevatedButton.styleFrom(
                                primary: Colors.white, // Button color
                                onPrimary: Colors.white,
                                shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(
                                      10.0), // Change radius here
                                ), // Text color
                              ),
                              child: Center(
                                child: Text(
                                  'EDIT',
                                  style: TextStyle(
                                      fontSize: 12, color: Colors.green),
                                ),
                              )),
                        ),
                      ],
                    ),
                  ],
                ),
                /*  Spacer(),
            ElevatedButton(
              onPressed: () {
                // Handle Edit Button click
              },
              child: Text('Edit'),
            ),*/
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
                      Text('WithDraw')
                    ],
                  ),
                ),
              ),
              SizedBox(
                width: 80,
              ),
              Stack(
                alignment: Alignment.bottomCenter,
                children: [
                  Column(
                    children: [
                      Text(
                        'Orders', // Replace with your desired text
                        style: TextStyle(
                          fontSize: 15, // Adjust the font size as needed
                        ),
                      ),
                      Text(
                        TotalOrders, // Replace with your desired text
                        style: TextStyle(
                          color: Colors.lightBlue,
                          fontWeight: FontWeight.bold,
                          fontSize: 15, // Adjust the font size as needed
                        ),
                      ),
                    ],
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
                width: 75,
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
                      Text('Transfer')
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
                style: TextStyle(color: Colors.blue, fontSize: 18),
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
                      color: Colors.green, // Change color as needed
                      elevation: 2,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(5.0),
                      ),
                      child: GestureDetector(
                        onTap: () {
                          Navigator.of(context).push(
                            MaterialPageRoute(builder: (context) => Wallet_n()),
                          );
                        },
                        child: Container(
                          //walletn

                          child: Column(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                Text(
                                  "₹" + TotalEarnings,
                                  style: TextStyle(
                                      color: Colors.white,
                                      fontSize: 17,
                                      fontFamily: "Montserrat"),
                                ),
                                SizedBox(
                                  height: 4.5,
                                ),
                                Text(
                                  'Total Earning',
                                  style: TextStyle(
                                      color: Colors.white,
                                      fontSize: 17,
                                      fontFamily: "Montserrat"),
                                )
                              ]),

                          height: 120,

                          // Card content for the first card
                        ),
                      ),
                    ),
                  ),
                  SizedBox(width: 1.5), // Adjust spacing between cards
                  Expanded(
                    child: Card(
                      color: Color(0xFF1DAD9F), // Change color as needed
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
                                    fontSize: 17,
                                    fontFamily: "Montserrat"),
                              ),
                              SizedBox(
                                height: 4.5,
                              ),
                              Text(
                                'QuKart Cash',
                                style: TextStyle(
                                    color: Colors.white,
                                    fontSize: 17,
                                    fontFamily: "Montserrat"),
                              )
                            ]),
                        // Card content for the second card
                      ),
                    ),
                  ),
                ],
              ),
              SizedBox(height: 5), // Adjust spacing between rows
              Row(
                children: [
                  Expanded(
                    child: Card(
                      color: Colors.lightBlue, // Change color as needed
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
                              '₹0.00',
                              style: TextStyle(
                                  color: Colors.white,
                                  fontSize: 17,
                                  fontFamily: "Montserrat"),
                            ),
                            SizedBox(height: 4.5),
                            Text(
                              'Fund Wallet',
                              style: TextStyle(
                                  color: Colors.white,
                                  fontSize: 17,
                                  fontFamily: "Montserrat"),
                            ),
                          ],
                        ),
                        // Card content for the third card
                      ),
                    ),
                  ),
                  SizedBox(width: 1.5), // Adjust spacing between cards
                  Expanded(
                    child: Card(
                      color: Color(0xFFF8709D), // Change color as needed
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
                                    fontSize: 17,
                                    fontFamily: "Montserrat"),
                              ),
                              SizedBox(height: 4.5),
                              //WithdrawList
                              Text(
                                'Total Withdrawals',
                                style: TextStyle(
                                    color: Colors.white,
                                    fontSize: 17,
                                    fontFamily: "Montserrat"),
                              ),
                            ],
                          ),
                          // Card content for the fourth card
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
                      color: Color(0xFF566DF1), // Change color as needed
                      elevation: 2,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(5.0),
                      ),
//FundTransferHistory
                      child: GestureDetector(
                        onTap: () {
                          Navigator.of(context).push(
                            MaterialPageRoute(
                                builder: (context) => FundTransferHistory()),
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
                                    fontSize: 17,
                                    fontFamily: "Montserrat"),
                              ),
                              SizedBox(height: 4.5),
                              Text(
                                'Fund Transferred',
                                style: TextStyle(
                                    color: Colors.white,
                                    fontSize: 17,
                                    fontFamily: "Montserrat"),
                              ),
                            ],
                          ),
                          // Card content for the third card
                        ),
                      ),
                    ),
                  ),
                  SizedBox(width: 1.5), // Adjust spacing between cards
                  Expanded(
                    child: Card(
                      color: Colors.deepPurpleAccent, // Change color as needed
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
                                  fontSize: 17,
                                  fontFamily: "Montserrat"),
                            ),
                            SizedBox(height: 4.5),
                            Text(
                              'Fund Received',
                              style: TextStyle(
                                  color: Colors.white,
                                  fontSize: 17,
                                  fontFamily: "Montserrat"),
                            ),
                          ],
                        ),
                        // Card content for the fourth card
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
                      color: Color(0xFFF07E01), // Change color as needed
                      elevation: 2,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(5.0),
                      ),
//PendingOrders
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
                                    fontSize: 17,
                                    fontFamily: "Montserrat"),
                              ),
                              SizedBox(height: 4.5),
                              Text(
                                'Total Orders',
                                style: TextStyle(
                                    color: Colors.white,
                                    fontSize: 17,
                                    fontFamily: "Montserrat"),
                              ),
                            ],
                          ),
                          // Card content for the third card
                        ),
                      ),
                    ),
                  ),
                  // Add more rows with different background colors and card contents if needed
                ],
              ),
              SizedBox(height: 5),
              Row(
                children: [
                  Expanded(
                    child: Card(
                      color: Color(0xFF1DAD9F), // Change color as needed
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
                                    fontSize: 17,
                                    fontFamily: "Montserrat"),
                              ),
                              SizedBox(height: 4.5),
                              Text(
                                'New Orders',
                                style: TextStyle(
                                    color: Colors.white,
                                    fontSize: 17,
                                    fontFamily: "Montserrat"),
                              ),
                            ],
                          ),
                          // Card content for the third card
                        ),
                      ),
                    ),
                  ),
                  SizedBox(width: 1.5), // Adjust spacing between cards
                  Expanded(
                    child: Card(
                      color: Color(0xFFF8709D), // Change color as needed
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
                                    fontSize: 17,
                                    fontFamily: "Montserrat"),
                              ),
                              SizedBox(height: 4.5),
                              Text(
                                'Completed Orders',
                                style: TextStyle(
                                    color: Colors.white,
                                    fontSize: 17,
                                    fontFamily: "Montserrat"),
                              ),
                            ],
                          ),
                          // Card content for the fourth card
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
                      color: Colors.deepPurpleAccent, // Change color as needed
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
                                  fontFamily: "Montserrat"),
                            ),
                            SizedBox(height: 7.5),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                Image.asset(
                                  'assets/images/greentick.png',
                                  cacheHeight: 20,
                                  cacheWidth: 20,
                                ),
                                Text(
                                  Kyc,
                                  style: TextStyle(
                                      color: Colors.white,
                                      fontSize: 17,
                                      fontFamily: "Montserrat"),
                                ),
                              ],
                            ),
                          ],
                        ),
                        // Card content for the third card
                      ),
                    ),
                  ),
                  SizedBox(width: 1.5), // Adjust spacing between cards
                  Expanded(
                    child: Card(
                      color: Color(0xFF566DF1), // Change color as needed
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
                                  fontSize: 17,
                                  fontFamily: "Montserrat"),
                            ),
                            SizedBox(height: 4.5),
                            Text(
                              'Direct Members',
                              style: TextStyle(
                                  color: Colors.white,
                                  fontSize: 17,
                                  fontFamily: "Montserrat"),
                            ),
                          ],
                        ),
                        // Card content for the fourth card
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
                      color: Colors.green, // Change color as needed
                      elevation: 2,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(5.0),
                      ),
//ComposeMessage
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
                                    fontSize: 17,
                                    fontFamily: "Montserrat"),
                              ),
                              SizedBox(height: 4.5),
                              Text(
                                'Message Sent',
                                style: TextStyle(
                                    color: Colors.white,
                                    fontSize: 17,
                                    fontFamily: "Montserrat"),
                              ),
                            ],
                          ),
                          // Card content for the third card
                        ),
                      ),
                    ),
                  ),
                  SizedBox(width: 1.5), // Adjust spacing between cards
                  Expanded(
                    child: Card(
                      color: Colors.lightBlue, // Change color as needed
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
                                    fontSize: 17,
                                    fontFamily: "Montserrat"),
                              ),
                              SizedBox(height: 4.5),
                              Text(
                                'Inbox Messages',
                                style: TextStyle(
                                    color: Colors.white,
                                    fontSize: 17,
                                    fontFamily: "Montserrat"),
                              ),
                            ],
                          ),
                          // Card content for the fourth card
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
    );
  }
}

class Settings extends StatefulWidget {
  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<Settings> {
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
                  "PIOS URIRIJI",
                  style: TextStyle(
                    fontSize: 18,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                SizedBox(width: 166),
                CircleAvatar(
                  radius: 20,
                  backgroundImage: AssetImage('assets/circle_image.jpg'),
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
                    style: TextStyle(fontSize: 16, fontFamily: "Montserrat"),
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
          //Changepassword
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
                    style: TextStyle(fontSize: 17, fontFamily: "Montserrat"),
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
          //ChangeTransactionpassword
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
                    style: TextStyle(fontSize: 17, fontFamily: "Montserrat"),
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
          //SendTestimonal
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
                    style: TextStyle(fontSize: 17, fontFamily: "Montserrat"),
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
                  fontWeight: FontWeight.bold,
                  color: Colors.black,
                  fontFamily: "Montserrat"),
            ),
          ),
          //KYCApplication
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
                    style: TextStyle(fontSize: 17, fontFamily: "Montserrat"),
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
                    style: TextStyle(fontSize: 17, fontFamily: "Montserrat"),
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
                  fontWeight: FontWeight.bold,
                  color: Colors.black,
                  fontFamily: "Montserrat"),
            ),
          ),
          Divider(),
          Padding(
            padding: EdgeInsets.symmetric(vertical: 6, horizontal: 16),
            child: Text(
              'Address1',
              style: TextStyle(
                  fontSize: 17, color: Colors.black, fontFamily: "Montserrat"),
            ),
          ),
          Padding(
            padding: EdgeInsets.symmetric(vertical: 6, horizontal: 16),
            child: Text(
              'Address2',
              style: TextStyle(
                  fontSize: 17, color: Colors.black, fontFamily: "Montserrat"),
            ),
          ),
          Padding(
            padding: EdgeInsets.symmetric(vertical: 6, horizontal: 16),
            child: Text(
              'City',
              style: TextStyle(
                  fontSize: 17, color: Colors.black, fontFamily: "Montserrat"),
            ),
          ),
          Padding(
            padding: EdgeInsets.symmetric(vertical: 16, horizontal: 16),
            child: Text(
              'Settings',
              style: TextStyle(
                  fontSize: 17,
                  fontWeight: FontWeight.bold,
                  color: Colors.black,
                  fontFamily: "Montserrat"),
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
                    style: TextStyle(fontSize: 17, fontFamily: "Montserrat"),
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
                    style: TextStyle(fontSize: 17, fontFamily: "Montserrat"),
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
          //About
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
                    style: TextStyle(fontSize: 17, fontFamily: "Montserrat"),
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
          Container(
            padding: EdgeInsets.symmetric(vertical: 1, horizontal: 16),
            child: Row(
              children: [
                Text(
                  'Sign Out',
                  style: TextStyle(
                      fontSize: 17,
                      color: Colors.red,
                      fontFamily: "Montserrat"),
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
          // ... Other sections
        ]),
      ),
    );
  }
}

Widget buildCustomRow(String text) {
  return GestureDetector(
    onTap: () {
      // Handle row tap
    },
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
