import 'dart:convert';
import 'dart:developer';
import 'package:http/http.dart' as http;
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:login_project_sample/KYCList.dart';
import 'package:login_project_sample/utils/response_handler.dart';

void main() {
  runApp(KYCProcessing());
}

class KYCProcessing extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: KycVerificationScreen(),
    );
  }
}

class KycVerificationScreen extends StatefulWidget {
  @override
  _KycVerificationScreenState createState() => _KycVerificationScreenState();
}

class _KycVerificationScreenState extends State<KycVerificationScreen> {
  Future<http.Response>? __futureLogin;
  bool isProofCopyVisible = true;
  bool isPhotoFaceVisible = true;
  DateTime selectedDate = DateTime.now();
  String checkboxStatus = "0";
  String checkboxStatus1 = "0";
  TextEditingController textFNameController = TextEditingController();
  TextEditingController textLNameController = TextEditingController();
  TextEditingController textMNumberController = TextEditingController();
  TextEditingController textDOBController = TextEditingController();
  TextEditingController textEMailController = TextEditingController();
  TextEditingController textAddress1Controller = TextEditingController();
  TextEditingController textAddress2Controller = TextEditingController();
  TextEditingController textStateController = TextEditingController();
  TextEditingController textCityController = TextEditingController();
  TextEditingController textZipCodeController = TextEditingController();
  TextEditingController textCountryController = TextEditingController();
  String ValidateFName = '';
  String ValidateLName = '';
  String ValidateMobile = '';
  String ValidateEMail = '';
  String ValidateDOB = '';
  String ValidateAddress1 = '';
  String ValidateAddress2 = '';
  String ValidateState = '';
  String ValidateCity = '';
  String ValidateZipCode = '';
  String ValidateCountry = '';
  FocusNode FocusFirstName = FocusNode();
  FocusNode FocusLastName = FocusNode();
  FocusNode FocusMoile = FocusNode();
  FocusNode FocusEMail = FocusNode();
  FocusNode FocusDOB = FocusNode();
  FocusNode FocusAddress1 = FocusNode();
  FocusNode FocusAddress2 = FocusNode();
  FocusNode FocusState = FocusNode();
  FocusNode FocusCity = FocusNode();
  FocusNode FocusZipCode = FocusNode();
  FocusNode FocusCountry = FocusNode();

  @override
  void initState() {
    super.initState();
    // Initially, set focus to the text field
    FocusFirstName.requestFocus();
    // FocusLastName.requestFocus();
  }

  Future<void> selectDate(BuildContext context) async {
    final DateTime? picked = await showDatePicker(
      context: context,
      initialDate: selectedDate,
      firstDate: DateTime(1900), // Adjust as per your requirement
      lastDate: DateTime.now(), // You can set an upper limit if needed
    );

    if (picked != null && picked != selectedDate) {
      setState(() {
        selectedDate = picked;
      });

      // Convert the selected date to your desired format
      String formattedDate = "${picked.year}-${picked.month}-${picked.day}";
      print('Selected date: $formattedDate');
    }
  }

  void validateTextField() {
    String FirstName = textFNameController.text.trim();
    String LastName = textLNameController.text.trim();
    String EMail = textEMailController.text.trim();
    String Address1 = textAddress1Controller.text.trim();
    String Address2 = textAddress2Controller.text.trim();
    String DOB = textDOBController.text.trim();
    String State = textStateController.text.trim();
    String City = textCityController.text.trim();
    String ZipCode = textZipCodeController.text.trim();
    String Country = textCountryController.text.trim();
    String MobileNumber = textMNumberController.text.trim();
    if (checkboxStatus == "0") {
      Fluttertoast.showToast(
        msg: 'Please accept Terms and Conditions',
        gravity: ToastGravity.BOTTOM,
        textColor: Colors.white,
      );
    }
    if (checkboxStatus1 == "0") {
      Fluttertoast.showToast(
        msg: 'Please accept Terms and Conditions',
        gravity: ToastGravity.BOTTOM,
        textColor: Colors.white,
      );
    }
    if (FirstName.isEmpty) {
      Fluttertoast.showToast(
        msg: 'First name is empty',
        gravity: ToastGravity.BOTTOM,
        textColor: Colors.white,
      );
      FocusFirstName.requestFocus();
    }
    if (LastName.isEmpty) {
      Fluttertoast.showToast(
        msg: 'Last name is empty',
        gravity: ToastGravity.BOTTOM,
        textColor: Colors.white,
      );
      FocusLastName.requestFocus();
    }

    if (MobileNumber.isEmpty) {
      Fluttertoast.showToast(
        msg: 'Phone number is empty',
        gravity: ToastGravity.BOTTOM,
        textColor: Colors.white,
      );
      FocusMoile.requestFocus();
    }
    if (DOB.isEmpty) {
      Fluttertoast.showToast(
        msg: 'DOB is empty',
        gravity: ToastGravity.BOTTOM,
        textColor: Colors.white,
      );
      FocusDOB.requestFocus();
    }
    if (EMail.isEmpty) {
      Fluttertoast.showToast(
        msg: 'EMail is empty',
        gravity: ToastGravity.BOTTOM,
        textColor: Colors.white,
      );
      FocusEMail.requestFocus();
    }
    if (Address1.isEmpty) {
      Fluttertoast.showToast(
        msg: 'Address1 is empty',
        gravity: ToastGravity.BOTTOM,
        textColor: Colors.white,
      );
      FocusAddress1.requestFocus();
    }
    if (Address2.isEmpty) {
      Fluttertoast.showToast(
        msg: 'Address2 is empty',
        gravity: ToastGravity.BOTTOM,
        textColor: Colors.white,
      );
      FocusAddress2.requestFocus();
    }

    if (State.isEmpty) {
      Fluttertoast.showToast(
        msg: 'State is empty',
        gravity: ToastGravity.BOTTOM,
        textColor: Colors.white,
      );
      FocusState.requestFocus();
    }
    if (City.isEmpty) {
      Fluttertoast.showToast(
        msg: 'City is empty',
        gravity: ToastGravity.BOTTOM,
        textColor: Colors.white,
      );
      FocusCity.requestFocus();
    }
    if (ZipCode.isEmpty) {
      Fluttertoast.showToast(
        msg: 'Zip Code is empty',
        gravity: ToastGravity.BOTTOM,
        textColor: Colors.white,
      );
      FocusZipCode.requestFocus();
    }
    if (Country.isEmpty) {
      Fluttertoast.showToast(
        msg: 'Country is empty',
        gravity: ToastGravity.BOTTOM,
        textColor: Colors.white,
      );
      FocusCountry.requestFocus();
    }
    __futureLogin = ResponseHandler.performPost(
        "KYCAdd",
        'customerid=1000000'
                '&date=&firstname=' +
            textFNameController.text +
            '&lastname=' +
            textLNameController.text +
            '&phone=' +
            textMNumberController.text +
            '&dob=' +
            textDOBController.text +
            '&gender=&telegram=&address1=' +
            textAddress1Controller.text +
            '&address2=' +
            textAddress2Controller.text +
            '&state=' +
            textStateController.text +
            '&city=' +
            textCityController.text +
            '&zip=' +
            textZipCodeController.text +
            '&country=' +
            textCountryController.text +
            '&submitdate=&submitkby=');
    __futureLogin?.then((value) {
      print('Response body: ${value.body}');

      String jsonResponse = ResponseHandler.parseData(value.body);

      print('JSON Response: ${jsonResponse}');
      Navigator.push(context,
          MaterialPageRoute(builder: (BuildContext context) => KYCList()));
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          leading: IconButton(
            icon: Icon(Icons.arrow_back),
            onPressed: () {
              // Handle back button action
            },
          ),
          title: Text('KYC VERIFICATION'),
        ),
        body: SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.all(16.0),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Text(
                  'Begin your ID Verification',
                  style: TextStyle(
                    fontSize: 19,
                    fontWeight: FontWeight.bold,
                    color: Colors.black,
                  ),
                  textAlign: TextAlign.center,
                ),
                SizedBox(height: 5),
                Text(
                  'Verify your identity to participate in the token sale.',
                  style: TextStyle(
                    fontSize: 13.5,
                    color: Colors.black,
                  ),
                  textAlign: TextAlign.center,
                ),
                SizedBox(height: 16),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    Container(
                      width: 50,
                      height: 50,
                      decoration: BoxDecoration(
                        color: Colors.blue,
                        shape: BoxShape.circle,
                      ),
                      child: Center(
                        child: Text(
                          '1',
                          style: TextStyle(
                            color: Colors.white,
                            fontWeight: FontWeight.bold,
                            fontSize: 18,
                          ),
                        ),
                      ),
                    ),
                    SizedBox(
                      width: 5,
                    ),
                    Text(
                      'Personal Details',
                      style: TextStyle(
                        fontSize: 18,
                        fontWeight: FontWeight.bold,
                        color: Colors.black,
                      ),
                      textAlign: TextAlign.center,
                    ),
                  ],
                ),
                SizedBox(height: 16),
                Text(
                  'Your simple personal information required for identification. Please type carefully and fill out the form with your personal details.',
                  style: TextStyle(
                    fontSize: 16,
                    color: Colors.black,
                  ),
                  textAlign: TextAlign.center,
                ),
                SizedBox(height: 10),
                Text(
                  'You are not allowed to edit the details once you submitted the application.',
                  style: TextStyle(
                    fontSize: 16,
                    color: Colors.black,
                  ),
                  textAlign: TextAlign.center,
                ),
                SizedBox(height: 15),
                SizedBox(
                  height: 45,
                  width: 310,
                  child: TextField(
                    controller: textFNameController,
                    focusNode: FocusFirstName,
                    textAlignVertical: TextAlignVertical.bottom,
                    decoration: InputDecoration(
                      hintText: 'Firstname',
                      hintStyle: TextStyle(fontFamily: "Montserrat"),
                      border: OutlineInputBorder(
                        borderSide: BorderSide(color: Colors.white),
                      ),
                    ),
                  ),
                ),
                if (ValidateFName.isNotEmpty)
                  Text(
                    ValidateFName,
                    style: TextStyle(
                      color: Colors.red,
                    ),
                  ),
                SizedBox(height: 10),
                SizedBox(
                  height: 45,
                  width: 310,
                  child: TextField(
                    controller: textLNameController,
                    focusNode: FocusLastName,
                    textAlignVertical: TextAlignVertical.bottom,
                    decoration: InputDecoration(
                      hintText: 'Lastname',
                      hintStyle: TextStyle(fontFamily: "Montserrat"),
                      border: OutlineInputBorder(
                        borderSide: BorderSide(color: Colors.white),
                      ),
                    ),
                  ),
                ),
                if (ValidateLName.isNotEmpty)
                  Text(
                    ValidateLName,
                    style: TextStyle(
                      color: Colors.red,
                    ),
                  ),
                SizedBox(height: 10),
                SizedBox(
                  height: 45,
                  width: 310,
                  child: TextField(
                    keyboardType: TextInputType.number,
                    controller: textMNumberController,
                    focusNode: FocusMoile,
                    textAlignVertical: TextAlignVertical.bottom,
                    decoration: InputDecoration(
                      hintText: 'Phone Number',
                      hintStyle: TextStyle(fontFamily: "Montserrat"),
                      border: OutlineInputBorder(
                        borderSide: BorderSide(color: Colors.white),
                      ),
                    ),
                  ),
                ),
                if (ValidateMobile.isNotEmpty)
                  Text(
                    ValidateMobile,
                    style: TextStyle(
                      color: Colors.red,
                    ),
                  ),
                SizedBox(height: 10),
                SizedBox(
                  height: 45,
                  width: 310,
                  child: TextField(
                    controller: textDOBController,
                    focusNode: FocusDOB,
                    textAlignVertical: TextAlignVertical.bottom,
                    decoration: InputDecoration(
                      hintText: 'Date of Birth',
                      hintStyle: TextStyle(fontFamily: "Montserrat"),
                      border: OutlineInputBorder(
                        borderSide: BorderSide(color: Colors.white),
                      ),
                    ),
                  ),
                ),
                SizedBox(height: 10),
                SizedBox(
                  height: 45,
                  width: 310,
                  child: TextField(
                    keyboardType: TextInputType.emailAddress,
                    controller: textEMailController,
                    focusNode: FocusEMail,
                    textAlignVertical: TextAlignVertical.bottom,
                    decoration: InputDecoration(
                      hintText: 'Email Address',
                      hintStyle: TextStyle(fontFamily: "Montserrat"),
                      border: OutlineInputBorder(
                        borderSide: BorderSide(color: Colors.white),
                      ),
                    ),
                  ),
                ),
                if (ValidateEMail.isNotEmpty)
                  Text(
                    ValidateEMail,
                    style: TextStyle(
                      color: Colors.red,
                    ),
                  ),
                SizedBox(height: 10),
                SizedBox(
                  height: 45,
                  width: 310,
                  child: TextField(
                    controller: textAddress1Controller,
                    focusNode: FocusAddress1,
                    textAlignVertical: TextAlignVertical.bottom,
                    decoration: InputDecoration(
                      hintText: 'Address Line 1',
                      hintStyle: TextStyle(fontFamily: "Montserrat"),
                      border: OutlineInputBorder(
                        borderSide: BorderSide(color: Colors.white),
                      ),
                    ),
                  ),
                ),
                if (ValidateAddress1.isNotEmpty)
                  Text(
                    ValidateAddress1,
                    style: TextStyle(
                      color: Colors.red,
                    ),
                  ),
                SizedBox(height: 10),
                SizedBox(
                  height: 45,
                  width: 310,
                  child: TextField(
                    controller: textAddress2Controller,
                    focusNode: FocusAddress2,
                    textAlignVertical: TextAlignVertical.bottom,
                    decoration: InputDecoration(
                      hintText: 'Address Line 2',
                      hintStyle: TextStyle(fontFamily: "Montserrat"),
                      border: OutlineInputBorder(
                        borderSide: BorderSide(color: Colors.white),
                      ),
                    ),
                  ),
                ),
                if (ValidateAddress2.isNotEmpty)
                  Text(
                    ValidateAddress2,
                    style: TextStyle(
                      color: Colors.red,
                    ),
                  ),
                SizedBox(height: 10),
                SizedBox(
                  height: 45,
                  width: 310,
                  child: TextField(
                    controller: textStateController,
                    focusNode: FocusState,
                    textAlignVertical: TextAlignVertical.bottom,
                    decoration: InputDecoration(
                      hintText: 'State',
                      hintStyle: TextStyle(fontFamily: "Montserrat"),
                      border: OutlineInputBorder(
                        borderSide: BorderSide(color: Colors.white),
                      ),
                    ),
                  ),
                ),
                if (ValidateState.isNotEmpty)
                  Text(
                    ValidateState,
                    style: TextStyle(
                      color: Colors.red,
                    ),
                  ),
                SizedBox(height: 10),
                SizedBox(
                  height: 45,
                  width: 310,
                  child: TextField(
                    controller: textCityController,
                    focusNode: FocusCity,
                    textAlignVertical: TextAlignVertical.bottom,
                    decoration: InputDecoration(
                      hintText: 'City',
                      hintStyle: TextStyle(fontFamily: "Montserrat"),
                      border: OutlineInputBorder(
                        borderSide: BorderSide(color: Colors.white),
                      ),
                    ),
                  ),
                ),
                if (ValidateCity.isNotEmpty)
                  Text(
                    ValidateCity,
                    style: TextStyle(
                      color: Colors.red,
                    ),
                  ),
                SizedBox(height: 10),
                SizedBox(
                  height: 45,
                  width: 310,
                  child: TextField(
                    keyboardType: TextInputType.number,
                    controller: textZipCodeController,
                    focusNode: FocusZipCode,
                    textAlignVertical: TextAlignVertical.bottom,
                    decoration: InputDecoration(
                      hintText: 'Zip Code',
                      hintStyle: TextStyle(fontFamily: "Montserrat"),
                      border: OutlineInputBorder(
                        borderSide: BorderSide(color: Colors.white),
                      ),
                    ),
                  ),
                ),
                if (ValidateZipCode.isNotEmpty)
                  Text(
                    ValidateZipCode,
                    style: TextStyle(
                      color: Colors.red,
                    ),
                  ),
                SizedBox(height: 10),
                SizedBox(
                  height: 45,
                  width: 310,
                  child: TextField(
                    controller: textCountryController,
                    focusNode: FocusCountry,
                    textAlignVertical: TextAlignVertical.bottom,
                    decoration: InputDecoration(
                      hintText: 'Country',
                      hintStyle: TextStyle(fontFamily: "Montserrat"),
                      border: OutlineInputBorder(
                        borderSide: BorderSide(color: Colors.white),
                      ),
                    ),
                  ),
                ),
                if (ValidateCountry.isNotEmpty)
                  Text(
                    ValidateCountry,
                    style: TextStyle(
                      color: Colors.red,
                    ),
                  ),
                SizedBox(height: 16),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    Container(
                      width: 50,
                      height: 50,
                      decoration: BoxDecoration(
                        color: Colors.blue,
                        shape: BoxShape.circle,
                      ),
                      child: Center(
                        child: Text(
                          '2',
                          style: TextStyle(
                            color: Colors.white,
                            fontWeight: FontWeight.bold,
                            fontSize: 18,
                          ),
                        ),
                      ),
                    ),
                    SizedBox(
                      width: 5,
                    ),
                    Text(
                      'Document Upload',
                      style: TextStyle(
                        fontSize: 18,
                        fontWeight: FontWeight.bold,
                        color: Colors.black,
                      ),
                      textAlign: TextAlign.center,
                    ),
                  ],
                ),
                SizedBox(
                  height: 16,
                ),
                Text(
                  'To verify your identity, please upload any of your document',
                  style: TextStyle(
                    fontSize: 16,
                    color: Colors.black,
                  ),
                  textAlign: TextAlign.center,
                ),
                SizedBox(
                  height: 10,
                ),
                Text(
                  'In order to complete, please upload any of the following personal document.',
                  style: TextStyle(
                      fontSize: 16,
                      color: Colors.black,
                      fontWeight: FontWeight.bold),
                  textAlign: TextAlign.center,
                ),
                SizedBox(
                  height: 10,
                ),
                Text(
                  'To avoid delays when verifying account,\n Please make sure below:',
                  style: TextStyle(
                    fontSize: 16,
                    color: Colors.black,
                  ),
                  textAlign: TextAlign.center,
                ),
                SizedBox(height: 10),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    Image.asset("assets/images/tickiconpng.png",
                        cacheHeight: 15, cacheWidth: 15),
                    SizedBox(
                      width: 5,
                    ),
                    Text(
                      'Chosen credential must not be expired.',
                      style: TextStyle(
                        fontSize: 16,
                        color: Colors.black,
                      ),
                      textAlign: TextAlign.center,
                    ),
                  ],
                ),
                SizedBox(height: 10),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    Image.asset("assets/images/tickiconpng.png",
                        cacheHeight: 15, cacheWidth: 15),
                    SizedBox(
                      width: 5,
                    ),
                    Text(
                      'Document should be good condition \n and clearly visible.',
                      style: TextStyle(
                        fontSize: 16,
                        color: Colors.black,
                      ),
                      textAlign: TextAlign.center,
                    ),
                  ],
                ),
                SizedBox(height: 10),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    Image.asset("assets/images/tickiconpng.png",
                        cacheHeight: 15, cacheWidth: 15),
                    SizedBox(
                      width: 5,
                    ),
                    Text(
                      'Make sure that there is no light glare \n on the card.',
                      style: TextStyle(
                        fontSize: 16,
                        color: Colors.black,
                      ),
                      textAlign: TextAlign.center,
                    ),
                  ],
                ),
                SizedBox(height: 10),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    SizedBox(
                      height: 60,
                      width: 108,
                      child: Expanded(
                        child: Card(
                          color: Colors.blueAccent,
                          child: Center(
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                Image.asset(
                                  "assets/images/passport.png",
                                  cacheWidth: 20,
                                  cacheHeight: 20,
                                  color: Colors.white,
                                ),
                                SizedBox(
                                  width: 5,
                                ),
                                Text(
                                  'Passport',
                                  style: TextStyle(
                                    fontSize: 14,
                                    fontWeight: FontWeight.bold,
                                    color: Colors.white,
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ),
                      ),
                    ),
                    SizedBox(
                      height: 60,
                      width: 108,
                      child: Expanded(
                        child: Card(
                          color: Colors.blueAccent,
                          child: Center(
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                Image.asset(
                                  "assets/images/passport.png",
                                  cacheWidth: 20,
                                  cacheHeight: 20,
                                  color: Colors.white,
                                ),
                                SizedBox(
                                  width: 5,
                                ),
                                Text(
                                  'National ID\n Card',
                                  style: TextStyle(
                                    fontSize: 14,
                                    fontWeight: FontWeight.bold,
                                    color: Colors.white,
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ),
                      ),
                    ),
                    SizedBox(
                      height: 60,
                      width: 108,
                      child: Expanded(
                        child: Card(
                          color: Colors.blueAccent,
                          child: Center(
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                Image.asset(
                                  "assets/images/passport.png",
                                  cacheWidth: 20,
                                  cacheHeight: 20,
                                  color: Colors.white,
                                ),
                                SizedBox(
                                  width: 5,
                                ),
                                Text(
                                  'Driver\n License',
                                  style: TextStyle(
                                    fontSize: 14,
                                    fontWeight: FontWeight.bold,
                                    color: Colors.white,
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
                Visibility(
                  visible: isProofCopyVisible,
                  child: Align(
                    alignment: Alignment.centerLeft,
                    child: Text(
                      'Upload Here Your Passport Copy',
                      style: TextStyle(
                        fontSize: 17,
                        fontWeight: FontWeight.bold,
                        color: Colors.black,
                      ),
                    ),
                  ),
                ),
                SizedBox(height: 16),
                SizedBox(height: 16),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                    Container(
                      width: 120,
                      height: 40,
                      decoration: BoxDecoration(
                        color: Colors.green,
                        borderRadius: BorderRadius.circular(1),
                      ),
                      child: Center(
                        child: Text(
                          'Choose File',
                          style: TextStyle(
                            color: Colors.white,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ),
                    ),
                    SizedBox(width: 16),
                    Image.asset(
                      "assets/images/ipassport.png",
                      cacheHeight: 70,
                      cacheWidth: 70,
                    ),
                  ],
                ),
                SizedBox(height: 16),
                Align(
                  alignment: Alignment.centerLeft,
                  child: Text(
                    'Upload a photo of Proof Copy hold by your hand',
                    style: TextStyle(
                      fontSize: 16,
                      fontWeight: FontWeight.bold,
                      color: Colors.black,
                    ),
                  ),
                ),
                SizedBox(height: 16),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                    Container(
                      width: 120,
                      height: 40,
                      decoration: BoxDecoration(
                        color: Colors.green,
                        borderRadius: BorderRadius.circular(1),
                      ),
                      child: Center(
                        child: Text(
                          'Choose File',
                          style: TextStyle(
                            color: Colors.white,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ),
                    ),
                    SizedBox(width: 16),
                    Image.asset(
                      "assets/images/photoface.png",
                      cacheHeight: 70,
                      cacheWidth: 70,
                    ),
                  ],
                ),
                SizedBox(height: 16),
                Row(
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: [
                    Align(
                      alignment: Alignment.centerLeft,
                    ),
                    Checkbox(
                        value: checkboxStatus == "1",
                        onChanged: (bool? newValue) {
                          setState(() {
                            checkboxStatus = newValue == true ? "1" : "0";
                          });
                          print('cjeckbosfstsyd:$checkboxStatus');
                        }),
                    Text(
                        style: TextStyle(fontSize: 14),
                        'I have read the Terms and Condition and\n Privacy and Policy.'),
                  ],
                ),
                SizedBox(height: 16),
                Row(
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: [
                    Align(
                      alignment: Alignment.centerLeft,
                    ),
                    Checkbox(
                        value: checkboxStatus1 == "1",
                        onChanged: (bool? newValue) {
                          setState(() {
                            checkboxStatus1 = newValue == true ? "1" : "0";
                          });
                          print('cjeckbosfstsyd:$checkboxStatus1');
                        }),
                    Text(
                        style: TextStyle(fontSize: 14),
                        'All the personal information I have \nentered is correct.'),
                  ],
                ),
                SizedBox(height: 16),
                SizedBox(
                  width: 320,
                  height: 40,
                  child: ElevatedButton(
                    onPressed: validateTextField,
                    child: Text(
                      'PROCESS FOR VERIFY',
                      style:
                          TextStyle(fontWeight: FontWeight.bold, fontSize: 17),
                    ),
                    style: ElevatedButton.styleFrom(
                      backgroundColor: Colors.green,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(20),
                      ),
                    ),
                  ),
                ),
                SizedBox(height: 25.0),
              ],
            ),
          ),
        ));
  }

  @override
  void dispose() {
    textFNameController.dispose();
    textLNameController.dispose();
    textMNumberController.dispose();
    textEMailController.dispose();
    textAddress1Controller.dispose();
    textAddress2Controller.dispose();
    FocusFirstName.dispose();
    FocusLastName.dispose();
    FocusMoile.dispose();
    FocusEMail.dispose();
    FocusAddress1.dispose();
    FocusAddress2.dispose();
    FocusState.dispose();
    FocusCountry.dispose();
    FocusCity.dispose();
    FocusDOB.dispose();
    FocusZipCode.dispose();
    textStateController.dispose();
    textCountryController.dispose();
    textCityController.dispose();
    textZipCodeController.dispose();
    textDOBController.dispose();
    super.dispose();
  }
}
