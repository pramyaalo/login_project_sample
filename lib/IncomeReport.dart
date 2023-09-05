import 'package:flutter/material.dart';
import 'package:login_project_sample/CashWalletHistory.dart';
import 'package:login_project_sample/DirectIncomeReport.dart';
import 'package:login_project_sample/FranchiseIncome.dart';
import 'package:login_project_sample/Franchise_Monthly_Report.dart';
import 'package:login_project_sample/Franchise_Refferal_Report.dart';
import 'package:login_project_sample/PayoutHistory.dart';
import 'package:login_project_sample/PairIncomeBonusReport.dart';
import 'package:login_project_sample/Payouts.dart';

class IncomeReport extends StatefulWidget {
  @override
  State<IncomeReport> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<IncomeReport> {
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
          'Income Report',
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
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Padding(
                  padding: const EdgeInsets.only(top: 5),
                  child: Card(
                    elevation: 4,
                    child: Padding(
                      padding: const EdgeInsets.all(16.0),
                      child: Column(
                        children: [
                          Image.asset(
                            "assets/images/rupee.png",
                            height: 40,
                            width: 40,
                            color: Colors.green,
                          ),
                          SizedBox(height: 8),
                          SizedBox(
                            width: 280,
                            child: Text('₹100.00',
                                textAlign: TextAlign.center,
                                style: TextStyle(
                                    fontWeight: FontWeight.bold, fontSize: 20)),
                          ),
                          SizedBox(height: 8),
                          SizedBox(
                            width: 310,
                            child: Text('Available E - Wallet Balance',
                                textAlign: TextAlign.center,
                                style: TextStyle(fontSize: 13)),
                          ),
                        ],
                      ),
                    ),
                  ),
                ),
              ],
            ),
            SizedBox(
              height: 8,
            ),
            Column(
              children: [
                Row(
                  children: [
                    Expanded(
                      child: Card(
                        color: Colors.blue, // Change color as needed
                        elevation: 2,
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(5.0),
                        ),
                        child: Container(
                          child: Column(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                Image.asset('assets/images/direct_income.png',
                                    color: Colors.white,
                                    cacheHeight: 40,
                                    cacheWidth: 40),
                                SizedBox(
                                  height: 4.5,
                                ),
                                GestureDetector(
                                    onTap: () {
                                      Navigator.push(
                                        context,
                                        MaterialPageRoute(
                                            builder: (context) =>
                                                DirectIncomeReport()),
                                      );
                                    },
                                    child: Text(
                                      'Direct Income',
                                      style: TextStyle(
                                          color: Colors.white,
                                          fontSize: 17,
                                          fontFamily: "Montserrat"),
                                    )),
                              ]),
                          height: 120,
                          // Card content for the first card
                        ),
                      ),
                    ),
                    SizedBox(width: 1.5), // Adjust spacing between cards
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
                                Image.asset('assets/images/bonus.png',
                                    color: Colors.white,
                                    cacheHeight: 40,
                                    cacheWidth: 40),
                                SizedBox(
                                  height: 4.5,
                                ),
                                GestureDetector(
                                    onTap: () {
                                      Navigator.push(
                                        context,
                                        MaterialPageRoute(
                                            builder: (context) =>
                                                PairIncomeBonusReport()),
                                      );
                                    },
                                    child: Text(
                                      'Pair Income Bonus',
                                      style: TextStyle(
                                          color: Colors.white,
                                          fontSize: 17,
                                          fontFamily: "Montserrat"),
                                    )),
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
                              Image.asset(
                                'assets/images/franchise.png',
                                cacheWidth: 40,
                                cacheHeight: 40,
                                color: Colors.white,
                              ),
                              SizedBox(height: 4.5),
                              GestureDetector(
                                onTap: () {
                                  Navigator.push(
                                    context,
                                    MaterialPageRoute(
                                        builder: (context) =>
                                            FranchiseIncome()),
                                  );
                                },
                                child: Text(
                                  'Franchise Income',
                                  style: TextStyle(
                                      color: Colors.white,
                                      fontSize: 17,
                                      fontFamily: "Montserrat"),
                                ),
                              )
                            ],
                          ),
                          // Card content for the third card
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
                              Image.asset(
                                'assets/images/franchise_report.png',
                                cacheHeight: 40,
                                cacheWidth: 40,
                                color: Colors.white,
                              ),
                              SizedBox(height: 4.5),
                              GestureDetector(
                                onTap: () {
                                  Navigator.push(
                                    context,
                                    MaterialPageRoute(
                                        builder: (context) =>
                                            FranchiseRefferelIncome()),
                                  );
                                },
                                child: Text(
                                  'Franchise Referral',
                                  style: TextStyle(
                                      color: Colors.white,
                                      fontSize: 17,
                                      fontFamily: "Montserrat"),
                                ),
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
                              Image.asset(
                                'assets/images/report.png',
                                cacheWidth: 40,
                                cacheHeight: 40,
                                color: Colors.white,
                              ),
                              SizedBox(height: 4.5),
                              Text(
                                'Pair Income Report',
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
                              Image.asset(
                                'assets/images/franchise_income.png',
                                cacheHeight: 40,
                                cacheWidth: 40,
                                color: Colors.white,
                              ),
                              SizedBox(height: 4.5),
                              GestureDetector(
                                onTap: () {
                                  Navigator.push(
                                    context,
                                    MaterialPageRoute(
                                        builder: (context) =>
                                            FranchiseMonthyIncome()),
                                  );
                                },
                                child: Text(
                                  'Franchise Monthly \n          Income',
                                  style: TextStyle(
                                      color: Colors.white,
                                      fontSize: 17,
                                      fontFamily: "Montserrat"),
                                ),
                              ),
                            ],
                          ),
                          // Card content for the fourth card
                        ),
                      ),
                    ),
                  ],
                ),
                // Add more rows with different background colors and card contents if needed
              ],
            )
          ],
        ),
      ),
    );
  }
}
