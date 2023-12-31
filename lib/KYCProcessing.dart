import 'dart:convert';
import 'dart:developer';
import 'package:http/http.dart' as http;
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:image_picker/image_picker.dart';
import 'package:intl/intl.dart';
import 'package:login_project_sample/KYCList.dart';
import 'package:login_project_sample/utils/response_handler.dart';
import 'dart:io';
import 'package:get/get.dart';
import 'package:login_project_sample/utils/shared_preferences.dart';

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
  var selectedDate = DateTime.now().obs;
  String SelectedValue = '';
  String status = "1";
  int selectstatus = -1;
  TextEditingController dateController = TextEditingController();
  late String memberId;
  void chooseDate() async {
    DateTime? pickedDate = await showDatePicker(
      context: context,
      initialDate: selectedDate.value,
      firstDate: DateTime(1800),
      lastDate: DateTime(2024),
      helpText: 'Select DOB',
      cancelText: 'Close',
      confirmText: 'Confirm',
      errorFormatText: 'Enter a valid date',
      errorInvalidText: 'Enter a valid date range',
      fieldLabelText: 'DOB',
      fieldHintText: 'Month/Date/Year',
    );
    if (pickedDate != null && pickedDate != selectedDate.value) {
      selectedDate.value = pickedDate;
      dateController.text = DateFormat('dd/MM/yyyy').format(pickedDate);
    }
  }

  bool disableDate(DateTime day) {
    if ((day.isAfter(DateTime.now().subtract(Duration(days: 1))) &&
        day.isBefore(DateTime.now().add(Duration(days: 5))))) {
      return true;
    }
    return false;
  }

  String FirstName = '',
      LastName = '',
      EMail = '',
      Address1 = '',
      Address2 = '',
      DOB = '',
      State = '',
      City = '',
      ZipCode = '',
      Country = '',
      MobileNumber = '';
  String? base64Image, imageToUpload;
  String? PassportByHand;

  String? NationalIdImage;
  String? NationalIdBack;
  String? NationalIdCopyHand;

  String? DriverLicencecopy;
  String? DiverLicenceCopyHand;

  Future<http.Response>? __futureLogin;
  bool isProofCopyVisible = true;
  bool isPhotoFaceVisible = true;
  String checkboxStatus = "0";
  String checkboxStatus1 = "0";
  TextEditingController textFNameController = TextEditingController();
  TextEditingController textLNameController = TextEditingController();
  TextEditingController textMNumberController = TextEditingController();
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

    FocusFirstName.requestFocus();
  }

  Future<void> _loadImage() async {
    print('stvv5yatus:${base64Image}');
    imageToUpload = base64Image;
    try {
      print('status:${status}');
      if (status == "1") {
        imageToUpload = base64Image!;
        print('imageTorttUpload: $imageToUpload');
      } else if (status == "5") {
        imageToUpload = PassportByHand;
      } else if (status == "2") {
        imageToUpload = NationalIdImage;
      } else if (status == "3") {
        imageToUpload = NationalIdBack;
      } else if (status == "4") {
        imageToUpload = DriverLicencecopy;
      } else if (status == "6") {
        imageToUpload = DiverLicenceCopyHand;
      } else {
        imageToUpload = NationalIdCopyHand;
        print('imageToUpload: $imageToUpload');
      }
      print('Image to Upload: $imageToUpload');

      __futureLogin = ResponseHandler.performPost("KycUploadImage",
          'ID=$memberId&Colname=$SelectedValue&KeyValue=$imageToUpload');
      print('Respfhgfgonse body: ${SelectedValue}${imageToUpload}');
      __futureLogin?.then((value) {
        print('Respuiewweonse body: ${value.body}');

        String jsonResponse = ResponseHandler.parseData(value.body);

        print('JSONerty Response: ${jsonResponse}');
      });
    } catch (e) {
      print("Error: $e");
      Fluttertoast.showToast(msg: "An error occurred");
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
      _loadImage();
    }
  }

  Future<void> _openDriverLicenceId() async {
    final picker = ImagePicker();
    final pickedFile = await picker.getImage(source: ImageSource.gallery);

    if (pickedFile != null) {
      final imageBytes = await pickedFile.readAsBytes();
      final encodedImage = base64Encode(imageBytes);

      setState(() {
        DriverLicencecopy = encodedImage;
        print('baseeeeeeb4:$DriverLicencecopy');
      });
      _loadImage();
    }
  }

  Future<void> _openDriverLicenceCopyHand() async {
    final picker = ImagePicker();
    final pickedFile = await picker.getImage(source: ImageSource.gallery);

    if (pickedFile != null) {
      final imageBytes = await pickedFile.readAsBytes();
      final encodedImage = base64Encode(imageBytes);

      setState(() {
        DiverLicenceCopyHand = encodedImage;
        print('baseeeeeeb4:$DiverLicenceCopyHand');
      });
      _loadImage();
    }
  }

  Future<void> _openNationalId() async {
    final picker = ImagePicker();
    final pickedFile = await picker.getImage(source: ImageSource.gallery);

    if (pickedFile != null) {
      final imageBytes = await pickedFile.readAsBytes();
      final encodedImage = base64Encode(imageBytes);

      setState(() {
        NationalIdImage = encodedImage;
        print('baseeeeeeb4:$NationalIdImage');
      });
      _loadImage();
    }
  }

  Future<void> _openNationalIdBack() async {
    final picker = ImagePicker();
    final pickedFile = await picker.getImage(source: ImageSource.gallery);

    if (pickedFile != null) {
      final imageBytes = await pickedFile.readAsBytes();
      final encodedImage = base64Encode(imageBytes);

      setState(() {
        NationalIdBack = encodedImage;
        print('baseeeeeeb4:$NationalIdBack');
      });
      _loadImage();
    }
  }

  Future<void> _openNtionalIdCopyHand() async {
    final picker = ImagePicker();
    final pickedFile = await picker.getImage(source: ImageSource.gallery);

    if (pickedFile != null) {
      final imageBytes = await pickedFile.readAsBytes();
      final encodedImage = base64Encode(imageBytes);

      setState(() {
        NationalIdCopyHand = encodedImage;
        print('baseeeeeeb4:$NationalIdCopyHand');
      });
      _loadImage();
    }
  }

  //NationalIdBack
//NationalIdCopyHand
  Future<void> _openPassportGallery() async {
    final picker = ImagePicker();
    final pickedFile = await picker.getImage(source: ImageSource.gallery);

    if (pickedFile != null) {
      final imageBytes = await pickedFile.readAsBytes();
      final encodedImage = base64Encode(imageBytes);

      setState(() {
        PassportByHand = encodedImage;
        print('baseeeeeeb4:$PassportByHand');
      });
      _loadImage();
    }
  }
  //_openPassportGallery

  void validateTextField() {
    FirstName = textFNameController.text.trim();
    LastName = textLNameController.text.trim();
    EMail = textEMailController.text.trim();
    Address1 = textAddress1Controller.text.trim();
    Address2 = textAddress2Controller.text.trim();
    DOB = dateController.text.trim();
    State = textStateController.text.trim();
    City = textCityController.text.trim();
    ZipCode = textZipCodeController.text.trim();
    Country = textCountryController.text.trim();
    MobileNumber = textMNumberController.text.trim();
    if (checkboxStatus == "0") {
      Fluttertoast.showToast(
        msg: 'Please accept Terms and Conditions',
        gravity: ToastGravity.BOTTOM,
        textColor: Colors.white,
      );
    }
    if (checkboxStatus1 == "") {
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
    _uploadImageAndRegister();
  }

  Future<void> _uploadImageAndRegister() async {
    memberId = await Prefs.getStringValue(Prefs.PREFS_USER_ID);

    log("memberId" + memberId!);
    __futureLogin = ResponseHandler.performPost(
        "KYCAdd",
        'customerid=$memberId&date=&firstname=$FirstName&lastname=$LastName'
            '&phone=$MobileNumber&dob=$DOB&gender=1&telegram='
            '&address1=$Address1&address2=$Address2'
            '&state=$State&city=$City&zip=$ZipCode'
            '&country=$Country&submitdate=&submitkby=');
    print('Customer ID: $memberId');
    print('Date: ');
    print('First Name: ${textFNameController.text}');
    print('Last Name: ${textLNameController.text}');
    print('Phone: ${textMNumberController.text}');
    print('Date of Birth: ${dateController.text}');
    print('Gender: ');
    print('Telegram: ');
    print('Address 1: ${textAddress1Controller.text}');
    print('Address 2: ${textAddress2Controller.text}');
    print('State: ${textStateController.text}');
    print('City: ${textCityController.text}');
    print('ZIP Code: ${textZipCodeController.text}');
    print('Country: ${textCountryController.text}');
    print('Submit Date: ');
    print('Submitted by: ');

    __futureLogin?.then((value) {
      print('Response body: ${value.body}');

      String jsonResponse = ResponseHandler.parseData(value.body);

      print('JSON Response: ${jsonResponse}');
    });
  }

  String selectedDocument = 'Passport'; // Default selected document
  bool showPassportFields = true;
  bool showNationalIdFields = false;
  bool showDriversLicenseFields = false;

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

//_openPassportCamera
  Future<void> _openPassportCamera() async {
    final picker = ImagePicker();
    final pickedFile = await picker.getImage(source: ImageSource.camera);

    if (pickedFile != null) {
      final imageBytes = await pickedFile.readAsBytes();
      final encodedImage = base64Encode(imageBytes);

      setState(() {
        PassportByHand = encodedImage;
        print('baseeeeeeb4:$PassportByHand');
      });
    }
  }

  Future<void> _openNationalIDCamera() async {
    final picker = ImagePicker();
    final pickedFile = await picker.getImage(source: ImageSource.camera);

    if (pickedFile != null) {
      final imageBytes = await pickedFile.readAsBytes();
      final encodedImage = base64Encode(imageBytes);

      setState(() {
        NationalIdImage = encodedImage;
        print('baseeeeeeb4:$NationalIdImage');
      });
    }
  }

  Future<void> _openNationalIdBackCamera() async {
    final picker = ImagePicker();
    final pickedFile = await picker.getImage(source: ImageSource.camera);

    if (pickedFile != null) {
      final imageBytes = await pickedFile.readAsBytes();
      final encodedImage = base64Encode(imageBytes);

      setState(() {
        NationalIdBack = encodedImage;
        print('baseeeeeeb4:$NationalIdBack');
      });
    }
  }

  Future<void> _openNationalIDCopyHandCamera() async {
    final picker = ImagePicker();
    final pickedFile = await picker.getImage(source: ImageSource.camera);

    if (pickedFile != null) {
      final imageBytes = await pickedFile.readAsBytes();
      final encodedImage = base64Encode(imageBytes);

      setState(() {
        NationalIdCopyHand = encodedImage;
        print('baseeeeeeb4:$NationalIdCopyHand');
      });
    }
  }

  Future<void> _openDriverLicenseCamera() async {
    final picker = ImagePicker();
    final pickedFile = await picker.getImage(source: ImageSource.camera);

    if (pickedFile != null) {
      final imageBytes = await pickedFile.readAsBytes();
      final encodedImage = base64Encode(imageBytes);

      setState(() {
        DriverLicencecopy = encodedImage;
        print('baseeeeeeb4:$DriverLicencecopy');
      });
    }
  }

  Future<void> _openDriverLienseCopyHandCamera() async {
    final picker = ImagePicker();
    final pickedFile = await picker.getImage(source: ImageSource.camera);

    if (pickedFile != null) {
      final imageBytes = await pickedFile.readAsBytes();
      final encodedImage = base64Encode(imageBytes);

      setState(() {
        DiverLicenceCopyHand = encodedImage;
        print('baseeeeeeb4:$DiverLicenceCopyHand');
      });
    }
  }

  //_openNtionalIdCopyHand
  //_openDriverLicenceId
  Future _showSelectionDialog(BuildContext context) {
    selectstatus = 1;
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
                                  fontSize: 13, color: Colors.black))),
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
                            style:
                                TextStyle(fontSize: 13, color: Colors.black))),
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
                      child: Text(
                        "Cancel",
                        style: TextStyle(
                          color: Colors.white,
                          fontSize: 14,
                          fontWeight: FontWeight.bold,
                        ),
                        textAlign: TextAlign.center,
                      ),
                    ),
                  ),
                ],
              ),
            ),
          );
        });
  }

  Future _showNationalId(BuildContext context) {
    selectstatus = 2;
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
                                  fontSize: 13, color: Colors.black))),
                      onTap: () {
                        _openNationalId();
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
                            style:
                                TextStyle(fontSize: 13, color: Colors.black))),
                    onTap: () {
                      _openNationalIDCamera();
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
                      child: Text(
                        "Cancel",
                        style: TextStyle(
                          color: Colors.white,
                          fontSize: 14,
                          fontWeight: FontWeight.bold,
                        ),
                        textAlign: TextAlign.center,
                      ),
                    ),
                  ),
                ],
              ),
            ),
          );
        });
  }

  Future _showNationalIdBack(BuildContext context) {
    selectstatus = 2;
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
                                  fontSize: 13, color: Colors.black))),
                      onTap: () {
                        _openNationalIdBack();
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
                            style:
                                TextStyle(fontSize: 13, color: Colors.black))),
                    onTap: () {
                      _openNationalIdBackCamera();
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
                      child: Text(
                        "Cancel",
                        style: TextStyle(
                          color: Colors.white,
                          fontSize: 14,
                          fontWeight: FontWeight.bold,
                        ),
                        textAlign: TextAlign.center,
                      ),
                    ),
                  ),
                ],
              ),
            ),
          );
        });
  }

  Future _OpenNationalCopyHand(BuildContext context) {
    selectstatus = 2;
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
                                  fontSize: 13, color: Colors.black))),
                      onTap: () {
                        _openNtionalIdCopyHand();
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
                            style:
                                TextStyle(fontSize: 13, color: Colors.black))),
                    onTap: () {
                      _openNationalIDCopyHandCamera();
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
                      child: Text(
                        "Cancel",
                        style: TextStyle(
                          color: Colors.white,
                          fontSize: 14,
                          fontWeight: FontWeight.bold,
                        ),
                        textAlign: TextAlign.center,
                      ),
                    ),
                  ),
                ],
              ),
            ),
          );
        });
  }

  Future _showDriverLicenceID(BuildContext context) {
    selectstatus = 3;
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
                                  fontSize: 13, color: Colors.black))),
                      onTap: () {
                        _openDriverLicenceId();
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
                            style:
                                TextStyle(fontSize: 13, color: Colors.black))),
                    onTap: () {
                      _openDriverLicenseCamera();
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
                      child: Text(
                        "Cancel",
                        style: TextStyle(
                          color: Colors.white,
                          fontSize: 14,
                          fontWeight: FontWeight.bold,
                        ),
                        textAlign: TextAlign.center,
                      ),
                    ),
                  ),
                ],
              ),
            ),
          );
        });
  }

  Future _showPassportByHand(BuildContext context) {
    selectstatus = 1;
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
                                  fontSize: 13, color: Colors.black))),
                      onTap: () {
                        _openPassportGallery();
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
                            style:
                                TextStyle(fontSize: 13, color: Colors.black))),
                    onTap: () {
                      _openPassportCamera();
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
                      child: Text(
                        "Cancel",
                        style: TextStyle(
                          color: Colors.white,
                          fontSize: 14,
                          fontWeight: FontWeight.bold,
                        ),
                        textAlign: TextAlign.center,
                      ),
                    ),
                  ),
                ],
              ),
            ),
          );
        });
  }

  Future _showDriverLicenseCopyHand(BuildContext context) {
    selectstatus = 3;
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
                                  fontSize: 13, color: Colors.black))),
                      onTap: () {
                        _openDriverLicenceCopyHand();
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
                            style:
                                TextStyle(fontSize: 13, color: Colors.black))),
                    onTap: () {
                      _openDriverLienseCopyHandCamera();
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
                      child: Text(
                        "Cancel",
                        style: TextStyle(
                          color: Colors.white,
                          fontSize: 14,
                          fontWeight: FontWeight.bold,
                        ),
                        textAlign: TextAlign.center,
                      ),
                    ),
                  ),
                ],
              ),
            ),
          );
        });
  }

//_openDriverLicenceCopyHand
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          backgroundColor: Color(0xFF007E01),
          leading: IconButton(
            icon: Icon(Icons.arrow_back),
            onPressed: () {
              // Handle back button action
            },
          ),
          title: Text('KYC Verification Details'), titleSpacing: 15,
          leadingWidth: 30,
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
                          onTap: () {},
                          decoration: InputDecoration(
                            hintText: 'Select DOB',
                            suffixIcon: GestureDetector(
                              onTap: () {
                                chooseDate();
                              },
                              child: Image.asset('assets/images/calendar.png',
                                  cacheWidth: 25,
                                  cacheHeight:
                                      25), // Replace with your desired icon
                            ),
                            border: OutlineInputBorder(
                              borderSide: BorderSide(color: Colors.white),
                            ),
                          ),
                          readOnly: true,
                          controller:
                              dateController, // Use the TextEditingController
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
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Container(
                            height: 44,
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(5),
                              border: Border.all(
                                color: Colors
                                    .indigoAccent, // Set the border color to green
                                width: 1.0, // Set the border width as needed
                              ),
                            ),
                            child: ElevatedButton(
                              onPressed: () {
                                setState(() {
                                  selectedDocument = 'Passport';
                                  showPassportFields = true;
                                  showNationalIdFields = false;
                                  showDriversLicenseFields = false;
                                });
                              },
                              style: ElevatedButton.styleFrom(
                                primary: selectedDocument == 'Passport'
                                    ? Colors.indigoAccent
                                    : Colors.white,
                                onPrimary: selectedDocument == 'Passport'
                                    ? Colors.white
                                    : Colors.black,
                              ),
                              child: Row(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Image.asset(
                                    'assets/images/passport.png',
                                    width: 20,
                                    height: 20,
                                    color: selectedDocument == 'Passport'
                                        ? Colors.white
                                        : Colors.black,
                                  ),
                                  Text('Passport',
                                      style: TextStyle(
                                          color: selectedDocument == 'Passport'
                                              ? Colors.white
                                              : Colors.black)),
                                ],
                              ),
                            ),
                          ),
                          SizedBox(
                            width: 2,
                          ),
                          Container(
                            height: 44,
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(5),
                              border: Border.all(
                                color: Colors
                                    .indigoAccent, // Set the border color to green
                                width: 1.0, // Set the border width as needed
                              ),
                            ),
                            child: ElevatedButton(
                              onPressed: () {
                                setState(() {
                                  selectedDocument = 'National ID Card';
                                  showPassportFields = false;
                                  showNationalIdFields = true;
                                  showDriversLicenseFields = false;
                                });
                              },
                              style: ElevatedButton.styleFrom(
                                primary: selectedDocument == 'National ID Card'
                                    ? Colors.indigoAccent
                                    : Colors.white,
                                onPrimary:
                                    selectedDocument == 'National ID Card'
                                        ? Colors.white
                                        : Colors.black,
                              ),
                              child: Row(
                                children: [
                                  Image.asset(
                                    'assets/images/passport.png',
                                    width: 20,
                                    height: 20,
                                    color:
                                        selectedDocument == 'National ID Card'
                                            ? Colors.white
                                            : Colors.black,
                                  ),
                                  Text('National\n ID Card',
                                      style: TextStyle(
                                          color: selectedDocument ==
                                                  'National ID Card'
                                              ? Colors.white
                                              : Colors.black)),
                                ],
                              ),
                            ),
                          ),
                          SizedBox(
                            width: 2,
                          ),
                          Container(
                            height: 44,
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(5),
                              border: Border.all(
                                color: Colors
                                    .indigoAccent, // Set the border color to green
                                width: 1.0, // Set the border width as needed
                              ),
                            ),
                            child: ElevatedButton(
                              onPressed: () {
                                setState(() {
                                  selectedDocument = "Driver's License";
                                  showPassportFields = false;
                                  showNationalIdFields = false;
                                  showDriversLicenseFields = true;
                                });
                              },
                              style: ElevatedButton.styleFrom(
                                primary: selectedDocument == "Driver's License"
                                    ? Colors.indigoAccent
                                    : Colors.white,
                                onPrimary:
                                    selectedDocument == "Driver's License"
                                        ? Colors.white
                                        : Colors.black,
                              ),
                              child: Row(
                                children: [
                                  Image.asset('assets/images/passport.png',
                                      color:
                                          selectedDocument == "Driver's License"
                                              ? Colors.white
                                              : Colors.black,
                                      width: 20,
                                      height: 20),
                                  Text('Driver \n License',
                                      style: TextStyle(
                                          color: selectedDocument ==
                                                  "Driver's License"
                                              ? Colors.white
                                              : Colors.black)),
                                ],
                              ),
                            ),
                          ),
                        ],
                      ),
                      /*  Container(
                            height: 40, // Set the desired height
                            width: 360,
                            child: ToggleButtons(
                              isSelected: [
                                selectedDocument == 'Passport',
                                selectedDocument == 'National ID Card',
                                selectedDocument == "Driver's License"
                              ],
                              onPressed: (int index) {
                                setState(() {
                                  if (index == 0) {
                                    selectedDocument = 'Passport';
                                    showPassportFields = true;
                                    showNationalIdFields = false;
                                    showDriversLicenseFields = false;
                                  } else if (index == 1) {
                                    selectedDocument = 'National ID Card';
                                    showPassportFields = false;
                                    showNationalIdFields = true;
                                    showDriversLicenseFields = false;
                                  } else if (index == 2) {
                                    selectedDocument = "Driver's License";
                                    showPassportFields = false;
                                    showNationalIdFields = false;
                                    showDriversLicenseFields = true;
                                  }
                                });
                              },
                              children: [
                                Text(
                                  'Passport',
                                  style: TextStyle(
                                    color: selectedDocument == 'Passport'
                                        ? Colors.white
                                        : Colors.black,
                                  ),
                                ),
                                Text(
                                  'National\n ID Card',
                                  style: TextStyle(
                                    color: Colors.white,
                                  ),
                                ),
                                Text(
                                  "Driver's\n License",
                                  style: TextStyle(
                                    color: Colors.white,
                                  ),
                                ),
                              ],
                              fillColor: Colors
                                  .purple, // Background color when selected
                              color:
                                  Colors.black, // Text color when not selected
                              selectedColor: Colors.white,
                              */ /* ElevatedButton(
                              onPressed: () {
                                setState(() {
                                  selectedDocument = 'Passport';
                                  showPassportFields = true;
                                  showNationalIdFields = false;
                                  showDriversLicenseFields = false;
                                });
                              },
                              style: ButtonStyle(
                                backgroundColor:
                                    MaterialStateProperty.resolveWith<Color>(
                                  (states) {
                                    final stateSet = states.toSet();
                                    if (stateSet
                                        .contains(MaterialState.pressed)) {
                                      // When button is pressed
                                      return Color(
                                          0xFF007E01); // Purple background
                                    } else if (selectedDocument == 'Passport') {
                                      // When Passport button is selected
                                      return Colors.blue; // Dark blue background
                                    } else {
                                      // Default state
                                      return Colors.white; // White background
                                    }
                                  },
                                ),
                              ),
                              child: Row(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                                children: [
                                  Image.asset('assets/images/passport.png',
                                      width: 20, height: 20),
                                  SizedBox(
                                    width: 2,
                                  ),
                                  Text(
                                    'Passport',
                                    style: TextStyle(
                                      color: selectedDocument == 'Passport' ||
                                              stateSet.contains(
                                                  MaterialState.pressed) ||
                                              stateSet.contains(
                                                  MaterialState.selected)
                                          ? Colors.white
                                          : Colors.black,
                                    ),
                                  ),
                                ],
                              ),
                            ),
                            ElevatedButton(
                              onPressed: () {
                                setState(() {
                                  selectedDocument = 'National ID Card';
                                  showPassportFields = false;
                                  showNationalIdFields = true;
                                  showDriversLicenseFields = false;
                                });
                              },
                              style: ElevatedButton.styleFrom(
                                primary: selectedDocument == 'National ID Card'
                                    ? Colors.blue
                                    : Colors.grey,
                              ),
                              child: Row(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                                children: [
                                  Image.asset('assets/images/passport.png',
                                      width: 20, height: 20),
                                  SizedBox(
                                    width: 2,
                                  ),
                                  Text('National\n ID Card'),
                                ],
                              ),
                            ),
                            ElevatedButton(
                              onPressed: () {
                                setState(() {
                                  selectedDocument = "Driver's License";
                                  showPassportFields = false;
                                  showNationalIdFields = false;
                                  showDriversLicenseFields = true;
                                });
                              },
                              style: ElevatedButton.styleFrom(
                                primary: selectedDocument == "Driver's License"
                                    ? Colors.blue
                                    : Colors.grey,
                              ),
                              child: Row(
                                children: [
                                  Image.asset('assets/images/passport.png',
                                      width: 20, height: 20),
                                  SizedBox(
                                    width: 5,
                                  ),
                                  Text('Driver \n License'),
                                ],
                              ),
                            ),*/ /*
                            ),
                          )*/

                      SizedBox(
                        height: 10,
                      ),

                      if (showPassportFields)
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              'Upload here your passport copy',
                              style: TextStyle(
                                fontSize: 18,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                            Row(
                              children: [
                                ElevatedButton(
                                  onPressed: () {
                                    setState(() {
                                      SelectedValue = 'Passport';
                                      status = "1";
                                    });

                                    _showSelectionDialog(context);
                                  },
                                  style: ElevatedButton.styleFrom(
                                    primary: Color(0xFF007E01),
                                    shape: RoundedRectangleBorder(
                                      borderRadius: BorderRadius.circular(4),
                                      // Set the circular radius
                                    ), // Set the background color to blue
                                  ),
                                  child: Text(
                                    'Choose File',
                                  ),
                                ),
                                SizedBox(
                                  width: 80,
                                ),
                                if (base64Image != null)
                                  Image(
                                    image: MemoryImage(
                                      base64Decode(base64Image!),
                                    ),
                                    width: 70,
                                    height: 70,
                                  )
                                else
                                  Image.asset("assets/images/ipassport.png",
                                      width: 70, height: 70),
                              ],
                            ),
                            Text(
                              'Upload a Photo of Proof Copy hold by your hand',
                              style: TextStyle(
                                fontSize: 18,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                            Row(
                              children: [
                                ElevatedButton(
                                  onPressed: () {
                                    SelectedValue = 'passportphoto';
                                    status = "5";
                                    _showPassportByHand(context);
                                  },
                                  style: ElevatedButton.styleFrom(
                                    primary: Color(0xFF007E01),
                                    shape: RoundedRectangleBorder(
                                      borderRadius: BorderRadius.circular(4),
                                      // Set the circular radius
                                    ), // Set the background color to blue
                                  ),
                                  child: Text(
                                    'Choose File',
                                  ),
                                ),
                                SizedBox(
                                  width: 80,
                                ),
                                if (PassportByHand != null)
                                  Image(
                                    image: MemoryImage(
                                      base64Decode(PassportByHand!),
                                    ),
                                    height: 70,
                                    width: 70,
                                  )
                                else
                                  Image.asset("assets/images/photoface.png",
                                      width: 70, height: 70),
                              ],
                            ),
                          ],
                        )
                      else if (showNationalIdFields)
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              'Upload here your National ID Copy',
                              style: TextStyle(
                                fontSize: 18,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                            Row(
                              children: [
                                ElevatedButton(
                                  onPressed: () {
                                    SelectedValue = 'idfront';
                                    status = "2";
                                    _showNationalId(context);
                                  },
                                  style: ElevatedButton.styleFrom(
                                    primary: Color(0xFF007E01),
                                    shape: RoundedRectangleBorder(
                                      borderRadius: BorderRadius.circular(4),
                                      // Set the circular radius
                                    ), // Set the background color to blue
                                  ),
                                  child: Text(
                                    'Choose File',
                                  ),
                                ),
                                SizedBox(
                                  width: 80,
                                ),
                                if (NationalIdImage != null)
                                  Image(
                                    image: MemoryImage(
                                      base64Decode(NationalIdImage!),
                                    ),
                                    width: 70,
                                    height: 70,
                                  )
                                else
                                  Image.asset("assets/images/idfront.png",
                                      width: 70, height: 70),
                              ],
                            ),
                            Text(
                              'Upload Here Your National ID Back Side',
                              style: TextStyle(
                                fontSize: 18,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                            Row(
                              children: [
                                ElevatedButton(
                                  onPressed: () {
                                    SelectedValue = 'idback';
                                    status = "3";
                                    _showNationalIdBack(context);
                                  },
                                  style: ElevatedButton.styleFrom(
                                    primary: Color(0xFF007E01),
                                    shape: RoundedRectangleBorder(
                                      borderRadius: BorderRadius.circular(4),
                                      // Set the circular radius
                                    ), // Set the background color to blue
                                  ),
                                  child: Text(
                                    'Choose File',
                                  ),
                                ),
                                SizedBox(
                                  width: 80,
                                ),
                                if (NationalIdBack != null)
                                  Image(
                                    image: MemoryImage(
                                      base64Decode(NationalIdBack!),
                                    ),
                                    height: 70,
                                    width: 70,
                                  )
                                else
                                  Image.asset("assets/images/idback.png",
                                      width: 70, height: 70),
                              ],
                            ),
                            Text(
                              'Upload a Photo of proof copy hold ny you hand',
                              style: TextStyle(
                                fontSize: 18,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                            Row(
                              children: [
                                ElevatedButton(
                                  onPressed: () {
                                    SelectedValue = 'nationalidphoto';
                                    status = "7";
                                    _OpenNationalCopyHand(context);
                                  },
                                  style: ElevatedButton.styleFrom(
                                    primary: Color(0xFF007E01),
                                    shape: RoundedRectangleBorder(
                                      borderRadius: BorderRadius.circular(4),
                                      // Set the circular radius
                                    ), // Set the background color to blue
                                  ),
                                  child: Text(
                                    'Choose File',
                                  ),
                                ),
                                SizedBox(
                                  width: 80,
                                ),
                                if (NationalIdCopyHand != null)
                                  Image(
                                    image: MemoryImage(
                                      base64Decode(NationalIdCopyHand!),
                                    ),
                                    height: 70,
                                    width: 70,
                                  )
                                else
                                  Image.asset("assets/images/photoface.png",
                                      width: 70, height: 70),
                              ],
                            ),
                          ],
                        )
                      else if (showDriversLicenseFields)
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              'Upload here your Drivers copy',
                              style: TextStyle(
                                fontSize: 18,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                            Row(
                              children: [
                                ElevatedButton(
                                  onPressed: () {
                                    SelectedValue = 'driver';
                                    status = "4";
                                    _showDriverLicenceID(context);
                                  },
                                  style: ElevatedButton.styleFrom(
                                    primary: Color(0xFF007E01),
                                    shape: RoundedRectangleBorder(
                                      borderRadius: BorderRadius.circular(4),
                                      // Set the circular radius
                                    ), // Set the background color to blue
                                  ),
                                  child: Text(
                                    'Choose File',
                                  ),
                                ),
                                SizedBox(
                                  width: 80,
                                ),
                                if (DriverLicencecopy != null)
                                  Image(
                                    image: MemoryImage(
                                      base64Decode(DriverLicencecopy!),
                                    ),
                                    width: 70,
                                    height: 70,
                                  )
                                else
                                  Image.asset("assets/images/idriver.png",
                                      width: 70, height: 70),
                              ],
                            ),
                            Text(
                              'Upload a Photo of Proof Copy hold by your hand',
                              style: TextStyle(
                                fontSize: 18,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                            Row(
                              children: [
                                ElevatedButton(
                                  onPressed: () {
                                    SelectedValue = 'driverphoto';
                                    status = "6";
                                    _showDriverLicenseCopyHand(context);
                                  },
                                  style: ElevatedButton.styleFrom(
                                    primary: Color(0xFF007E01),
                                    shape: RoundedRectangleBorder(
                                      borderRadius: BorderRadius.circular(4),
                                      // Set the circular radius
                                    ), // Set the background color to blue
                                  ),
                                  child: Text(
                                    'Choose File',
                                  ),
                                ),
                                SizedBox(
                                  width: 80,
                                ),
                                if (DiverLicenceCopyHand != null)
                                  Image(
                                    image: MemoryImage(
                                      base64Decode(DiverLicenceCopyHand!),
                                    ),
                                    height: 70,
                                    width: 70,
                                  )
                                else
                                  Image.asset("assets/images/photoface.png",
                                      width: 70, height: 70),
                              ],
                            ),
                          ],
                        ),

                      Row(
                        children: [
                          Checkbox(
                              value: checkboxStatus == "1",
                              onChanged: (bool? newValue) {
                                setState(() {
                                  checkboxStatus = newValue == true ? "1" : "0";
                                });
                                print('cjeckbosfstsyd:$checkboxStatus');
                              }),
                          Text(
                              'I have read the terms and Condition and \n Privacy and Policy.',
                              style:
                                  TextStyle(color: Colors.black, fontSize: 14)),
                        ],
                      ),
                      Row(
                        children: [
                          Checkbox(
                              value: checkboxStatus1 == "1",
                              onChanged: (bool? newValue) {
                                setState(() {
                                  checkboxStatus = newValue == true ? "1" : "0";
                                });
                                print('cjeckbosfstsyd:$checkboxStatus');
                              }),
                          Text(
                              'I have read the terms and Condition and \n Privacy and Policy.',
                              style:
                                  TextStyle(color: Colors.black, fontSize: 14)),
                        ],
                      ),
                      ElevatedButton(
                        onPressed: () {
                          validateTextField();
                        },
                        style: ElevatedButton.styleFrom(
                          primary: Colors.blue, // Change to your desired color
                        ),
                        child: SizedBox(
                            height: 40,
                            width: 360,
                            child: Padding(
                              padding: const EdgeInsets.only(top: 10),
                              child: Text(
                                'PROCESS FOR VERIFY',
                                textAlign: TextAlign.center,
                              ),
                            )),
                      ),
                      // Display the selected image here, replace 'imageFile' with your image variable

                      /* Visibility(
                  visible: isPassportVisible,
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
                ),*/
                    ]))));
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
    dateController.dispose();
    super.dispose();
  }
}

class DocumentButton extends StatefulWidget {
  final String label;
  final bool isVisible;
  final VoidCallback onTap;

  DocumentButton({
    required this.label,
    required this.isVisible,
    required this.onTap,
  });

  @override
  _DocumentButtonState createState() => _DocumentButtonState();
}

class _DocumentButtonState extends State<DocumentButton> {
  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 60,
      width: 108,
      child: Card(
        color: widget.isVisible ? Color(0xFF566DF1) : Colors.white,
        shape: RoundedRectangleBorder(
          side: BorderSide(color: Color(0xFF566DF1), width: 0.6),
          borderRadius: BorderRadius.circular(8.0),
        ),
        child: InkWell(
          onTap: widget.onTap,
          child: Center(
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Image.asset(
                  "assets/images/passport.png",
                  cacheWidth: 20,
                  cacheHeight: 20,
                  color: widget.isVisible ? Colors.white : Colors.black,
                ),
                SizedBox(
                  width: 5,
                ),
                Text(
                  widget.label,
                  style: TextStyle(
                    fontSize: 14,
                    fontWeight: FontWeight.bold,
                    color: widget.isVisible ? Colors.white : Colors.black,
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
