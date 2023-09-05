import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:login_project_sample/utils/shared_preferences.dart';

import 'package:pie_chart/pie_chart.dart';

void main() {
  runApp(Dashboard());
}

class Dashboard extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: DashboardScreen(),
    );
  }
}

class DashboardScreen extends StatefulWidget {
  @override
  _DashboardScreenState createState() => _DashboardScreenState();
}

class _DashboardScreenState extends State<DashboardScreen> {
  String? UserId;

  @override
  void initState() {
    super.initState();
    retrieveUsername();
  }

  void retrieveUsername() async {
    String? storedUserid = await Prefs.getStringValue(Prefs.PREFS_USER_ID);
    setState(() {
      UserId = storedUserid;
      print('Userid$UserId');
    });
  }

  int index = 0;
  final tabs = ["Home()", "BuyProducts()", " My Orders()", "Accounts()"];
  Map<String, double> dataMap = {
    "Food Items": 18.47,
    "Clothes": 17.70,
    "Technology": 4.25,
    "Cosmetics": 3.51,
    "Other": 2.83,
  };

  // Colors for each segment
  // of the pie chart
  List<Color> colorList = [
    const Color(0xffD95AF3),
    const Color(0xff3EE094),
    const Color(0xff3398F6),
    const Color(0xffFA4A42),
    const Color(0xffFE9539)
  ];

  // List of gradients for the
  // background of the pie chart
  final gradientList = <List<Color>>[
    [
      Color.fromRGBO(223, 250, 92, 1),
      Color.fromRGBO(129, 250, 112, 1),
    ],
    [
      Color.fromRGBO(129, 182, 205, 1),
      Color.fromRGBO(91, 253, 199, 1),
    ],
    [
      Color.fromRGBO(175, 63, 62, 1.0),
      Color.fromRGBO(254, 154, 92, 1),
    ]
  ];
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.white,
        leading: IconButton(
          icon: Icon(
            Icons.menu,
            color: Colors.black,
          ),
          onPressed: () {
            Navigator.pop(context);
          },
        ),
        title: Text(
          'Pios \nCS1000000',
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
      body: Text("index"),
      bottomNavigationBar: BottomNavigationBar(
        currentIndex: index,
        type: BottomNavigationBarType.fixed,
        unselectedLabelStyle: const TextStyle(fontFamily: "Montserrat"),
        selectedLabelStyle: const TextStyle(fontFamily: "Montserrat"),
        items: const [
          BottomNavigationBarItem(
            icon: Icon(Icons.home),
            label: "Home",
          ),
          BottomNavigationBarItem(
              icon: Icon(Icons.shopping_cart), label: "But Products"),
          BottomNavigationBarItem(
              icon: Icon(Icons.shopping_bag), label: "My Orders"),
          BottomNavigationBarItem(
              icon: Icon(Icons.account_circle), label: "Accounts"),
        ],
        onTap: (current_index) {
          setState(() {
            index = current_index;
          });
        },
      ),
      drawer: Drawer(
        child: SingleChildScrollView(
          child: Column(
            children: [
              Container(
                padding: EdgeInsets.all(16),
                height: 150,
                color: Colors.green,
                child: Row(
                  children: [
                    CircleAvatar(
                      backgroundImage: AssetImage(
                        'assets/images/blankprofile.webp',
                      ),
                      radius: 40.0,
                    ),
                    SizedBox(width: 16.0),
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Row(
                          children: [
                            Text(
                              'John Doe',
                              style: TextStyle(
                                  fontSize: 17.0,
                                  fontWeight: FontWeight.bold,
                                  color: Colors.white),
                            ),
                            SizedBox(width: 90.0),
                            Text('Available',
                                style: TextStyle(
                                    fontWeight: FontWeight.bold,
                                    fontSize: 15,
                                    color: Colors.white)),
                          ],
                        ),
                        SizedBox(height: 8.0),
                        Row(
                          children: [
                            Text(
                              'CS1000000',
                              style: TextStyle(
                                  color: Colors.white,
                                  fontSize: 18.0,
                                  fontWeight: FontWeight.bold),
                            ),
                            SizedBox(width: 70.0),
                            Text('₹0.00',
                                style: TextStyle(
                                    color: Colors.white,
                                    fontWeight: FontWeight.bold,
                                    fontSize: 22)),
                          ],
                        ),
                        SizedBox(height: 8.0),
                        Row(
                          children: [
                            Container(
                              height: 25,
                              width: 58,
                              child: ElevatedButton(
                                  onPressed: () {},
                                  style: ElevatedButton.styleFrom(
                                    primary: Colors.white, // Button color
                                    onPrimary: Colors.white,
                                    shape: RoundedRectangleBorder(
                                      borderRadius: BorderRadius.circular(
                                          10.0), // Change radius here
                                    ), // Text color
                                  ),
                                  child: Center(
                                    child: Text(
                                      'EDIT',
                                      style: TextStyle(
                                          fontSize: 12, color: Colors.green),
                                    ),
                                  )),
                            ),
                          ],
                        ),
                      ],
                    ),
                    /*  Spacer(),
            ElevatedButton(
              onPressed: () {
                // Handle Edit Button click
              },
              child: Text('Edit'),
            ),*/
                  ],
                ),
              ),
              SizedBox(
                height: 12,
              ),
              Row(
                children: [
                  SizedBox(
                    width: 20,
                  ),
                  Column(
                    children: [
                      Image.asset(
                        'assets/images/withdraw2.png',
                        cacheHeight: 65,
                        cacheWidth: 65,
                      ),
                      Text('WithDraw')
                    ],
                  ),
                  SizedBox(
                    height: 150,
                    child: PieChart(
                      dataMap: {
                        'Red': 5,
                        'Green': 5,
                      },
                      colorList: [Colors.red, Colors.green],
                      chartRadius: MediaQuery.of(context).size.width / 2,
                      centerText: "Chart",
                      ringStrokeWidth: 24,
                      animationDuration: Duration(seconds: 2),
                      chartValuesOptions: ChartValuesOptions(
                        showChartValues: true,
                        showChartValuesOutside: true,
                        showChartValuesInPercentage: true,
                        showChartValueBackground: false,
                      ),
                    ),
                  ),
                  Column(
                    children: [
                      Image.asset(
                        'assets/images/transfer.png',
                        cacheHeight: 65,
                        cacheWidth: 65,
                      ),
                      Text('Transfer')
                    ],
                  ),
                ],
              ),
              SizedBox(
                height: 12,
              ),
              Align(
                alignment: Alignment.topLeft,
                child: Text(
                  '   Notification',
                  style: TextStyle(color: Colors.blue, fontSize: 18),
                ),
              ),
              SizedBox(
                height: 12,
              ),
              Column(
                children: [
                  Row(
                    children: [
                      Expanded(
                        child: Card(
                          color: Colors.green, // Change color as needed
                          elevation: 2,
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(5.0),
                          ),
                          child: Container(
                            child: Column(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  Text(
                                    '₹0.00',
                                    style: TextStyle(
                                        color: Colors.white,
                                        fontSize: 17,
                                        fontFamily: "Montserrat"),
                                  ),
                                  SizedBox(
                                    height: 4.5,
                                  ),
                                  Text(
                                    'Total Earning',
                                    style: TextStyle(
                                        color: Colors.white,
                                        fontSize: 17,
                                        fontFamily: "Montserrat"),
                                  )
                                ]),
                            height: 120,
                            // Card content for the first card
                          ),
                        ),
                      ),
                      SizedBox(width: 1.5), // Adjust spacing between cards
                      Expanded(
                        child: Card(
                          color: Color(0xFF1DAD9F), // Change color as needed
                          elevation: 2,
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(5.0),
                          ),
                          child: Container(
                            height: 120,
                            child: Column(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  Text(
                                    '₹0.00',
                                    style: TextStyle(
                                        color: Colors.white,
                                        fontSize: 17,
                                        fontFamily: "Montserrat"),
                                  ),
                                  SizedBox(
                                    height: 4.5,
                                  ),
                                  Text(
                                    'QuKart Cash',
                                    style: TextStyle(
                                        color: Colors.white,
                                        fontSize: 17,
                                        fontFamily: "Montserrat"),
                                  )
                                ]),
                            // Card content for the second card
                          ),
                        ),
                      ),
                    ],
                  ),
                  SizedBox(height: 5), // Adjust spacing between rows
                  Row(
                    children: [
                      Expanded(
                        child: Card(
                          color: Colors.lightBlue, // Change color as needed
                          elevation: 2,
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(5.0),
                          ),

                          child: Container(
                            height: 120,
                            child: Column(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                Text(
                                  '₹0.00',
                                  style: TextStyle(
                                      color: Colors.white,
                                      fontSize: 17,
                                      fontFamily: "Montserrat"),
                                ),
                                SizedBox(height: 4.5),
                                Text(
                                  'Fund Wallet',
                                  style: TextStyle(
                                      color: Colors.white,
                                      fontSize: 17,
                                      fontFamily: "Montserrat"),
                                ),
                              ],
                            ),
                            // Card content for the third card
                          ),
                        ),
                      ),
                      SizedBox(width: 1.5), // Adjust spacing between cards
                      Expanded(
                        child: Card(
                          color: Color(0xFFF8709D), // Change color as needed
                          elevation: 2,
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(5.0),
                          ),
                          child: Container(
                            height: 120,
                            child: Column(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                Text(
                                  '₹0.00',
                                  style: TextStyle(
                                      color: Colors.white,
                                      fontSize: 17,
                                      fontFamily: "Montserrat"),
                                ),
                                SizedBox(height: 4.5),
                                Text(
                                  'Total Withdrawals',
                                  style: TextStyle(
                                      color: Colors.white,
                                      fontSize: 17,
                                      fontFamily: "Montserrat"),
                                ),
                              ],
                            ),
                            // Card content for the fourth card
                          ),
                        ),
                      ),
                    ],
                  ),
                  SizedBox(height: 5),
                  Row(
                    children: [
                      Expanded(
                        child: Card(
                          color: Color(0xFF566DF1), // Change color as needed
                          elevation: 2,
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(5.0),
                          ),

                          child: Container(
                            height: 120,
                            child: Column(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                Text(
                                  '₹0.00',
                                  style: TextStyle(
                                      color: Colors.white,
                                      fontSize: 17,
                                      fontFamily: "Montserrat"),
                                ),
                                SizedBox(height: 4.5),
                                Text(
                                  'Fund Transferred',
                                  style: TextStyle(
                                      color: Colors.white,
                                      fontSize: 17,
                                      fontFamily: "Montserrat"),
                                ),
                              ],
                            ),
                            // Card content for the third card
                          ),
                        ),
                      ),
                      SizedBox(width: 1.5), // Adjust spacing between cards
                      Expanded(
                        child: Card(
                          color:
                              Colors.deepPurpleAccent, // Change color as needed
                          elevation: 2,
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(5.0),
                          ),
                          child: Container(
                            height: 120,
                            child: Column(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                Text(
                                  '₹0.00',
                                  style: TextStyle(
                                      color: Colors.white,
                                      fontSize: 17,
                                      fontFamily: "Montserrat"),
                                ),
                                SizedBox(height: 4.5),
                                Text(
                                  'Fund Received',
                                  style: TextStyle(
                                      color: Colors.white,
                                      fontSize: 17,
                                      fontFamily: "Montserrat"),
                                ),
                              ],
                            ),
                            // Card content for the fourth card
                          ),
                        ),
                      ),
                    ],
                  ),
                  SizedBox(height: 5),
                  Row(
                    children: [
                      Expanded(
                        child: Card(
                          color: Color(0xFFF07E01), // Change color as needed
                          elevation: 2,
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(5.0),
                          ),

                          child: Container(
                            height: 120,
                            child: Column(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                SizedBox(height: 4.5),
                                Text(
                                  'Total Orders',
                                  style: TextStyle(
                                      color: Colors.white,
                                      fontSize: 17,
                                      fontFamily: "Montserrat"),
                                ),
                              ],
                            ),
                            // Card content for the third card
                          ),
                        ),
                      ),
                      // Add more rows with different background colors and card contents if needed
                    ],
                  ),
                  SizedBox(height: 5),
                  Row(
                    children: [
                      Expanded(
                        child: Card(
                          color: Color(0xFF1DAD9F), // Change color as needed
                          elevation: 2,
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(5.0),
                          ),

                          child: Container(
                            height: 120,
                            child: Column(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                Text(
                                  '0',
                                  style: TextStyle(
                                      color: Colors.white,
                                      fontSize: 17,
                                      fontFamily: "Montserrat"),
                                ),
                                SizedBox(height: 4.5),
                                Text(
                                  'New Orders',
                                  style: TextStyle(
                                      color: Colors.white,
                                      fontSize: 17,
                                      fontFamily: "Montserrat"),
                                ),
                              ],
                            ),
                            // Card content for the third card
                          ),
                        ),
                      ),
                      SizedBox(width: 1.5), // Adjust spacing between cards
                      Expanded(
                        child: Card(
                          color: Color(0xFFF8709D), // Change color as needed
                          elevation: 2,
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(5.0),
                          ),
                          child: Container(
                            height: 120,
                            child: Column(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                Text(
                                  '0',
                                  style: TextStyle(
                                      color: Colors.white,
                                      fontSize: 17,
                                      fontFamily: "Montserrat"),
                                ),
                                SizedBox(height: 4.5),
                                Text(
                                  'Completed Orders',
                                  style: TextStyle(
                                      color: Colors.white,
                                      fontSize: 17,
                                      fontFamily: "Montserrat"),
                                ),
                              ],
                            ),
                            // Card content for the fourth card
                          ),
                        ),
                      ),
                    ],
                  ),
                  SizedBox(height: 5),
                  Row(
                    children: [
                      Expanded(
                        child: Card(
                          color:
                              Colors.deepPurpleAccent, // Change color as needed
                          elevation: 2,
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(5.0),
                          ),

                          child: Container(
                            height: 120,
                            child: Column(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                Text(
                                  'KYC Status',
                                  style: TextStyle(
                                      color: Colors.white,
                                      fontSize: 15,
                                      fontFamily: "Montserrat"),
                                ),
                                SizedBox(height: 7.5),
                                Row(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  children: [
                                    Image.asset(
                                      'assets/images/greentick.png',
                                      cacheHeight: 20,
                                      cacheWidth: 20,
                                    ),
                                    Text(
                                      'Approved',
                                      style: TextStyle(
                                          color: Colors.white,
                                          fontSize: 17,
                                          fontFamily: "Montserrat"),
                                    ),
                                  ],
                                ),
                              ],
                            ),
                            // Card content for the third card
                          ),
                        ),
                      ),
                      SizedBox(width: 1.5), // Adjust spacing between cards
                      Expanded(
                        child: Card(
                          color: Color(0xFF566DF1), // Change color as needed
                          elevation: 2,
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(5.0),
                          ),
                          child: Container(
                            height: 120,
                            child: Column(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                Text(
                                  '0',
                                  style: TextStyle(
                                      color: Colors.white,
                                      fontSize: 17,
                                      fontFamily: "Montserrat"),
                                ),
                                SizedBox(height: 4.5),
                                Text(
                                  'Direct Members',
                                  style: TextStyle(
                                      color: Colors.white,
                                      fontSize: 17,
                                      fontFamily: "Montserrat"),
                                ),
                              ],
                            ),
                            // Card content for the fourth card
                          ),
                        ),
                      ),
                    ],
                  ),
                  SizedBox(height: 5),
                  Row(
                    children: [
                      Expanded(
                        child: Card(
                          color: Colors.green, // Change color as needed
                          elevation: 2,
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(5.0),
                          ),

                          child: Container(
                            height: 120,
                            child: Column(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                Text(
                                  '0',
                                  style: TextStyle(
                                      color: Colors.white,
                                      fontSize: 17,
                                      fontFamily: "Montserrat"),
                                ),
                                SizedBox(height: 4.5),
                                Text(
                                  'Message Sent',
                                  style: TextStyle(
                                      color: Colors.white,
                                      fontSize: 17,
                                      fontFamily: "Montserrat"),
                                ),
                              ],
                            ),
                            // Card content for the third card
                          ),
                        ),
                      ),
                      SizedBox(width: 1.5), // Adjust spacing between cards
                      Expanded(
                        child: Card(
                          color: Colors.lightBlue, // Change color as needed
                          elevation: 2,
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(5.0),
                          ),
                          child: Container(
                            height: 120,
                            child: Column(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                Text(
                                  '0',
                                  style: TextStyle(
                                      color: Colors.white,
                                      fontSize: 17,
                                      fontFamily: "Montserrat"),
                                ),
                                SizedBox(height: 4.5),
                                Text(
                                  'Inbox Messages',
                                  style: TextStyle(
                                      color: Colors.white,
                                      fontSize: 17,
                                      fontFamily: "Montserrat"),
                                ),
                              ],
                            ),
                            // Card content for the fourth card
                          ),
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}
