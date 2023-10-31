import 'dart:convert';
import 'dart:developer';

import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:syncfusion_flutter_gauges/gauges.dart';

import 'package:fluttertoast/fluttertoast.dart';
import 'package:login_project_sample/BankDetails.dart';
import 'package:login_project_sample/DashBoard.dart';
import 'package:login_project_sample/Models/LoginModel.dart';
import 'package:login_project_sample/signup.dart';
import 'package:login_project_sample/utils/shared_preferences.dart';
import 'package:quickalert/quickalert.dart';
import 'package:http/http.dart' as http;
import 'package:login_project_sample/utils/response_handler.dart';
import 'package:shared_preferences/shared_preferences.dart';

class DataToSend {
  final String message;
  DataToSend(this.message);
}

class LoginApp extends StatefulWidget {
  const LoginApp({super.key});

  @override
  _MyLoginPageState createState() => _MyLoginPageState();
}

class _MyLoginPageState extends State<LoginApp> {
  String MemberId = '';
  String UserName = '';
  String base64Image = '';
  bool _passwordVisible = false;
  Future<http.Response>? __futureLogin;

  final TextEditingController _userNameController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();
  final TextEditingController _forgetpasswordUsercontroller =
      TextEditingController();
  Future<void> _forgotPassword() async {
    try {
      MemberId = await Prefs.getStringValue(Prefs.PREFS_USER_ID);
      log("MemberId" + MemberId);
      UserName = await Prefs.getStringValue(Prefs.PREFS_USER_NAME);

      __futureLogin = ResponseHandler.performPost(
          "ForgotPassword", 'Username=${_forgetpasswordUsercontroller.text}');

      __futureLogin?.then((value) {
        print('Response body: ${value.body}');

        String jsonResponse = ResponseHandler.parseData(value.body);

        print('JSON Response: ${jsonResponse}');
        try {
          List<dynamic> decodedJson = json.decode(jsonResponse);
          Map<String, dynamic> firstUser = decodedJson[0];

          print('CustomerId ${firstUser["CustomerId"]}');
          print('Balance ${firstUser["Balance"]}');
          setState(() {});

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

  @override
  Widget build(BuildContext context) {
    SystemChrome.setSystemUIOverlayStyle(SystemUiOverlayStyle(
      statusBarColor: Color(0xFF007E01), // Dark green color
    ));
    return MaterialApp(
      home: Scaffold(
          body: Center(
        child: Container(
          height: MediaQuery.of(context).size.height / .1,
          decoration: BoxDecoration(
            image: DecorationImage(
              image: AssetImage('assets/images/loginbg7.png'),
              fit: BoxFit.cover,
            ),
          ),
          child: SingleChildScrollView(
            child: Column(
              children: [
                Padding(
                  padding: const EdgeInsets.only(
                      top: 170), // Adjust the top padding here
                  child: Image.asset('assets/images/logor.jpg',
                      width: 200, height: 100),
                ),
                SizedBox(height: 10),
                Text(
                  'Login to your customer Account',
                  style: TextStyle(
                    fontSize: 16,
                    fontWeight: FontWeight.w600,
                    color: Color(0xFF007E01),
                  ),
                ),
                SizedBox(height: 25),
                SizedBox(
                  height: 40,
                  width: 310,
                  child: TextField(
                    style: TextStyle(
                        color: Colors.black,
                        fontSize: 16,
                        fontWeight: FontWeight.w500),
                    controller: _userNameController,
                    decoration: InputDecoration(
                      hintText: 'Enter Username',
                      border: OutlineInputBorder(
                        borderSide: BorderSide(color: Colors.white),
                        borderRadius: BorderRadius.circular(1.0),
                      ),
                      contentPadding: EdgeInsets.symmetric(
                          vertical: 10.0, horizontal: 10.0),
                    ),
                  ),
                ),
                SizedBox(height: 10),
                SizedBox(
                  height: 40,
                  width: 310,
                  child: TextField(
                    style: TextStyle(
                        color: Colors.black,
                        fontSize: 16,
                        fontWeight: FontWeight.w500),
                    obscureText: !_passwordVisible,
                    controller: _passwordController,
                    decoration: InputDecoration(
                      hintText: 'Enter Password',
                      filled: true,
                      fillColor: Colors.white,
                      border: OutlineInputBorder(
                        borderSide: BorderSide(color: Colors.white),
                        borderRadius: BorderRadius.circular(1.0),
                      ),
                      contentPadding: EdgeInsets.symmetric(
                          vertical: 10.0, horizontal: 10.0),
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
                          color: Color(0xFF454343),
                        ),
                      ),
                    ),
                  ),
                ),
                SizedBox(height: 10),
                InkWell(
                  onTap: () {
                    print('Alert Dialog Clicked');
                    showDialog(
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
                              ),
                              padding: EdgeInsets.only(top: 15, left: 16),
                              child: Text(
                                "Password",
                                style: TextStyle(
                                  color: Colors.white,
                                  fontSize: 18,
                                  fontWeight: FontWeight.bold,
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
                                  SizedBox(
                                    height: 8,
                                  ),
                                  Padding(
                                    padding: const EdgeInsets.only(
                                        right: 10, left: 10),
                                    child: SizedBox(
                                      height: 40,
                                      width: 310,
                                      child: TextField(
                                        controller:
                                            _forgetpasswordUsercontroller,
                                        decoration: InputDecoration(
                                          hintText: 'Enter Username',
                                          hintStyle: TextStyle(),
                                          border: OutlineInputBorder(
                                            borderSide:
                                                BorderSide(color: Colors.white),
                                            borderRadius:
                                                BorderRadius.circular(1.0),
                                          ),
                                          contentPadding: EdgeInsets.symmetric(
                                              vertical: 10.0, horizontal: 10.0),
                                        ),
                                      ),
                                    ),
                                  ),
                                  SizedBox(
                                    height: 16,
                                  ),
                                  Padding(
                                    padding: const EdgeInsets.only(
                                        left: 10, right: 10),
                                    child: SizedBox(
                                      height: 45,
                                      width: 310,
                                      child: ElevatedButton(
                                        onPressed: () {
                                          _forgotPassword();
                                        },
                                        style: ElevatedButton.styleFrom(
                                          primary: Color(
                                              0xFF007E01), // Green background color
                                          onPrimary:
                                              Colors.white, // White text color
                                          shape: RoundedRectangleBorder(
                                            borderRadius: BorderRadius.circular(
                                                10), // Circular border radius
                                          ),
                                        ),
                                        child: Text(
                                          "Forget  Password",
                                          style: TextStyle(fontSize: 17),
                                        ),
                                      ),
                                    ),
                                  ),
                                  SizedBox(
                                    height: 25,
                                  ),
                                ],
                              ),
                            ),
                          );
                        });
                    //_forgotPassword();
                    /*  Navigator.push(
                      context,
                      MaterialPageRoute(builder: (context) => bankdetails()),
                    );*/
                    //_showDialog(context);
                  },
                  child: Text(
                    'Forgot Password?',
                    style: TextStyle(
                      fontSize: 16,
                      fontWeight: FontWeight.w600,
                      color: Color(0xFF007E01),
                    ),
                  ),
                ),
                SizedBox(height: 10),
                SizedBox(
                  height: 40,
                  width: 150,
                  child: ElevatedButton(
                    onPressed: () {
                      Stack(
                        alignment: Alignment.center,
                        children: <Widget>[
                          CircularProgressIndicator(
                              color: Colors
                                  .black), // Place the CircularProgressIndicator on top
                          SfRadialGauge(
                            axes: <RadialAxis>[
                              RadialAxis(
                                minimum: 0,
                                maximum: 360,
                                showAxisLine: false,
                                showLabels: false,
                                showTicks: false,
                                radiusFactor: 0.55,
                                pointers: <GaugePointer>[
                                  RangePointer(
                                    value: 330,
                                    width: 0.25,
                                    cornerStyle: CornerStyle.bothCurve,
                                    sizeUnit: GaugeSizeUnit.factor,
                                  )
                                ],
                              ),
                            ],
                          ),
                        ],
                      );

                      print('JSON Response: ${_userNameController.text}');
                      __futureLogin = ResponseHandler.performPost(
                          "Login",
                          'username=' +
                              _userNameController.text +
                              '&password=' +
                              _passwordController.text);
                      __futureLogin?.then((value) {
                        print('Response body: ${value.body}');

                        String jsonResponse =
                            ResponseHandler.parseData(value.body);

                        print('JSON Response: ${jsonResponse}');

                        try {
                          //Map<String, dynamic> map = json.decode(jsonResponse);
                          List<dynamic> decodedJson = json.decode(jsonResponse);
                          print('decodedJson: ${decodedJson}');
                          LoginModel fm = LoginModel.fromJson(decodedJson[0]);
                          print('decodedJson[0]: ${decodedJson[0]}');

                          Prefs.saveStringValue(
                              Prefs.PREFS_USER_TYPE, fm.UserType);
                          Prefs.saveStringValue(
                              Prefs.PREFS_USER_TYPE_ID, fm.UserTypeId);
                          Prefs.saveStringValue(Prefs.PREFS_USER_ID, fm.UserID);
                          MemberId = fm.UserID;
                          print('USERID' + MemberId);
                          Prefs.saveStringValue(
                              Prefs.PREFS_USER_NAME, fm.Username);
                          UserName = fm.Username;

                          Prefs.saveStringValue(Prefs.PREFS_NAME, fm.Name);
                          Prefs.saveStringValue(
                              Prefs.PREFS_PASSWORD, fm.Password);
                          Prefs.saveStringValue(
                              Prefs.PREFS_TRANSACTION_PASSWORD,
                              fm.TransactionPassword);
                          Prefs.saveStringValue(Prefs.EMAIL, fm.Email);
                          Prefs.saveStringValue(Prefs.PREFS_MOBILE, fm.Mobile);
                          Prefs.saveStringValue(Prefs.PREFS_TIME_IN, fm.Timein);
                          Prefs.saveStringValue(
                              Prefs.PREFS_TIME_OUT, fm.Timeout);
                          Prefs.saveStringValue(Prefs.STATUS, fm.Status);

                          Prefs.saveStringValue(Prefs.PREFS_TWO, fm.Two);
                          Prefs.saveStringValue(Prefs.PREFS_PHOTO, fm.Photo);
                          base64Image = fm.Photo;
                          print('object$base64Image');
                          Prefs.saveStringValue(Prefs.PREFS_PAYPAL, fm.Paypal);
                          Prefs.saveStringValue(Prefs.PREFS_PAYZA, fm.Payza);
                          Prefs.saveStringValue(
                              Prefs.PREFS_DATE_CREATED, fm.Datecreated);
                          Prefs.saveStringValue(
                              Prefs.PREFS_CURRENCY, fm.Currency);

                          Future<void> saveImageToPrefs() async {
                            SharedPreferences prefs =
                                await SharedPreferences.getInstance();
                            await prefs.setString('user_image', base64Image!);
                          }

                          saveImageToPrefs();
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (context) =>
                                  Dashboard(data: MemberId, data1: UserName),
                            ),
                          );
                        } catch (error) {
                          Fluttertoast.showToast(msg: "Login Failed");
                          log(error.toString());
                        }
                      });
                      log('buttonPress' + _userNameController.text);
                    },
                    style: ButtonStyle(
                      backgroundColor:
                          MaterialStateProperty.all<Color>(Color(0xFF007E01)),
                    ),
                    child: Text('LOGIN',
                        style: TextStyle(
                          fontSize: 16,
                        )),
                  ),
                ),
                SizedBox(height: 10),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text(
                      "Don't have an account?",
                      style: TextStyle(
                          fontSize: 16,
                          fontWeight: FontWeight.w600,
                          color: Color(0xFF007E01)),
                    ),
                    SizedBox(width: 5),
                    GestureDetector(
                      onTap: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(builder: (context) => signup()),
                        );
                      },
                      child: Text(
                        "Sign Up",
                        style: TextStyle(
                            fontSize: 16,
                            fontWeight: FontWeight.w600,
                            color: Color(0xFF007E01)),
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
        ),
      )),
    );
  }
}

class PasswordField extends StatefulWidget {
  @override
  _PasswordFieldState createState() => _PasswordFieldState();
}

class _PasswordFieldState extends State<PasswordField> {
  void togglePasswordVisibility() {
    setState(() {
      showPassword = !showPassword;
    });
  }

  bool showPassword = true;

  @override
  Widget build(BuildContext context) {
    return TextField(
      style: TextStyle(fontSize: 15),
      decoration: InputDecoration(
        hintText: 'Enter Password',
        filled: true,
        fillColor: Colors.white,
        border: OutlineInputBorder(
          borderSide: BorderSide(color: Colors.white),
          borderRadius: BorderRadius.circular(1.0),
        ),
        suffixIcon: GestureDetector(
          onTap: togglePasswordVisibility,
          child: showPassword
              ? Icon(Icons.visibility)
              : Icon(Icons.visibility_off),
        ),
      ),
      obscureText: showPassword,
    );
  }
}
