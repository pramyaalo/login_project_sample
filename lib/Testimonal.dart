import 'dart:convert';
import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:image_picker/image_picker.dart';
import 'package:login_project_sample/AddReview.dart';
import 'package:login_project_sample/CashWalletHistory.dart';
import 'package:login_project_sample/ComposeMessage.dart';
import 'package:login_project_sample/IncomeReport.dart';
import 'package:login_project_sample/PayoutHistory.dart';
import 'package:login_project_sample/KYCApplication.dart';
import 'package:login_project_sample/KYCList.dart';
import 'package:login_project_sample/Payouts.dart';
import 'package:login_project_sample/PendingOrders.dart';
import 'package:login_project_sample/WithdrawList.dart';
import 'package:login_project_sample/utils/response_handler.dart';
import 'package:http/http.dart' as http;
import 'package:login_project_sample/utils/shared_preferences.dart';

class SendTestimonal extends StatefulWidget {
  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<SendTestimonal> {
  Future<http.Response>? _futureLogin;
  late String memberId;
  int title = 0;
  String? base64Image;
  late String Description;
  final TextEditingController _titlecontroller = TextEditingController();
  final TextEditingController _descriptioncontroller = TextEditingController();
  void validateTextField() {
    String Title = _titlecontroller.text.trim();
    String Description = _descriptioncontroller.text.trim();

    try {
      title = int.parse(Title);
      print('gghhj$title');
    } catch (e) {
      // Handle the case where the title cannot be parsed as an integer.
      Fluttertoast.showToast(
        msg: 'Title must be an integer',
        gravity: ToastGravity.BOTTOM,
        textColor: Colors.white,
      );
      return;
    }
    if (Description.isEmpty) {
      Fluttertoast.showToast(
        msg: 'First name is empty',
        gravity: ToastGravity.BOTTOM,
        textColor: Colors.white,
      );
    }
    _uploadImageAndRegister(title);
    // FocusFirstName.requestFocus();
  }

  Future<void> _uploadImageAndRegister(int title) async {
    memberId = await Prefs.getStringValue(Prefs.PREFS_USER_ID);

    log("memberId" + memberId!);
    Description = _descriptioncontroller.text.toString();

    _futureLogin = ResponseHandler.performPost("TestimonialSave",
        'id=0&title=$title&description=$Description&KeyValue=$base64Image&MemberId=$memberId');
    _futureLogin?.then((value) {
      print('Response body: ${value.body}');

      String jsonResponse = ResponseHandler.parseData(value.body);

      print('JSON Response: ${jsonResponse}');

      Navigator.of(context).pop();
    });
  }

  void _showSelectionDialog(BuildContext context) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text("Select Source"),
          content: SingleChildScrollView(
            child: ListBody(
              children: [
                GestureDetector(
                  child: Text("Open Camera"),
                  onTap: () {
                    _openCamera();
                    Navigator.of(context).pop(); // Close the dialog
                  },
                ),
                SizedBox(height: 16),
                GestureDetector(
                  child: Text("Open Gallery"),
                  onTap: () {
                    _openGallery();
                    Navigator.of(context).pop(); // Close the dialog
                  },
                ),
              ],
            ),
          ),
        );
      },
    );
  }

  Future<void> _openCamera() async {
    final picker = ImagePicker();
    final pickedFile = await picker.getImage(source: ImageSource.camera);

    if (pickedFile != null) {
      final imageBytes = await pickedFile.readAsBytes();
      final encodedImage = base64Encode(imageBytes);

      setState(() {
        base64Image = encodedImage;
        print('baseeeeeeb4:$base64Image');
      });
    }
  }

  Future<void> _openGallery() async {
    final picker = ImagePicker();
    final pickedFile = await picker.getImage(source: ImageSource.gallery);

    if (pickedFile != null) {
      final imageBytes = await pickedFile.readAsBytes();
      final encodedImage = base64Encode(imageBytes);

      setState(() {
        base64Image = encodedImage;
        print('baseeeeeeb4:$base64Image');
      });
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
          'Send Testimonial',
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
                          Stack(
                            alignment: Alignment.bottomRight,
                            children: <Widget>[
                              SizedBox(height: 20),
                              if (base64Image != null)
                                CircleAvatar(
                                  radius: 50,
                                  backgroundColor: Colors.white,
                                  backgroundImage: MemoryImage(
                                    base64Decode(base64Image!),
                                  ),
                                ),
                              IconButton(
                                icon: Icon(Icons.camera_alt),
                                onPressed: () {
                                  _showSelectionDialog(context);
                                },
                              ),
                            ],
                          ),
                          SizedBox(height: 8),
                          SizedBox(
                            width: 280,
                            child: Text('CS1000000',
                                textAlign: TextAlign.center,
                                style: TextStyle(
                                    fontWeight: FontWeight.bold,
                                    fontSize: 20,
                                    fontFamily: "Montserrat")),
                          ),
                          SizedBox(height: 8),
                          SizedBox(
                            width: 310,
                            child: Text('Pies',
                                textAlign: TextAlign.center,
                                style: TextStyle(
                                    fontSize: 17,
                                    fontWeight: FontWeight.bold,
                                    fontFamily: "Montserrat")),
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
                  padding: const EdgeInsets.all(10.0),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.start,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Padding(
                        padding: const EdgeInsets.symmetric(
                            vertical: 10, horizontal: 8),
                        child: Text('Send Testimonial',
                            style: TextStyle(
                                fontWeight: FontWeight.bold,
                                fontSize: 18,
                                fontFamily: "Montserrat")),
                      ),
                      Padding(
                        padding: const EdgeInsets.symmetric(
                            vertical: 10, horizontal: 8),
                        child: Text('Testimonial Title',
                            style: TextStyle(
                                fontSize: 16, fontFamily: "Montserrat")),
                      ),
                      SizedBox(
                        height: 45,
                        child: TextField(
                          controller: _titlecontroller,
                          decoration: InputDecoration(
                              border: OutlineInputBorder(),
                              hintText: '  Testimonial Title',
                              hintStyle: TextStyle(fontFamily: "Montserrat"),
                              contentPadding: EdgeInsets.only(bottom: 5)),
                          style: TextStyle(
                            fontSize: 17,
                          ),
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.symmetric(
                            vertical: 10, horizontal: 8),
                        child: Text('Testimonial Description',
                            style: TextStyle(
                                fontSize: 16, fontFamily: "Montserrat")),
                      ),
                      Container(
                        height: 160,
                        padding: EdgeInsets.all(5),
                        decoration: BoxDecoration(
                          border: Border.all(
                            color: Colors.grey,
                          ),
                          borderRadius: BorderRadius.circular(5),
                        ),
                        child: TextField(
                          controller: _descriptioncontroller,
                          decoration: InputDecoration(
                            hintText: '  Testimonial Description',
                            hintStyle: TextStyle(fontFamily: "Montserrat"),
                            border: InputBorder.none,
                          ),
                          style: TextStyle(
                            fontSize: 17,
                          ),
                        ),
                      ),
                      SizedBox(
                        height: 16,
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                        children: [
                          ElevatedButton(
                            onPressed: () {
                              validateTextField();
                              /*  Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                      builder: (BuildContext context) =>
                                          KYCApplication()));*/
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
                                          AddReview()));
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
