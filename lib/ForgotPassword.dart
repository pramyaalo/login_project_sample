import 'package:flutter/material.dart';
import 'package:login_project_sample/CashWalletHistory.dart';
import 'package:login_project_sample/ComposeMessage.dart';
import 'package:login_project_sample/IncomeReport.dart';
import 'package:login_project_sample/PayoutHistory.dart';
import 'package:login_project_sample/Payouts.dart';
import 'package:login_project_sample/PendingOrders.dart';
import 'package:login_project_sample/Testimonal.dart';
import 'package:login_project_sample/WithdrawList.dart';

class ForgotPassword extends StatefulWidget {
  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<ForgotPassword> {
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
          'Forgot Password',
          style: TextStyle(
              color: Colors.black, fontSize: 17, fontWeight: FontWeight.bold),
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
                          ClipOval(
                            child: Image.asset(
                              "assets/images/blankprofile.webp",
                              height: 40,
                              width: 40,
                            ),
                          ),
                          SizedBox(height: 8),
                          SizedBox(
                            width: 280,
                            child: Text('CS1000000',
                                textAlign: TextAlign.center,
                                style: TextStyle(
                                    fontWeight: FontWeight.bold,
                                    fontSize: 20,
                                   )),
                          ),
                          SizedBox(height: 8),
                          SizedBox(
                            width: 310,
                            child: Text('Pies',
                                textAlign: TextAlign.center,
                                style: TextStyle(
                                    fontSize: 17,
                                    fontWeight: FontWeight.bold,
                                     )),
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
                          decoration: InputDecoration(
                              border: OutlineInputBorder(),
                              prefixIcon: Image.asset(
                                'assets/images/password_icon.png',
                                alignment: Alignment.center,
                                cacheHeight: 20,
                                cacheWidth: 20,
                                color: Colors.black,
                              ),
                              hintText: 'Old Password',
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
                          decoration: InputDecoration(
                              border: OutlineInputBorder(),
                              prefixIcon: Image.asset(
                                  'assets/images/password_icon.png',
                                  alignment: Alignment.center,
                                  cacheHeight: 20,
                                  cacheWidth: 20,
                                  color: Colors.black),
                              hintText: 'New Password',
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
                                  color: Colors.black),
                              hintText: 'Confirm New Password',
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
                                          ComposeMessage()));
                            },
                            style: ElevatedButton.styleFrom(
                              primary: Colors.deepPurpleAccent, // Button color
                              onPrimary: Colors.white, // Text color
                            ),
                            child: SizedBox(
                                width: 115,
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
                            width: 1,
                          ),
                          ElevatedButton(
                            onPressed: () {
                              Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                      builder: (BuildContext context) =>
                                          SendTestimonal()));
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
