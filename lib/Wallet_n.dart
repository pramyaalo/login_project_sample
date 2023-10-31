import 'dart:convert';
import 'dart:developer';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:http/http.dart' as http;
import 'package:flutter/material.dart';
import 'package:login_project_sample/AddFunDWallet.dart';
import 'package:login_project_sample/CashWalletHistory.dart';
import 'package:login_project_sample/FundTransferHistory.dart';
import 'package:login_project_sample/Payouts.dart';
import 'package:login_project_sample/QCashWalletHistory.dart';
import 'package:login_project_sample/WithDrawFund.dart';
import 'package:login_project_sample/WithdrawList.dart';
import 'package:login_project_sample/utils/response_handler.dart';
import 'package:login_project_sample/utils/shared_preferences.dart';

class Wallet_n extends StatefulWidget {
  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<Wallet_n> {
  Future<http.Response>? __futureLogin;
  String memberId = '', Name = '', UserName = '';
  late String Balance = "";
  @override
  void initState() {
    _loadmemberid();

    super.initState();
  }

  Future<void> _loadmemberid() async {
    try {
      memberId = await Prefs.getStringValue(Prefs.PREFS_USER_ID);
      log("memberId" + memberId);
      UserName = await Prefs.getStringValue(Prefs.PREFS_USER_NAME);
      Name = await Prefs.getStringValue(Prefs.PREFS_NAME);
      log("memberId" + Name);
      __futureLogin = ResponseHandler.performPost(
          "GetEwalletbalanceTranspwd", 'MemberId=${memberId}');
      print('memberdfgfdgghId: ${memberId}');
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
            Balance = double.parse(firstUser["Balance"].toString())
                .toStringAsFixed(2);
            print('Balance:$Balance');
          });

          print('TransactionPassword: ${firstUser["TransactionPassword"]}');
          print('------------------');
        } catch (error) {
          Fluttertoast.showToast(msg: "No Data...");
          log(error.toString());
        }
      });
    } catch (e) {
      print("Error: $e");
      Fluttertoast.showToast(msg: "An error occurred");
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
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
        title: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
          Text(
            UserName,
            style: TextStyle(
              fontSize: 16,
              color: Colors.black,
              fontWeight: FontWeight.bold,
            ),
          ),
          SizedBox(
            height: 4,
            width: 4,
          ),
          Text(
            Name,
            style: TextStyle(fontSize: 14, color: Colors.black),
          ),
        ]),
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
      body: SingleChildScrollView(
        child: Column(children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Padding(
                padding: const EdgeInsets.only(top: 5),
                child: Card(
                  elevation: 4,
                  child: Padding(
                    padding: const EdgeInsets.all(16.0),
                    child: Column(
                      children: [
                        Image.asset(
                          "assets/images/rupee.png",
                          height: 40,
                          width: 40,
                          color: Color(0xFF007E01),
                        ),
                        SizedBox(height: 5),
                        SizedBox(
                          width: 280,
                          child: Text("₹" + Balance,
                              textAlign: TextAlign.center,
                              style: TextStyle(
                                  fontWeight: FontWeight.bold, fontSize: 30)),
                        ),
                        SizedBox(height: 5),
                        SizedBox(
                          width: 310,
                          child: Text('Available E - Wallet Balance',
                              textAlign: TextAlign.center,
                              style: TextStyle(
                                  fontSize: 13,
                                  fontWeight: FontWeight.w500,
                                  color: Colors.black)),
                        ),
                      ],
                    ),
                  ),
                ),
              ),
            ],
          ),
          SizedBox(
            height: 8,
          ),
          Column(
            children: [
              Row(
                children: [
                  Expanded(
                    child: Card(
                      color: Colors.blue, // Change color as needed
                      elevation: 2,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(5.0),
                      ),
                      child: Container(
                        child: Column(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Image.asset('assets/images/buy.png',
                                  color: Colors.white,
                                  cacheHeight: 40,
                                  cacheWidth: 40),
                              SizedBox(
                                height: 4.5,
                              ),
                              GestureDetector(
                                onTap: () {
                                  Navigator.push(
                                    context,
                                    MaterialPageRoute(
                                        builder: (context) => WithdrawFund()),
                                  );
                                },
                                child: Text(
                                  'Withdraw Funds',
                                  style: TextStyle(
                                      color: Colors.white,
                                      fontSize: 17,
                                      fontWeight: FontWeight.w500),
                                ),
                              ),
                            ]),
                        height: 120,
                        // Card content for the first card
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
                              Image.asset('assets/images/myadpacks.png',
                                  color: Colors.white,
                                  cacheHeight: 40,
                                  cacheWidth: 40),
                              SizedBox(
                                height: 4.5,
                              ),
                              GestureDetector(
                                onTap: () {
                                  Navigator.push(
                                    context,
                                    MaterialPageRoute(
                                        builder: (context) =>
                                            cashwallethistory()),
                                  );
                                },
                                child: Text(
                                  'Cash Wallet History',
                                  style: TextStyle(
                                      color: Colors.white,
                                      fontSize: 17,
                                      fontWeight: FontWeight.w500),
                                ),
                              ),
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
                      color: Color(0xFFF8709D), // Change color as needed
                      elevation: 2,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(5.0),
                      ),

                      child: Container(
                        height: 120,
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Image.asset(
                              'assets/images/transaction_png.png',
                              cacheWidth: 40,
                              cacheHeight: 40,
                              color: Colors.white,
                            ),
                            SizedBox(height: 4.5),
                            GestureDetector(
                              onTap: () {
                                Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                      builder: (context) =>
                                          FundTransferHistory()),
                                );
                              },
                              //FundTransferHistory
                              child: Text(
                                'Fund Wallet History',
                                style: TextStyle(
                                    color: Colors.white,
                                    fontSize: 17,
                                    fontWeight: FontWeight.w500),
                              ),
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
                            Image.asset(
                              'assets/images/rupee.png',
                              cacheHeight: 40,
                              cacheWidth: 40,
                              color: Colors.white,
                            ),
                            SizedBox(height: 4.5),
                            GestureDetector(
                              onTap: () {
                                Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                      builder: (context) => AddFundWallet()),
                                );
                              },
                              child: Text(
                                'Add Fund Wallet',
                                style: TextStyle(
                                    color: Colors.white,
                                    fontSize: 17,
                                    fontWeight: FontWeight.w500),
                              ),
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
                      color: Color(0xFF58AD69), // Change color as needed
                      elevation: 2,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(5.0),
                      ),

                      child: Container(
                        height: 120,
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Image.asset(
                              'assets/images/pending_png.webp',
                              cacheWidth: 40,
                              cacheHeight: 40,
                              color: Colors.white,
                            ),
                            SizedBox(height: 4.5),
                            GestureDetector(
                              onTap: () {
                                Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                      builder: (context) => WithdrawList()),
                                );
                              },
                              child: Text(
                                'Withdraw History',
                                style: TextStyle(
                                    color: Colors.white,
                                    fontSize: 17,
                                    fontWeight: FontWeight.w500),
                              ),
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
                          //Payouts
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Image.asset(
                              'assets/images/report_png.png',
                              cacheHeight: 40,
                              cacheWidth: 40,
                              color: Colors.white,
                            ),
                            SizedBox(height: 4.5),
                            GestureDetector(
                              onTap: () {
                                Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                      builder: (context) => Payouts()),
                                );
                              },
                              child: Text(
                                'Payouts Reports',
                                style: TextStyle(
                                    color: Colors.white,
                                    fontSize: 17,
                                    fontWeight: FontWeight.w500),
                              ),
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

                      child: Container(
                        height: 120,
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Image.asset(
                              'assets/images/history.png',
                              cacheWidth: 40,
                              cacheHeight: 40,
                              color: Colors.white,
                            ),
                            SizedBox(height: 4.5),
                            GestureDetector(
                              onTap: () {
                                Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                      builder: (context) =>
                                          QCashWalletHistory()),
                                );
                              },
                              child: Text(
                                'QuCash Wallet History',
                                style: TextStyle(
                                    color: Colors.white,
                                    fontSize: 17,
                                    fontWeight: FontWeight.w500),
                              ),
                            ),
                          ],
                        ),
                        // Card content for the third card
                      ),
                    ),
                  ),
                  // Add more rows with different background colors and card contents if needed
                ],
              )
            ],
          ),
        ]),
      ),
    );
  }
}
