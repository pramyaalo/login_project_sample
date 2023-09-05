import 'dart:convert';
import 'dart:developer';
import 'package:http/http.dart' as http;
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:login_project_sample/Models/KYCListModel.dart';
import 'package:login_project_sample/utils/response_handler.dart';
import 'package:login_project_sample/utils/shared_preferences.dart';

class KYCList extends StatefulWidget {
  @override
  _MyWidgetState createState() => _MyWidgetState();
}

class _MyWidgetState extends State<KYCList> {
  static Future<List<KYCListModel>?> getPayment() async {
    String? memberId = await Prefs.getStringValue(Prefs.PREFS_USER_ID);
    List<KYCListModel> bookingCardData = [];
    Future<http.Response>? __futureLabels =
        ResponseHandler.performPost("KYCdocs", "customerid=$memberId");
    log('MemberId :' + memberId!);

    return await __futureLabels?.then((value) {
      String jsonResponse = ResponseHandler.parseData(value.body);
      log('jsonResponsedf :' + jsonResponse);
      try {
        //Map<String, dynamic> map = json.decode(jsonResponse);
        List<dynamic> decodedJson = json.decode(jsonResponse);

        print('json : ${decodedJson}');

        for (int i = 0; i < decodedJson.length; i++) {
          KYCListModel fm = KYCListModel.fromJson(decodedJson[i]);
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
            'KYC List Details',
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
        body: Center(
            child: FutureBuilder<List<KYCListModel>?>(
                future: getPayment(),
                builder: (context, snapshot) {
                  if (snapshot.hasData &&
                      snapshot.connectionState == ConnectionState.done) {
                    return ListView.builder(
                        itemCount: snapshot.data!.length,
                        itemBuilder: (context, index) {
                          return Container(
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.stretch,
                              children: [
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
                                          "KYC Information",
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
                                                Text("Submitted By",
                                                    style: TextStyle(
                                                      fontSize: 16,
                                                      fontFamily: "Montserrat",
                                                    )),
                                                SizedBox(
                                                  width: 38,
                                                ),
                                                Text(": "),
                                                SizedBox(
                                                  width: 5,
                                                ),
                                                Text(
                                                    snapshot
                                                        .data![index].firstname,
                                                    style: TextStyle(
                                                      fontSize: 16,
                                                      fontFamily: "Montserrat",
                                                    )),
                                              ],
                                            ),
                                          ],
                                        ),
                                        SizedBox(height: 8),
                                        Row(
                                          children: [
                                            Text("Submitted On",
                                                style: TextStyle(
                                                  fontSize: 16,
                                                  fontFamily: "Montserrat",
                                                )),
                                            SizedBox(
                                              width: 35,
                                            ),
                                            Text(": "),
                                            SizedBox(
                                              width: 5,
                                            ),
                                            Text(
                                                snapshot
                                                    .data![index].customerid,
                                                style: TextStyle(
                                                  fontSize: 16,
                                                  fontFamily: "Montserrat",
                                                )),
                                          ],
                                        ),
                                        SizedBox(height: 8),
                                        Row(
                                          children: [
                                            Text("Checked By",
                                                style: TextStyle(
                                                  fontSize: 16,
                                                  fontFamily: "Montserrat",
                                                )),
                                            SizedBox(
                                              width: 52,
                                            ),
                                            Text(": "),
                                            SizedBox(
                                              width: 5,
                                            ),
                                            Text(snapshot.data![index].checkby,
                                                style: TextStyle(
                                                  fontSize: 16,
                                                  fontFamily: "Montserrat",
                                                )),
                                          ],
                                        ),
                                        SizedBox(height: 8),
                                        Row(
                                          children: [
                                            Text("Checked On",
                                                style: TextStyle(
                                                  fontSize: 16,
                                                  fontFamily: "Montserrat",
                                                )),
                                            SizedBox(
                                              width: 48,
                                            ),
                                            Text(": "),
                                            SizedBox(
                                              width: 5,
                                            ),
                                            Text(
                                                snapshot.data![index].checkdate,
                                                style: TextStyle(
                                                  fontSize: 10,
                                                  fontFamily: "Montserrat",
                                                )),
                                          ],
                                        ),
                                        SizedBox(height: 8),
                                        Row(
                                          children: [
                                            Text("Admin Note",
                                                style: TextStyle(
                                                  fontSize: 16,
                                                  fontFamily: "Montserrat",
                                                )),
                                            SizedBox(
                                              width: 49,
                                            ),
                                            Text(": "),
                                            SizedBox(
                                              width: 5,
                                            ),
                                            Image.asset(
                                              'assets/images/greentick.png',
                                              cacheWidth: 15,
                                              cacheHeight: 15,
                                            ),
                                            Text(
                                                snapshot.data![index].adminnote,
                                                style: TextStyle(
                                                  fontSize: 16,
                                                  fontFamily: "Montserrat",
                                                )),
                                          ],
                                        ),
                                        SizedBox(height: 8),
                                        Row(
                                          children: [
                                            Text("Approved",
                                                style: TextStyle(
                                                  fontSize: 16,
                                                  fontFamily: "Montserrat",
                                                )),
                                            SizedBox(
                                              width: 69,
                                            ),
                                            Text(": "),
                                            SizedBox(
                                              width: 5,
                                            ),
                                            Image.asset(
                                              'assets/images/greentick.png',
                                              cacheWidth: 15,
                                              cacheHeight: 15,
                                            ),
                                            Text("Approved",
                                                style: TextStyle(
                                                  fontSize: 16,
                                                  fontFamily: "Montserrat",
                                                )),
                                          ],
                                        ),
                                        SizedBox(height: 8),
                                      ],
                                    ),
                                  ),
                                ),
                                SizedBox(
                                  height: 16,
                                ),
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
                                          "Personal Information",
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
                                                Text("First Name",
                                                    style: TextStyle(
                                                      fontSize: 16,
                                                      fontFamily: "Montserrat",
                                                    )),
                                                SizedBox(
                                                  width: 55,
                                                ),
                                                Text(": "),
                                                SizedBox(
                                                  width: 5,
                                                ),
                                                Text(
                                                    snapshot
                                                        .data![index].firstname,
                                                    style: TextStyle(
                                                      fontSize: 16,
                                                      fontFamily: "Montserrat",
                                                    )),
                                              ],
                                            ),
                                          ],
                                        ),
                                        SizedBox(height: 8),
                                        Row(
                                          children: [
                                            Text("Last Name",
                                                style: TextStyle(
                                                  fontSize: 16,
                                                  fontFamily: "Montserrat",
                                                )),
                                            SizedBox(
                                              width: 55,
                                            ),
                                            Text(": "),
                                            SizedBox(
                                              width: 5,
                                            ),
                                            Text(snapshot.data![index].lastname,
                                                style: TextStyle(
                                                  fontSize: 16,
                                                  fontFamily: "Montserrat",
                                                )),
                                          ],
                                        ),
                                        SizedBox(height: 8),
                                        Row(
                                          children: [
                                            Text("Phone Number",
                                                style: TextStyle(
                                                  fontSize: 16,
                                                  fontFamily: "Montserrat",
                                                )),
                                            SizedBox(
                                              width: 20,
                                            ),
                                            Text(": "),
                                            SizedBox(
                                              width: 5,
                                            ),
                                            Text(snapshot.data![index].phone,
                                                style: TextStyle(
                                                  fontSize: 16,
                                                  fontFamily: "Montserrat",
                                                )),
                                          ],
                                        ),
                                        SizedBox(height: 8),
                                        Row(
                                          children: [
                                            Text("Date of Birth",
                                                style: TextStyle(
                                                  fontSize: 16,
                                                  fontFamily: "Montserrat",
                                                )),
                                            SizedBox(
                                              width: 40,
                                            ),
                                            Text(": "),
                                            SizedBox(
                                              width: 5,
                                            ),
                                            Text(snapshot.data![index].dob,
                                                style: TextStyle(
                                                  fontSize: 16,
                                                  fontFamily: "Montserrat",
                                                )),
                                          ],
                                        ),
                                        SizedBox(height: 8),
                                        Row(
                                          children: [
                                            Text("Gender",
                                                style: TextStyle(
                                                  fontSize: 16,
                                                  fontFamily: "Montserrat",
                                                )),
                                            SizedBox(
                                              width: 84,
                                            ),
                                            Text(": "),
                                            SizedBox(
                                              width: 5,
                                            ),
                                            Text(snapshot.data![index].gender,
                                                style: TextStyle(
                                                  fontSize: 16,
                                                  fontFamily: "Montserrat",
                                                )),
                                          ],
                                        ),
                                        SizedBox(height: 8),
                                        Row(
                                          children: [
                                            Text("Username",
                                                style: TextStyle(
                                                  fontSize: 16,
                                                  fontFamily: "Montserrat",
                                                )),
                                            SizedBox(
                                              width: 59,
                                            ),
                                            Text(": "),
                                            SizedBox(
                                              width: 5,
                                            ),
                                            Text("susan",
                                                style: TextStyle(
                                                  fontSize: 16,
                                                  fontFamily: "Montserrat",
                                                )),
                                          ],
                                        ),
                                        SizedBox(height: 8),
                                        Row(
                                          children: [
                                            Text("Address Line 1",
                                                style: TextStyle(
                                                  fontSize: 16,
                                                  fontFamily: "Montserrat",
                                                )),
                                            SizedBox(
                                              width: 28,
                                            ),
                                            Text(": "),
                                            SizedBox(
                                              width: 5,
                                            ),
                                            Text(snapshot.data![index].address1,
                                                style: TextStyle(
                                                  fontSize: 16,
                                                  fontFamily: "Montserrat",
                                                )),
                                          ],
                                        ),
                                        SizedBox(height: 8),
                                        Row(
                                          children: [
                                            Text("Address Line 2",
                                                style: TextStyle(
                                                  fontSize: 16,
                                                  fontFamily: "Montserrat",
                                                )),
                                            SizedBox(
                                              width: 27,
                                            ),
                                            Text(": "),
                                            SizedBox(
                                              width: 5,
                                            ),
                                            Text(snapshot.data![index].address2,
                                                style: TextStyle(
                                                  fontSize: 16,
                                                  fontFamily: "Montserrat",
                                                )),
                                          ],
                                        ),
                                        SizedBox(height: 8),
                                        Row(
                                          children: [
                                            Text("State",
                                                style: TextStyle(
                                                  fontSize: 16,
                                                  fontFamily: "Montserrat",
                                                )),
                                            SizedBox(
                                              width: 102,
                                            ),
                                            Text(": "),
                                            SizedBox(
                                              width: 5,
                                            ),
                                            Text(snapshot.data![index].state,
                                                style: TextStyle(
                                                  fontSize: 16,
                                                  fontFamily: "Montserrat",
                                                )),
                                          ],
                                        ),
                                        SizedBox(height: 8),
                                        Row(
                                          children: [
                                            Text("City",
                                                style: TextStyle(
                                                  fontSize: 16,
                                                  fontFamily: "Montserrat",
                                                )),
                                            SizedBox(width: 112),
                                            Text(": "),
                                            SizedBox(
                                              width: 5,
                                            ),
                                            Text(snapshot.data![index].city,
                                                style: TextStyle(
                                                  fontSize: 16,
                                                  fontFamily: "Montserrat",
                                                )),
                                          ],
                                        ),
                                        SizedBox(height: 8),
                                        Row(
                                          children: [
                                            Text("Zip Code",
                                                style: TextStyle(
                                                  fontSize: 16,
                                                  fontFamily: "Montserrat",
                                                )),
                                            SizedBox(
                                              width: 72,
                                            ),
                                            Text(": "),
                                            SizedBox(
                                              width: 5,
                                            ),
                                            Text(snapshot.data![index].zip,
                                                style: TextStyle(
                                                  fontSize: 16,
                                                  fontFamily: "Montserrat",
                                                )),
                                          ],
                                        ),
                                        SizedBox(height: 8),
                                        Row(
                                          children: [
                                            Text("Country",
                                                style: TextStyle(
                                                  fontSize: 16,
                                                  fontFamily: "Montserrat",
                                                )),
                                            SizedBox(
                                              width: 80,
                                            ),
                                            Text(": "),
                                            SizedBox(
                                              width: 5,
                                            ),
                                            Text(snapshot.data![index].country,
                                                style: TextStyle(
                                                  fontSize: 16,
                                                  fontFamily: "Montserrat",
                                                )),
                                          ],
                                        ),
                                      ],
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
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      children: [
                                        Text(
                                          "Uploded Documents",
                                          style: TextStyle(
                                            fontWeight: FontWeight.bold,
                                            fontSize: 18,
                                          ),
                                        ),
                                        SizedBox(height: 16),
                                        Column(
                                          children: [
                                            Text("Passport : ",
                                                style: TextStyle(
                                                  fontSize: 16,
                                                  fontFamily: "Montserrat",
                                                )),
                                          ],
                                        ),
                                        SizedBox(height: 4),
                                        Container(
                                          width: 200, // Set the width
                                          height: 120, // Set the height
                                          decoration: BoxDecoration(
                                            shape: BoxShape.rectangle,
                                            color: Colors.white,
                                          ),
                                          /* child: Image.asset(
                          // Replace with your image path

                          ),*/
                                        ),
                                        SizedBox(height: 8),
                                        Column(
                                          children: [
                                            Text("Passport Photo : ",
                                                style: TextStyle(
                                                  fontSize: 16,
                                                  fontFamily: "Montserrat",
                                                )),
                                          ],
                                        ),
                                        SizedBox(height: 4),
                                        Container(
                                          width: 200, // Set the width
                                          height: 120, // Set the height
                                          decoration: BoxDecoration(
                                            shape: BoxShape.rectangle,
                                            color: Colors.white,
                                          ),
                                          /* child: Image.asset(
                          // Replace with your image path

                          ),*/
                                        ),
                                        SizedBox(height: 8),
                                        Column(
                                          children: [
                                            Text("ID Front Side : ",
                                                style: TextStyle(
                                                  fontSize: 16,
                                                  fontFamily: "Montserrat",
                                                )),
                                          ],
                                        ),
                                        SizedBox(height: 4),
                                        Container(
                                          width: 200, // Set the width
                                          height: 120, // Set the height
                                          decoration: BoxDecoration(
                                            shape: BoxShape.rectangle,
                                            color: Colors.white,
                                          ),
                                          /* child: Image.asset(
                          // Replace with your image path

                          ),*/
                                        ),
                                        SizedBox(height: 8),
                                        Column(
                                          children: [
                                            Text("ID Back Side : ",
                                                style: TextStyle(
                                                  fontSize: 16,
                                                  fontFamily: "Montserrat",
                                                )),
                                          ],
                                        ),
                                        SizedBox(height: 4),
                                        Container(
                                          width: 200, // Set the width
                                          height: 120, // Set the height
                                          decoration: BoxDecoration(
                                            shape: BoxShape.rectangle,
                                            color: Colors.white,
                                          ),
                                          /* child: Image.asset(
                          // Replace with your image path

                          ),*/
                                        ),
                                        SizedBox(height: 8),
                                        Column(
                                          children: [
                                            Text("National Photo : ",
                                                style: TextStyle(
                                                  fontSize: 16,
                                                  fontFamily: "Montserrat",
                                                )),
                                          ],
                                        ),
                                        SizedBox(height: 4),
                                        Container(
                                          width: 200, // Set the width
                                          height: 120, // Set the height
                                          decoration: BoxDecoration(
                                            shape: BoxShape.rectangle,
                                            color: Colors.white,
                                          ),
                                          /* child: Image.asset(
                          // Replace with your image path

                          ),*/
                                        ),
                                        SizedBox(height: 8),
                                        Column(
                                          children: [
                                            Text("Driver Photo : ",
                                                style: TextStyle(
                                                  fontSize: 16,
                                                  fontFamily: "Montserrat",
                                                )),
                                          ],
                                        ),
                                        SizedBox(height: 4),
                                        Container(
                                          width: 200, // Set the width
                                          height: 120, // Set the height
                                          decoration: BoxDecoration(
                                            shape: BoxShape.rectangle,
                                            color: Colors.white,
                                          ),
                                          /* child: Image.asset(
                          // Replace with your image path

                          ),*/
                                        ),
                                        SizedBox(height: 8),
                                      ],
                                    ),
                                  ),
                                ),
                                SizedBox(height: 16),
                              ],
                            ),
                          );
                        });
                  } else {
                    return CircularProgressIndicator();
                  }
                })));
  }
}

void main() {
  runApp(MaterialApp(
    home: KYCList(),
  ));
}
