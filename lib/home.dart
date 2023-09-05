import 'dart:convert';
import 'dart:developer';

import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:login_project_sample/BankDetails.dart';
import 'package:login_project_sample/DashBoard.dart';
import 'package:login_project_sample/Models/LoginModel.dart';
import 'package:login_project_sample/signup.dart';
import 'package:login_project_sample/utils/shared_preferences.dart';
import 'package:quickalert/quickalert.dart';
import 'package:http/http.dart' as http;
import 'package:login_project_sample/utils/response_handler.dart';

class LoginApp extends StatefulWidget {
  const LoginApp({super.key});

  @override
  _MyLoginPageState createState() => _MyLoginPageState();
}

class _MyLoginPageState extends State<LoginApp> {
  bool showPassword = false;
  Future<http.Response>? __futureLogin;

  final TextEditingController _userNameController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();

  @override
  void initState() {
    showPassword = false;
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        body: Container(
          decoration: BoxDecoration(
            image: DecorationImage(
              image: AssetImage('assets/images/loginbg7.png'),
              fit: BoxFit.cover,
            ),
          ),
          child: Center(
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
                    color: Colors.green,
                  ),
                ),
                SizedBox(height: 25),
                SizedBox(
                  height: 40,
                  width: 310,
                  child: TextField(
                    controller: _userNameController,
                    decoration: InputDecoration(
                      hintText: 'Enter Username',
                      hintStyle: TextStyle(fontFamily: "Montserrat"),
                      border: OutlineInputBorder(
                        borderSide: BorderSide(color: Colors.white),
                        borderRadius: BorderRadius.circular(1.0),
                      ),
                    ),
                  ),
                ),
                SizedBox(height: 10),
                SizedBox(
                  height: 40,
                  width: 310,
                  child: TextField(
                    controller: _passwordController,
                    style: TextStyle(fontFamily: "Montserrat", fontSize: 15),
                    decoration: InputDecoration(
                      hintText: 'Enter Password',
                      filled: true,
                      fillColor: Colors.white,
                      border: OutlineInputBorder(
                        borderSide: BorderSide(color: Colors.white),
                        borderRadius: BorderRadius.circular(1.0),
                      ),
                      suffixIcon: GestureDetector(
                        child: showPassword
                            ? Icon(Icons.visibility)
                            : Icon(Icons.visibility_off),
                      ),
                    ),
                    obscureText: showPassword,
                  ),
                ),
                SizedBox(height: 10),
                InkWell(
                  onTap: () {
                    print('Alert Dialog Clicked');
                    Navigator.push(
                      context,
                      MaterialPageRoute(builder: (context) => bankdetails()),
                    );
                    //_showDialog(context);
                  },
                  child: Text(
                    'Forgot Password',
                    style: TextStyle(
                      fontSize: 16,
                      color: Colors.green,
                    ),
                  ),
                ),
                SizedBox(height: 20),
                SizedBox(
                  height: 50,
                  width: 150,
                  child: ElevatedButton(
                    onPressed: () {
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
                          print('USERID' + fm.UserID);
                          Prefs.saveStringValue(
                              Prefs.PREFS_USER_NAME, fm.Username);
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
                          Prefs.saveStringValue(Prefs.PREFS_PAYPAL, fm.Paypal);
                          Prefs.saveStringValue(Prefs.PREFS_PAYZA, fm.Payza);
                          Prefs.saveStringValue(
                              Prefs.PREFS_DATE_CREATED, fm.Datecreated);
                          Prefs.saveStringValue(
                              Prefs.PREFS_CURRENCY, fm.Currency);

                          Navigator.push(
                              context,
                              MaterialPageRoute(
                                  builder: (BuildContext context) =>
                                      Dashboard()));
                        } catch (error) {
                          Fluttertoast.showToast(msg: "Login Failed");
                          log(error.toString());
                        }
                      });
                      log('buttonPress' + _userNameController.text);
                    },
                    style: ButtonStyle(
                      backgroundColor:
                          MaterialStateProperty.all<Color>(Colors.green),
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
                      style: TextStyle(fontSize: 16, color: Colors.grey),
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
                        style: TextStyle(fontSize: 16, color: Colors.blue),
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
        ),
      ),
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
      style: TextStyle(fontFamily: "Montserrat", fontSize: 15),
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

void _showDialog(BuildContext context) {
  showDialog(
      context: context,
      builder: (BuildContext context) {
        return Dialog(
          shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(20.0)), //this right here
          child: Container(
            height: 200,
            child: Padding(
              padding: const EdgeInsets.all(12.0),
              child: Column(
                children: [
                  Container(
                    color: Colors.green,
                    height: 50,
                    child: SizedBox(
                      width: 380.0,
                      height: 30,
                      child: Text(
                        "LOGIN",
                        style: TextStyle(
                          color: Colors.white,
                          fontSize: 16,
                        ),
                      ),
                    ),
                  ),
                  SizedBox(
                    height: 10,
                  ),
                  TextField(
                    decoration: InputDecoration(
                        border: OutlineInputBorder(
                          borderSide: BorderSide(color: Colors.white),
                          borderRadius: BorderRadius.circular(1.0),
                        ),
                        hintText: 'What do you want to remember?'),
                  ),
                  SizedBox(
                    width: 320.0,
                    child: ElevatedButton(
                      onPressed: () {},
                      child: Text(
                        "Save",
                        style: TextStyle(color: Colors.white),
                      ),
                    ),
                  )
                ],
              ),
            ),
          ),
        );
      });
}
