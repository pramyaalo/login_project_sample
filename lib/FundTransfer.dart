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

class FundTransfer extends StatefulWidget {
  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<FundTransfer> {
  bool isTextFieldEnabled = false;
  Future<http.Response>? __futureLogin;
  final TextEditingController _EBalanceController = TextEditingController();
  bool _isFieldEmpty = false;

  late String Balance = "";
  final TextEditingController _AmountController = TextEditingController();
  void _validateAndSubmit() {
    setState(() {
      _isFieldEmpty = _AmountController.text.isEmpty;
      print('Submitted: ${_isFieldEmpty}');
      Fluttertoast.showToast(msg: 'Please Enter Withdraw Amount');
    });

    if (!_isFieldEmpty) {
      _function2();
      // Perform your action with the non-empty value
      print('Submitted: ${_AmountController.text}');
    }
  }

  void _function2() async {
    String memberid = await Prefs.getStringValue(Prefs.PREFS_USER_ID);
    __futureLogin = ResponseHandler.performPost(
        "WithdrawfundSave",
        'MemberId=1000000'
                '&Debit=' +
            _AmountController.text);
    __futureLogin?.then((value) {
      print('Response body: ${value.body}');

      String jsonResponse = ResponseHandler.parseData(value.body);

      print('JSON Response: ${jsonResponse}');
      Navigator.push(context,
          MaterialPageRoute(builder: (BuildContext context) => IncomeReport()));
    });
    log('buttonPress' + _AmountController.text);
  }

  @override
  void dispose() {
    _AmountController.dispose();
    super.dispose();
  }

  @override
  void initState() {
    //String userid = Prefs.getStringValue(Prefs.PREFS_USER_ID);
    __futureLogin = ResponseHandler.performPost(
        "GetEwalletbalanceTranspwd", 'MemberId=1000000');
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

    super.initState();
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
          onPressed: () {},
        ),
        title: Text(
          'Fund Transfer',
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
                            color: Colors.green,
                          ),
                          SizedBox(height: 8),
                          SizedBox(
                            width: 280,
                            child: Text(Balance,
                                textAlign: TextAlign.center,
                                style: TextStyle(
                                    fontWeight: FontWeight.bold, fontSize: 20)),
                          ),
                          SizedBox(height: 8),
                          SizedBox(
                            width: 310,
                            child: Text('Available E - Wallet Balance',
                                textAlign: TextAlign.center,
                                style: TextStyle(fontSize: 13)),
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
                              'assets/images/profile_icon.png',
                              cacheHeight: 20,
                              color: Colors.green,
                              cacheWidth: 20,
                            ),
                            SizedBox(
                              width: 25,
                            ),
                            Text("UserName",
                                style: TextStyle(
                                    fontFamily: "Montserrat",
                                    fontSize: 16,
                                    fontWeight: FontWeight.bold,
                                    color: Colors.black54)),
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
                                  'assets/images/transaction_png.png',
                                  alignment: Alignment.center,
                                  cacheHeight: 20,
                                  cacheWidth: 20,
                                  color: Colors.green),
                              hintText: 'Transer to MemberId',
                              errorText: _isFieldEmpty
                                  ? 'Field can\'t be empty'
                                  : null,
                              hintStyle: TextStyle(fontFamily: "Montserrat"),
                              contentPadding: EdgeInsets.only(bottom: 5)),
                          style: TextStyle(
                            fontSize: 17,
                          ),
                        ),
                      ),
                      SizedBox(height: 16),
                      SizedBox(
                        height: 45,
                        width: 300,
                        child: TextField(
                          decoration: InputDecoration(
                              border: OutlineInputBorder(),
                              prefixIcon: Image.asset(
                                  'assets/images/moneytransfer.png',
                                  alignment: Alignment.center,
                                  cacheHeight: 20,
                                  cacheWidth: 20,
                                  color: Colors.green),
                              hintText: 'Enter Amount to Transfer',
                              hintStyle: TextStyle(fontFamily: "Montserrat"),
                              contentPadding: EdgeInsets.only(bottom: 5)),
                          style: TextStyle(
                            fontSize: 17,
                          ),
                        ),
                      ),
                      SizedBox(height: 16),
                      SizedBox(
                        height: 45,
                        width: 300,
                        child: TextField(
                          decoration: InputDecoration(
                              border: OutlineInputBorder(),
                              prefixIcon: Image.asset(
                                  'assets/images/password_icon.png',
                                  alignment: Alignment.center,
                                  cacheHeight: 20,
                                  cacheWidth: 20,
                                  color: Colors.green),
                              hintText: 'Enter Transaction Password',
                              hintStyle: TextStyle(fontFamily: "Montserrat"),
                              contentPadding: EdgeInsets.only(bottom: 5)),
                          style: TextStyle(
                            fontSize: 17,
                          ),
                        ),
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
                              primary: Colors.deepPurpleAccent, // Button color
                              onPrimary: Colors.white, // Text color
                            ),
                            child: SizedBox(
                                width: 115.5,
                                height: 45,
                                child: Center(
                                  child: Text(
                                    'Transfer Amount',
                                    style: TextStyle(
                                      fontSize: 15,
                                    ),
                                  ),
                                )),
                          ),
                          SizedBox(
                            width: 10,
                          ),
                          ElevatedButton(
                            onPressed: () {
                              Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                      builder: (BuildContext context) =>
                                          Payouts()));
                            },
                            style: ElevatedButton.styleFrom(
                              primary: Colors.green, // Button color
                              onPrimary: Colors.white, // Text color
                            ),
                            child: SizedBox(
                                width: 115,
                                height: 45,
                                child: Center(
                                  child: Text(
                                    'Close',
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
