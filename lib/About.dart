import 'package:flutter/material.dart';

void main() {
  runApp(About());
}

class About extends StatelessWidget {
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
        backgroundColor: Colors.green,
        leading: IconButton(
          icon: Icon(
            Icons.arrow_back,
            color: Colors.white,
          ),
          onPressed: () {
            Navigator.pop(context);
          },
        ),
        title: Text(
          'About',
          style: TextStyle(
              color: Colors.white, fontSize: 17, fontWeight: FontWeight.bold),
        ),
      ),
      body: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Container(
              padding: EdgeInsets.all(10),
              child: Text(
                "About Quickart",
                style: TextStyle(
                  fontSize: 24,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
            /*  Padding(
            padding: const EdgeInsets.all(16.0),
            child: Text(
              "Quickart is a revolutionary app that simplifies your shopping experience. It provides you with a wide range of products at your fingertips. With Quickart, you can browse, compare, and purchase products effortlessly. Say goodbye to long queues and hello to Quickart!",
              style: TextStyle(fontSize: 16),
            ),
          ),*/
            Padding(
              padding: const EdgeInsets.only(
                  top: 10, right: 10, left: 10, bottom: 10),
              child: Text(
                "QuKart Store Pvt Ltd, which began its tasks in the year 2020, Founded by some prominent names from MNCs and Leaders of level marketing around the Globe.QuKart Store Pvt Ltd is the number one online provider in India. We here at QuKart Store, are people who came together to implement a broad vision of the economic spectrum. To open the doors of opportunity and prosperity by empowering our Team QuKart Store to achieve financial independence and economic stability by maximizing the wealth through our Policy.\n\nQuKart Store Pvt Ltd is continually extending its item range to present imaginative items consistently and confirmed organization and has faith in world class     administration levels to every one of its clients. Presently QuKart Store Pvt Ltd is web based shopping, in future disconnected deals outlets plan all through  world and across the board system of merchants, which is continually developing each year.\n\nVISION\nTo assist individuals with carrying on with an existence of monetary freedom on their own terms\n\nMISSION\nTo develop to a worldwide scale and become the benchmark in direct sale business",
                style: TextStyle(fontSize: 16),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
