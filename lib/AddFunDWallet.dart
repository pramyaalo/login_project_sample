import 'dart:convert';
import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:login_project_sample/BinaryIncomeReport.dart';
import 'package:login_project_sample/CashWalletHistory.dart';
import 'package:login_project_sample/ComposeMessage.dart';
import 'package:login_project_sample/DashBoard.dart';
import 'package:login_project_sample/IncomeReport.dart';
import 'package:login_project_sample/PayoutHistory.dart';
import 'package:login_project_sample/Models/Fund_Wallet_Balance_Model.dart';
import 'package:login_project_sample/Payouts.dart';
import 'package:login_project_sample/PendingOrders.dart';
import 'package:login_project_sample/Testimonal.dart';
import 'package:login_project_sample/WithdrawList.dart';
import 'package:http/http.dart' as http;
import 'package:login_project_sample/utils/response_handler.dart';
import 'package:login_project_sample/utils/shared_preferences.dart';

class AddFundWallet extends StatefulWidget {
  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<AddFundWallet> {
  bool isTextFieldEnabled = false;
  Future<http.Response>? __futureLogin;
  String memberId = '', Username = '', Name = '';
  bool _isFieldEmpty = false;

  late String Balance = "", formattedBalance = "";
  final TextEditingController _AmountController = TextEditingController();

  void _function2() async {
    String AMount = _AmountController.text;

    __futureLogin = ResponseHandler.performPost(
        "AddFundWallet", 'MemberId=${memberId}&Amount=$AMount');
    __futureLogin?.then((value) {
      print('Response body: ${value.body}');

      String jsonResponse = ResponseHandler.parseData(value.body);

      print('JSON Resdfsdcdfsponse: ${jsonResponse}');
      if (jsonResponse == "Allowed") {
        Fluttertoast.showToast(
          msg: "Fund Addedd Sucessfully",
          gravity: ToastGravity.BOTTOM,
          textColor: Colors.white,
        );
        Navigator.pop(context);
      }
    });
  }

  @override
  void initState() {
    _loadmemberid();

    super.initState();
  }

  Future<void> _loadmemberid() async {
    try {
      memberId = await Prefs.getStringValue(Prefs.PREFS_USER_ID);
      Username = await Prefs.getStringValue(Prefs.PREFS_USER_NAME);
      Name = await Prefs.getStringValue(Prefs.PREFS_NAME);
      log("memberfhhjykkId" + Name);

      __futureLogin = ResponseHandler.performPost(
          "GetFundwalletbalance", 'MemberId=${memberId}');
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
            Balance = firstUser["Balance"].toString();
            double doubleValue = double.parse(Balance);
            formattedBalance = doubleValue.toStringAsFixed(2);

            print('Balancesdfg:$formattedBalance');
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
        title: Text(
          'Withdraw Funds',
          style: TextStyle(
              color: Colors.black, fontSize: 17, fontWeight: FontWeight.bold),
        ),
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
                          SizedBox(height: 8),
                          SizedBox(
                            width: 280,
                            child: Text("₹" + formattedBalance,
                                textAlign: TextAlign.center,
                                style: TextStyle(
                                    fontWeight: FontWeight.bold, fontSize: 30)),
                          ),
                          SizedBox(height: 4),
                          SizedBox(
                            width: 310,
                            child: Text('Available Fund Wallet Balance',
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
                              'assets/images/name_icon.png',
                              cacheHeight: 20,
                              color: Colors.green,
                              cacheWidth: 20,
                            ),
                            SizedBox(
                              width: 25,
                            ),
                            Text(Name,
                                style: TextStyle(
                                    fontSize: 16,
                                    fontWeight: FontWeight.w500,
                                    color: Colors.black)),
                          ],
                        ),
                      ),
                      SizedBox(height: 16),
                      Container(
                        padding: EdgeInsets.all(10),
                        decoration: BoxDecoration(
                          border: Border.all(color: Colors.grey),
                          borderRadius: BorderRadius.circular(3),
                        ),
                        child: Row(
                          children: [
                            Image.asset(
                              'assets/images/id.png',
                              cacheHeight: 20,
                              color: Colors.green,
                              cacheWidth: 20,
                            ),
                            SizedBox(
                              width: 25,
                            ),
                            Text(Username,
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
                        width: 300,
                        child: TextField(
                            controller: _AmountController,
                            decoration: InputDecoration(
                                border: OutlineInputBorder(),
                                prefixIcon: Image.asset(
                                    'assets/images/money.png',
                                    alignment: Alignment.center,
                                    cacheHeight: 20,
                                    cacheWidth: 20,
                                    color: Colors.green),
                                hintText: 'Amount',
                                contentPadding: EdgeInsets.only(bottom: 5)),
                            style: TextStyle(
                                fontSize: 17,
                                fontWeight: FontWeight.w500,
                                color: Colors.black)),
                      ),
                      SizedBox(height: 16),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                        children: [
                          ElevatedButton(
                            onPressed: () {
                              _function2();
                            },
                            style: ElevatedButton.styleFrom(
                              primary: Colors.indigoAccent, // Button color
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
                                    'Add Fund',
                                    style: TextStyle(
                                      fontSize: 17,
                                    ),
                                  ),
                                )),
                          ),
                          SizedBox(
                            width: 1,
                          ),
                          ElevatedButton(
                            onPressed: () {
                              Navigator.pop(context);
                            },
                            style: ElevatedButton.styleFrom(
                              primary: Colors.green, // Button color
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
