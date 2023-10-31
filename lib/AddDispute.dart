import 'dart:convert';
import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';

import 'package:login_project_sample/Reported_Dispute.dart';
import 'package:login_project_sample/utils/response_handler.dart';
import 'package:http/http.dart' as http;

class AddDispute extends StatefulWidget {
  @override
  _SignUpPageState createState() => _SignUpPageState();
}

class _SignUpPageState extends State<AddDispute> {
  List<String> colors = ['Product', 'Delivery Boy', 'Shop', 'Other'];
  List<String> Orderstatus = ['Cancelled', 'Refund', 'Complained', 'Other'];
  List<String> DisputeStatus = ['Reported'];
  late String selectedColor;
  late String orderstatus;
  late String selectdispute = "Reported";
  final _formKey = GlobalKey<FormState>();
  String _selectedOption = 'Self';
  bool _obscureText = true;
  Future<http.Response>? __futureLogin;
  final TextEditingController _userNameController = TextEditingController();
  final TextEditingController _userIdController = TextEditingController();
  String _email = '';
  String _password = '';

  @override
  void initState() {
    super.initState();
    selectedColor = colors[0];
    orderstatus = Orderstatus[0];
    selectdispute = DisputeStatus[0]; // Set an initial value;
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
          'Pios \nCS1000000',
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
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Padding(padding: EdgeInsets.only(top: 20)),
            Text(
              '   Apply Dispute',
              style: TextStyle(
                  fontSize: 20,
                  fontWeight: FontWeight.bold,
                  color: Colors.black),
            ),
            SizedBox(height: 20),
            Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    SizedBox(
                      height: 45,
                      width: 310,
                      child: TextField(
                        textAlignVertical: TextAlignVertical.bottom,
                        controller: _userNameController,
                        decoration: InputDecoration(
                          hintText: 'Enter First Name',

                          prefixIcon: Image.asset(
                            "assets/images/profile_icon.png",
                            color: Colors.black,
                            alignment: Alignment.center,
                            cacheHeight: 21,
                            cacheWidth: 20,
                          ),
                          border: OutlineInputBorder(
                            borderSide: BorderSide(color: Colors.white),
                          ),
                        ),
                      ),
                    ),
                  ],
                )
              ],
            ),
            SizedBox(height: 16.0),
            Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    SizedBox(
                      height: 45,
                      width: 310,
                      child: TextField(
                        controller: _userIdController,
                        textAlignVertical: TextAlignVertical.bottom,
                        decoration: InputDecoration(
                          hintText: 'User ID',

                          prefixIcon: Image.asset(
                            "assets/images/profile_icon.png",
                            color: Colors.black,
                            alignment: Alignment.center,
                            cacheHeight: 21,
                            cacheWidth: 20,
                          ),
                          border: OutlineInputBorder(
                            borderSide: BorderSide(color: Colors.white),
                          ),
                        ),
                      ),
                    ),
                  ],
                )
              ],
            ),
            SizedBox(height: 16.0),
            Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    SizedBox(
                      height: 45,
                      width: 310,
                      child: TextField(
                        textAlignVertical: TextAlignVertical.bottom,
                        decoration: InputDecoration(
                          hintText: 'Mobile Number',
                          prefixIcon: Image.asset(
                            "assets/images/phone_icon.png",
                            alignment: Alignment.center,
                            color: Colors.black,
                            cacheHeight: 21,
                            cacheWidth: 20,
                          ),
                          border: OutlineInputBorder(
                            borderSide: BorderSide(color: Colors.white),
                          ),
                        ),
                      ),
                    ),
                  ],
                )
              ],
            ),
            SizedBox(height: 16.0),
            Column(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      Container(
                        width: 310,
                        height: 40,
                        decoration: BoxDecoration(
                          border: Border.all(color: Colors.grey),
                          borderRadius: BorderRadius.circular(3.0),
                        ),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          crossAxisAlignment: CrossAxisAlignment.center,
                          children: [
                            Padding(
                              padding: EdgeInsets.only(right: 20, left: 20),
                              child: Expanded(
                                child: DropdownButton<String>(
                                  value: selectedColor,
                                  items: colors.map<DropdownMenuItem<String>>(
                                      (String item) {
                                    return DropdownMenuItem<String>(
                                      value: item,
                                      child: Padding(
                                        padding: EdgeInsets.only(
                                            right: 157, left: 0),
                                        child: Container(
                                          alignment: Alignment.centerLeft,
                                          child: Text(item),
                                        ),
                                      ),
                                    );
                                  }).toList(),
                                  onChanged: (String? newValue) {
                                    setState(() {
                                      selectedColor = newValue!;
                                    });
                                  },
                                  underline: Container(),
                                  icon: Icon(Icons.arrow_drop_down),
                                  iconSize: 24,
                                  alignment: Alignment.centerLeft,
                                ),
                              ),
                            ),
                          ],
                        ),
                      ),
                    ],
                  )
                ]),
            SizedBox(height: 16.0),
            Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    SizedBox(
                      height: 45,
                      width: 310,
                      child: TextField(
                        textAlignVertical: TextAlignVertical.bottom,
                        decoration: InputDecoration(
                          hintText: 'Order Amount',
                          prefixIcon: Image.asset(
                            "assets/images/rupee.png",
                            alignment: Alignment.center,
                            color: Colors.black,
                            cacheHeight: 21,
                            cacheWidth: 20,
                          ),
                          border: OutlineInputBorder(
                            borderSide: BorderSide(color: Colors.white),
                          ),
                        ),
                      ),
                    ),
                  ],
                )
              ],
            ),
            SizedBox(height: 16.0),
            Column(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      Container(
                        width: 310,
                        height: 40,
                        decoration: BoxDecoration(
                          border: Border.all(color: Colors.grey),
                          borderRadius: BorderRadius.circular(3.0),
                        ),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          crossAxisAlignment: CrossAxisAlignment.center,
                          children: [
                            Padding(
                              padding: EdgeInsets.only(right: 20, left: 20),
                              child: Expanded(
                                child: DropdownButton<String>(
                                  value: orderstatus,
                                  items:
                                      Orderstatus.map<DropdownMenuItem<String>>(
                                          (String item) {
                                    return DropdownMenuItem<String>(
                                      value: item,
                                      child: Padding(
                                        padding: EdgeInsets.only(
                                            right: 157, left: 0),
                                        child: Container(
                                          alignment: Alignment.centerLeft,
                                          child: Text(item),
                                        ),
                                      ),
                                    );
                                  }).toList(),
                                  onChanged: (String? newValue) {
                                    setState(() {
                                      orderstatus = newValue!;
                                    });
                                  },
                                  underline: Container(),
                                  icon: Icon(Icons.arrow_drop_down),
                                  iconSize: 24,
                                  alignment: Alignment.centerLeft,
                                ),
                              ),
                            ),
                          ],
                        ),
                      ),
                    ],
                  )
                ]),
            SizedBox(height: 16.0),
            Column(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      Container(
                        width: 310,
                        height: 40,
                        decoration: BoxDecoration(
                          border: Border.all(color: Colors.grey),
                          borderRadius: BorderRadius.circular(3.0),
                        ),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          crossAxisAlignment: CrossAxisAlignment.center,
                          children: [
                            Padding(
                              padding: EdgeInsets.only(right: 20, left: 20),
                              child: Expanded(
                                child: DropdownButton<String>(
                                  value: selectdispute,
                                  items: DisputeStatus.map<
                                      DropdownMenuItem<String>>((String item) {
                                    return DropdownMenuItem<String>(
                                      value: item,
                                      child: Padding(
                                        padding: EdgeInsets.only(
                                            right: 177, left: 1),
                                        child: Container(
                                          alignment: Alignment.centerLeft,
                                          child: Text(item),
                                        ),
                                      ),
                                    );
                                  }).toList(),
                                  onChanged: (String? newValue) {
                                    setState(() {
                                      selectdispute = newValue!;
                                    });
                                  },
                                  underline: Container(),
                                  icon: Icon(Icons.arrow_drop_down),
                                  iconSize: 24,
                                  alignment: Alignment.centerLeft,
                                ),
                              ),
                            ),
                          ],
                        ),
                      ),
                    ],
                  )
                ]),
            SizedBox(height: 16.0),
            Padding(
              padding: const EdgeInsets.only(left: 25, right: 25),
              child: Container(
                height: 160,
                padding: EdgeInsets.all(5),
                decoration: BoxDecoration(
                  border: Border.all(
                    color: Colors.grey,
                  ),
                  borderRadius: BorderRadius.circular(3.0),
                ),
                child: TextField(
                  decoration: InputDecoration(
                    hintText: '  Tell us about the dispute',

                    border: InputBorder.none,
                  ),
                  style: TextStyle(
                    fontSize: 17,
                  ),
                ),
              ),
            ),
            SizedBox(height: 16.0),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                SizedBox(
                  width: 320,
                  height: 40,
                  child: ElevatedButton(
                    style: ElevatedButton.styleFrom(
                      primary: Colors.green, // Button color
                      onPrimary: Colors.white, // Text color
                    ),
                    onPressed: () {
                      __futureLogin = ResponseHandler.performPost(
                          "Login",
                          'username=' +
                              _userNameController.text +
                              '&password=' +
                              _userIdController.text);
                      __futureLogin?.then((value) {
                        print('Response body: ${value.body}');

                        String jsonResponse =
                            ResponseHandler.parseData(value.body);

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
                    },
                    child: Text(
                      'Submit',
                      style: TextStyle(
                        fontWeight: FontWeight.bold,
                        fontSize: 17,
                      ),
                    ),
                  ),
                ),
              ],
            ),
            SizedBox(height: 16.0),
          ],
        ),
      ),
    );
  }
}

void _pickImageFromCamera() async {
  // Add camera image picking logic here
  // For example, you can use the camera package to open the camera and pick an image
  // Then, open the camera and take a picture or record a video
  // After capturing the image, you can display it in the CircleAvatar
}

void main() {
  runApp(MaterialApp(
    home: AddDispute(),
  ));
}
