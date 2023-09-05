import 'dart:convert';
import 'dart:developer';
import 'package:http/http.dart' as http;
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:login_project_sample/Models/WalletCashHistoryModel.dart';
import 'package:login_project_sample/utils/response_handler.dart';
import 'package:login_project_sample/utils/shared_preferences.dart';

class cashwallethistory extends StatefulWidget {
  const cashwallethistory({Key? key}) : super(key: key);

  @override
  _CabsListScreenState createState() => _CabsListScreenState();
}

class _CabsListScreenState extends State<cashwallethistory> {
  static Future<List<WalletCashHistoryModel>?> getPartPaymentData() async {
    String? memberId = await Prefs.getStringValue(Prefs.PREFS_USER_ID);
    List<WalletCashHistoryModel> bookingCardData = [];
    Future<http.Response>? __futureLabels = ResponseHandler.performPost(
        "GetCashWalletAddHistory",
        "MemberId=$memberId&Month=07&Year=2021&PageIndex=1");

    return await __futureLabels?.then((value) {
      String jsonResponse = ResponseHandler.parseData(value.body);
      log(jsonResponse);
      try {
        //Map<String, dynamic> map = json.decode(jsonResponse);
        List<dynamic> decodedJson = json.decode(jsonResponse);

        print('json : ${decodedJson}');

        for (int i = 0; i < decodedJson.length; i++) {
          WalletCashHistoryModel fm =
              WalletCashHistoryModel.fromJson(decodedJson[i]);
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
                icon: Icon(
                  Icons.arrow_back,
                  color: Colors.black,
                ),
                onPressed: () {
                  Navigator.pop(context);
                },
              ),
              title: Text(
                'Cash Wallet History',
                style: TextStyle(
                    color: Colors.black,
                    fontSize: 16,
                    fontFamily: "Montserrat",
                    fontWeight: FontWeight.bold),
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
            body: Center(
                child: FutureBuilder<List<WalletCashHistoryModel>?>(
                    future: getPartPaymentData(),
                    builder: (context, snapshot) {
                      if (snapshot.hasData &&
                          snapshot.connectionState == ConnectionState.done) {
                        return ListView.builder(
                            itemCount: snapshot.data!.length,
                            itemBuilder: (context, index) {
                              //return Text(snapshot.data?[index].LabelName ?? "got null");

                              return Container(
                                  child: Column(
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      children: [
                                    SingleChildScrollView(
                                        child: Card(
                                            margin: EdgeInsets.only(
                                                right: 10, left: 10, top: 15),
                                            elevation: 5,
                                            color: Colors.white,
                                            child: Column(
                                              crossAxisAlignment:
                                                  CrossAxisAlignment.start,
                                              children: [
                                                Container(
                                                  padding: EdgeInsets.all(10),
                                                  child: Row(
                                                    mainAxisAlignment:
                                                        MainAxisAlignment
                                                            .spaceBetween,
                                                    children: [
                                                      Image(
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
                                                              snapshot
                                                                  .data![index]
                                                                  .customerName,
                                                              textAlign:
                                                                  TextAlign.end,
                                                              style: TextStyle(
                                                                  fontFamily:
                                                                      "Montserrat",
                                                                  fontSize: 14,
                                                                  fontWeight:
                                                                      FontWeight
                                                                          .bold)),
                                                          SizedBox(
                                                            width: 100,
                                                          ),
                                                          SizedBox(
                                                            height: 4,
                                                          ),
                                                          Row(
                                                            children: [
                                                              Text(
                                                                snapshot
                                                                    .data![
                                                                        index]
                                                                    .username,
                                                                textAlign:
                                                                    TextAlign
                                                                        .center,
                                                                // Text(snapshot.data![index].message,
                                                                style: TextStyle(
                                                                    fontFamily:
                                                                        "Montserrat",
                                                                    fontSize:
                                                                        14,
                                                                    fontWeight:
                                                                        FontWeight
                                                                            .normal),
                                                              ),
                                                              SizedBox(
                                                                width: 55,
                                                              ),
                                                              Image.asset(
                                                                "assets/images/tickiconpng.png",
                                                                cacheWidth: 15,
                                                                cacheHeight: 15,
                                                              ),
                                                              Text(
                                                                  snapshot
                                                                      .data![
                                                                          index]
                                                                      .type,
                                                                  textAlign:
                                                                      TextAlign
                                                                          .end,

                                                                  //Text(snapshot.data![index].username,
                                                                  style: TextStyle(
                                                                      fontFamily:
                                                                          "Montserrat",
                                                                      fontSize:
                                                                          12,
                                                                      color: Colors
                                                                          .green,
                                                                      fontWeight:
                                                                          FontWeight
                                                                              .bold)),
                                                            ],
                                                          ),
                                                          SizedBox(
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
                                                                padding: EdgeInsets
                                                                    .symmetric(
                                                                        horizontal:
                                                                            6,
                                                                        vertical:
                                                                            2),
                                                                child: Text(
                                                                    'Cash Wallet',
                                                                    style: TextStyle(
                                                                        fontSize:
                                                                            13)),
                                                              ),
                                                              SizedBox(
                                                                width: 55,
                                                              ),
                                                              Image.asset(
                                                                "assets/images/tickiconpng.png",
                                                                cacheWidth: 15,
                                                                cacheHeight: 15,
                                                              ),
                                                              Text(
                                                                  snapshot
                                                                      .data![
                                                                          index]
                                                                      .dateCreated,
                                                                  textAlign:
                                                                      TextAlign
                                                                          .end,

                                                                  //Text(,
                                                                  style: TextStyle(
                                                                      fontFamily:
                                                                          "Montserrat",
                                                                      fontSize:
                                                                          12,
                                                                      color: Colors
                                                                          .green,
                                                                      fontWeight:
                                                                          FontWeight
                                                                              .bold)),
                                                            ],
                                                          ),
                                                          SizedBox(
                                                            height: 4.5,
                                                          ),
                                                          Text(
                                                              snapshot
                                                                  .data![index]
                                                                  .message,
                                                              overflow:
                                                                  TextOverflow
                                                                      .ellipsis,
                                                              //Text(snapshot.data![index].type,
                                                              style: TextStyle(
                                                                  fontFamily:
                                                                      "Montserrat",
                                                                  fontSize: 13,
                                                                  fontWeight:
                                                                      FontWeight
                                                                          .normal)),
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
                                                      child: Divider(
                                                          thickness:
                                                              2), // Divider after GridView
                                                    ),
                                                    Text(
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
                                                      SizedBox(
                                                        width: 10,
                                                      ),
                                                      Image.asset(
                                                        "assets/images/orderpng.png",
                                                        cacheHeight: 12,
                                                        cacheWidth: 12,
                                                      ),
                                                      Text(
                                                        ' User ID: ',
                                                        style: TextStyle(
                                                            fontSize: 14),
                                                      ),
                                                      SizedBox(
                                                        width: 5,
                                                      ),
                                                      Text(
                                                        snapshot.data![index]
                                                            .username,
                                                        style: TextStyle(
                                                            fontSize: 14),
                                                      ),
                                                      SizedBox(width: 123),
                                                      Text(
                                                        snapshot.data![index]
                                                            .amount,
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
                                            ))),
                                  ]));
                            });
                      } else {
                        return CircularProgressIndicator();
                      }
                    }))));
  }
  /*child: ListView.builder<List<WalletCashHistoryModel>?>(
    future: getPartPaymentData(),
    itemCount: walletCashHistoryList.length,
    itemBuilder: (context, index) {
    WalletCashHistoryModel item = WalletCashHistoryModel[index];
          children: [
            Container(
              margin: EdgeInsets.fromLTRB(0, 20, 0, 0),
              color: Colors.white,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Container(
                      margin: EdgeInsets.all(10),
                      child: Text("Choose your car",
                          style: TextStyle(
                              fontFamily: "Montserrat",
                              fontSize: 14,
                              fontWeight: FontWeight.normal))),
                  Container(
                    padding: EdgeInsets.all(10),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Image(
                          image: AssetImage("assets/images/tickiconpng.png"),
                          width: 100,
                          height: 80,
                        ),
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(item.,
                                style: TextStyle(
                                    fontFamily: "Montserrat",
                                    fontSize: 14,
                                    fontWeight: FontWeight.bold)),
                            SizedBox(
                              height: 2.5,
                            ),
                            Text("Verna or Similar",
                                style: TextStyle(
                                    fontFamily: "Montserrat",
                                    fontSize: 12,
                                    fontWeight: FontWeight.normal)),
                            SizedBox(
                              height: 2.5,
                            ),
                            Text("3- baggages & 4-Peoples",
                                style: TextStyle(
                                    fontFamily: "Montserrat",
                                    fontSize: 12,
                                    fontWeight: FontWeight.normal)),
                          ],
                        ),
                        Text("₹4,999",
                            style: TextStyle(
                                fontFamily: "Montserrat",
                                fontSize: 14,
                                fontWeight: FontWeight.bold)),
                      ],
                    ),
                  ),
                  Container(
                    width: double.infinity,
                    height: 0.5,
                    color: Colors.grey,
                  ),
                  Container(
                    padding: EdgeInsets.all(10),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Image(
                          image: AssetImage("assets/images/sedanpng.png"),
                          width: 100,
                          height: 80,
                        ),
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text("Sedan Car",
                                style: TextStyle(
                                    fontFamily: "Montserrat",
                                    fontSize: 14,
                                    fontWeight: FontWeight.bold)),
                            SizedBox(
                              height: 2.5,
                            ),
                            Text("Verna or Similar",
                                style: TextStyle(
                                    fontFamily: "Montserrat",
                                    fontSize: 12,
                                    fontWeight: FontWeight.normal)),
                            SizedBox(
                              height: 2.5,
                            ),
                            Text("3- baggages & 4-Peoples",
                                style: TextStyle(
                                    fontFamily: "Montserrat",
                                    fontSize: 12,
                                    fontWeight: FontWeight.normal)),
                          ],
                        ),
                        Text("₹4,999",
                            style: TextStyle(
                                fontFamily: "Montserrat",
                                fontSize: 14,
                                fontWeight: FontWeight.bold)),
                      ],
                    ),
                  ),
                  Container(
                    width: double.infinity,
                    height: 0.5,
                    color: Colors.grey,
                  ),
                  Container(
                    padding: EdgeInsets.all(10),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Image(
                          image: AssetImage("assets/images/sedanpng.png"),
                          width: 100,
                          height: 80,
                        ),
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text("Sedan Car",
                                style: TextStyle(
                                    fontFamily: "Montserrat",
                                    fontSize: 14,
                                    fontWeight: FontWeight.bold)),
                            SizedBox(
                              height: 2.5,
                            ),
                            Text("Verna or Similar",
                                style: TextStyle(
                                    fontFamily: "Montserrat",
                                    fontSize: 12,
                                    fontWeight: FontWeight.normal)),
                            SizedBox(
                              height: 2.5,
                            ),
                            Text("3- baggages & 4-Peoples",
                                style: TextStyle(
                                    fontFamily: "Montserrat",
                                    fontSize: 12,
                                    fontWeight: FontWeight.normal)),
                          ],
                        ),
                        Text("₹4,999",
                            style: TextStyle(
                                fontFamily: "Montserrat",
                                fontSize: 14,
                                fontWeight: FontWeight.bold)),
                      ],
                    ),
                  ),
                  Container(
                    width: double.infinity,
                    height: 0.5,
                    color: Colors.grey,
                  ),
                  Container(
                    padding: EdgeInsets.all(10),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Image(
                          image: AssetImage("assets/images/sedanpng.png"),
                          width: 100,
                          height: 80,
                        ),
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text("Sedan Car",
                                style: TextStyle(
                                    fontFamily: "Montserrat",
                                    fontSize: 14,
                                    fontWeight: FontWeight.bold)),
                            SizedBox(
                              height: 2.5,
                            ),
                            Text("Verna or Similar",
                                style: TextStyle(
                                    fontFamily: "Montserrat",
                                    fontSize: 12,
                                    fontWeight: FontWeight.normal)),
                            SizedBox(
                              height: 2.5,
                            ),
                            Text("3- baggages & 4-Peoples",
                                style: TextStyle(
                                    fontFamily: "Montserrat",
                                    fontSize: 12,
                                    fontWeight: FontWeight.normal)),
                          ],
                        ),
                        Text("₹4,999",
                            style: TextStyle(
                                fontFamily: "Montserrat",
                                fontSize: 14,
                                fontWeight: FontWeight.bold)),
                      ],
                    ),
                  ),
                  Container(
                    width: double.infinity,
                    height: 0.5,
                    color: Colors.grey,
                  ),
                  Container(
                    padding: EdgeInsets.all(10),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Image(
                          image: AssetImage("assets/images/sedanpng.png"),
                          width: 100,
                          height: 80,
                        ),
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text("Sedan Car",
                                style: TextStyle(
                                    fontFamily: "Montserrat",
                                    fontSize: 14,
                                    fontWeight: FontWeight.bold)),
                            SizedBox(
                              height: 2.5,
                            ),
                            Text("Verna or Similar",
                                style: TextStyle(
                                    fontFamily: "Montserrat",
                                    fontSize: 12,
                                    fontWeight: FontWeight.normal)),
                            SizedBox(
                              height: 2.5,
                            ),
                            Text("3- baggages & 4-Peoples",
                                style: TextStyle(
                                    fontFamily: "Montserrat",
                                    fontSize: 12,
                                    fontWeight: FontWeight.normal)),
                          ],
                        ),
                        Text("₹4,999",
                            style: TextStyle(
                                fontFamily: "Montserrat",
                                fontSize: 14,
                                fontWeight: FontWeight.bold)),
                      ],
                    ),
                  ),
                  Container(
                    width: double.infinity,
                    height: 0.5,
                    color: Colors.grey,
                  ),
                  Container(
                    padding: EdgeInsets.all(10),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Image(
                          image: AssetImage("assets/images/sedanpng.png"),
                          width: 100,
                          height: 80,
                        ),
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text("Sedan Car",
                                style: TextStyle(
                                    fontFamily: "Montserrat",
                                    fontSize: 14,
                                    fontWeight: FontWeight.bold)),
                            SizedBox(
                              height: 2.5,
                            ),
                            Text("Verna or Similar",
                                style: TextStyle(
                                    fontFamily: "Montserrat",
                                    fontSize: 12,
                                    fontWeight: FontWeight.normal)),
                            SizedBox(
                              height: 2.5,
                            ),
                            Text("3- baggages & 4-Peoples",
                                style: TextStyle(
                                    fontFamily: "Montserrat",
                                    fontSize: 12,
                                    fontWeight: FontWeight.normal)),
                          ],
                        ),
                        Text("₹4,999",
                            style: TextStyle(
                                fontFamily: "Montserrat",
                                fontSize: 14,
                                fontWeight: FontWeight.bold)),
                      ],
                    ),
                  ),
                  Container(
                    width: double.infinity,
                    height: 0.5,
                    color: Colors.grey,
                  ),
                ],
              ),
            )*/
}
