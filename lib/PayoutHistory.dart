import 'dart:convert';
import 'dart:developer';
import 'package:http/http.dart' as http;
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:login_project_sample/Models/PayoutHistoryModel.dart';
import 'package:login_project_sample/Models/WalletCashHistoryModel.dart';
import 'package:login_project_sample/utils/response_handler.dart';

import 'IncomeReport.dart';

class ItemReport extends StatefulWidget {
  @override
  _CabsListScreenState createState() => _CabsListScreenState();
}

class _CabsListScreenState extends State<ItemReport> {
  String _selectedMonth = 'January'; // Default selected month

  List<String> months = [
    'January',
    'February',
    'March',
    'April',
    'May',
    'June',
    'July',
    'August',
    'September',
    'October',
    'November',
    'December'
  ];
  String _selectedYear = '2020'; // Default selected month

  List<String> year = ['2020', '2021', '2022', '2023', '2024', '2025'];
  @override
  void initState() {
    super.initState();
    _selectedMonth = months[0];

    _selectedYear = year[0];
  }

  static Future<List<PayoutHistoryModel>?> getPartPaymentData() async {
    List<PayoutHistoryModel> bookingCardData = [];
    Future<http.Response>? __futureLabels = ResponseHandler.performPost(
        "GetIncomereport",
        "MemberId=1000000&ReportTypeId=12&Month=07&Year=2021&PageIndex=1");

    return await __futureLabels?.then((value) {
      String jsonResponse = ResponseHandler.parseData(value.body);
      log(jsonResponse);
      try {
        List<dynamic> decodedJson = json.decode(jsonResponse);

        for (int i = 0; i < decodedJson.length; i++) {
          PayoutHistoryModel lm = PayoutHistoryModel.fromJson(decodedJson[i]);
          bookingCardData.add(lm);
        }
      } catch (error) {
        Fluttertoast.showToast(msg: error.toString());
      }
      return bookingCardData;
    });
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
              'Cheap Shop \n CS1000000',
              style: TextStyle(
                  color: Colors.black,
                  fontSize: 16,
                   fontWeight: FontWeight.bold),
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
          body: Center(
              child: FutureBuilder<List<PayoutHistoryModel>?>(
                  future: getPartPaymentData(),
                  builder: (context, snapshot) {
                    if (snapshot.hasData &&
                        snapshot.connectionState == ConnectionState.done) {
                      return ListView.builder(
                          itemCount: snapshot.data!.length,
                          itemBuilder: (context, index) {
                            return Container(
                                child: Column(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: [
                                  SingleChildScrollView(
                                      child: Column(
                                    children: [
                                      Padding(
                                        padding: const EdgeInsets.only(top: 10),
                                        child: Row(
                                            mainAxisAlignment:
                                                MainAxisAlignment.center,
                                            children: [
                                              Container(
                                                width: 138,
                                                height: 40,
                                                decoration: BoxDecoration(
                                                  border: Border.all(
                                                      color: Colors.grey),
                                                  borderRadius:
                                                      BorderRadius.circular(
                                                          3.0),
                                                ),
                                                child: Row(
                                                  mainAxisAlignment:
                                                      MainAxisAlignment.end,
                                                  children: [
                                                    Padding(
                                                      padding:
                                                          const EdgeInsets.only(
                                                              left: 5.0),
                                                      child: DropdownButton<
                                                          String>(
                                                        value: _selectedMonth,
                                                        onChanged:
                                                            (String? newValue) {
                                                          setState(() {
                                                            _selectedMonth =
                                                                newValue!;
                                                          });
                                                        },
                                                        items: months.map<
                                                            DropdownMenuItem<
                                                                String>>((String
                                                            value) {
                                                          return DropdownMenuItem<
                                                              String>(
                                                            value: value,
                                                            child: Text(value),
                                                          );
                                                        }).toList(),
                                                        underline: Container(),
                                                      ),
                                                    ),
                                                  ],
                                                ),
                                              ),
                                              const SizedBox(width: 6),
                                              Container(
                                                width: 138,
                                                height: 40,
                                                decoration: BoxDecoration(
                                                  border: Border.all(
                                                      color: Colors.grey),
                                                  borderRadius:
                                                      BorderRadius.circular(
                                                          3.0),
                                                ),
                                                child: Row(
                                                  mainAxisAlignment:
                                                      MainAxisAlignment.end,
                                                  children: [
                                                    DropdownButton<String>(
                                                      value: _selectedYear,
                                                      onChanged:
                                                          (String? newValue) {
                                                        setState(() {
                                                          _selectedYear =
                                                              newValue!;
                                                        });
                                                      },
                                                      items: year.map<
                                                              DropdownMenuItem<
                                                                  String>>(
                                                          (String value) {
                                                        return DropdownMenuItem<
                                                            String>(
                                                          value: value,
                                                          child: Text(value),
                                                        );
                                                      }).toList(),
                                                      underline: Container(),
                                                    ),
                                                  ],
                                                ),
                                              ),
                                              const SizedBox(width: 6),
                                              Container(
                                                child: Row(
                                                  mainAxisAlignment:
                                                      MainAxisAlignment.end,
                                                  children: [
                                                    Image.asset(
                                                      'assets/images/refresh2.png',
                                                      cacheWidth: 40,
                                                      cacheHeight: 40,
                                                      alignment:
                                                          Alignment.center,
                                                    )
                                                  ],
                                                ),
                                              ),
                                            ]),
                                      ),
                                      Card(
                                          margin: const EdgeInsets.only(
                                              right: 10, left: 10, top: 15),
                                          elevation: 5,
                                          color: Colors.white,
                                          child: Column(
                                            crossAxisAlignment:
                                                CrossAxisAlignment.start,
                                            children: [
                                              Container(
                                                padding:
                                                    const EdgeInsets.all(10),
                                                child: Row(
                                                  mainAxisAlignment:
                                                      MainAxisAlignment.start,
                                                  children: [
                                                    const Image(
                                                      image: AssetImage(
                                                          "assets/images/incomeiconpng.png"),
                                                      width: 70,
                                                      height: 80,
                                                    ),
                                                    Column(
                                                      mainAxisAlignment:
                                                          MainAxisAlignment
                                                              .start,
                                                      crossAxisAlignment:
                                                          CrossAxisAlignment
                                                              .start,
                                                      children: [
                                                        Text(
                                                            "CheapShop" +
                                                                " " +
                                                                "(" +
                                                                snapshot
                                                                    .data![
                                                                        index]
                                                                    .Username +
                                                                ")",
                                                            textAlign:
                                                                TextAlign.end,
                                                            //Text(snapshot.data![index].username,
                                                            style: TextStyle(

                                                                fontSize: 14,
                                                                fontWeight:
                                                                    FontWeight
                                                                        .bold)),
                                                        const SizedBox(
                                                          width: 100,
                                                        ),
                                                        const SizedBox(
                                                          height: 4,
                                                        ),
                                                        Row(
                                                          children: [
                                                            Text(
                                                              "Referral Income Generated",
                                                              textAlign:
                                                                  TextAlign
                                                                      .center,
                                                              // Text(snapshot.data![index].message,
                                                              style: TextStyle(

                                                                  fontSize: 11,
                                                                  fontWeight:
                                                                      FontWeight
                                                                          .normal),
                                                            ),
                                                            const SizedBox(
                                                              width: 20,
                                                            ),
                                                            Image.asset(
                                                              "assets/images/tickiconpng.png",
                                                              cacheWidth: 15,
                                                              cacheHeight: 15,
                                                              color: Colors.red,
                                                            ),
                                                            Text(
                                                                textAlign:
                                                                    TextAlign
                                                                        .end,
                                                                "TDS:" +
                                                                    " " +
                                                                    snapshot
                                                                        .data![
                                                                            index]
                                                                        .TDS,
                                                                //Text(snapshot.data![index].username,
                                                                style: TextStyle(

                                                                    fontSize:
                                                                        12,
                                                                    color: Colors
                                                                        .red,
                                                                    fontWeight:
                                                                        FontWeight
                                                                            .bold)),
                                                          ],
                                                        ),
                                                        const SizedBox(
                                                          height: 4.5,
                                                        ),
                                                        Row(
                                                          children: [
                                                            Text(
                                                              "Amount:" +
                                                                  snapshot
                                                                      .data![
                                                                          index]
                                                                      .Amount,
                                                              textAlign:
                                                                  TextAlign
                                                                      .center,
                                                              // Text(snapshot.data![index].message,
                                                              style: TextStyle(

                                                                  color: Colors
                                                                      .green,
                                                                  fontSize: 13,
                                                                  fontWeight:
                                                                      FontWeight
                                                                          .normal),
                                                            ),
                                                            const SizedBox(
                                                              width: 30,
                                                            ),
                                                            Image.asset(
                                                              "assets/images/tickiconpng.png",
                                                              cacheWidth: 15,
                                                              cacheHeight: 15,
                                                              color: Colors.red,
                                                            ),
                                                            Text(
                                                                textAlign:
                                                                    TextAlign
                                                                        .end,
                                                                "Service Tax:" +
                                                                    " " +
                                                                    snapshot
                                                                        .data![
                                                                            index]
                                                                        .ServiceTax,
                                                                //Text(snapshot.data![index].username,
                                                                style: TextStyle(

                                                                    fontSize:
                                                                        12,
                                                                    color: Colors
                                                                        .red,
                                                                    fontWeight:
                                                                        FontWeight
                                                                            .bold)),
                                                          ],
                                                        ),
                                                        const SizedBox(
                                                          height: 4.5,
                                                        ),
                                                        Row(
                                                          children: [
                                                            const SizedBox(
                                                              width: 140,
                                                            ),
                                                            Image.asset(
                                                              "assets/images/tickiconpng.png",
                                                              cacheWidth: 15,
                                                              cacheHeight: 15,
                                                              color: Colors.red,
                                                            ),
                                                            Text(
                                                                textAlign:
                                                                    TextAlign
                                                                        .end,
                                                                "Cash :" +
                                                                    " " +
                                                                    snapshot
                                                                        .data![
                                                                            index]
                                                                        .qcash,
                                                                //Text(snapshot.data![index].username,
                                                                style: TextStyle(

                                                                    fontSize:
                                                                        12,
                                                                    color: Colors
                                                                        .red,
                                                                    fontWeight:
                                                                        FontWeight
                                                                            .bold)),
                                                          ],
                                                        ),
                                                      ],
                                                    ),
                                                  ],
                                                ),
                                              ),
                                              Row(
                                                children: [
                                                  Container(
                                                    height: 1,
                                                    width: 265,
                                                    // Make the Divider span the full width
                                                    child: const Divider(
                                                        thickness:
                                                            2), // Divider after GridView
                                                  ),
                                                  const Text(
                                                    ' Net Amount',
                                                    style:
                                                        TextStyle(fontSize: 12),
                                                  ),
                                                ],
                                              ),
                                              Padding(
                                                padding: const EdgeInsets.only(
                                                    bottom: 10, top: 4),
                                                child: Row(
                                                  mainAxisAlignment:
                                                      MainAxisAlignment.start,
                                                  children: [
                                                    const SizedBox(
                                                      width: 10,
                                                    ),
                                                    Image.asset(
                                                      "assets/images/orderpng.png",
                                                      cacheHeight: 12,
                                                      cacheWidth: 12,
                                                    ),
                                                    const Text(
                                                      ' User ID: ',
                                                      style: TextStyle(
                                                          fontSize: 14),
                                                    ),
                                                    const SizedBox(
                                                      width: 5,
                                                    ),
                                                    Text(
                                                      snapshot.data![index]
                                                          .Username,
                                                      style: TextStyle(
                                                          fontSize: 14),
                                                    ),
                                                    const SizedBox(width: 115),
                                                    Text(
                                                      snapshot.data![index]
                                                          .NETAmount,
                                                      style: TextStyle(
                                                          fontSize: 14,
                                                          fontWeight:
                                                              FontWeight.bold),
                                                    ),
                                                    // User Type on the left side
                                                  ],
                                                ),
                                              ),
                                            ],
                                          )),
                                    ],
                                  ))
                                ]));
                          });
                    } else {
                      return CircularProgressIndicator();
                    }
                  }))),
    );
  }
}
