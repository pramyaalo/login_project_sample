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
  Future<http.Response>? __futureLogin;

  final TextEditingController AccountHolderName = TextEditingController();
  final TextEditingController AccountNumber = TextEditingController();
  final TextEditingController BankName = TextEditingController();
  final TextEditingController BranchName = TextEditingController();
  final TextEditingController IFSC = TextEditingController();

  String selectedAccountType = 'Savings';
  List<String> accountTypes = ['Savings', 'Current'];
  String accType = "1";
  String memberId = '';
  late String Balance = "";
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
          Fluttertoast.showToast(msg: "Login Failed");
          log(error.toString());
        }
      });

      __futureLogin = ResponseHandler.performPost(
          "MemberbankSearch", 'MemberId=${memberId}');
      print('memberdfgfdgghId: ${memberId}');
      __futureLogin?.then((value) {
        print('Response dgrgebody: ${value.body}');

        String jsonResponse = ResponseHandler.parseData(value.body);

        print('JSON Redghyjsponse: ${jsonResponse}');
        try {
          //Map<String, dynamic> map = json.decode(jsonResponse);
          List<dynamic> decodedJson = json.decode(jsonResponse);
          Map<String, dynamic> firstUser = decodedJson[0];

          // print('CustomerId ${firstUser["CustomerId"]}');
          print('Firstname ${firstUser["Firstname"]}');
          setState(() {
            AccountHolderName.text = firstUser['AccountName'].toString();
            AccountNumber.text = firstUser['AccountNumber'];
            BankName.text = firstUser['BankName'];
            BranchName.text = firstUser['Branch'];
            IFSC.text = firstUser['BankCode'];
            accType = firstUser['AccountType'];
            if (accType == '2') {
              selectedAccountType = 'Current';
            } else {
              selectedAccountType = 'Savings';
            }
            // _emailController.text = jsonData['Email'];
            String Firstname = firstUser["Firstname"].toString();

            print('Firstname:$Firstname');
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

  Future<void> _uploadImageAndRegister() async {
    try {
      Future<http.Response>? __futureLogin;
      String memberId = await Prefs.getStringValue(Prefs.PREFS_USER_ID);
      log("memberId" + memberId);
      String username = await Prefs.getStringValue(Prefs.PREFS_USER_NAME);
      log("usegdfhrname" + username);
      final String AccountName = AccountHolderName.text;
      final String Accountnmber = AccountNumber.text;
      final String bankname = BankName.text;
      log("usegdfhrname" + bankname);

      final String branchname = BranchName.text;
      final String ifsc = IFSC.text;

      __futureLogin = ResponseHandler.performPost(
          "MemberbankSave",
          'CustomerID=$memberId&Username=$username&AccountName=$AccountName&AccountNumber=$Accountnmber&BankName=$bankname&BranchName=$branchname'
              '&IFSCCode=$ifsc&Accounttype=$accType&KeyValue=');
      __futureLogin?.then((value) {
        print('Response body: ${value.body}');

        String jsonResponse = ResponseHandler.parseData(value.body);

        print('JSON Response: ${jsonResponse}');
        if (jsonResponse == "1") {
          Fluttertoast.showToast(msg: 'Bank Details Added Sucessfully');
          Navigator.of(context).pop();
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
        ), titleSpacing: 15,
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
      body: Container(
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
                              color: Color(0xFF007E01),
                            ),
                            SizedBox(height: 8),
                            SizedBox(
                              width: 280,
                              child: Text(Balance,
                                  textAlign: TextAlign.center,
                                  style: TextStyle(
                                      fontWeight: FontWeight.bold,
                                      fontSize: 30)),
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
                            controller: BankName,
                            decoration: InputDecoration(
                                border: OutlineInputBorder(),
                                prefixIcon: Image.asset(
                                    'assets/images/city_icon.png',
                                    alignment: Alignment.center,
                                    cacheHeight: 20,
                                    cacheWidth: 20),
                                hintText: 'Bank Name',
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
                            controller: BranchName,
                            decoration: InputDecoration(
                                border: OutlineInputBorder(),
                                prefixIcon: Image.asset(
                                    'assets/images/city_icon.png',
                                    alignment: Alignment.center,
                                    cacheHeight: 20,
                                    cacheWidth: 20),
                                hintText: 'Branch Name',
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
                            controller: IFSC,
                            decoration: InputDecoration(
                                border: OutlineInputBorder(),
                                prefixIcon: Image.asset(
                                    'assets/images/password_icon.png',
                                    alignment: Alignment.center,
                                    cacheHeight: 20,
                                    cacheWidth: 20),
                                hintText: 'IFSC',
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
                                _uploadImageAndRegister();
                                /*  Navigator.push(
                                    context,
                                    MaterialPageRoute(
                                        builder: (BuildContext context) =>
                                            ReferandEarn()));*/
                              },
                              style: ElevatedButton.styleFrom(
                                primary: Colors.indigoAccent, // Button color
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
                              onPressed: () {},
                              style: ElevatedButton.styleFrom(
                                primary: Color(0xFF007E01), // Button color
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
