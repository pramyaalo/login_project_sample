import 'package:flutter/material.dart';

class Payouts extends StatefulWidget {
  @override
  _MyWidgetState createState() => _MyWidgetState();
}

class _MyWidgetState extends State<Payouts> {
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
          'Payouts',
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
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          SizedBox(height: 16),
          SizedBox(
            height: 40,
            width: 390,
            child: Container(
              padding: EdgeInsets.all(10),
              margin: EdgeInsets.only(left: 15, right: 15),
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(4),
                border: Border.all(color: Colors.grey),
              ),
              child: TextField(
                decoration: InputDecoration(
                  hintText: "04 Mar 2021",
                  contentPadding: EdgeInsets.only(bottom: 10),
                  border: InputBorder.none,
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
                    "Payout Report for 08/08/9090",
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
                                fontFamily: "Montserrat",
                              )),
                          SizedBox(
                            width: 105,
                          ),
                          Text(": "),
                          SizedBox(
                            width: 5,
                          ),
                          Text("Pios ",
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
                      Text("Full Name",
                          style: TextStyle(
                            fontSize: 16,
                            fontFamily: "Montserrat",
                          )),
                      SizedBox(
                        width: 85,
                      ),
                      Text(": "),
                      SizedBox(
                        width: 5,
                      ),
                      Text("CS1000000",
                          style: TextStyle(
                            fontSize: 16,
                            fontFamily: "Montserrat",
                          )),
                    ],
                  ),
                  SizedBox(height: 8),
                  Row(
                    children: [
                      Text("Date",
                          style: TextStyle(
                            fontSize: 16,
                            fontFamily: "Montserrat",
                          )),
                      SizedBox(
                        width: 126,
                      ),
                      Text(": "),
                      SizedBox(
                        width: 5,
                      ),
                      Text("08/02/2023",
                          style: TextStyle(
                            fontSize: 16,
                            fontFamily: "Montserrat",
                          )),
                    ],
                  ),
                  SizedBox(height: 8),
                  Row(
                    children: [
                      Text("Binary Income",
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
                      Text("₹100",
                          style: TextStyle(
                            fontSize: 16,
                            fontFamily: "Montserrat",
                          )),
                    ],
                  ),
                  SizedBox(height: 8),
                  Row(
                    children: [
                      Text("Franchise Income",
                          style: TextStyle(
                            fontSize: 16,
                            fontFamily: "Montserrat",
                          )),
                      SizedBox(
                        width: 24,
                      ),
                      Text(": "),
                      SizedBox(
                        width: 5,
                      ),
                      Text("₹100",
                          style: TextStyle(
                            fontSize: 16,
                            fontFamily: "Montserrat",
                          )),
                    ],
                  ),
                  SizedBox(height: 8),
                  Row(
                    children: [
                      Text("Franchise Monthly",
                          style: TextStyle(
                            fontSize: 16,
                            fontFamily: "Montserrat",
                          )),
                      SizedBox(
                        width: 19,
                      ),
                      Text(": "),
                      SizedBox(
                        width: 5,
                      ),
                      Text("₹100",
                          style: TextStyle(
                            fontSize: 16,
                            fontFamily: "Montserrat",
                          )),
                    ],
                  ),
                  SizedBox(height: 8),
                  Row(
                    children: [
                      Text("Franchise Referral",
                          style: TextStyle(
                            fontSize: 16,
                            fontFamily: "Montserrat",
                          )),
                      SizedBox(
                        width: 21,
                      ),
                      Text(": "),
                      SizedBox(
                        width: 5,
                      ),
                      Text("₹100",
                          style: TextStyle(
                            fontSize: 16,
                            fontFamily: "Montserrat",
                          )),
                    ],
                  ),
                  SizedBox(height: 8),
                  Row(
                    children: [
                      Text("TDS",
                          style: TextStyle(
                            fontSize: 16,
                            fontFamily: "Montserrat",
                          )),
                      SizedBox(
                        width: 134,
                      ),
                      Text(": "),
                      SizedBox(
                        width: 5,
                      ),
                      Text("₹100",
                          style: TextStyle(
                            fontSize: 16,
                            fontFamily: "Montserrat",
                          )),
                    ],
                  ),
                  SizedBox(height: 8),
                  Row(
                    children: [
                      Text("Service Tax",
                          style: TextStyle(
                            fontSize: 16,
                            fontFamily: "Montserrat",
                          )),
                      SizedBox(
                        width: 75,
                      ),
                      Text(": "),
                      SizedBox(
                        width: 5,
                      ),
                      Text("₹100",
                          style: TextStyle(
                            fontSize: 16,
                            fontFamily: "Montserrat",
                          )),
                    ],
                  ),
                  SizedBox(height: 8),
                  Row(
                    children: [
                      Text("QuCash",
                          style: TextStyle(
                            fontSize: 16,
                            fontFamily: "Montserrat",
                          )),
                      SizedBox(width: 102),
                      Text(": "),
                      SizedBox(
                        width: 5,
                      ),
                      Text("₹100",
                          style: TextStyle(
                            fontSize: 16,
                            fontFamily: "Montserrat",
                          )),
                    ],
                  ),
                  SizedBox(height: 8),
                  Row(
                    children: [
                      Text("Deduction",
                          style: TextStyle(
                            fontSize: 16,
                            fontFamily: "Montserrat",
                          )),
                      SizedBox(
                        width: 82,
                      ),
                      Text(": "),
                      SizedBox(
                        width: 5,
                      ),
                      Text("₹100",
                          style: TextStyle(
                            fontSize: 16,
                            fontFamily: "Montserrat",
                          )),
                    ],
                  ),
                  SizedBox(height: 8),
                  Row(
                    children: [
                      Text("Net Amount",
                          style: TextStyle(
                            fontSize: 16,
                            fontFamily: "Montserrat",
                          )),
                      SizedBox(
                        width: 66,
                      ),
                      Text(": "),
                      SizedBox(
                        width: 5,
                      ),
                      Text("₹100",
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
        ],
      ),
    );
  }
}

void main() {
  runApp(MaterialApp(
    home: Payouts(),
  ));
}
