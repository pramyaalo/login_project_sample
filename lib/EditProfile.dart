import 'dart:async';
import 'dart:convert';
import 'dart:developer';
import 'dart:io';
import 'dart:typed_data';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:http/http.dart' as http;
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:login_project_sample/DashBoard.dart';
import 'package:login_project_sample/ForgotPassword.dart';
import 'package:login_project_sample/utils/response_handler.dart';
import 'package:login_project_sample/utils/shared_preferences.dart';
import 'package:shared_preferences/shared_preferences.dart';

class EditProfile extends StatefulWidget {
  @override
  _SignUpPageState createState() => _SignUpPageState();
}

class _SignUpPageState extends State<EditProfile> {
  final TextEditingController _firstNameController = TextEditingController();
  late String memberId, UserName;
  Future<http.Response>? __futureLogin;
  late String FirstName,
      LastName,
      Email,
      mobile,
      address1,
      address2,
      city,
      state,
      pincode,
      postal;
  final TextEditingController _lastnameController = TextEditingController();
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _mobileController = TextEditingController();
  final TextEditingController _address1Controller = TextEditingController();
  final TextEditingController _address2Controller = TextEditingController();
  final TextEditingController _cityController = TextEditingController();
  final TextEditingController _stateController = TextEditingController();
  final TextEditingController _pincodeController = TextEditingController();
  final TextEditingController _postalareaController = TextEditingController();
  XFile? _imageFile;
  String? _userImage;
  String? ImagePath;
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

  Future<void> _uploadImageAndRegister() async {
    memberId = await Prefs.getStringValue(Prefs.PREFS_USER_ID);
    UserName = await Prefs.getStringValue(Prefs.PREFS_USER_NAME);

    log("memberId" + UserName!);
    try {
      print('imagefile$_imageFile.path');

      FirstName = _firstNameController.text.toString();
      LastName = _lastnameController.text.toString();
      Email = _emailController.text.toString();
      mobile = _mobileController.text.toString();
      address1 = _address1Controller.text.toString();
      address2 = _address2Controller.text.toString();
      city = _cityController.text.toString();
      state = _stateController.text.toString();
      pincode = _pincodeController.text.toString();
      postal = _postalareaController.text.toString();
      __futureLogin = ResponseHandler.performPost(
          "MemberSave",
          'CustomerID=0&PlacementID=$memberId&FirstName=$FirstName&LastName=$LastName&DateofBirth=&Gender=1&Marital=1&AddressLine1=$address1'
              '&AddressLine2=$address2&city=$city&state=$state&Zipcode=$pincode&PostalArea=$postal&Country=India&Phone=$mobile&Email=$Email'
              '&Username=CS1000000&Password=&TransactionPassword=&SponsorID=$memberId&RankName=&AccountName='
              '&AccountNumber=&BankName=&Branch=&BankCode=&AccountType=&Relation=&status=1&NomineeaAge=25&Expiry=&KeyValue=');

      /*   __futureLogin = ResponseHandler.performPost(
          "JoinnowSave",
          'CustomerID=0&PlacementID=1000000&FirstName=Pramya&LastName=A&DateofBirth=12/12/1990&Gender=1&Marital=1&AddressLine1=Colachel'
              '&AddressLine2=Ritapuram&city=Nagercoil&state=TN&Zipcode=629789&PostalArea=629159&Country="India"&Phone=8675784378&Email=aa@gmail.com'
              '&Username=CS1000000&Password=123456&TransactionPassword=123456&SponsorID=1000000&RankName=&AccountName='
              '&AccountNumber=&BankName=&Branch=&BankCode=&AccountType=&Relation=&status=1&NomineeaAge=25&Expiry=&KeyValue=/9j/4AAQSkZJRgABAQAAAQABAAD/2wBDAA0JCgsKCA0LCgsODg0PEyAVExISEyccHhcgLikxMC4pLSwzOko+MzZGNywtQFdBRkxOUlNSMj5aYVpQYEpRUk//2wBDAQ4ODhMREyYVFSZPNS01T09PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PT0//wAARCAAGAAoDASIAAhEBAxEB/8QAFQABAQAAAAAAAAAAAAAAAAAAAAX/xAAfEAACAgEEAwAAAAAAAAAAAAABAgMEAAUREmEhIjH/xAAVAQEBAAAAAAAAAAAAAAAAAAACA//EABcRAQEBAQAAAAAAAAAAAAAAAAEAAhH/2gAMAwEAAhEDEQA/AJVPVF1B5Evh3ZQpQr87385EsS0xYlCwSAczt794xgKml7f/2Q==');*/
      /*print('CustomerID=0');
      print('PlacementID=$memberId');
      print('FirstName=$FirstName');
      print('LastName=$LastName');
      print('DateofBirth=$DOB');
      print('Gender=1');
      print('Marital=1');
      print('address1=$address1');
      print('address2=$address2');
      print('city=$city');
      print('state=$state');
      print('Zipcode=$pincode');
      print('PostalArea=$postal');
      print('Country=India');
      print('Phone=$mobile');
      print('Email=$Email');
      print('Username=CS10000000');
      print('Password=$password');
      print('TransactionPassword=$TransactionPassword');
      print('SponsorID=1000000');
      print('RankName=');
      print('AccountName=');
      print('AccountNumber=');
      print('BankName=');
      print('Branch=');
      print('BankCode=');
      print('AccountType=');
      print('Relation=');
      print('status=1');
      print('NomineeaAge=25');
      print('Expiry=');
      print('KeyValue=$base64Image');*/
      __futureLogin?.then((value) {
        print('Response body: ${value.body}');

        String jsonResponse = ResponseHandler.parseData(value.body);

        print('JSON Response: ${jsonResponse}');

        if (jsonResponse == "1") {
          Fluttertoast.showToast(msg: 'Joined successfully');
          //saveImageToPrefs();
          Navigator.push(
              context,
              MaterialPageRoute(
                  builder: (context) => Dashboard(
                        data: memberId,
                        data1: UserName,
                      )));
        } else if (jsonResponse == "Not Allowed") {
          Fluttertoast.showToast(msg: 'Unable to join');
        }
        /* try {
          //Map<String, dynamic> map = json.decode(jsonResponse);
          List<dynamic> decodedJson = json.decode(jsonResponse);
          print('decodedJson: ${decodedJson}');
        } catch (error) {
          Fluttertoast.showToast(msg: "Login Failed");
          log(error.toString());
        }*/
      });
    } catch (e) {
      print("Error: $e");
      Fluttertoast.showToast(msg: "An error occurred");
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
            // _keyValue = keyValue.toString();
          });
        } else {
          // Handle error response
        }
      } catch (e) {
        // Handle exceptions
      }
    }
  }

  Future<void> _loadImage() async {
    final imagePath = await loadImageFromPrefs();
    final firstName = await LoadFirstName();
    final lastName = await LoadLastName();
    final Email = await LoadEmail();
    final Mobile = await LoadMobile();
    final Address1 = await LoadAddress1();
    final Address2 = await LoadAddress2();
    final City = await LoadCity();
    final State = await LoadState();
    final PinCode = await LoadPin();
    final Postal = await LoadPostal();
    setState(() {
      if (imagePath != null) {
        _userImage = (imagePath);
        print('imagepatg:$_userImage');
      }
      if (firstName != null) {
        _firstNameController.text = firstName.toString();
      }
      if (lastName != null) {
        _lastnameController.text = lastName.toString();
      }
      if (Mobile != null) {
        _mobileController.text = Mobile.toString();
      }
      if (Email != null) {
        _emailController.text = Email.toString();
      }
      if (Address1 != null) {
        _address1Controller.text = Address1.toString();
      }
      if (Address2 != null) {
        _address2Controller.text = Address2.toString();
      }
      if (City != null) {
        _cityController.text = City.toString();
      }
      if (State != null) {
        _stateController.text = State.toString();
      }
      if (PinCode != null) {
        _pincodeController.text = PinCode.toString();
      }
      if (Postal != null) {
        _postalareaController.text = Postal.toString();
      }
    });
  }

  Future<String?> loadImageFromPrefs() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    return prefs.getString('user_image');
  }

  Future<String?> LoadFirstName() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    return prefs.getString('firstName').toString();
  }

  Future<String?> LoadLastName() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    return prefs.getString('lastName').toString();
  }

  Future<String?> LoadEmail() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    return prefs.getString('email').toString();
  }

  Future<String?> LoadMobile() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    return prefs.getString('mobile').toString();
  }

  Future<String?> LoadAddress1() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    return prefs.getString('address1').toString();
  }

  Future<String?> LoadAddress2() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    return prefs.getString('address2').toString();
  }

  Future<String?> LoadCity() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    return prefs.getString('city').toString();
  }

  Future<String?> LoadState() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    return prefs.getString('state').toString();
  }

  Future<String?> LoadPin() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    return prefs.getString('pincode').toString();
  }

  Future<String?> LoadPostal() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    return prefs.getString('postal').toString();
  }

  Future<void> _openCamera() async {
    final picker = ImagePicker();
    final pickedFile = await picker.pickImage(source: ImageSource.camera);

    if (pickedFile != null) {
      setState(() {
        _imageFile = XFile(pickedFile.path);
      });
    }
  }

  @override
  void initState() {
    super.initState();
    _loadImage();
  }

// Function to open the gallery and select an image
  Future<void> _openGallery() async {
    final picker = ImagePicker();
    final pickedFile = await picker.pickImage(source: ImageSource.gallery);

    if (pickedFile != null) {
      setState(() {
        _imageFile = XFile(pickedFile.path);
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
    // Create a MemoryImage from the decoded bytes
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
            InkWell(
              onTap: () {
                print('Button Clicked');
                _showSelectionDialog(context);
              },
              child: Stack(
                alignment: Alignment.bottomRight,
                children: [
                  CircleAvatar(
                    radius: 50, // Adjust the size as needed
                    backgroundImage:
                        MemoryImage(base64Decode(_userImage as String)),
                  ),
                  Icon(Icons.camera_alt),
                ],
              ),
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
                        controller: _firstNameController,
                        textAlignVertical: TextAlignVertical.bottom,
                        decoration: InputDecoration(
                          hintText: 'Enter First Name',
                          hintStyle: TextStyle(fontFamily: "Montserrat"),
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
                        controller: _lastnameController,
                        textAlignVertical: TextAlignVertical.bottom,
                        decoration: InputDecoration(
                          hintText: 'Enter Last Name',
                          hintStyle: TextStyle(fontFamily: "Montserrat"),
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
                        controller: _emailController,
                        textAlignVertical: TextAlignVertical.bottom,
                        decoration: InputDecoration(
                          hintText: 'Enter Email Address',
                          prefixIcon: Image.asset(
                            "assets/images/email_icon.png",
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
                        controller: _mobileController,
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
                          hintText: 'Address',
                          prefixIcon: Image.asset(
                            "assets/images/description.png",
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
                          hintText: 'Street',
                          prefixIcon: Image.asset(
                            "assets/images/street_icon.png",
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
                        controller: _pincodeController,
                        textAlignVertical: TextAlignVertical.bottom,
                        decoration: InputDecoration(
                          hintText: 'Zip Code',
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
                        controller: _postalareaController,
                        textAlignVertical: TextAlignVertical.bottom,
                        decoration: InputDecoration(
                          hintText: 'Country',
                          prefixIcon: Image.asset(
                            "assets/images/country_icon.png",
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
              width: 320,
              height: 40,
              child: ElevatedButton(
                onPressed: () {
                  Navigator.push(
                      context,
                      MaterialPageRoute(
                          builder: (BuildContext context) => ForgotPassword()));
                },
                child: Text(
                  'Update',
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
    home: EditProfile(),
  ));
}
