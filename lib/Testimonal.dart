import 'dart:convert';
import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:image_picker/image_picker.dart';
import 'package:login_project_sample/AddReview.dart';

import 'package:login_project_sample/utils/response_handler.dart';
import 'package:http/http.dart' as http;
import 'package:login_project_sample/utils/shared_preferences.dart';

class SendTestimonal extends StatefulWidget {
  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<SendTestimonal> {
  Future<http.Response>? _futureLogin;
  late String memberId, UserName = '', Name = '';
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
  }

  @override
  void initState() {
    super.initState();

    _loadmemberid();
  }

  Future<void> _loadmemberid() async {
    memberId = await Prefs.getStringValue(Prefs.PREFS_USER_ID);
    log("memberId" + memberId);
    UserName = await Prefs.getStringValue(Prefs.PREFS_USER_NAME);
    log("UserNameUserNameUserName" + UserName);
    Name = await Prefs.getStringValue(Prefs.PREFS_NAME);
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

  Future _showSelectionDialog(BuildContext context) {
    return showDialog(
        context: context,
        builder: (BuildContext context) {
          return AlertDialog(
            titlePadding: EdgeInsets.all(0),
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(20),
            ),
            title: Container(
              height: 50,
              decoration: BoxDecoration(
                color: Color(0xFF007E01),
                borderRadius: BorderRadius.only(
                  topLeft: Radius.circular(20),
                  topRight: Radius.circular(20),
                ),
              ),
              child: Center(
                child: Text(
                  "Add Photo",
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: 17,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
            ),
            contentPadding: EdgeInsets.only(top: 10.0),
            content: Container(
              width: 100.0,
              child: Column(
                mainAxisAlignment: MainAxisAlignment.start,
                crossAxisAlignment: CrossAxisAlignment.stretch,
                mainAxisSize: MainAxisSize.min,
                children: <Widget>[
                  Padding(
                    padding: const EdgeInsets.only(top: 10),
                    child: GestureDetector(
                      child: Center(
                          child: Text("Gallery",
                              style: TextStyle(
                                  fontWeight: FontWeight.w500, fontSize: 17))),
                      onTap: () {
                        _openGallery();
                        Navigator.of(context).pop(); // Close the dialog
                      },
                    ),
                  ),
                  SizedBox(
                    height: 8,
                  ),
                  Divider(color: Colors.grey, thickness: 1),
                  SizedBox(
                    height: 8,
                  ),
                  GestureDetector(
                    child: Center(
                        child: Text("Take Photo",
                            style: TextStyle(
                                fontWeight: FontWeight.w500, fontSize: 17))),
                    onTap: () {
                      _openCamera();
                      Navigator.of(context).pop(); // Close the dialog
                    },
                  ),
                  SizedBox(
                    height: 16,
                  ),
                  InkWell(
                    child: Container(
                        padding: EdgeInsets.only(top: 15.0, bottom: 10.0),
                        decoration: BoxDecoration(
                          color: Color(0xFF007E01),
                          borderRadius: BorderRadius.only(
                              bottomLeft: Radius.circular(20),
                              bottomRight: Radius.circular(20)),
                        ),
                        child: GestureDetector(
                          onTap: () {
                            Navigator.pop(context);
                          },
                          child: Text(
                            "Cancel",
                            style: TextStyle(
                              color: Colors.white,
                              fontSize: 17,
                              fontWeight: FontWeight.w500,
                            ),
                            textAlign: TextAlign.center,
                          ),
                        )),
                  ),
                ],
              ),
            ),
          );
        });
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
                      padding: const EdgeInsets.only(
                          top: 8, bottom: 8, left: 15, right: 15),
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
                                )
                              else
                                Image.asset("assets/images/profile.png",
                                    width: 70, height: 70),
                              /* IconButton(
                                icon: Icon(Icons.camera_alt),
                                onPressed: () {
                                  _showSelectionDialog(context);
                                },
                              ),*/
                            ],
                          ),
                          SizedBox(height: 8),
                          SizedBox(
                            width: 280,
                            child: Text(UserName,
                                textAlign: TextAlign.center,
                                style: TextStyle(
                                  fontWeight: FontWeight.w700,
                                  fontSize: 25,
                                )),
                          ),
                          SizedBox(height: 2),
                          SizedBox(
                            width: 310,
                            child: Text(Name,
                                textAlign: TextAlign.center,
                                style: TextStyle(
                                  fontSize: 19,
                                  fontWeight: FontWeight.w700,
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
                            )),
                      ),
                      Padding(
                        padding: const EdgeInsets.symmetric(
                            vertical: 10, horizontal: 8),
                        child: Text('Testimonial Title',
                            style: TextStyle(
                                fontSize: 16, fontWeight: FontWeight.w500)),
                      ),
                      SizedBox(
                        height: 45,
                        child: TextField(
                          controller: _titlecontroller,
                          decoration: InputDecoration(
                              border: OutlineInputBorder(),
                              hintText: '  Testimonial Title',
                              contentPadding: EdgeInsets.only(bottom: 5)),
                          style: TextStyle(
                              fontSize: 17, fontWeight: FontWeight.w500),
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.symmetric(
                            vertical: 10, horizontal: 8),
                        child: Text('Testimonial Description',
                            style: TextStyle(
                                fontSize: 16, fontWeight: FontWeight.w500)),
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
                            border: InputBorder.none,
                          ),
                          style: TextStyle(
                              fontSize: 17, fontWeight: FontWeight.w500),
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
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(
                                    10), // Adjust the radius as needed
                              ),
                              primary: Colors.indigoAccent, // Button color
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
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(
                                    10), // Adjust the radius as needed
                              ),
                              primary: Color(0xFF007E01), // Button color
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
