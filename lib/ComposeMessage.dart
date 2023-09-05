import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';
import 'package:login_project_sample/Wallet_n.dart';

void main() {
  runApp(ComposeMessage());
}

class ComposeMessage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: TabViewExample(),
    );
  }
}

class TabViewExample extends StatefulWidget {
  @override
  _TabViewExampleState createState() => _TabViewExampleState();
}

class _TabViewExampleState extends State<TabViewExample> {
  Widget _tabSection(BuildContext context) {
    return DefaultTabController(
      length: 3,
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: <Widget>[
          Container(
            child: TabBar(
                labelColor: Colors.black,
                isScrollable: true,
                indicatorColor: Colors.green,
                tabs: [
                  Tab(
                    child: Text(
                      "          COMPOSE",
                      style: TextStyle(fontFamily: ("Montserrat")),
                    ),
                  ),
                  Tab(
                    child: Text(
                      "INBOX",
                      style: TextStyle(fontFamily: ("Montserrat")),
                    ),
                  ),
                  Tab(
                    child: Text(
                      "OUTBOX",
                      style: TextStyle(fontFamily: ("Montserrat")),
                    ),
                  ),
                ]),
          ),
          Container(
            //Add this to give height
            height: MediaQuery.of(context).size.height,
            child: TabBarView(children: [
              Container(
                child: Container(
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.start,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Card(
                        elevation: 6,
                        child: SizedBox(
                          width: 340,
                          child: Padding(
                            padding: const EdgeInsets.all(16.0),
                            child: Column(
                              children: [
                                SizedBox(
                                  height: 45,
                                  child: TextField(
                                    decoration: InputDecoration(
                                        border: OutlineInputBorder(),
                                        prefixIcon: Image.asset(
                                          'assets/images/profile_icon.png',
                                          alignment: Alignment.center,
                                          cacheHeight: 20,
                                          cacheWidth: 20,
                                          color: Colors.green,
                                        ),
                                        hintText: 'Admin',
                                        hintStyle:
                                            TextStyle(fontFamily: "Montserrat"),
                                        contentPadding:
                                            EdgeInsets.only(bottom: 5)),
                                    style: TextStyle(
                                      fontSize: 17,
                                    ),
                                  ),
                                ),
                                SizedBox(height: 16),
                                SizedBox(
                                  height: 45,
                                  child: TextField(
                                    decoration: InputDecoration(
                                        border: OutlineInputBorder(),
                                        prefixIcon: Image.asset(
                                            'assets/images/notification_icon.png',
                                            alignment: Alignment.center,
                                            cacheHeight: 20,
                                            cacheWidth: 20,
                                            color: Colors.green),
                                        hintText: 'Subject',
                                        hintStyle:
                                            TextStyle(fontFamily: "Montserrat"),
                                        contentPadding:
                                            EdgeInsets.only(bottom: 5)),
                                    style: TextStyle(
                                      fontSize: 17,
                                    ),
                                  ),
                                ),
                                SizedBox(height: 16),
                                Container(
                                  height: 160,
                                  padding: EdgeInsets.all(5),
                                  decoration: BoxDecoration(
                                    border: Border.all(
                                      color: Colors.grey,
                                    ),
                                    borderRadius: BorderRadius.circular(5),
                                  ),
                                  child: TextField(
                                    decoration: InputDecoration(
                                      hintText: '   Message',
                                      hintStyle:
                                          TextStyle(fontFamily: "Montserrat"),
                                      border: InputBorder.none,
                                    ),
                                    style: TextStyle(
                                      fontSize: 17,
                                    ),
                                  ),
                                ),
                                SizedBox(height: 16),
                                Row(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceEvenly,
                                  children: [
                                    ElevatedButton(
                                      onPressed: () {
                                        Navigator.push(
                                            context,
                                            MaterialPageRoute(
                                                builder:
                                                    (BuildContext context) =>
                                                        Wallet_n()));
                                      },
                                      style: ElevatedButton.styleFrom(
                                        primary: Colors
                                            .deepPurpleAccent, // Button color
                                        onPrimary: Colors.white, // Text color
                                      ),
                                      child: const SizedBox(
                                          width: 120,
                                          height: 45,
                                          child: Center(
                                            child: Text(
                                              'Send Message',
                                              style: TextStyle(
                                                fontSize: 16,
                                                fontFamily: "Montserrat",
                                              ),
                                            ),
                                          )),
                                    ),
                                    SizedBox(
                                      width: 4,
                                    ),
                                    ElevatedButton(
                                      onPressed: () {
                                        /*  Navigator.push(
                                            context,
                                            MaterialPageRoute(
                                                builder:
                                                    (BuildContext context) =>
                                                        WithdrawList()));*/
                                      },
                                      style: ElevatedButton.styleFrom(
                                        primary: Colors.green, // Button color
                                        onPrimary: Colors.white, // Text color
                                      ),
                                      child: SizedBox(
                                          width: 120,
                                          height: 45,
                                          child: Center(
                                            child: Text(
                                              'Cancel',
                                              style: TextStyle(
                                                fontSize: 16,
                                                fontFamily: "Montserrat",
                                              ),
                                            ),
                                          )),
                                    ),
                                  ],
                                ),
                              ],
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
              Container(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.start,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Card(
                        margin: EdgeInsets.only(right: 10, left: 10, top: 15),
                        elevation: 5,
                        color: Colors.white,
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Container(
                              padding: EdgeInsets.all(10),
                              child: Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                children: [
                                  Image(
                                    image: AssetImage(
                                      "assets/images/chat.png",
                                    ),
                                    width: 70,
                                    height: 40,
                                    color: Colors.red,
                                  ),
                                  Column(
                                    mainAxisAlignment: MainAxisAlignment.start,
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: [
                                      Text("Sender: Jenifer Aniston",
                                          textAlign: TextAlign.end,
                                          //Text(snapshot.data![index].username,
                                          style: TextStyle(
                                              fontFamily: "Montserrat",
                                              fontSize: 14,
                                              fontWeight: FontWeight.bold)),
                                      SizedBox(
                                        width: 100,
                                      ),
                                      SizedBox(
                                        height: 4,
                                      ),
                                      Row(
                                        children: [
                                          Text(
                                            "Sub",
                                            textAlign: TextAlign.center,
                                            // Text(snapshot.data![index].message,
                                            style: TextStyle(
                                                fontFamily: "Montserrat",
                                                fontSize: 14,
                                                fontWeight: FontWeight.normal),
                                          ),
                                        ],
                                      ),
                                      SizedBox(
                                        height: 4.5,
                                      ),
                                      Row(
                                        children: [
                                          Text('Test Message',
                                              style: TextStyle(fontSize: 13)),
                                          SizedBox(
                                            width: 30,
                                          ),
                                          Image.asset(
                                            "assets/images/tickiconpng.png",
                                            cacheWidth: 15,
                                            cacheHeight: 15,
                                          ),
                                          Text(
                                              textAlign: TextAlign.end,
                                              "27/01/2019;4:40 PM",
                                              //Text(snapshot.data![index].username,
                                              style: TextStyle(
                                                  fontFamily: "Montserrat",
                                                  fontSize: 12,
                                                  color: Colors.green,
                                                  fontWeight: FontWeight.bold)),
                                          SizedBox(
                                            height: 19,
                                          )
                                        ],
                                      ),
                                    ],
                                  ),
                                ],
                              ),
                            ),
                          ],
                        )),
                    Card(
                        margin: EdgeInsets.only(right: 10, left: 10, top: 15),
                        elevation: 5,
                        color: Colors.white,
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Container(
                              padding: EdgeInsets.all(10),
                              child: Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                children: [
                                  Image(
                                    image: AssetImage(
                                      "assets/images/chat.png",
                                    ),
                                    width: 70,
                                    height: 40,
                                    color: Colors.red,
                                  ),
                                  Column(
                                    mainAxisAlignment: MainAxisAlignment.start,
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: [
                                      Text("Sender: Jenifer Aniston",
                                          textAlign: TextAlign.end,
                                          //Text(snapshot.data![index].username,
                                          style: TextStyle(
                                              fontFamily: "Montserrat",
                                              fontSize: 14,
                                              fontWeight: FontWeight.bold)),
                                      SizedBox(
                                        width: 100,
                                      ),
                                      SizedBox(
                                        height: 4,
                                      ),
                                      Row(
                                        children: [
                                          Text(
                                            "Sub",
                                            textAlign: TextAlign.center,
                                            // Text(snapshot.data![index].message,
                                            style: TextStyle(
                                                fontFamily: "Montserrat",
                                                fontSize: 14,
                                                fontWeight: FontWeight.normal),
                                          ),
                                        ],
                                      ),
                                      SizedBox(
                                        height: 4.5,
                                      ),
                                      Row(
                                        children: [
                                          Text('Test Message',
                                              style: TextStyle(fontSize: 13)),
                                          SizedBox(
                                            width: 30,
                                          ),
                                          Image.asset(
                                            "assets/images/tickiconpng.png",
                                            cacheWidth: 15,
                                            cacheHeight: 15,
                                          ),
                                          Text(
                                              textAlign: TextAlign.end,
                                              "27/01/2019;4:40 PM",
                                              //Text(snapshot.data![index].username,
                                              style: TextStyle(
                                                  fontFamily: "Montserrat",
                                                  fontSize: 12,
                                                  color: Colors.green,
                                                  fontWeight: FontWeight.bold)),
                                          SizedBox(
                                            height: 19,
                                          )
                                        ],
                                      ),
                                    ],
                                  ),
                                ],
                              ),
                            ),
                          ],
                        )),
                    Card(
                        margin: EdgeInsets.only(right: 10, left: 10, top: 15),
                        elevation: 5,
                        color: Colors.white,
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Container(
                              padding: EdgeInsets.all(10),
                              child: Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                children: [
                                  Image(
                                    image: AssetImage(
                                      "assets/images/chat.png",
                                    ),
                                    width: 70,
                                    height: 40,
                                    color: Colors.red,
                                  ),
                                  Column(
                                    mainAxisAlignment: MainAxisAlignment.start,
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: [
                                      Text("Sender: Jenifer Aniston",
                                          textAlign: TextAlign.end,
                                          //Text(snapshot.data![index].username,
                                          style: TextStyle(
                                              fontFamily: "Montserrat",
                                              fontSize: 14,
                                              fontWeight: FontWeight.bold)),
                                      SizedBox(
                                        width: 100,
                                      ),
                                      SizedBox(
                                        height: 4,
                                      ),
                                      Row(
                                        children: [
                                          Text(
                                            "Sub",
                                            textAlign: TextAlign.center,
                                            // Text(snapshot.data![index].message,
                                            style: TextStyle(
                                                fontFamily: "Montserrat",
                                                fontSize: 14,
                                                fontWeight: FontWeight.normal),
                                          ),
                                        ],
                                      ),
                                      SizedBox(
                                        height: 4.5,
                                      ),
                                      Row(
                                        children: [
                                          Text('Test Message',
                                              style: TextStyle(fontSize: 13)),
                                          SizedBox(
                                            width: 30,
                                          ),
                                          Image.asset(
                                            "assets/images/tickiconpng.png",
                                            cacheWidth: 15,
                                            cacheHeight: 15,
                                          ),
                                          Text(
                                              textAlign: TextAlign.end,
                                              "27/01/2019;4:40 PM",
                                              //Text(snapshot.data![index].username,
                                              style: TextStyle(
                                                  fontFamily: "Montserrat",
                                                  fontSize: 12,
                                                  color: Colors.green,
                                                  fontWeight: FontWeight.bold)),
                                          SizedBox(
                                            height: 19,
                                          )
                                        ],
                                      ),
                                    ],
                                  ),
                                ],
                              ),
                            ),
                          ],
                        )),
                    Card(
                        margin: EdgeInsets.only(right: 10, left: 10, top: 15),
                        elevation: 5,
                        color: Colors.white,
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Container(
                              padding: EdgeInsets.all(10),
                              child: Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                children: [
                                  Image(
                                    image: AssetImage(
                                      "assets/images/chat.png",
                                    ),
                                    width: 70,
                                    height: 40,
                                    color: Colors.red,
                                  ),
                                  Column(
                                    mainAxisAlignment: MainAxisAlignment.start,
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: [
                                      Text("Sender: Jenifer Aniston",
                                          textAlign: TextAlign.end,
                                          //Text(snapshot.data![index].username,
                                          style: TextStyle(
                                              fontFamily: "Montserrat",
                                              fontSize: 14,
                                              fontWeight: FontWeight.bold)),
                                      SizedBox(
                                        width: 100,
                                      ),
                                      SizedBox(
                                        height: 4,
                                      ),
                                      Row(
                                        children: [
                                          Text(
                                            "Sub",
                                            textAlign: TextAlign.center,
                                            // Text(snapshot.data![index].message,
                                            style: TextStyle(
                                                fontFamily: "Montserrat",
                                                fontSize: 14,
                                                fontWeight: FontWeight.normal),
                                          ),
                                        ],
                                      ),
                                      SizedBox(
                                        height: 4.5,
                                      ),
                                      Row(
                                        children: [
                                          Text('Test Message',
                                              style: TextStyle(fontSize: 13)),
                                          SizedBox(
                                            width: 30,
                                          ),
                                          Image.asset(
                                            "assets/images/tickiconpng.png",
                                            cacheWidth: 15,
                                            cacheHeight: 15,
                                          ),
                                          Text(
                                              textAlign: TextAlign.end,
                                              "27/01/2019;4:40 PM",
                                              //Text(snapshot.data![index].username,
                                              style: TextStyle(
                                                  fontFamily: "Montserrat",
                                                  fontSize: 12,
                                                  color: Colors.green,
                                                  fontWeight: FontWeight.bold)),
                                          SizedBox(
                                            height: 19,
                                          )
                                        ],
                                      ),
                                    ],
                                  ),
                                ],
                              ),
                            ),
                          ],
                        )),
                    Card(
                        margin: EdgeInsets.only(right: 10, left: 10, top: 15),
                        elevation: 5,
                        color: Colors.white,
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Container(
                              padding: EdgeInsets.all(10),
                              child: Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                children: [
                                  Image(
                                    image: AssetImage(
                                      "assets/images/chat.png",
                                    ),
                                    width: 70,
                                    height: 40,
                                    color: Colors.red,
                                  ),
                                  Column(
                                    mainAxisAlignment: MainAxisAlignment.start,
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: [
                                      Text("Sender: Jenifer Aniston",
                                          textAlign: TextAlign.end,
                                          //Text(snapshot.data![index].username,
                                          style: TextStyle(
                                              fontFamily: "Montserrat",
                                              fontSize: 14,
                                              fontWeight: FontWeight.bold)),
                                      SizedBox(
                                        width: 100,
                                      ),
                                      SizedBox(
                                        height: 4,
                                      ),
                                      Row(
                                        children: [
                                          Text(
                                            "Sub",
                                            textAlign: TextAlign.center,
                                            // Text(snapshot.data![index].message,
                                            style: TextStyle(
                                                fontFamily: "Montserrat",
                                                fontSize: 14,
                                                fontWeight: FontWeight.normal),
                                          ),
                                        ],
                                      ),
                                      SizedBox(
                                        height: 4.5,
                                      ),
                                      Row(
                                        children: [
                                          Text('Test Message',
                                              style: TextStyle(fontSize: 13)),
                                          SizedBox(
                                            width: 30,
                                          ),
                                          Image.asset(
                                            "assets/images/tickiconpng.png",
                                            cacheWidth: 15,
                                            cacheHeight: 15,
                                          ),
                                          Text(
                                              textAlign: TextAlign.end,
                                              "27/01/2019;4:40 PM",
                                              //Text(snapshot.data![index].username,
                                              style: TextStyle(
                                                  fontFamily: "Montserrat",
                                                  fontSize: 12,
                                                  color: Colors.green,
                                                  fontWeight: FontWeight.bold)),
                                          SizedBox(
                                            height: 19,
                                          )
                                        ],
                                      ),
                                    ],
                                  ),
                                ],
                              ),
                            ),
                          ],
                        )),
                    Card(
                        margin: EdgeInsets.only(right: 10, left: 10, top: 15),
                        elevation: 5,
                        color: Colors.white,
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Container(
                              padding: EdgeInsets.all(10),
                              child: Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                children: [
                                  Image(
                                    image: AssetImage(
                                      "assets/images/chat.png",
                                    ),
                                    width: 70,
                                    height: 40,
                                    color: Colors.red,
                                  ),
                                  Column(
                                    mainAxisAlignment: MainAxisAlignment.start,
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: [
                                      Text("Sender: Jenifer Aniston",
                                          textAlign: TextAlign.end,
                                          //Text(snapshot.data![index].username,
                                          style: TextStyle(
                                              fontFamily: "Montserrat",
                                              fontSize: 14,
                                              fontWeight: FontWeight.bold)),
                                      SizedBox(
                                        width: 100,
                                      ),
                                      SizedBox(
                                        height: 4,
                                      ),
                                      Row(
                                        children: [
                                          Text(
                                            "Sub",
                                            textAlign: TextAlign.center,
                                            // Text(snapshot.data![index].message,
                                            style: TextStyle(
                                                fontFamily: "Montserrat",
                                                fontSize: 14,
                                                fontWeight: FontWeight.normal),
                                          ),
                                        ],
                                      ),
                                      SizedBox(
                                        height: 4.5,
                                      ),
                                      Row(
                                        children: [
                                          Text('Test Message',
                                              style: TextStyle(fontSize: 13)),
                                          SizedBox(
                                            width: 30,
                                          ),
                                          Image.asset(
                                            "assets/images/tickiconpng.png",
                                            cacheWidth: 15,
                                            cacheHeight: 15,
                                          ),
                                          Text(
                                              textAlign: TextAlign.end,
                                              "27/01/2019;4:40 PM",
                                              //Text(snapshot.data![index].username,
                                              style: TextStyle(
                                                  fontFamily: "Montserrat",
                                                  fontSize: 12,
                                                  color: Colors.green,
                                                  fontWeight: FontWeight.bold)),
                                          SizedBox(
                                            height: 19,
                                          )
                                        ],
                                      ),
                                    ],
                                  ),
                                ],
                              ),
                            ),
                          ],
                        )),
                  ],
                ),
              ),
              Container(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.start,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Card(
                        margin: EdgeInsets.only(right: 10, left: 10, top: 15),
                        elevation: 5,
                        color: Colors.white,
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Container(
                              padding: EdgeInsets.all(10),
                              child: Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                children: [
                                  Image(
                                    image: AssetImage(
                                      "assets/images/chat.png",
                                    ),
                                    width: 70,
                                    height: 40,
                                    color: Colors.red,
                                  ),
                                  Column(
                                    mainAxisAlignment: MainAxisAlignment.start,
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: [
                                      Text("Sender: Jenifer Aniston",
                                          textAlign: TextAlign.end,
                                          //Text(snapshot.data![index].username,
                                          style: TextStyle(
                                              fontFamily: "Montserrat",
                                              fontSize: 14,
                                              fontWeight: FontWeight.bold)),
                                      SizedBox(
                                        width: 100,
                                      ),
                                      SizedBox(
                                        height: 4,
                                      ),
                                      Row(
                                        children: [
                                          Text(
                                            "Sub",
                                            textAlign: TextAlign.center,
                                            // Text(snapshot.data![index].message,
                                            style: TextStyle(
                                                fontFamily: "Montserrat",
                                                fontSize: 14,
                                                fontWeight: FontWeight.normal),
                                          ),
                                        ],
                                      ),
                                      SizedBox(
                                        height: 4.5,
                                      ),
                                      Row(
                                        children: [
                                          Text('Test Message',
                                              style: TextStyle(fontSize: 13)),
                                          SizedBox(
                                            width: 30,
                                          ),
                                          Image.asset(
                                            "assets/images/tickiconpng.png",
                                            cacheWidth: 15,
                                            cacheHeight: 15,
                                          ),
                                          Text(
                                              textAlign: TextAlign.end,
                                              "27/01/2019;4:40 PM",
                                              //Text(snapshot.data![index].username,
                                              style: TextStyle(
                                                  fontFamily: "Montserrat",
                                                  fontSize: 12,
                                                  color: Colors.green,
                                                  fontWeight: FontWeight.bold)),
                                          SizedBox(
                                            height: 19,
                                          )
                                        ],
                                      ),
                                    ],
                                  ),
                                ],
                              ),
                            ),
                          ],
                        )),
                    Card(
                        margin: EdgeInsets.only(right: 10, left: 10, top: 15),
                        elevation: 5,
                        color: Colors.white,
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Container(
                              padding: EdgeInsets.all(10),
                              child: Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                children: [
                                  Image(
                                    image: AssetImage(
                                      "assets/images/chat.png",
                                    ),
                                    width: 70,
                                    height: 40,
                                    color: Colors.red,
                                  ),
                                  Column(
                                    mainAxisAlignment: MainAxisAlignment.start,
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: [
                                      Text("Sender: Jenifer Aniston",
                                          textAlign: TextAlign.end,
                                          //Text(snapshot.data![index].username,
                                          style: TextStyle(
                                              fontFamily: "Montserrat",
                                              fontSize: 14,
                                              fontWeight: FontWeight.bold)),
                                      SizedBox(
                                        width: 100,
                                      ),
                                      SizedBox(
                                        height: 4,
                                      ),
                                      Row(
                                        children: [
                                          Text(
                                            "Sub",
                                            textAlign: TextAlign.center,
                                            // Text(snapshot.data![index].message,
                                            style: TextStyle(
                                                fontFamily: "Montserrat",
                                                fontSize: 14,
                                                fontWeight: FontWeight.normal),
                                          ),
                                        ],
                                      ),
                                      SizedBox(
                                        height: 4.5,
                                      ),
                                      Row(
                                        children: [
                                          Text('Test Message',
                                              style: TextStyle(fontSize: 13)),
                                          SizedBox(
                                            width: 30,
                                          ),
                                          Image.asset(
                                            "assets/images/tickiconpng.png",
                                            cacheWidth: 15,
                                            cacheHeight: 15,
                                          ),
                                          Text(
                                              textAlign: TextAlign.end,
                                              "27/01/2019;4:40 PM",
                                              //Text(snapshot.data![index].username,
                                              style: TextStyle(
                                                  fontFamily: "Montserrat",
                                                  fontSize: 12,
                                                  color: Colors.green,
                                                  fontWeight: FontWeight.bold)),
                                          SizedBox(
                                            height: 19,
                                          )
                                        ],
                                      ),
                                    ],
                                  ),
                                ],
                              ),
                            ),
                          ],
                        )),
                    Card(
                        margin: EdgeInsets.only(right: 10, left: 10, top: 15),
                        elevation: 5,
                        color: Colors.white,
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Container(
                              padding: EdgeInsets.all(10),
                              child: Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                children: [
                                  Image(
                                    image: AssetImage(
                                      "assets/images/chat.png",
                                    ),
                                    width: 70,
                                    height: 40,
                                    color: Colors.red,
                                  ),
                                  Column(
                                    mainAxisAlignment: MainAxisAlignment.start,
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: [
                                      Text("Sender: Jenifer Aniston",
                                          textAlign: TextAlign.end,
                                          //Text(snapshot.data![index].username,
                                          style: TextStyle(
                                              fontFamily: "Montserrat",
                                              fontSize: 14,
                                              fontWeight: FontWeight.bold)),
                                      SizedBox(
                                        width: 100,
                                      ),
                                      SizedBox(
                                        height: 4,
                                      ),
                                      Row(
                                        children: [
                                          Text(
                                            "Sub",
                                            textAlign: TextAlign.center,
                                            // Text(snapshot.data![index].message,
                                            style: TextStyle(
                                                fontFamily: "Montserrat",
                                                fontSize: 14,
                                                fontWeight: FontWeight.normal),
                                          ),
                                        ],
                                      ),
                                      SizedBox(
                                        height: 4.5,
                                      ),
                                      Row(
                                        children: [
                                          Text('Test Message',
                                              style: TextStyle(fontSize: 13)),
                                          SizedBox(
                                            width: 30,
                                          ),
                                          Image.asset(
                                            "assets/images/tickiconpng.png",
                                            cacheWidth: 15,
                                            cacheHeight: 15,
                                          ),
                                          Text(
                                              textAlign: TextAlign.end,
                                              "27/01/2019;4:40 PM",
                                              //Text(snapshot.data![index].username,
                                              style: TextStyle(
                                                  fontFamily: "Montserrat",
                                                  fontSize: 12,
                                                  color: Colors.green,
                                                  fontWeight: FontWeight.bold)),
                                          SizedBox(
                                            height: 19,
                                          )
                                        ],
                                      ),
                                    ],
                                  ),
                                ],
                              ),
                            ),
                          ],
                        )),
                    Card(
                        margin: EdgeInsets.only(right: 10, left: 10, top: 15),
                        elevation: 5,
                        color: Colors.white,
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Container(
                              padding: EdgeInsets.all(10),
                              child: Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                children: [
                                  Image(
                                    image: AssetImage(
                                      "assets/images/chat.png",
                                    ),
                                    width: 70,
                                    height: 40,
                                    color: Colors.red,
                                  ),
                                  Column(
                                    mainAxisAlignment: MainAxisAlignment.start,
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: [
                                      Text("Sender: Jenifer Aniston",
                                          textAlign: TextAlign.end,
                                          //Text(snapshot.data![index].username,
                                          style: TextStyle(
                                              fontFamily: "Montserrat",
                                              fontSize: 14,
                                              fontWeight: FontWeight.bold)),
                                      SizedBox(
                                        width: 100,
                                      ),
                                      SizedBox(
                                        height: 4,
                                      ),
                                      Row(
                                        children: [
                                          Text(
                                            "Sub",
                                            textAlign: TextAlign.center,
                                            // Text(snapshot.data![index].message,
                                            style: TextStyle(
                                                fontFamily: "Montserrat",
                                                fontSize: 14,
                                                fontWeight: FontWeight.normal),
                                          ),
                                        ],
                                      ),
                                      SizedBox(
                                        height: 4.5,
                                      ),
                                      Row(
                                        children: [
                                          Text('Test Message',
                                              style: TextStyle(fontSize: 13)),
                                          SizedBox(
                                            width: 30,
                                          ),
                                          Image.asset(
                                            "assets/images/tickiconpng.png",
                                            cacheWidth: 15,
                                            cacheHeight: 15,
                                          ),
                                          Text(
                                              textAlign: TextAlign.end,
                                              "27/01/2019;4:40 PM",
                                              //Text(snapshot.data![index].username,
                                              style: TextStyle(
                                                  fontFamily: "Montserrat",
                                                  fontSize: 12,
                                                  color: Colors.green,
                                                  fontWeight: FontWeight.bold)),
                                          SizedBox(
                                            height: 19,
                                          )
                                        ],
                                      ),
                                    ],
                                  ),
                                ],
                              ),
                            ),
                          ],
                        )),
                    Card(
                        margin: EdgeInsets.only(right: 10, left: 10, top: 15),
                        elevation: 5,
                        color: Colors.white,
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Container(
                              padding: EdgeInsets.all(10),
                              child: Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                children: [
                                  Image(
                                    image: AssetImage(
                                      "assets/images/chat.png",
                                    ),
                                    width: 70,
                                    height: 40,
                                    color: Colors.red,
                                  ),
                                  Column(
                                    mainAxisAlignment: MainAxisAlignment.start,
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: [
                                      Text("Sender: Jenifer Aniston",
                                          textAlign: TextAlign.end,
                                          //Text(snapshot.data![index].username,
                                          style: TextStyle(
                                              fontFamily: "Montserrat",
                                              fontSize: 14,
                                              fontWeight: FontWeight.bold)),
                                      SizedBox(
                                        width: 100,
                                      ),
                                      SizedBox(
                                        height: 4,
                                      ),
                                      Row(
                                        children: [
                                          Text(
                                            "Sub",
                                            textAlign: TextAlign.center,
                                            // Text(snapshot.data![index].message,
                                            style: TextStyle(
                                                fontFamily: "Montserrat",
                                                fontSize: 14,
                                                fontWeight: FontWeight.normal),
                                          ),
                                        ],
                                      ),
                                      SizedBox(
                                        height: 4.5,
                                      ),
                                      Row(
                                        children: [
                                          Text('Test Message',
                                              style: TextStyle(fontSize: 13)),
                                          SizedBox(
                                            width: 30,
                                          ),
                                          Image.asset(
                                            "assets/images/tickiconpng.png",
                                            cacheWidth: 15,
                                            cacheHeight: 15,
                                          ),
                                          Text(
                                              textAlign: TextAlign.end,
                                              "27/01/2019;4:40 PM",
                                              //Text(snapshot.data![index].username,
                                              style: TextStyle(
                                                  fontFamily: "Montserrat",
                                                  fontSize: 12,
                                                  color: Colors.green,
                                                  fontWeight: FontWeight.bold)),
                                          SizedBox(
                                            height: 19,
                                          )
                                        ],
                                      ),
                                    ],
                                  ),
                                ],
                              ),
                            ),
                          ],
                        )),
                    Card(
                        margin: EdgeInsets.only(right: 10, left: 10, top: 15),
                        elevation: 5,
                        color: Colors.white,
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Container(
                              padding: EdgeInsets.all(10),
                              child: Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                children: [
                                  Image(
                                    image: AssetImage(
                                      "assets/images/chat.png",
                                    ),
                                    width: 70,
                                    height: 40,
                                    color: Colors.red,
                                  ),
                                  Column(
                                    mainAxisAlignment: MainAxisAlignment.start,
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: [
                                      Text("Sender: Jenifer Aniston",
                                          textAlign: TextAlign.end,
                                          //Text(snapshot.data![index].username,
                                          style: TextStyle(
                                              fontFamily: "Montserrat",
                                              fontSize: 14,
                                              fontWeight: FontWeight.bold)),
                                      SizedBox(
                                        width: 100,
                                      ),
                                      SizedBox(
                                        height: 4,
                                      ),
                                      Row(
                                        children: [
                                          Text(
                                            "Sub",
                                            textAlign: TextAlign.center,
                                            // Text(snapshot.data![index].message,
                                            style: TextStyle(
                                                fontFamily: "Montserrat",
                                                fontSize: 14,
                                                fontWeight: FontWeight.normal),
                                          ),
                                        ],
                                      ),
                                      SizedBox(
                                        height: 4.5,
                                      ),
                                      Row(
                                        children: [
                                          Text('Test Message',
                                              style: TextStyle(fontSize: 13)),
                                          SizedBox(
                                            width: 30,
                                          ),
                                          Image.asset(
                                            "assets/images/tickiconpng.png",
                                            cacheWidth: 15,
                                            cacheHeight: 15,
                                          ),
                                          Text(
                                              textAlign: TextAlign.end,
                                              "27/01/2019;4:40 PM",
                                              //Text(snapshot.data![index].username,
                                              style: TextStyle(
                                                  fontFamily: "Montserrat",
                                                  fontSize: 12,
                                                  color: Colors.green,
                                                  fontWeight: FontWeight.bold)),
                                          SizedBox(
                                            height: 19,
                                          )
                                        ],
                                      ),
                                    ],
                                  ),
                                ],
                              ),
                            ),
                          ],
                        )),
                  ],
                ),
              ),
            ]),
          ),
        ],
      ),
    );
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
          'Withdraw List',
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
          children: [
            _tabSection(context),
          ],
        ),
      ),
    ));
  }
}
