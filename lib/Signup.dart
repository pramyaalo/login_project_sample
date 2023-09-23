import 'dart:convert';
import 'dart:developer';
import 'dart:io';
import 'dart:convert';
import 'dart:typed_data';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:image_picker/image_picker.dart';
import 'package:http/http.dart' as http;
import 'package:flutter/services.dart'
    show SystemChrome, SystemUiOverlayStyle, rootBundle;
import 'package:login_project_sample/AddDispute.dart';
import 'package:login_project_sample/BankDetails.dart';
import 'package:login_project_sample/BinaryIncomeReport.dart';
import 'package:login_project_sample/CashWalletHistory.dart';
import 'package:login_project_sample/DirectIncomeReport.dart';
import 'package:login_project_sample/EditProfile.dart';
import 'package:login_project_sample/IncomeReport.dart';
import 'package:login_project_sample/KYCApplication.dart';
import 'package:login_project_sample/KYCList.dart';
import 'package:login_project_sample/KYCProcessing.dart';
import 'package:login_project_sample/Models/SignupModel.dart';
import 'package:login_project_sample/PayoutHistory.dart';
import 'package:login_project_sample/Payouts.dart';
import 'package:login_project_sample/PendingOrders.dart';
import 'package:login_project_sample/Reported_Dispute.dart';
import 'package:login_project_sample/Wallet_n.dart';
import 'package:login_project_sample/WithDrawFund.dart';
import 'package:login_project_sample/WithdrawList.dart';
import 'package:login_project_sample/pairIncomeReport.dart';
import 'package:login_project_sample/utils/response_handler.dart';

class signup extends StatefulWidget {
  @override
  _SignUpPageState createState() => _SignUpPageState();
}

enum Gender { self, franchise }

class _SignUpPageState extends State<signup> {
  Gender? _selectedGender = Gender.self; // Set the default selection to "Self"
  bool _isTextFieldVisible = true;
  Future<http.Response>? __futureLogin;
  String checkboxStatus = "0";
  String checkboxStatus1 = "0";
  bool _passwordVisible = false;
  bool _confirmpasswordVisible = false;
  bool _transactionpasswordVisible = false;
  bool _confirmtransactionpasswordVisible = false;
  final TextEditingController _ReferralId = TextEditingController();
  final TextEditingController _locationController = TextEditingController();
  final TextEditingController _firstNameController = TextEditingController();
  final TextEditingController _lastnameController = TextEditingController();
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _mobileController = TextEditingController();
  final TextEditingController _address1Controller = TextEditingController();
  final TextEditingController _address2Controller = TextEditingController();
  final TextEditingController _cityController = TextEditingController();
  final TextEditingController _stateController = TextEditingController();
  final TextEditingController _pincodeController = TextEditingController();
  final TextEditingController _postalareaController = TextEditingController();
  final TextEditingController _passwordcontroller = TextEditingController();
  final TextEditingController _confirmpasswordcontroller =
      TextEditingController();
  final TextEditingController _transactionpasswordcontroller =
      TextEditingController();
  final TextEditingController _confirmtransactionpasswordcontroller =
      TextEditingController();

  String ValidateReffId = '';
  String ValidateFName = '';
  String ValidateLName = '';
  String ValidateLocation = '';
  String ValidateMobile = '';
  String ValidateEMail = '';
  String ValidateDOB = '';
  String ValidateAddress1 = '';
  String ValidateAddress2 = '';
  String ValidateState = '';
  String ValidateCity = '';
  String ValidatePinCode = '';
  String ValidatePostalArea = '';
  String ValidatePassword = '';
  String ValidateConfirmPassword = '';
  String ValidateTransactionPassword = '';
  String ValidateConfirmTransactionPassword = '';

  FocusNode FocusReferralID = FocusNode();
  FocusNode FocusFirstName = FocusNode();
  FocusNode FocusLastName = FocusNode();
  FocusNode FocusMoile = FocusNode();
  FocusNode FocusEMail = FocusNode();
  FocusNode FocusPassword = FocusNode();
  FocusNode FocusAddress1 = FocusNode();
  FocusNode FocusAddress2 = FocusNode();
  FocusNode FocusState = FocusNode();
  FocusNode FocusCity = FocusNode();
  FocusNode FocusPinCode = FocusNode();
  FocusNode FocusPostalArea = FocusNode();
  FocusNode FocusLocation = FocusNode();

  String? base64Image;
  XFile? _imageFile;
  String? _keyValue;
  final ImagePicker _imagePicker = ImagePicker();
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

  void validateTextField() {
    String RefrralId = _ReferralId.text.trim();
    String FirstName = _firstNameController.text.trim();
    String Location = _locationController.text.trim();
    String LastName = _lastnameController.text.trim();
    String EMail = _emailController.text.trim();
    String MobileNumber = _mobileController.text.trim();
    String Address1 = _address1Controller.text.trim();
    String Address2 = _address2Controller.text.trim();
    String City = _cityController.text.trim();
    String State = _stateController.text.trim();
    String PinCode = _pincodeController.text.trim();
    String PostalArea = _postalareaController.text.trim();
    String Password = _passwordcontroller.text.trim();
    String ConfirmPassword = _confirmpasswordcontroller.text.trim();
    String TransactionPassword = _transactionpasswordcontroller.text.trim();
    String ConfirmTransactionPassword =
        _confirmtransactionpasswordcontroller.text.trim();

    if (RefrralId.isEmpty) {
      Fluttertoast.showToast(
        msg: 'Referral Id is empty',
        gravity: ToastGravity.BOTTOM,
        textColor: Colors.white,
      );
      FocusFirstName.requestFocus();
    } else if (FirstName.isEmpty) {
      Fluttertoast.showToast(
        msg: 'First name is empty',
        gravity: ToastGravity.BOTTOM,
        textColor: Colors.white,
      );
      FocusFirstName.requestFocus();
    } else if (LastName.isEmpty) {
      Fluttertoast.showToast(
        msg: 'Last name is empty',
        gravity: ToastGravity.BOTTOM,
        textColor: Colors.white,
      );
      FocusLastName.requestFocus();
    } else if (MobileNumber.isEmpty) {
      Fluttertoast.showToast(
        msg: 'Phone number is empty',
        gravity: ToastGravity.BOTTOM,
        textColor: Colors.white,
      );
      FocusMoile.requestFocus();
    } else if (PinCode.isEmpty) {
      Fluttertoast.showToast(
        msg: 'PinCode is empty',
        gravity: ToastGravity.BOTTOM,
        textColor: Colors.white,
      );
      FocusPinCode.requestFocus();
    } else if (EMail.isEmpty) {
      Fluttertoast.showToast(
        msg: 'EMail is empty',
        gravity: ToastGravity.BOTTOM,
        textColor: Colors.white,
      );
      FocusEMail.requestFocus();
    } else if (Address1.isEmpty) {
      Fluttertoast.showToast(
        msg: 'Address1 is empty',
        gravity: ToastGravity.BOTTOM,
        textColor: Colors.white,
      );
      FocusAddress1.requestFocus();
    } else if (Address2.isEmpty) {
      Fluttertoast.showToast(
        msg: 'Address2 is empty',
        gravity: ToastGravity.BOTTOM,
        textColor: Colors.white,
      );
      FocusAddress2.requestFocus();
    } else if (State.isEmpty) {
      Fluttertoast.showToast(
        msg: 'State is empty',
        gravity: ToastGravity.BOTTOM,
        textColor: Colors.white,
      );
      FocusState.requestFocus();
    } else if (City.isEmpty) {
      Fluttertoast.showToast(
        msg: 'City is empty',
        gravity: ToastGravity.BOTTOM,
        textColor: Colors.white,
      );
      FocusCity.requestFocus();
    } else if (PostalArea.isEmpty) {
      Fluttertoast.showToast(
        msg: 'PostalArea is empty',
        gravity: ToastGravity.BOTTOM,
        textColor: Colors.white,
      );
      FocusPinCode.requestFocus();
    } else if (Password != ConfirmPassword) {
      Fluttertoast.showToast(
        msg: 'Passwords Does not Match',
        gravity: ToastGravity.BOTTOM,
        textColor: Colors.white,
      );
    } else if (TransactionPassword != ConfirmTransactionPassword) {
      Fluttertoast.showToast(
        msg: 'Transaction Passwords Does not Match',
        gravity: ToastGravity.BOTTOM,
        textColor: Colors.white,
      );
    }
    if (checkboxStatus == "0") {
      Fluttertoast.showToast(
        msg: 'Please accept Terms and Conditions',
        gravity: ToastGravity.BOTTOM,
        textColor: Colors.white,
      );
    }
    /*__futureLogin = ResponseHandler.performPost(
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
            '&submitdate=&submitkby=');*/
    /*_futureLogin?.then((value) {
      print('Response body: ${value.body}');

      String jsonResponse = ResponseHandler.parseData(value.body);

      print('JSON Response: ${jsonResponse}');
      Navigator.push(context,
          MaterialPageRoute(builder: (BuildContext context) => KYCList()));
    });*/
  }

  Future<void> _uploadImageAndRegister() async {
    try {
      print('imagefile$_imageFile.path');

      final String Username = _ReferralId.text;
      final String FirstName = _firstNameController.text;
      final String LastName = _lastnameController.text;
      final String Email = _emailController.text;
      final String location = _locationController.text;
      final String mobile = _mobileController.text;
      final String address1 = _address1Controller.text;
      final String address2 = _address2Controller.text;
      final String city = _cityController.text;
      final String state = _stateController.text;
      final String pincode = _pincodeController.text;
      final String postal = _postalareaController.text;
      SignupModel signupmodel = SignupModel(
          customerID: "1000000",
          firstname: FirstName,
          lastname: LastName,
          dateOfBirth: "",
          gender: "1",
          marital: "1",
          addressLine1: address1,
          addressLine2: address2,
          city: city,
          state: state,
          zipcode: pincode,
          country: "india",
          phone: mobile,
          email: Email,
          nominee: "aa",
          relation: "a",
          nomineeaAge: "30");

      /* __futureLogin = ResponseHandler.performPost(
            "MemberSave", 'jsonString=$jsonData&KeyValue=$base64Image');
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
          }*/
    } catch (e) {
      print("Error: $e");
      Fluttertoast.showToast(msg: "An error occurred");
    }
  }

  Future<void> _saveImageAndGetKeyValue() async {
    if (_imageFile == null) {
      return; // No image selected
    }

    final bytes = await _imageFile!.readAsBytes();
    final imageEncoded = base64Encode(bytes);

    final String USER_AGENT = "Mozilla/5.0";

    try {
      final url =
          Uri.parse("https://lapay.app/webserviceimages.asmx/SaveImage");
      final response = await http.post(
        url,
        headers: {"User-Agent": USER_AGENT},
        body: {"KeyId": imageEncoded},
      );

      if (response.statusCode == 200) {
        // Successfully received the response
        final jsonData = json.decode(response.body) as Map<String, dynamic>;
        final keyValue = jsonData["keyId"] as int;
        setState(() {
          _keyValue = keyValue.toString();
        });
      } else {
        // Handle error response
      }
    } catch (e) {
      // Handle exceptions
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

  final _formKey = GlobalKey<FormState>();
  String _selectedOption = 'Self';
  bool _obscureText = true;

  String _email = '';
  String _password = '';

  @override
  Widget build(BuildContext context) {
    SystemChrome.setSystemUIOverlayStyle(SystemUiOverlayStyle(
      statusBarColor: Color(0xFF007E01), // Dark green color
    ));
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
          'Join Now',
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
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Padding(padding: EdgeInsets.only(top: 20)),
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
                        controller: _ReferralId,
                        textAlignVertical: TextAlignVertical.bottom,
                        decoration: InputDecoration(
                          hintText: 'Referral ID',
                          hintStyle: TextStyle(fontFamily: "Montserrat"),
                          prefixIcon: Image.asset(
                            "assets/images/id_icon.png",
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
            SizedBox(
              height: 80,
              width: 310,
              child: Container(
                decoration: BoxDecoration(
                  border: Border.all(color: Colors.grey),
                  borderRadius: BorderRadius.circular(
                    5.0,
                  ),
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Padding(
                      padding: const EdgeInsets.only(left: 15, top: 10),
                      child: const Text(
                        'Product',
                        style: TextStyle(
                          fontSize: 17,
                        ),
                      ),
                    ),
                    Row(
                      // Use a Row for horizontal alignment
                      children: [
                        SizedBox(
                          width: 129,
                          height: 40,
                          child: Expanded(
                            child: ListTile(
                              title: Text('Self'),
                              leading: Radio<Gender>(
                                value: Gender.self,
                                groupValue: _selectedGender,
                                onChanged: (Gender? value) {
                                  setState(() {
                                    _selectedGender = value;
                                    _isTextFieldVisible = true;
                                  });
                                },
                              ),
                            ),
                          ),
                        ),
                        SizedBox(
                          height: 40,
                          width: 172,
                          child: Flexible(
                            child: ListTile(
                              title: Text('Franchise'),
                              leading: Radio<Gender>(
                                value: Gender.franchise,
                                groupValue: _selectedGender,
                                onChanged: (Gender? value) {
                                  setState(() {
                                    _selectedGender = value;
                                    _isTextFieldVisible = false;
                                  });
                                },
                              ),
                            ),
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
            ),
            SizedBox(height: 16.0),
            Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Row(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    SizedBox(
                      height: 45,
                      width: 310,
                      child: Visibility(
                        maintainSize: false,
                        visible: _selectedGender ==
                            Gender
                                .franchise, // Show the TextField only when "Self" is selected
                        child: TextField(
                          controller: _locationController,
                          textAlignVertical: TextAlignVertical.bottom,
                          decoration: InputDecoration(
                            hintText: 'Location',
                            prefixIcon: Image.asset(
                              "assets/images/locationjpg.jpg",
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
                        controller: _firstNameController,
                        textAlignVertical: TextAlignVertical.bottom,
                        decoration: InputDecoration(
                          hintText: 'First Name',
                          prefixIcon: Image.asset(
                            "assets/images/name_icon.png",
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
                        controller: _lastnameController,
                        textAlignVertical: TextAlignVertical.bottom,
                        decoration: InputDecoration(
                          hintText: 'Last Name',
                          prefixIcon: Image.asset(
                            "assets/images/name_icon.png",
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
              children: [
                Row(
                  children: [
                    SizedBox(width: 25.0),
                    Container(
                      width: 100,
                      height: 45,
                      decoration: BoxDecoration(
                        border: Border.all(
                          color: Colors.grey,
                          width: 1.0,
                        ),
                        borderRadius: BorderRadius.circular(5.0),
                      ),
                      child: Center(
                        child: SizedBox(
                          width: 40, // Adjust the width as needed
                          child: TextField(
                            decoration: InputDecoration(
                              hintText: 'MM',
                              border: InputBorder.none,
                            ),
                          ),
                        ),
                      ),
                    ),
                    SizedBox(width: 8.0), // Add some space between fields
                    Container(
                      height: 45,
                      width: 100,
                      decoration: BoxDecoration(
                        border: Border.all(
                          color: Colors.grey,
                          width: 1.0,
                        ),
                        borderRadius: BorderRadius.circular(5.0),
                      ),
                      child: Center(
                        child: SizedBox(
                          width: 40, // Adjust the width as needed
                          child: TextField(
                            decoration: InputDecoration(
                              hintText: 'DD',
                              border: InputBorder.none,
                            ),
                          ),
                        ),
                      ),
                    ),
                    SizedBox(width: 8.0), // Add some space between fields
                    Container(
                      width: 95,
                      height: 45,
                      decoration: BoxDecoration(
                        border: Border.all(
                          color: Colors.grey,
                          width: 1.0,
                        ),
                        borderRadius: BorderRadius.circular(5.0),
                      ),
                      child: Padding(
                        padding: EdgeInsets.only(left: 10),
                        child: SizedBox(
                          width: 7, // Adjust the width as needed
                          child: DropdownButton<String>(
                            items: <String>[
                              'YYYY',
                              '2022',
                              '2023',
                              '2024', // Add more years here
                            ].map<DropdownMenuItem<String>>(
                              (String value) {
                                return DropdownMenuItem<String>(
                                  value: value,
                                  child: Text(value),
                                );
                              },
                            ).toList(),
                            onChanged: (String) {},
                            value: 'YYYY', // Set the initial value
                            underline:
                                Container(), // Hide the default underline
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
                        keyboardType: TextInputType.emailAddress,
                        controller: _emailController,
                        textAlignVertical: TextAlignVertical.bottom,
                        decoration: InputDecoration(
                          hintText: 'Email',
                          prefixIcon: Image.asset(
                            "assets/images/emailpngresized.png",
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
                        keyboardType: TextInputType.phone,
                        controller: _mobileController,
                        textAlignVertical: TextAlignVertical.bottom,
                        decoration: InputDecoration(
                          hintText: 'Mobile',
                          prefixIcon: Image.asset(
                            "assets/images/mobile_icon.png",
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
                        controller: _address1Controller,
                        textAlignVertical: TextAlignVertical.bottom,
                        decoration: InputDecoration(
                          hintText: 'Address Line 1',
                          prefixIcon: Image.asset(
                            "assets/images/address_icon.png",
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
                        controller: _address2Controller,
                        textAlignVertical: TextAlignVertical.bottom,
                        decoration: InputDecoration(
                          hintText: 'Address Line 2',
                          prefixIcon: Image.asset(
                            "assets/images/address_icon.png",
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
                        controller: _cityController,
                        textAlignVertical: TextAlignVertical.bottom,
                        decoration: InputDecoration(
                          hintText: 'City',
                          prefixIcon: Image.asset(
                            "assets/images/city_icon.png",
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
                        controller: _stateController,
                        textAlignVertical: TextAlignVertical.bottom,
                        decoration: InputDecoration(
                          hintText: 'State',
                          prefixIcon: Image.asset(
                            "assets/images/state_icon.png",
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
                        keyboardType: TextInputType.phone,
                        controller: _pincodeController,
                        textAlignVertical: TextAlignVertical.bottom,
                        decoration: InputDecoration(
                          hintText: 'Pin Code',
                          prefixIcon: Image.asset(
                            "assets/images/zipcode_icon.webp",
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
                        controller: _postalareaController,
                        textAlignVertical: TextAlignVertical.bottom,
                        decoration: InputDecoration(
                          hintText: 'Postal Area',
                          prefixIcon: Image.asset(
                            "assets/images/locationjpg.jpg",
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
            Text(
              'Login Information',
              style: TextStyle(
                fontWeight: FontWeight.bold,
                fontSize: 16,
              ),
            ),
            SizedBox(height: 10.0),
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
                        controller: _passwordcontroller,
                        obscureText: !_passwordVisible,
                        textAlignVertical: TextAlignVertical.bottom,
                        decoration: InputDecoration(
                          hintText: 'Password',
                          prefixIcon: Image.asset(
                            "assets/images/password_icon.png",
                            alignment: Alignment.center,
                            cacheHeight: 21,
                            cacheWidth: 20,
                          ),
                          suffixIcon: GestureDetector(
                            onTap: () {
                              setState(() {
                                _passwordVisible =
                                    !_passwordVisible; // Toggle password visibility
                              });
                            },
                            child: Icon(
                              _passwordVisible
                                  ? Icons.visibility
                                  : Icons.visibility_off,
                              color: Colors.grey,
                            ),
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
                        controller: _confirmpasswordcontroller,
                        obscureText: !_confirmpasswordVisible,
                        textAlignVertical: TextAlignVertical.bottom,
                        decoration: InputDecoration(
                          hintText: 'Confirm Password',
                          prefixIcon: Image.asset(
                            "assets/images/password_icon.png",
                            alignment: Alignment.center,
                            cacheHeight: 21,
                            cacheWidth: 20,
                          ),
                          suffixIcon: GestureDetector(
                            onTap: () {
                              setState(() {
                                _confirmpasswordVisible =
                                    !_confirmpasswordVisible; // Toggle password visibility
                              });
                            },
                            child: Icon(
                              _confirmpasswordVisible
                                  ? Icons.visibility
                                  : Icons.visibility_off,
                              color: Colors.grey,
                            ),
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
                        controller: _transactionpasswordcontroller,
                        obscureText: !_transactionpasswordVisible,
                        textAlignVertical: TextAlignVertical.bottom,
                        decoration: InputDecoration(
                          hintText: 'Transaction Password',
                          prefixIcon: Image.asset(
                            "assets/images/password_icon.png",
                            alignment: Alignment.center,
                            cacheHeight: 21,
                            cacheWidth: 20,
                          ),
                          suffixIcon: GestureDetector(
                            onTap: () {
                              setState(() {
                                _transactionpasswordVisible =
                                    !_transactionpasswordVisible; // Toggle password visibility
                              });
                            },
                            child: Icon(
                              _transactionpasswordVisible
                                  ? Icons.visibility
                                  : Icons.visibility_off,
                              color: Colors.grey,
                            ),
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
                        controller: _confirmtransactionpasswordcontroller,
                        obscureText: !_confirmtransactionpasswordVisible,
                        textAlignVertical: TextAlignVertical.bottom,
                        decoration: InputDecoration(
                          hintText: 'Confirm Transaction Password',
                          prefixIcon: Image.asset(
                            "assets/images/password_icon.png",
                            alignment: Alignment.center,
                            cacheHeight: 21,
                            cacheWidth: 20,
                          ),
                          suffixIcon: GestureDetector(
                            onTap: () {
                              setState(() {
                                _confirmtransactionpasswordVisible =
                                    !_confirmtransactionpasswordVisible; // Toggle password visibility
                              });
                            },
                            child: Icon(
                              _confirmtransactionpasswordVisible
                                  ? Icons.visibility
                                  : Icons.visibility_off,
                              color: Colors.grey,
                            ),
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
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Align(
                  alignment: Alignment.center,
                ),
                Checkbox(
                    value: checkboxStatus == "1",
                    onChanged: (bool? newValue) {
                      setState(() {
                        checkboxStatus = newValue == true ? "1" : "0";
                      });
                      print('cjeckbosfstsyd:$checkboxStatus');
                    }),
                Text('Accept Terms and Conditions'),
              ],
            ),
            SizedBox(
              width: 320,
              height: 45,
              child: ElevatedButton(
                style: ElevatedButton.styleFrom(
                  primary: Color(0xFF007E01), // Set the background color here
                ),
                onPressed: () {
                  validateTextField();
                },
                child: Text(
                  'CREATE ACCOUNT',
                  style: TextStyle(fontWeight: FontWeight.bold, fontSize: 17),
                ),
              ),
            ),
            SizedBox(height: 25.0),
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
    home: signup(),
  ));
}

/*Future<void> saveImageAndRetrieveKeyId(String imageEncoded) async {
  final String USER_AGENT = "Mozilla/5.0";

  try {
    final url = Uri.parse("https://lapay.app/webserviceimages.asmx/SaveImage");
    final response = await http.post(
      url,
      headers: {"User-Agent": USER_AGENT},
      body: {"KeyId": imageEncoded},
    );

    if (response.statusCode == 200) {
      // Successfully received the response
      final jsonData = json.decode(response.body); // Parse the response body
      final keyValue = jsonData["keyId"] as String; // Access the "keyId" value

      print("Received keyId: $keyValue");

      // Now you can use the keyValue as needed
      // For example, call another function to update the profile with this keyId
      await updateProfileWithKeyId(keyValue);
    } else {
      // Handle error response
      print("Error response: ${response.statusCode}");
    }
  } catch (e) {
    // Handle exceptions
    print("Exception: $e");
  }
}

Future<void> updateProfileWithKeyId(String keyId) async {
  // Implement the logic to update the profile using the provided keyId
  // For example, make another HTTP request or update a local database
  print("Updating profile with keyId: $keyId");
}*/
