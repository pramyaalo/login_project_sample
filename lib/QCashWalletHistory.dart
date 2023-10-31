import 'dart:convert';
import 'dart:developer';
import 'package:http/http.dart' as http;
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:login_project_sample/Models/BinaryIncomeReportModel.dart';
import 'package:login_project_sample/Models/QCashWalletHistoryModel.dart';
import 'package:login_project_sample/Models/WalletCashHistoryModel.dart';
import 'package:login_project_sample/utils/response_handler.dart';
import 'package:login_project_sample/utils/shared_preferences.dart';

class QCashWalletHistory extends StatefulWidget {
  const QCashWalletHistory({Key? key}) : super(key: key);

  @override
  _CabsListScreenState createState() => _CabsListScreenState();
}

class _CabsListScreenState extends State<QCashWalletHistory> {
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

  String _selectedDate = '1'; // Default selected month

  List<String> date = [
    '1',
    '2',
    '3',
    '4',
    '5',
    '6',
    '7',
    '8',
    '9',
    '10',
    '11',
    '12',
    '13',
    '14',
    '15',
    '16',
    '17',
    '18',
    '19',
    '20',
    '21',
    '22',
    '23',
    '24',
    '25',
    '26',
    '27',
    '28',
    '29',
    '30',
    '31'
  ];
  String _selectedYear = '2020'; // Default selected month

  List<String> year = ['2020', '2021', '2022', '2023', '2024', '2025'];

  @override
  void initState() {
    super.initState();
    _selectedMonth = months[0];
    _selectedDate = date[0];
    _selectedYear = year[0];
  }

  static Future<List<QCashWalletHistoryModel>?> getPartPaymentData() async {
    String? memberId = await Prefs.getStringValue(Prefs.PREFS_USER_ID);
    List<QCashWalletHistoryModel> bookingCardData = [];
    Future<http.Response>? __futureLabels = ResponseHandler.performPost(
        "GetQuCashWalletAddHistory",
        "MemberId=$memberId&Month=07&Year=2021&PageIndex=1");

    return await __futureLabels?.then((value) {
      String jsonResponse = ResponseHandler.parseData(value.body);
      log(jsonResponse);
      try {
        //Map<String, dynamic> map = json.decode(jsonResponse);
        List<dynamic> decodedJson = json.decode(jsonResponse);

        print('json : ${decodedJson}');

        for (int i = 0; i < decodedJson.length; i++) {
          QCashWalletHistoryModel fm =
              QCashWalletHistoryModel.fromJson(decodedJson[i]);
          bookingCardData.add(fm);
          //print('my FM: ${fm.Username}');
          //vanthu vanthu vanthuuuuu ta int strng thn thppa
        }
      } catch (error) {
        print('my error : ${error.toString()}');
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
            icon: const Icon(
              Icons.arrow_back,
              color: Colors.black,
              size: 30,
            ),
            onPressed: () {
              Navigator.pop(context);
            },
          ),
          title: const Text(
            'QuCash Wallet History',
            style: TextStyle(
                color: Colors.black, fontSize: 17, fontWeight: FontWeight.bold),
          ),
          titleSpacing: 15,
          leadingWidth: 30,
          actions: [
            Padding(
              padding: const EdgeInsets.only(right: 16.0, bottom: 10),
              child: Image.asset(
                'assets/images/logor.jpg', // Replace 'your_image.png' with your image asset path
                width: 90,
                height: 35,
              ),
            ),
          ],
        ),
        body: Center(
          child: FutureBuilder<List<QCashWalletHistoryModel>?>(
              future: getPartPaymentData(),
              builder: (context, snapshot) {
                if (snapshot.hasData &&
                    snapshot.connectionState == ConnectionState.done) {
                  return ListView.builder(
                      itemCount: snapshot.data!.length,
                      itemBuilder: (context, index) {
                        return Container(
                            child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                              SingleChildScrollView(
                                  child: Column(
                                children: [
                                  Card(
                                      margin: const EdgeInsets.only(
                                          right: 10, left: 10, top: 7),
                                      elevation: 5,
                                      color: Colors.white,
                                      child: Column(
                                        crossAxisAlignment:
                                            CrossAxisAlignment.start,
                                        children: [
                                          Container(
                                            padding: const EdgeInsets.all(10),
                                            child: Row(
                                              children: [
                                                const Image(
                                                  image: AssetImage(
                                                      "assets/images/incomeiconpng.png"),
                                                  width: 70,
                                                  height: 80,
                                                ),
                                                SizedBox(
                                                  width: 5,
                                                ),
                                                Column(
                                                  mainAxisAlignment:
                                                      MainAxisAlignment.start,
                                                  crossAxisAlignment:
                                                      CrossAxisAlignment.start,
                                                  children: [
                                                    Text(
                                                        snapshot.data![index]
                                                            .customerName,
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
                                                          snapshot.data![index]
                                                              .username,
                                                          textAlign:
                                                              TextAlign.center,
                                                          // Text(snapshot.data![index].message,
                                                          style: TextStyle(
                                                              fontSize: 14,
                                                              fontWeight:
                                                                  FontWeight
                                                                      .w500),
                                                        ),
                                                        const SizedBox(
                                                          width: 60,
                                                        ),
                                                        Image.asset(
                                                          "assets/images/tickiconpng.png",
                                                          cacheWidth: 15,
                                                          cacheHeight: 15,
                                                          color: Colors.green,
                                                        ),
                                                        Text(
                                                            textAlign:
                                                                TextAlign.end,
                                                            snapshot
                                                                .data![index]
                                                                .type,
                                                            //Text(snapshot.data![index].username,
                                                            style: TextStyle(
                                                                fontSize: 13,
                                                                color: Colors
                                                                    .green,
                                                                fontWeight:
                                                                    FontWeight
                                                                        .w500)),
                                                      ],
                                                    ),
                                                    const SizedBox(
                                                      height: 4.5,
                                                    ),
                                                    Row(
                                                      children: [
                                                        Container(
                                                          decoration:
                                                              BoxDecoration(
                                                            border: Border.all(
                                                                color: Colors
                                                                    .black),
                                                            borderRadius:
                                                                BorderRadius
                                                                    .circular(
                                                                        4),
                                                          ),
                                                          padding:
                                                              const EdgeInsets
                                                                  .symmetric(
                                                                  horizontal: 6,
                                                                  vertical: 2),
                                                          child: const Text(
                                                            'QUCASH WALLET',
                                                            style: TextStyle(
                                                                fontSize: 12,
                                                                fontWeight:
                                                                    FontWeight
                                                                        .w500,
                                                                color: Color(
                                                                    0xFF000080)),
                                                          ),
                                                        ),
                                                        const SizedBox(
                                                          width: 3,
                                                        ),
                                                        Image.asset(
                                                          "assets/images/tickiconpng.png",
                                                          cacheWidth: 15,
                                                          cacheHeight: 15,
                                                          color: Colors.green,
                                                        ),
                                                        Text(
                                                            textAlign:
                                                                TextAlign.end,
                                                            snapshot
                                                                .data![index]
                                                                .dateCreated,
                                                            //Text(snapshot.data![index].username,
                                                            style: TextStyle(
                                                                fontSize: 13,
                                                                color: Colors
                                                                    .green,
                                                                fontWeight:
                                                                    FontWeight
                                                                        .w500)),
                                                      ],
                                                    ),
                                                    const SizedBox(
                                                      height: 4.5,
                                                    ),
                                                    Text(
                                                        snapshot.data![index]
                                                            .message,
                                                        textAlign:
                                                            TextAlign.end,
                                                        //Text(snapshot.data![index].username,
                                                        style: TextStyle(
                                                            fontSize: 14,
                                                            fontWeight:
                                                                FontWeight
                                                                    .w500)),
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
                                                style: TextStyle(
                                                    fontSize: 12,
                                                    fontWeight:
                                                        FontWeight.w500),
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
                                                      fontSize: 14,
                                                      fontWeight:
                                                          FontWeight.w500),
                                                ),
                                                const SizedBox(
                                                  width: 5,
                                                ),
                                                Text(
                                                  snapshot
                                                      .data![index].username,
                                                  style: TextStyle(
                                                      fontSize: 14,
                                                      fontWeight:
                                                          FontWeight.w500),
                                                ),
                                                const SizedBox(width: 130),
                                                Text(
                                                  snapshot.data![index].amount,
                                                  style: TextStyle(
                                                      fontSize: 17,
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
              }),
        ),
      ),
    );
  }
}
