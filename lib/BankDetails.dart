import 'dart:convert';
import 'dart:developer';
import 'package:http/http.dart' as http;
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:login_project_sample/BinaryIncomeReport.dart';
import 'package:login_project_sample/CashWalletHistory.dart';
import 'package:login_project_sample/IncomeReport.dart';
import 'package:login_project_sample/Models/BankDetailsModel.dart';
import 'package:login_project_sample/PayoutHistory.dart';
import 'package:login_project_sample/Payouts.dart';
import 'package:login_project_sample/ReferandEarn.dart';
import 'package:login_project_sample/WithDrawFund.dart';
import 'package:login_project_sample/utils/response_handler.dart';
import 'package:login_project_sample/utils/shared_preferences.dart';

class bankdetails extends StatefulWidget {
  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<bankdetails> {
  final TextEditingController AccountHolderName = TextEditingController();
  final TextEditingController AccountNumber = TextEditingController();
  final TextEditingController BankName = TextEditingController();
  final TextEditingController BranchName = TextEditingController();
  final TextEditingController IFSC = TextEditingController();

  String selectedAccountType = 'Savings'; // Initial value
  List<String> accountTypes = ['Savings', 'Current'];
  String accType = "1";

  Future<void> _uploadImageAndRegister() async {
    try {
      Future<http.Response>? __futureLogin;
      String memberId = await Prefs.getStringValue(Prefs.PREFS_USER_ID);
      log("memberId" + memberId);
      final String AccountName = AccountHolderName.text;
      final String Accountnmber = AccountNumber.text;
      final String bankname = BankName.text;
      final String branchname = BranchName.text;
      final String ifsc = IFSC.text;
      BankDetailsModel bankDetailsModel = BankDetailsModel(
          AccountName: AccountName,
          AccountNumber: Accountnmber,
          AccountType: accType,
          BankCode: ifsc,
          BankName: bankname,
          Branch: branchname,
          CustomerID: memberId,
          Username: '');
      final jsonData = jsonEncode(bankDetailsModel.toJson());
      print('jsondata:$jsonData');

      __futureLogin = ResponseHandler.performPost(
          "MemberSave", 'jsonString=$jsonData&KeyValue=');
      __futureLogin?.then((value) {
        print('Response body: ${value.body}');

        String jsonResponse = ResponseHandler.parseData(value.body);

        print('JSON Response: ${jsonResponse}');

        try {
          //Map<String, dynamic> map = json.decode(jsonResponse);
          List<dynamic> decodedJson = json.decode(jsonResponse);
          print('decodedJson: ${decodedJson}');
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
          'Bank Details',
          style: TextStyle(
              color: Colors.black, fontSize: 17, fontWeight: FontWeight.bold),
        ),
        actions: [
          Padding(
            padding: EdgeInsets.only(right: 16.0, bottom: 10),
            child: Image.asset(
              'assets/images/logor.jpg',
              // Replace 'your_image.png' with your image asset path
              width: 90,
              height: 35,
            ),
          ),
        ],
      ),
      body: Center(
        child: SingleChildScrollView(
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
                              child: Text('₹100.00',
                                  textAlign: TextAlign.center,
                                  style: TextStyle(
                                      fontWeight: FontWeight.bold,
                                      fontSize: 20)),
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
                        SizedBox(
                          height: 45,
                          child: TextField(
                            controller: AccountHolderName,
                            decoration: InputDecoration(
                                border: OutlineInputBorder(),
                                prefixIcon: Image.asset(
                                    'assets/images/profile.png',
                                    alignment: Alignment.center,
                                    cacheHeight: 20,
                                    cacheWidth: 20),
                                hintText: 'Account Holder Name',
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
                          child: TextField(
                            controller: AccountNumber,
                            decoration: InputDecoration(
                                border: OutlineInputBorder(),
                                prefixIcon: Image.asset(
                                    'assets/images/zipcode_icon.webp',
                                    alignment: Alignment.center,
                                    cacheHeight: 20,
                                    cacheWidth: 20),
                                hintText: 'Account Number',
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
                                    'assets/images/city_icon.png',
                                    alignment: Alignment.center,
                                    cacheHeight: 20,
                                    cacheWidth: 20),
                                hintText: 'Bank Name',
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
                          width: 310,
                          child: TextField(
                            decoration: InputDecoration(
                                border: OutlineInputBorder(),
                                prefixIcon: Image.asset(
                                    'assets/images/city_icon.png',
                                    alignment: Alignment.center,
                                    cacheHeight: 20,
                                    cacheWidth: 20),
                                hintText: 'Branch Name',
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
                          width: 310,
                          child: DropdownButtonFormField<String>(
                            decoration: InputDecoration(
                              border: OutlineInputBorder(),
                              prefixIcon: Image.asset(
                                'assets/images/city_icon.png',
                                alignment: Alignment.center,
                                cacheHeight: 20,
                                cacheWidth: 20,
                              ),
                              hintText: 'Account Type',
                              hintStyle: TextStyle(fontFamily: "Montserrat"),
                              contentPadding: EdgeInsets.only(bottom: 5),
                            ),
                            value: selectedAccountType,
                            items: accountTypes
                                .map<DropdownMenuItem<String>>((String value) {
                              return DropdownMenuItem<String>(
                                value: value,
                                child: Text(value),
                              );
                            }).toList(),
                            onChanged: (String? newValue) {
                              selectedAccountType = newValue!;
                              accType = (newValue == 'Savings' ? "1" : "2");
                              print('acctype:$accType');
                            },
                          ),
                        ),
                        SizedBox(height: 16),
                        SizedBox(
                          height: 45,
                          width: 310,
                          child: TextField(
                            decoration: InputDecoration(
                                border: OutlineInputBorder(),
                                prefixIcon: Image.asset(
                                    'assets/images/password_icon.png',
                                    alignment: Alignment.center,
                                    cacheHeight: 20,
                                    cacheWidth: 20),
                                hintText: 'IFSC',
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
                                Navigator.push(
                                    context,
                                    MaterialPageRoute(
                                        builder: (BuildContext context) =>
                                            ReferandEarn()));
                              },
                              style: ElevatedButton.styleFrom(
                                primary:
                                    Colors.deepPurpleAccent, // Button color
                                onPrimary: Colors.white, // Text color
                              ),
                              child: SizedBox(
                                  width: 95,
                                  height: 45,
                                  child: Center(
                                    child: Text(
                                      'Update',
                                      style: TextStyle(
                                        fontSize: 17,
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
                                            WithdrawFund()));
                              },
                              style: ElevatedButton.styleFrom(
                                primary: Colors.green, // Button color
                                onPrimary: Colors.white, // Text color
                              ),
                              child: SizedBox(
                                  width: 95,
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
      ),
    );
  }
}
