import 'package:flutter/material.dart';

void main() {
  runApp(Settings());
}

class Settings extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: MyHomePage(),
    );
  }
}

class MyHomePage extends StatefulWidget {
  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
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
          'Settings',
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
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Container(
              padding: EdgeInsets.all(16),
              child: Row(
                children: [
                  Text(
                    "PIOS URIRIJI",
                    style: TextStyle(
                      fontSize: 18,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  SizedBox(width: 166),
                  CircleAvatar(
                    radius: 20,
                    backgroundImage: AssetImage('assets/circle_image.jpg'),
                  ),
                ],
              ),
            ),
            Padding(
              padding: EdgeInsets.symmetric(vertical: 1, horizontal: 16),
              child: Text(
                'Bank Details',
                style: TextStyle(
                    fontSize: 17,
                    fontWeight: FontWeight.bold,
                    color: Colors.black),
              ),
            ),
            Divider(),

            Container(
              padding: EdgeInsets.symmetric(vertical: 1, horizontal: 16),
              child: Row(
                children: [
                  Text(
                    'Manage Bank Details',
                    style: TextStyle(fontSize: 16, fontFamily: "Montserrat"),
                  ),
                  SizedBox(width: 130),
                  Image.asset(
                    'assets/images/right_arrow.png',
                    width: 16,
                    height: 16,
                  ),
                ],
              ),
            ),
            Divider(),
            Container(
              padding: EdgeInsets.symmetric(vertical: 1, horizontal: 16),
              child: Row(
                children: [
                  Text(
                    'Change Password',
                    style: TextStyle(fontSize: 17, fontFamily: "Montserrat"),
                  ),
                  SizedBox(width: 145),
                  Image.asset(
                    'assets/images/right_arrow.png',
                    width: 16,
                    height: 16,
                  ),
                ],
              ),
            ),
            Divider(),
            Container(
              padding: EdgeInsets.symmetric(vertical: 1, horizontal: 16),
              child: Row(
                children: [
                  Text(
                    'Change Transaction Password',
                    style: TextStyle(fontSize: 17, fontFamily: "Montserrat"),
                  ),
                  SizedBox(width: 40),
                  Image.asset(
                    'assets/images/right_arrow.png',
                    width: 16,
                    height: 16,
                  ),
                ],
              ),
            ),
            Divider(),
            Container(
              padding: EdgeInsets.symmetric(vertical: 1, horizontal: 16),
              child: Row(
                children: [
                  Text(
                    'Send Testimonial',
                    style: TextStyle(fontSize: 17, fontFamily: "Montserrat"),
                  ),
                  SizedBox(width: 150),
                  Image.asset(
                    'assets/images/right_arrow.png',
                    width: 16,
                    height: 16,
                  ),
                ],
              ),
            ),
            Padding(
              padding: EdgeInsets.symmetric(vertical: 16, horizontal: 16),
              child: Text(
                'KYC',
                style: TextStyle(
                    fontSize: 17,
                    fontWeight: FontWeight.bold,
                    color: Colors.black,
                    fontFamily: "Montserrat"),
              ),
            ),
            Container(
              padding: EdgeInsets.symmetric(vertical: 1, horizontal: 16),
              child: Row(
                children: [
                  Text(
                    'KYC Application',
                    style: TextStyle(fontSize: 17, fontFamily: "Montserrat"),
                  ),
                  SizedBox(width: 155),
                  Image.asset(
                    'assets/images/right_arrow.png',
                    width: 16,
                    height: 16,
                  ),
                ],
              ),
            ),
            Divider(),
            Container(
              padding: EdgeInsets.symmetric(vertical: 1, horizontal: 16),
              child: Row(
                children: [
                  Text(
                    'KYC Details',
                    style: TextStyle(fontSize: 17, fontFamily: "Montserrat"),
                  ),
                  SizedBox(width: 190),
                  Image.asset(
                    'assets/images/right_arrow.png',
                    width: 16,
                    height: 16,
                  ),
                ],
              ),
            ),
            Padding(
              padding: EdgeInsets.symmetric(vertical: 16, horizontal: 16),
              child: Text(
                'Address',
                style: TextStyle(
                    fontSize: 17,
                    fontWeight: FontWeight.bold,
                    color: Colors.black,
                    fontFamily: "Montserrat"),
              ),
            ),
            Divider(),
            Padding(
              padding: EdgeInsets.symmetric(vertical: 6, horizontal: 16),
              child: Text(
                'Address1',
                style: TextStyle(
                    fontSize: 17,
                    color: Colors.black,
                    fontFamily: "Montserrat"),
              ),
            ),
            Padding(
              padding: EdgeInsets.symmetric(vertical: 6, horizontal: 16),
              child: Text(
                'Address2',
                style: TextStyle(
                    fontSize: 17,
                    color: Colors.black,
                    fontFamily: "Montserrat"),
              ),
            ),
            Padding(
              padding: EdgeInsets.symmetric(vertical: 6, horizontal: 16),
              child: Text(
                'City',
                style: TextStyle(
                    fontSize: 17,
                    color: Colors.black,
                    fontFamily: "Montserrat"),
              ),
            ),
            Padding(
              padding: EdgeInsets.symmetric(vertical: 16, horizontal: 16),
              child: Text(
                'Settings',
                style: TextStyle(
                    fontSize: 17,
                    fontWeight: FontWeight.bold,
                    color: Colors.black,
                    fontFamily: "Montserrat"),
              ),
            ),
            Divider(),
            Container(
              padding: EdgeInsets.symmetric(vertical: 1, horizontal: 16),
              child: Row(
                children: [
                  Text(
                    'Write a feedback about app',
                    style: TextStyle(fontSize: 17, fontFamily: "Montserrat"),
                  ),
                  SizedBox(width: 60),
                  Image.asset(
                    'assets/images/right_arrow.png',
                    width: 16,
                    height: 16,
                  ),
                ],
              ),
            ),
            Divider(),
            Container(
              padding: EdgeInsets.symmetric(vertical: 1, horizontal: 16),
              child: Row(
                children: [
                  Text(
                    'Disputes',
                    style: TextStyle(fontSize: 17, fontFamily: "Montserrat"),
                  ),
                  SizedBox(width: 225),
                  Image.asset(
                    'assets/images/right_arrow.png',
                    width: 16,
                    height: 16,
                  ),
                ],
              ),
            ),
            Divider(),
            Container(
              padding: EdgeInsets.symmetric(vertical: 1, horizontal: 16),
              child: Row(
                children: [
                  Text(
                    'About',
                    style: TextStyle(fontSize: 17, fontFamily: "Montserrat"),
                  ),
                  SizedBox(width: 245),
                  Image.asset(
                    'assets/images/right_arrow.png',
                    width: 16,
                    height: 16,
                  ),
                ],
              ),
            ),
            Divider(),
            Container(
              padding: EdgeInsets.symmetric(vertical: 1, horizontal: 16),
              child: Row(
                children: [
                  Text(
                    'Sign Out',
                    style: TextStyle(
                        fontSize: 17,
                        color: Colors.red,
                        fontFamily: "Montserrat"),
                  ),
                  SizedBox(width: 225),
                  Image.asset(
                    'assets/images/right_arrow.png',
                    width: 16,
                    height: 16,
                  ),
                ],
              ),
            ),
            // ... Other sections
          ],
        ),
      ),
    );
  }
}

Widget buildCustomRow(String text) {
  return GestureDetector(
    onTap: () {
      // Handle row tap
    },
    child: Container(
      padding: EdgeInsets.symmetric(vertical: 16, horizontal: 16),
      child: Row(
        children: [
          Text(
            text,
            style: TextStyle(fontSize: 16),
          ),
          SizedBox(width: 220),
          Image.asset(
            'assets/images/right_arrow.png',
            width: 16,
            height: 16,
          ),
        ],
      ),
    ),
  );
}
