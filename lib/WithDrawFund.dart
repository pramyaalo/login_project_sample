import 'dart:convert';
import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';

import 'package:login_project_sample/DashBoard.dart';
import 'package:login_project_sample/IncomeReport.dart';

import 'package:http/http.dart' as http;
import 'package:login_project_sample/utils/response_handler.dart';
import 'package:login_project_sample/utils/shared_preferences.dart';

class WithdrawFund extends StatefulWidget {
  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<WithdrawFund> {
  bool isTextFieldEnabled = false;
  Future<http.Response>? __futureLogin;
  bool _isFieldEmpty = false;
  String memberId = '', Username = '';
  late String Balance = "", TransactionPassword = "";
  final TextEditingController _AmountController = TextEditingController();
  TextEditingController passwordController = TextEditingController();
  late double floatBalance;
  String password = '';

  @override
  void initState() {
    _loadmemberid();

    super.initState();
  }

  Future<void> _loadmemberid() async {
    try {
      memberId = await Prefs.getStringValue(Prefs.PREFS_USER_ID);
      log("memberfhhjykkId" + memberId);
      Username = await Prefs.getStringValue(Prefs.PREFS_USER_NAME);
      log("Usernameertt" + Username);
      __futureLogin = ResponseHandler.performPost(
          "GetEwalletbalanceTranspwd", 'MemberId=${memberId}');
      print('memberdfgfdgghId: ${memberId}');
      __futureLogin?.then((value) {
        print('Response body: ${value.body}');

        String jsonResponse = ResponseHandler.parseData(value.body);

        print('JSON Response: ${jsonResponse}');
        try {
          List<dynamic> decodedJson = json.decode(jsonResponse);
          Map<String, dynamic> firstUser = decodedJson[0];

          print('CustomerId ${firstUser["CustomerId"]}');
          print('Balance ${firstUser["Balance"]}');
          setState(() {
            Balance = double.parse(firstUser["Balance"].toString())
                .toStringAsFixed(2);
            TransactionPassword = firstUser["TransactionPassword"].toString();
            print('Balance:$Balance');
            print('TransactionPassword:$TransactionPassword');
          });

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

  void validation() {
    String amount = _AmountController.text;
    String enteredPassword = passwordController.text;
    double floatAmount;
    floatBalance = double.parse(Balance);
    print(floatBalance);
    password = TransactionPassword;
    try {
      floatAmount = double.parse(amount);
    } catch (FormatException) {
      floatAmount = 0.0;
    }

    bool cancel = false;

    if (amount.isEmpty) {
      cancel = true;
      Fluttertoast.showToast(
        msg: 'Enter Amount',
        gravity: ToastGravity.BOTTOM,
        textColor: Colors.white,
      );
    } else if (enteredPassword.isEmpty) {
      cancel = true;
      Fluttertoast.showToast(
        msg: 'Enter Transaction Password',
        gravity: ToastGravity.BOTTOM,
        textColor: Colors.white,
      );
    } else if (floatAmount <= 0) {
      cancel = true;
      Fluttertoast.showToast(
        msg: 'Amount must be greater than zero',
        gravity: ToastGravity.BOTTOM,
        textColor: Colors.white,
      );
    } else if (floatAmount > floatBalance) {
      cancel = true;
      Fluttertoast.showToast(
        msg: 'Available balance is low',
        gravity: ToastGravity.BOTTOM,
        textColor: Colors.white,
      );
    } else if (enteredPassword != password) {
      cancel = true;
      Fluttertoast.showToast(
        msg: 'Passwords mismatch',
        gravity: ToastGravity.BOTTOM,
        textColor: Colors.white,
      );
    }

    if (!cancel) {
      Fluttertoast.showToast(
        msg: 'Fund Withdrawn Successfully',
        gravity: ToastGravity.BOTTOM,
        textColor: Colors.white,
      );
      Navigator.of(context).pushReplacement(
        MaterialPageRoute(
          builder: (context) => Dashboard(data: memberId, data1: Username),
        ),
      );
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
          onPressed: () {  Navigator.pop(context);},
        ),
        title: Text(
          'Withdraw Funds',
          style: TextStyle(
              color: Colors.black, fontSize: 17, fontWeight: FontWeight.bold),
        ),
        titleSpacing: 15,
        leadingWidth: 30,
        actions: [
          Padding(
            padding: EdgeInsets.only(right: 16.0, bottom: 10),
            child: Image.asset(
              'assets/images/logor.jpg',
              width: 90,
              height: 35,
            ),
          ),
        ],
      ),
      body: SingleChildScrollView(
        child: Column(
          children: [
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
                          SizedBox(height: 4),
                          SizedBox(
                            width: 310,
                            child: Text('Available E - Wallet Balance',
                                textAlign: TextAlign.center,
                                style: TextStyle(
                                    fontSize: 13, fontWeight: FontWeight.w500)),
                          ),
                        ],
                      ),
                    ),
                  ),
                ),
              ],
            ),
            Card(
              elevation: 6,
              child: SizedBox(
                width: 340,
                child: Padding(
                  padding: const EdgeInsets.all(16.0),
                  child: Column(
                    children: [
                      Container(
                        padding: EdgeInsets.all(10),
                        decoration: BoxDecoration(
                          border: Border.all(color: Colors.grey),
                          borderRadius: BorderRadius.circular(3),
                        ),
                        child: Row(
                          children: [
                            Image.asset(
                              'assets/images/account_balance.png',
                              cacheHeight: 20,
                              color: Color(0xFF007E01),
                              cacheWidth: 20,
                            ),
                            SizedBox(
                              width: 25,
                            ),
                            Text("₹" + Balance,
                                style: TextStyle(
                                    fontSize: 16,
                                    fontWeight: FontWeight.w500,
                                    color: Colors.black)),
                          ],
                        ),
                      ),
                      SizedBox(height: 16),
                      SizedBox(
                        height: 45,
                        child: TextField(
                          controller: _AmountController,
                          decoration: InputDecoration(
                              border: OutlineInputBorder(),
                              prefixIcon: Image.asset(
                                  'assets/images/withdraw2.png',
                                  alignment: Alignment.center,
                                  cacheHeight: 20,
                                  cacheWidth: 20,
                                  color: Color(0xFF007E01)),
                              hintText: 'Withdraw Amount',
                              errorText: _isFieldEmpty
                                  ? 'Field can\'t be empty'
                                  : null,
                              contentPadding: EdgeInsets.only(bottom: 5)),
                          style: TextStyle(
                            fontSize: 17,
                            fontWeight: FontWeight.w500,
                          ),
                        ),
                      ),
                      SizedBox(height: 16),
                      SizedBox(
                        height: 45,
                        width: 300,
                        child: TextField(
                          obscureText: true,
                          controller: passwordController,
                          decoration: InputDecoration(
                              border: OutlineInputBorder(),
                              prefixIcon: Image.asset(
                                  'assets/images/password_icon.png',
                                  alignment: Alignment.center,
                                  cacheHeight: 20,
                                  cacheWidth: 20,
                                  color: Color(0xFF007E01)),
                              hintText: 'Transaction Password',
                              contentPadding: EdgeInsets.only(bottom: 5)),
                          style: TextStyle(
                            fontSize: 17,
                            fontWeight: FontWeight.w500,
                          ),
                        ),
                      ),
                      SizedBox(height: 16),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                        children: [
                          ElevatedButton(
                            onPressed: () {
                              validation();
                            },
                            style: ElevatedButton.styleFrom(
                              primary: Colors.indigoAccent, // Button color
                              onPrimary: Colors.white,
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(10),
                              ),
                            ),
                            child: SizedBox(
                                width: 115,
                                height: 45,
                                child: Center(
                                  child: Text(
                                    'Withdraw Fund',
                                    style: TextStyle(
                                      fontSize: 17,
                                      fontWeight: FontWeight.w600,
                                    ),
                                  ),
                                )),
                          ),
                          SizedBox(
                            width: 1,
                          ),
                          ElevatedButton(
                            onPressed: () {
                              Navigator.of(context).pop();
                            },
                            style: ElevatedButton.styleFrom(
                              primary: Color(0xFF007E01), // Button color
                              onPrimary: Colors.white,
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(10),
                              ), // Text color
                            ),
                            child: SizedBox(
                                width: 115,
                                height: 45,
                                child: Center(
                                  child: Text(
                                    'Cancel',
                                    style: TextStyle(
                                      fontSize: 17,
                                      fontWeight: FontWeight.w600,
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
    );
  }
}
