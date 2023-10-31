import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:login_project_sample/utils/shared_preferences.dart';
import 'package:share/share.dart';

void main() {
  runApp(ReferandEarn());
}

class ReferandEarn extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: MyHomePage(),
    );
  }
}

class MyHomePage extends StatefulWidget {
  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  String memberId = '', Username = '';
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
    } catch (e) {
      print("Error: $e");
      Fluttertoast.showToast(msg: "An error occurred");
    }
  }

  void shareText() {
    Share.share("Inviting you to join QuKart\n\n"
        "Download app from link:  https://play.google.com/store/apps/details?id=com.shopping.qukart\n"
        "Use my referrer code: $Username");
  }

  Future<void> _copyToClipboard(String text) async {
    await Clipboard.setData(ClipboardData(text: text));
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
          'Refer and Earn',
          style: TextStyle(
              color: Colors.black,
              fontSize: 17,

              fontWeight: FontWeight.bold),
        ), titleSpacing: 15,
        leadingWidth: 30,
      ),
      body: Column(
        children: [
          SizedBox(
            height: 250,
            child: Image.asset(
              'assets/images/referearn.png',
              fit: BoxFit.cover,
            ),
          ),
          Container(
            margin: EdgeInsets.all(10),
            padding: EdgeInsets.symmetric(horizontal: 10),
            height: 50,
            decoration: BoxDecoration(
              color: Color(0xFF007E01),
              border: Border.all(color: Color(0xFF007E01)),
              borderRadius: BorderRadius.circular(3),
            ),
            child: GestureDetector(
              onTap: () {
                shareText();
              },
              child: Row(
                children: [
                  Text(
                    "SHARE REFERAL CODE",
                    style: TextStyle(
                      color: Colors.white,
                      fontWeight: FontWeight.bold,
                      fontSize: 16,
                    ),
                  ),
                  SizedBox(width: 120),
                  Icon(
                    Icons.share,
                    color: Colors.white,
                  ),
                ],
              ),
            ),
          ),
          Row(
            children: [
              Expanded(
                child: Container(
                  margin: EdgeInsets.all(10),
                  padding: EdgeInsets.symmetric(horizontal: 10),
                  height: 50,
                  decoration: BoxDecoration(
                    color: Colors.white,
                    border: Border.all(color: Colors.grey),
                    borderRadius: BorderRadius.circular(3),
                  ),
                  child: GestureDetector(
                    onTap: () {
                      final textToCopy = "Copy Referal Code : $Username";
                      Clipboard.setData(ClipboardData(text: textToCopy))
                          .then((_) {
                        Fluttertoast.showToast(
                          msg: 'Copied to clipboard',
                          gravity: ToastGravity
                              .BOTTOM, // You can adjust the position
                          backgroundColor: Colors.black,
                          textColor: Colors.white,
                        );
                      });
                    },
                    child: Row(
                      children: [
                        Text(
                          "Copy Referal Code : " + Username,
                          style: TextStyle(
                            color: Colors.black,
                            fontWeight: FontWeight.bold,
                            fontSize: 16,
                          ),
                        ),
                        SizedBox(width: 60),
                        Icon(
                          Icons.copy,
                          color: Colors.black,
                        ),
                      ],
                    ),
                  ),
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
