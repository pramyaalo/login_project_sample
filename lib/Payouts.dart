import 'dart:convert';
import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:intl/intl.dart';
import 'package:http/http.dart' as http;
import 'package:login_project_sample/Models/PayoutReportsModel.dart';
import 'package:login_project_sample/utils/response_handler.dart';
import 'package:login_project_sample/utils/shared_preferences.dart';

class Payouts extends StatefulWidget {
  @override
  _MyWidgetState createState() => _MyWidgetState();
}

class _MyWidgetState extends State<Payouts> {
  static TextEditingController _dateController = TextEditingController();
  String memberId = '', Username = '', Name = '';
  static String date = '';

  Future<http.Response>? __futureLogin;
  static double deduction = 0.0;
  static List<dynamic> decodedJson = [];
  late DateTime _selectedDate;
  @override
  void initState() {
    _selectedDate = DateTime.now()
        .subtract(Duration(days: 30)); // One month before the current date
    _dateController = TextEditingController(
        text: DateFormat('MM/dd/yyyy').format(_selectedDate));
    _futurePayments = getPartPaymentData();
    _loadmemberid();

    super.initState();
  }

  Future<void> _loadmemberid() async {
    try {
      memberId = await Prefs.getStringValue(Prefs.PREFS_USER_ID);
      Username = await Prefs.getStringValue(Prefs.PREFS_USER_NAME);
      Name = await Prefs.getStringValue(Prefs.PREFS_NAME);
      log("memberfhhjykkId" + Name);
    } catch (e) {
      print("Error: $e");
      Fluttertoast.showToast(msg: "An error occurred");
    }
  }

  static Future<List<PayoutReportsModel>?> getPartPaymentData() async {
    date = _dateController.text.toString();
    print('jsoAdffwerdfsdffgfn : ${date}');
    String memberId = await Prefs.getStringValue(Prefs.PREFS_USER_ID);
    List<PayoutReportsModel> bookingCardData = [];

    Future<http.Response>? __futureLabels = ResponseHandler.performPost(
        "GetPayoutreport",
        'MemberId=${memberId}&Fromdt=$date&Todate=08/08/2021&PageIndex=1');
    print('Fromdt : ${date}');
    return await __futureLabels?.then((value) {
      String jsonResponse = ResponseHandler.parseData(value.body);
      log(jsonResponse);
      try {
        //Map<String, dynamic> map = json.decode(jsonResponse);
        decodedJson = json.decode(jsonResponse);

        print('jsoAdfsdffgfn : ${decodedJson}');

        for (int i = 0; i < decodedJson.length; i++) {
          PayoutReportsModel fm = PayoutReportsModel.fromJson(decodedJson[i]);
          bookingCardData.add(fm);
          String tds = fm.TDS; // Replace with your actual TDS value
          String serviceTax = fm.ServiceTax;
          double tdsValue = double.parse(tds);
          double serviceTaxValue = double.parse(serviceTax);
          deduction = tdsValue + serviceTaxValue;
          print('my FM: ${deduction}');
          print('my FM: ${fm.ServiceTax}');
          //vanthu vanthu vanthuuuuu ta int strng thn thppa
        }
      } catch (error) {
        print('my error : ${error.toString()}');
        Fluttertoast.showToast(msg: error.toString());
      }
      return bookingCardData;
    });
  }

  Future<List<PayoutReportsModel>?>? _futurePayments;

  Future<void> _selectDate(BuildContext context) async {
    final DateTime? picked = await showDatePicker(
      context: context,
      initialDate: _selectedDate,
      firstDate: DateTime(2000),
      lastDate: DateTime(2101),
    );
    if (picked != null && picked != _selectedDate) {
      setState(() {
        _selectedDate = picked;
        _dateController.text = DateFormat('MM/dd/yyyy').format(picked);
      });
      _futurePayments = getPartPaymentData();
    }
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
        child: Scaffold(
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
                'Payouts',
                style: TextStyle(
                    color: Colors.black,
                    fontSize: 17,
                    fontWeight: FontWeight.bold),
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
            body: Center(
                child: FutureBuilder<List<PayoutReportsModel>?>(
                    future: _futurePayments,
                    builder: (context, snapshot) {
                      if (snapshot.connectionState == ConnectionState.waiting) {
                        return CircularProgressIndicator(); // Show a loading indicator while data is loading.
                      } else if (snapshot.hasError) {
                        return Text("Error: ${snapshot.error}");
                      } else if (snapshot.hasData &&
                          snapshot.data!.isNotEmpty) {
                        // Data is available and not empty, display the list of records.
                        return ListView.builder(
                          itemCount: snapshot.data!.length,
                          itemBuilder: (context, index) {
                            return Column(
                              crossAxisAlignment: CrossAxisAlignment.stretch,
                              children: [
                                SizedBox(height: 16),
                                SizedBox(
                                  height: 46,
                                  width: 390,
                                  child: Container(
                                      padding: EdgeInsets.only(
                                          left: 15,
                                          right: 15,
                                          bottom: 10,
                                          top: 18),
                                      child: TextField(
                                        controller: _dateController,
                                        style: TextStyle(
                                            fontWeight: FontWeight.w500),
                                        onTap: () {},
                                        decoration: InputDecoration(
                                          // Adjust the value as needed
                                          suffixIcon: GestureDetector(
                                            onTap: () {
                                              _selectDate(context);
                                            },
                                            child: Image.asset(
                                              'assets/images/calendar.png',
                                              alignment: Alignment.center,
                                              width: 25,
                                              height: 25,
                                            ),
                                          ),
                                          border: OutlineInputBorder(
                                            borderSide:
                                                BorderSide(color: Colors.white),
                                          ),
                                          contentPadding:
                                              EdgeInsets.only(bottom: 16),
                                        ),
                                        readOnly: true,
                                      )),
                                ),
                                SizedBox(height: 16),
                                Card(
                                  shape: RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(
                                        25.0), // Adjust the value for desired curvature
                                  ),
                                  elevation: 5,
                                  margin: EdgeInsets.symmetric(horizontal: 16),
                                  child: Padding(
                                    padding: EdgeInsets.all(16),
                                    child: Column(
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      children: [
                                        Text(
                                          "Payout Report for" +
                                              " " +
                                              _dateController.text,
                                          style: TextStyle(
                                            fontWeight: FontWeight.bold,
                                            fontSize: 18,
                                          ),
                                        ),
                                        SizedBox(height: 16),
                                        Column(
                                          children: [
                                            Row(
                                              children: [
                                                Text("User ID",
                                                    style: TextStyle(
                                                        fontSize: 16,
                                                        fontWeight:
                                                            FontWeight.w500)),
                                                SizedBox(
                                                  width: 105,
                                                ),
                                                Text(": "),
                                                SizedBox(
                                                  width: 5,
                                                ),
                                                Text(snapshot.data![index].Name,
                                                    style: TextStyle(
                                                      fontSize: 16,
                                                    )),
                                              ],
                                            ),
                                          ],
                                        ),
                                        SizedBox(height: 8),
                                        Row(
                                          children: [
                                            Text("Full Name",
                                                style: TextStyle(
                                                  fontSize: 16,
                                                )),
                                            SizedBox(
                                              width: 85,
                                            ),
                                            Text(": "),
                                            SizedBox(
                                              width: 5,
                                            ),
                                            Text(snapshot.data![index].UserID,
                                                style: TextStyle(
                                                  fontSize: 16,
                                                )),
                                          ],
                                        ),
                                        SizedBox(height: 8),
                                        Row(
                                          children: [
                                            Text("Date",
                                                style: TextStyle(
                                                  fontSize: 16,
                                                )),
                                            SizedBox(
                                              width: 126,
                                            ),
                                            Text(": "),
                                            SizedBox(
                                              width: 5,
                                            ),
                                            Text(date.toString(),
                                                style: TextStyle(
                                                  fontSize: 16,
                                                )),
                                          ],
                                        ),
                                        SizedBox(height: 8),
                                        Row(
                                          children: [
                                            Text("Binary Income",
                                                style: TextStyle(
                                                  fontSize: 16,
                                                )),
                                            SizedBox(
                                              width: 55,
                                            ),
                                            Text(": "),
                                            SizedBox(
                                              width: 5,
                                            ),
                                            Text(
                                                "₹" +
                                                    snapshot.data![index]
                                                        .BinaryIncome,
                                                style: TextStyle(
                                                  fontSize: 16,
                                                )),
                                          ],
                                        ),
                                        SizedBox(height: 8),
                                        Row(
                                          children: [
                                            Text("Franchise Income",
                                                style: TextStyle(
                                                  fontSize: 16,
                                                )),
                                            SizedBox(
                                              width: 24,
                                            ),
                                            Text(": "),
                                            SizedBox(
                                              width: 5,
                                            ),
                                            Text(
                                                "₹" +
                                                    snapshot.data![index]
                                                        .FranchiseIncome,
                                                style: TextStyle(
                                                  fontSize: 16,
                                                )),
                                          ],
                                        ),
                                        SizedBox(height: 8),
                                        Row(
                                          children: [
                                            Text("Franchise Monthly",
                                                style: TextStyle(
                                                  fontSize: 16,
                                                )),
                                            SizedBox(
                                              width: 19,
                                            ),
                                            Text(": "),
                                            SizedBox(
                                              width: 5,
                                            ),
                                            Text("₹0.00",
                                                style: TextStyle(
                                                  fontSize: 16,
                                                )),
                                          ],
                                        ),
                                        SizedBox(height: 8),
                                        Row(
                                          children: [
                                            Text("Franchise Referral",
                                                style: TextStyle(
                                                  fontSize: 16,
                                                )),
                                            SizedBox(
                                              width: 21,
                                            ),
                                            Text(": "),
                                            SizedBox(
                                              width: 5,
                                            ),
                                            Text(
                                                "₹" +
                                                    snapshot.data![index]
                                                        .FranchiseReferral,
                                                style: TextStyle(
                                                  fontSize: 16,
                                                )),
                                          ],
                                        ),
                                        SizedBox(height: 8),
                                        Row(
                                          children: [
                                            Text("TDS",
                                                style: TextStyle(
                                                  fontSize: 16,
                                                )),
                                            SizedBox(
                                              width: 134,
                                            ),
                                            Text(": "),
                                            SizedBox(
                                              width: 5,
                                            ),
                                            Text(
                                                "₹" + snapshot.data![index].TDS,
                                                style: TextStyle(
                                                  fontSize: 16,
                                                )),
                                          ],
                                        ),
                                        SizedBox(height: 8),
                                        Row(
                                          children: [
                                            Text("Service Tax",
                                                style: TextStyle(
                                                  fontSize: 16,
                                                )),
                                            SizedBox(
                                              width: 75,
                                            ),
                                            Text(": "),
                                            SizedBox(
                                              width: 5,
                                            ),
                                            Text(
                                                "₹" +
                                                    snapshot.data![index]
                                                        .ServiceTax,
                                                style: TextStyle(
                                                  fontSize: 16,
                                                )),
                                          ],
                                        ),
                                        SizedBox(height: 8),
                                        Row(
                                          children: [
                                            Text("QuCash",
                                                style: TextStyle(
                                                  fontSize: 16,
                                                )),
                                            SizedBox(width: 102),
                                            Text(": "),
                                            SizedBox(
                                              width: 5,
                                            ),
                                            Text(
                                                "₹" +
                                                    snapshot.data![index].QCash,
                                                style: TextStyle(
                                                  fontSize: 16,
                                                )),
                                          ],
                                        ),
                                        SizedBox(height: 8),
                                        Row(
                                          children: [
                                            Text("Deduction",
                                                style: TextStyle(
                                                  fontSize: 16,
                                                )),
                                            SizedBox(
                                              width: 82,
                                            ),
                                            Text(": "),
                                            SizedBox(
                                              width: 5,
                                            ),
                                            Text("₹" + deduction.toString(),
                                                style: TextStyle(
                                                  fontSize: 16,
                                                )),
                                          ],
                                        ),
                                        SizedBox(height: 8),
                                        Row(
                                          children: [
                                            Text("Net Amount",
                                                style: TextStyle(
                                                  fontSize: 16,
                                                )),
                                            SizedBox(
                                              width: 66,
                                            ),
                                            Text(": "),
                                            SizedBox(
                                              width: 5,
                                            ),
                                            Text(
                                                "₹" +
                                                    snapshot
                                                        .data![index].NetAmt,
                                                style: TextStyle(
                                                  fontSize: 16,
                                                )),
                                          ],
                                        ),
                                      ],
                                    ),
                                  ),
                                ),
                              ],
                            );
                          },
                        );
                      } else {
                        return Column(
                          crossAxisAlignment: CrossAxisAlignment.stretch,
                          children: [
                            SizedBox(height: 16),
                            SizedBox(
                              height: 40,
                              width: 390,
                              child: Container(
                                padding: EdgeInsets.only(
                                  left: 15,
                                  right: 15,
                                ),
                                child: Align(
                                  alignment: Alignment.bottomCenter,
                                  child: TextField(
                                    onTap: () {},
                                    decoration: InputDecoration(
                                      hintText: 'Select DOB',
                                      suffixIcon: GestureDetector(
                                        onTap: () {
                                          _selectDate(context);
                                        },
                                        child: Image.asset(
                                            'assets/images/calendar.png',
                                            alignment: Alignment.center,
                                            cacheWidth: 25,
                                            cacheHeight:
                                                25), // Replace with your desired icon
                                      ),
                                      border: OutlineInputBorder(
                                        borderSide:
                                            BorderSide(color: Colors.white),
                                      ),
                                    ),
                                    readOnly: true,
                                    controller:
                                        _dateController, // Use the TextEditingController
                                  ),
                                ),
                              ),
                            ),
                            SizedBox(height: 16),
                            Card(
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(
                                    25.0), // Adjust the value for desired curvature
                              ),
                              elevation: 5,
                              margin: EdgeInsets.symmetric(horizontal: 16),
                              child: Padding(
                                padding: EdgeInsets.all(16),
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Text(
                                      "Payout Report for" +
                                          " " +
                                          _dateController.text,
                                      style: TextStyle(
                                        fontWeight: FontWeight.bold,
                                        fontSize: 18,
                                      ),
                                    ),
                                    SizedBox(height: 16),
                                    Column(
                                      children: [
                                        Row(
                                          children: [
                                            Text("User ID",
                                                style: TextStyle(
                                                  fontSize: 16,
                                                )),
                                            SizedBox(
                                              width: 105,
                                            ),
                                            Text(": "),
                                            SizedBox(
                                              width: 5,
                                            ),
                                            Text(Name,
                                                style: TextStyle(
                                                  fontSize: 16,
                                                )),
                                          ],
                                        ),
                                      ],
                                    ),
                                    SizedBox(height: 8),
                                    Row(
                                      children: [
                                        Text("Full Name",
                                            style: TextStyle(
                                              fontSize: 16,
                                            )),
                                        SizedBox(
                                          width: 85,
                                        ),
                                        Text(": "),
                                        SizedBox(
                                          width: 5,
                                        ),
                                        Text(Username,
                                            style: TextStyle(
                                              fontSize: 16,
                                            )),
                                      ],
                                    ),
                                    SizedBox(height: 8),
                                    Row(
                                      children: [
                                        Text("Date",
                                            style: TextStyle(
                                              fontSize: 16,
                                            )),
                                        SizedBox(
                                          width: 126,
                                        ),
                                        Text(": "),
                                        SizedBox(
                                          width: 5,
                                        ),
                                        Text(_dateController.text,
                                            style: TextStyle(
                                              fontSize: 16,
                                            )),
                                      ],
                                    ),
                                    SizedBox(height: 8),
                                    Row(
                                      children: [
                                        Text("Binary Income",
                                            style: TextStyle(
                                              fontSize: 16,
                                            )),
                                        SizedBox(
                                          width: 48,
                                        ),
                                        Text(": "),
                                        SizedBox(
                                          width: 5,
                                        ),
                                        Text("₹0",
                                            style: TextStyle(
                                              fontSize: 16,
                                            )),
                                      ],
                                    ),
                                    SizedBox(height: 8),
                                    Row(
                                      children: [
                                        Text("Franchise Income",
                                            style: TextStyle(
                                              fontSize: 16,
                                            )),
                                        SizedBox(
                                          width: 24,
                                        ),
                                        Text(": "),
                                        SizedBox(
                                          width: 5,
                                        ),
                                        Text("₹0",
                                            style: TextStyle(
                                              fontSize: 16,
                                            )),
                                      ],
                                    ),
                                    SizedBox(height: 8),
                                    Row(
                                      children: [
                                        Text("Franchise Monthly",
                                            style: TextStyle(
                                              fontSize: 16,
                                            )),
                                        SizedBox(
                                          width: 19,
                                        ),
                                        Text(": "),
                                        SizedBox(
                                          width: 5,
                                        ),
                                        Text("₹0",
                                            style: TextStyle(
                                              fontSize: 16,
                                            )),
                                      ],
                                    ),
                                    SizedBox(height: 8),
                                    Row(
                                      children: [
                                        Text("Franchise Referral",
                                            style: TextStyle(
                                              fontSize: 16,
                                            )),
                                        SizedBox(
                                          width: 21,
                                        ),
                                        Text(": "),
                                        SizedBox(
                                          width: 5,
                                        ),
                                        Text("₹0",
                                            style: TextStyle(
                                              fontSize: 16,
                                            )),
                                      ],
                                    ),
                                    SizedBox(height: 8),
                                    Row(
                                      children: [
                                        Text("TDS",
                                            style: TextStyle(
                                              fontSize: 16,
                                            )),
                                        SizedBox(
                                          width: 134,
                                        ),
                                        Text(": "),
                                        SizedBox(
                                          width: 5,
                                        ),
                                        Text("₹0",
                                            style: TextStyle(
                                              fontSize: 16,
                                            )),
                                      ],
                                    ),
                                    SizedBox(height: 8),
                                    Row(
                                      children: [
                                        Text("Service Tax",
                                            style: TextStyle(
                                              fontSize: 16,
                                            )),
                                        SizedBox(
                                          width: 75,
                                        ),
                                        Text(": "),
                                        SizedBox(
                                          width: 5,
                                        ),
                                        Text("₹0",
                                            style: TextStyle(
                                              fontSize: 16,
                                            )),
                                      ],
                                    ),
                                    SizedBox(height: 8),
                                    Row(
                                      children: [
                                        Text("QuCash",
                                            style: TextStyle(
                                              fontSize: 16,
                                            )),
                                        SizedBox(width: 102),
                                        Text(": "),
                                        SizedBox(
                                          width: 5,
                                        ),
                                        Text("₹0",
                                            style: TextStyle(
                                              fontSize: 16,
                                            )),
                                      ],
                                    ),
                                    SizedBox(height: 8),
                                    Row(
                                      children: [
                                        Text("Deduction",
                                            style: TextStyle(
                                              fontSize: 16,
                                            )),
                                        SizedBox(
                                          width: 82,
                                        ),
                                        Text(": "),
                                        SizedBox(
                                          width: 5,
                                        ),
                                        Text("₹0",
                                            style: TextStyle(
                                              fontSize: 16,
                                            )),
                                      ],
                                    ),
                                    SizedBox(height: 8),
                                    Row(
                                      children: [
                                        Text("Net Amount",
                                            style: TextStyle(
                                              fontSize: 16,
                                            )),
                                        SizedBox(
                                          width: 66,
                                        ),
                                        Text(": "),
                                        SizedBox(
                                          width: 5,
                                        ),
                                        Text("₹0",
                                            style: TextStyle(
                                              fontSize: 16,
                                            )),
                                      ],
                                    ),
                                  ],
                                ),
                              ),
                            ),
                          ],
                        );
                      }
                    }))));
  }
}

void main() {
  runApp(MaterialApp(
    home: Payouts(),
  ));
}
