import 'dart:convert';
import 'dart:developer';
import 'package:http/http.dart' as http;
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:login_project_sample/Models/PairIncomeReportDDl.dart';
import 'package:login_project_sample/utils/response_handler.dart';
import 'package:login_project_sample/utils/shared_preferences.dart';

class PairIncomeReport extends StatefulWidget {
  const PairIncomeReport({Key? key}) : super(key: key);

  @override
  _CabsListScreenState createState() => _CabsListScreenState();
}

class _CabsListScreenState extends State<PairIncomeReport> {
  List<PairIncomeReportDDl> labelData = [];
  String? selectedLabel = '-1#(03/28/2021 - 04/03/2021)';
  List<String> weeks = [];
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
  Future<void> fetchData() async {
    final response = await getLabels();

    if (response != null) {
      setState(() {
        labelData = response;
      });
    }
  }

  @override
  void initState() {
    super.initState();
    // Load data from the API when the widget initializes
    fetchData();
  }

  late String selectedMonth = "";

  static Future<List<PairIncomeReportDDl>?> getLabels() async {
    String memberId = await Prefs.getStringValue(Prefs.PREFS_USER_ID);
    log("memberId" + memberId);

    Future<http.Response>? __futureLabels = ResponseHandler.performPost(
        "TeamBonusPairWeek",
        "UserName=$memberId&ReportTypeId=23&Month=07&Year=2021&PageIndex=1");

    return await __futureLabels.then((value) {
      String jsonResponse = ResponseHandler.parseData(value.body);
      log(jsonResponse);
      List<PairIncomeReportDDl> labelData = [];
      try {
        //Map<String, dynamic> map = json.decode(jsonResponse);
        List<dynamic> decodedJson = json.decode(jsonResponse);

        print('json : ${decodedJson}');

        for (int i = 0; i < decodedJson.length; i++) {
          PairIncomeReportDDl fm = PairIncomeReportDDl.fromJson(decodedJson[i]);
          labelData.add(fm);
          //print('my FM: ${fm.Username}');
          //vanthu vanthu vanthuuuuu ta int strng thn thppa
        }
      } catch (error) {
        print('my error : ${error.toString()}');
        Fluttertoast.showToast(msg: error.toString());
      }
      return labelData;
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
                ),
                onPressed: () {
                  Navigator.pop(context);
                },
              ),
              title: const Text(
                'Pair Bonus Income Report',
                style: TextStyle(
                    color: Colors.black,
                    fontSize: 16,
                     fontWeight: FontWeight.bold),
              ), titleSpacing: 15,
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
                child: FutureBuilder<List<PairIncomeReportDDl>?>(
                    future: getLabels(),
                    builder: (context, snapshot) {
                      if (snapshot.hasData &&
                          snapshot.connectionState == ConnectionState.done) {
                        return ListView.builder(
                            itemCount: snapshot.data!.length,
                            itemBuilder: (context, index) {
                              //return Text(snapshot.data?[index].LabelName ?? "got null");

                              return Container(
                                  padding: EdgeInsets.all(10.0),
                                  child: Column(
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      children: [
                                        Padding(
                                          padding:
                                              const EdgeInsets.only(top: 10),
                                          child: Row(
                                              mainAxisAlignment:
                                                  MainAxisAlignment.center,
                                              children: [
                                                Container(
                                                  width: 150,
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
                                                        value: selectedLabel,
                                                        onChanged:
                                                            (String? newValue) {
                                                          setState(() {
                                                            selectedLabel =
                                                                newValue!;
                                                          });
                                                        },
                                                        items: labelData.map<
                                                                DropdownMenuItem<
                                                                    String>>(
                                                            (PairIncomeReportDDl
                                                                pairIncome) {
                                                          return DropdownMenuItem<
                                                              String>(
                                                            value: pairIncome
                                                                .weeks,
                                                            child: Text(
                                                                "${pairIncome.weeks} (${pairIncome.Weekno})"),
                                                          );
                                                        }).toList(),
                                                        underline: Container(),
                                                      )
                                                    ],
                                                  ),
                                                ),
                                                const SizedBox(width: 6),
                                                Container(
                                                  width: 150,
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
                                                        items: <String>[
                                                          'Option A',
                                                          'Option B',
                                                          'Option C',
                                                          'Option D'
                                                        ].map((String value) {
                                                          return DropdownMenuItem<
                                                              String>(
                                                            value: value,
                                                            child: Text(value),
                                                          );
                                                        }).toList(),
                                                        onChanged:
                                                            (String? newValue) {
                                                          // Do something with the selected value
                                                        },
                                                        underline: Container(),
                                                        icon: const Icon(
                                                          Icons.arrow_drop_down,
                                                        ),
                                                        iconSize: 24,
                                                        iconEnabledColor:
                                                            Colors.black,
                                                        alignment: Alignment
                                                            .centerRight,
                                                      ),
                                                    ],
                                                  ),
                                                ),
                                              ]),
                                        ),
                                        Card(
                                            margin: const EdgeInsets.only(
                                                right: 1, left: 1, top: 10),
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
                                                        MainAxisAlignment
                                                            .spaceBetween,
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
                                                              'CheapShop' +
                                                                  '(' +
                                                                  snapshot
                                                                      .data![
                                                                          index]
                                                                      .Weekno +
                                                                  ')',
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
                                                                snapshot
                                                                    .data![
                                                                        index]
                                                                    .Weekno,
                                                                textAlign:
                                                                    TextAlign
                                                                        .center,
                                                                style: TextStyle(

                                                                    fontSize:
                                                                        13,
                                                                    fontWeight:
                                                                        FontWeight
                                                                            .normal),
                                                              ),
                                                              const SizedBox(
                                                                width: 12,
                                                              ),
                                                              Image.asset(
                                                                "assets/images/tickiconpng.png",
                                                                cacheWidth: 15,
                                                                cacheHeight: 15,
                                                                color:
                                                                    Colors.red,
                                                              ),
                                                              Text(
                                                                  textAlign:
                                                                      TextAlign
                                                                          .end,
                                                                  'Cash :' +
                                                                      snapshot
                                                                          .data![
                                                                              index]
                                                                          .weeks,
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
                                                                'Amount :' +
                                                                    snapshot
                                                                        .data![
                                                                            index]
                                                                        .WeekDate,
                                                                textAlign:
                                                                    TextAlign
                                                                        .center,
                                                                // Text(snapshot.data![index].message,
                                                                style: TextStyle(

                                                                    fontSize:
                                                                        13,
                                                                    fontWeight:
                                                                        FontWeight
                                                                            .normal),
                                                              ),
                                                              const SizedBox(
                                                                width: 10,
                                                              ),
                                                              Image.asset(
                                                                "assets/images/tickiconpng.png",
                                                                cacheWidth: 15,
                                                                cacheHeight: 15,
                                                                color:
                                                                    Colors.red,
                                                              ),
                                                              Text(
                                                                  textAlign:
                                                                      TextAlign
                                                                          .end,
                                                                  'TDS :' +
                                                                      snapshot
                                                                          .data![
                                                                              index]
                                                                          .weeks,
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
                                                                padding: const EdgeInsets
                                                                    .symmetric(
                                                                    horizontal:
                                                                        6,
                                                                    vertical:
                                                                        2),
                                                                child:
                                                                    const Text(
                                                                  'DIRECT INCOME',
                                                                  style: TextStyle(
                                                                      fontSize:
                                                                          11.5),
                                                                ),
                                                              ),
                                                              const SizedBox(
                                                                width: 5,
                                                              ),
                                                              Image.asset(
                                                                "assets/images/tickiconpng.png",
                                                                cacheWidth: 15,
                                                                cacheHeight: 15,
                                                                color:
                                                                    Colors.red,
                                                              ),
                                                              Text(
                                                                  'Service Tax :' +
                                                                      snapshot
                                                                          .data![
                                                                              index]
                                                                          .Weekno,
                                                                  textAlign:
                                                                      TextAlign
                                                                          .end,
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
                                                      width:
                                                          265, // Make the Divider span the full width
                                                      child: const Divider(
                                                          thickness:
                                                              2), // Divider after GridView
                                                    ),
                                                    const Text(
                                                      ' Net Amount',
                                                      style: TextStyle(
                                                          fontSize: 12),
                                                    ),
                                                  ],
                                                ),
                                                Padding(
                                                  padding:
                                                      const EdgeInsets.only(
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
                                                            .Weekno,
                                                        style: TextStyle(
                                                            fontSize: 14),
                                                      ),
                                                      const SizedBox(
                                                          width: 145),
                                                      Text(
                                                        snapshot.data![index]
                                                            .Weekno,
                                                        style: TextStyle(
                                                            fontSize: 14,
                                                            fontWeight:
                                                                FontWeight
                                                                    .bold),
                                                      ),
                                                      // User Type on the left side
                                                    ],
                                                  ),
                                                ),
                                              ],
                                            )),
                                      ]));
                            });
                      } else {
                        return CircularProgressIndicator();
                      }
                    }))));
  }
}
