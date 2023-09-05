import 'package:flutter/material.dart';

class NavDrawer extends StatefulWidget {
  const NavDrawer({Key? key}) : super(key: key);

  @override
  State<NavDrawer> createState() => _HomeContainerState();
}

class _HomeContainerState extends State<NavDrawer> {
  int index = 0;

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
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
                icon: Icon(Icons.flight_sharp), label: "Flights"),
            BottomNavigationBarItem(icon: Icon(Icons.hotel), label: "Hotels"),
            BottomNavigationBarItem(
                icon: Icon(Icons.car_rental), label: "Cabs"),
            BottomNavigationBarItem(
                icon: Icon(Icons.holiday_village), label: "Holidays"),
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
                UserAccountsDrawerHeader(
                  accountName: Text("Corp Admin",
                      style: TextStyle(fontFamily: "Montserrat")),
                  accountEmail: Text("corpadmin@email.com",
                      style: TextStyle(fontFamily: "Montserrat")),
                  decoration: BoxDecoration(color: Colors.blue),
                  currentAccountPicture: CircleAvatar(
                      backgroundColor: Colors.white,
                      child: Text("CA",
                          style: TextStyle(fontFamily: "Montserrat"))),
                ),

                Row(
                  children: [
                    SizedBox(
                      width: 15,
                    ),
                    Icon(Icons.home, color: Colors.black54),
                    SizedBox(
                        width: 8), // Add some spacing between the icon and text
                    Text('Home', style: TextStyle(fontFamily: "Montserrat")),
                  ],
                ),

                /*   ListTile(
                  onTap: () {
                    setState(() {
                      index = 0;
                    });
                    Navigator.pop(context);
                  },
                  leading: Icon(Icons.home),
                  title:
                      Text("Home", style: TextStyle(fontFamily: "Montserrat")),
                ),*/
                // ListTile(onTap: (){}, leading: Icon(Icons.book_online_outlined), title:  Text("Bookings", style: TextStyle(fontFamily: "Montserrat")),),
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    ExpansionTile(
                      title: const Row(
                        children: [
                          Icon(IconData(0xee5e, fontFamily: 'MaterialIcons')),
                          SizedBox(width: 8),
                          Text('Booking',
                              style: TextStyle(fontFamily: "Montserrat")),
                        ],
                      ),
                      children: [
                        Column(
                          children: [
                            ExpansionTile(
                              title: Row(
                                children: [
                                  SizedBox(width: 20),
                                  Text("Book Now",
                                      style:
                                          TextStyle(fontFamily: "Montserrat")),
                                ],
                              ),
                              children: [
                                SizedBox(width: 20),
                                Row(
                                  children: [
                                    SizedBox(width: 20),
                                    InkWell(
                                      child: Text("Flights",
                                          style: TextStyle(
                                              fontFamily: "Montserrat")),
                                      onTap: () {},
                                    ),
                                  ],
                                ),
                                SizedBox(
                                  width: 20,
                                  height: 17,
                                ),
                                Row(
                                  children: [
                                    SizedBox(width: 20),
                                    InkWell(
                                        child: Text("Hotels",
                                            style: TextStyle(
                                                fontFamily: "Montserrat")),
                                        onTap: () {}),
                                  ],
                                ),
                                SizedBox(
                                  width: 20,
                                  height: 17,
                                ),
                                Row(
                                  children: [
                                    SizedBox(width: 20),
                                    InkWell(
                                      child: Text("Cars",
                                          style: TextStyle(
                                              fontFamily: "Montserrat")),
                                      onTap: () {},
                                    ),
                                  ],
                                ),
                                SizedBox(
                                  width: 20,
                                  height: 17,
                                ),
                                Row(
                                  children: [
                                    SizedBox(width: 20),
                                    InkWell(
                                      child: Text("Holidays",
                                          style: TextStyle(
                                              fontFamily: "Montserrat")),
                                      onTap: () {},
                                    ),
                                  ],
                                ),
                                SizedBox(
                                  width: 20,
                                  height: 17,
                                ),
                                Row(
                                  children: [
                                    SizedBox(width: 20),
                                    InkWell(
                                      child: Text("Buses",
                                          style: TextStyle(
                                              fontFamily: "Montserrat")),
                                      onTap: () {},
                                    ),
                                  ],
                                ),
                                SizedBox(
                                  width: 20,
                                  height: 17,
                                ),
                              ],
                            ),
                            Row(
                              children: [
                                SizedBox(width: 20),
                                InkWell(
                                  child: Text("Booking card",
                                      style:
                                          TextStyle(fontFamily: "Montserrat")),
                                  onTap: () {},
                                ),
                              ],
                            ),
                            SizedBox(
                              width: 20,
                              height: 17,
                            ),
                            Row(
                              children: [
                                SizedBox(width: 20),
                                InkWell(
                                  child: Text("New Booking",
                                      style:
                                          TextStyle(fontFamily: "Montserrat")),
                                  onTap: () {},
                                ),
                              ],
                            ),
                            SizedBox(
                              width: 20,
                              height: 17,
                            ),
                            Row(
                              children: [
                                SizedBox(width: 20),
                                InkWell(
                                  child: Text("Open Booking",
                                      style:
                                          TextStyle(fontFamily: "Montserrat")),
                                  onTap: () {},
                                ),
                              ],
                            ),
                            SizedBox(
                              width: 20,
                              height: 17,
                            ),
                            Row(
                              children: [
                                SizedBox(width: 20),
                                InkWell(
                                  child: Text("Part Payment",
                                      style:
                                          TextStyle(fontFamily: "Montserrat")),
                                  onTap: () {},
                                ),
                              ],
                            ),
                            SizedBox(
                              width: 20,
                              height: 17,
                            ),
                            Row(
                              children: [
                                SizedBox(width: 20),
                                InkWell(
                                  child: Text("Pending Payment",
                                      style:
                                          TextStyle(fontFamily: "Montserrat")),
                                  onTap: () {},
                                ),
                              ],
                            ),
                            SizedBox(
                              width: 20,
                              height: 17,
                            ),
                            Row(
                              children: [
                                SizedBox(width: 20),
                                InkWell(
                                  child: Text("Service Request",
                                      style:
                                          TextStyle(fontFamily: "Montserrat")),
                                  onTap: () {},
                                ),
                              ],
                            ),
                            SizedBox(
                              width: 20,
                              height: 17,
                            ),
                            Row(
                              children: [
                                SizedBox(width: 20),
                                InkWell(
                                  child: Text("Unconfirmed Booking",
                                      style:
                                          TextStyle(fontFamily: "Montserrat")),
                                  onTap: () {},
                                ),
                              ],
                            ),
                            SizedBox(
                              width: 20,
                              height: 17,
                            ),
                            Row(
                              children: [
                                SizedBox(width: 20),
                                InkWell(
                                  child: Text("Cancelled Flight Booking",
                                      style:
                                          TextStyle(fontFamily: "Montserrat")),
                                  onTap: () {},
                                ),
                              ],
                            ),
                            SizedBox(
                              width: 20,
                              height: 17,
                            ),
                            Row(
                              children: [
                                SizedBox(width: 20),
                                InkWell(
                                  child: Text("Booking Refunds Due",
                                      style:
                                          TextStyle(fontFamily: "Montserrat")),
                                  onTap: () {},
                                ),
                              ],
                            ),
                            SizedBox(
                              width: 20,
                              height: 17,
                            ),
                            Row(
                              children: [
                                SizedBox(width: 20),
                                InkWell(
                                  child: Text("All Booking List",
                                      style:
                                          TextStyle(fontFamily: "Montserrat")),
                                  onTap: () {},
                                ),
                              ],
                            ),
                            SizedBox(
                              width: 20,
                              height: 17,
                            ),
                            Row(
                              children: [
                                SizedBox(width: 20),
                                InkWell(
                                  child: Text("Productwise Booking",
                                      style:
                                          TextStyle(fontFamily: "Montserrat")),
                                  onTap: () {},
                                ),
                              ],
                            ),
                          ],
                        ),
                      ],
                    ),
                  ],
                ),

                Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
                  ExpansionTile(
                    title: Row(
                      children: [
                        Icon(const IconData(0xe4fb,
                            fontFamily: 'MaterialIcons')),
                        SizedBox(width: 8),
                        Text('Queues',
                            style: TextStyle(fontFamily: "Montserrat")),
                      ],
                    ),
                    children: [
                      Column(
                        children: [
                          Row(
                            children: [
                              SizedBox(width: 20),
                              InkWell(
                                child: Text("Ticket Order Queue",
                                    style: TextStyle(fontFamily: "Montserrat")),
                                onTap: () {},
                              ),
                            ],
                          ),
                          SizedBox(
                            width: 20,
                            height: 17,
                          ),
                          Row(
                            children: [
                              SizedBox(width: 20),
                              InkWell(
                                child: Text("Cancel Booking Queue",
                                    style: TextStyle(fontFamily: "Montserrat")),
                                onTap: () {},
                              ),
                            ],
                          ),
                          SizedBox(
                            width: 20,
                            height: 17,
                          ),
                          Row(
                            children: [
                              SizedBox(width: 20),
                              InkWell(
                                child: Text("Cancel Ticket Queue",
                                    style: TextStyle(fontFamily: "Montserrat")),
                                onTap: () {},
                              ),
                            ],
                          ),
                          SizedBox(
                            width: 20,
                            height: 17,
                          ),
                          Row(
                            children: [
                              SizedBox(width: 20),
                              InkWell(
                                child: Text("Approve Part Payment",
                                    style: TextStyle(fontFamily: "Montserrat")),
                                onTap: () {},
                              ),
                            ],
                          ),
                          SizedBox(
                            width: 20,
                            height: 17,
                          ),
                          Row(
                            children: [
                              SizedBox(width: 20),
                              InkWell(
                                child: Text("Approve Refund OnHold",
                                    style: TextStyle(fontFamily: "Montserrat")),
                                onTap: () {},
                              ),
                            ],
                          ),
                          SizedBox(
                            width: 20,
                            height: 17,
                          ),
                          Row(
                            children: [
                              SizedBox(width: 20),
                              InkWell(
                                child: Text("Payment Pending Queue",
                                    style: TextStyle(fontFamily: "Montserrat")),
                                onTap: () {},
                              ),
                            ],
                          ),
                          SizedBox(
                            width: 20,
                            height: 17,
                          ),
                          Row(
                            children: [
                              SizedBox(width: 20),
                              Text("Fraud Check Queue",
                                  style: TextStyle(fontFamily: "Montserrat")),
                            ],
                          ),
                          SizedBox(
                            width: 20,
                            height: 17,
                          ),
                          Row(
                            children: [
                              SizedBox(width: 20),
                              Text("Refunded Booking Queue",
                                  style: TextStyle(fontFamily: "Montserrat")),
                            ],
                          ),
                        ],
                      ),
                    ],
                  ),
                ]),
                Column(children: [
                  ExpansionTile(
                    title: Row(
                      children: [
                        Icon(const IconData(0xe140,
                            fontFamily: 'MaterialIcons')),
                        SizedBox(
                          width: 8,
                        ),
                        Text("Travellers",
                            style: TextStyle(fontFamily: "Montserrat")),
                      ],
                    ),
                    children: [
                      Column(
                        children: [
                          Row(
                            children: [
                              SizedBox(width: 20),
                              InkWell(
                                  child: Text("Manage Travellers",
                                      style:
                                          TextStyle(fontFamily: "Montserrat")),
                                  onTap: () {}),
                            ],
                          ),
                          SizedBox(
                            width: 20,
                            height: 17,
                          ),
                          Row(
                            children: [
                              SizedBox(width: 20),
                              InkWell(
                                child: Text("Approve Travellers",
                                    style: TextStyle(fontFamily: "Montserrat")),
                                onTap: () {},
                              ),
                            ],
                          ),
                          SizedBox(
                            width: 20,
                            height: 17,
                          ),
                          Row(
                            children: [
                              SizedBox(width: 20),
                              InkWell(
                                  child: Text("Block/Unblock Travellers",
                                      style:
                                          TextStyle(fontFamily: "Montserrat")),
                                  onTap: () {}),
                            ],
                          ),
                          SizedBox(
                            width: 20,
                            height: 17,
                          ),
                          Row(
                            children: [
                              SizedBox(width: 20),
                              InkWell(
                                child: Text("Active Travellers",
                                    style: TextStyle(fontFamily: "Montserrat")),
                                onTap: () {},
                              ),
                            ],
                          ),
                          SizedBox(
                            width: 20,
                            height: 17,
                          ),
                          Row(
                            children: [
                              SizedBox(width: 20),
                              InkWell(
                                child: Text("Change Password",
                                    style: TextStyle(fontFamily: "Montserrat")),
                                onTap: () {},
                              ),
                            ],
                          ),
                        ],
                      ),
                    ],
                  ),
                ]),
                Column(children: [
                  ExpansionTile(
                    title: Row(
                      children: [
                        Icon(const IconData(0xeec9,
                            fontFamily: 'MaterialIcons')),
                        SizedBox(
                          width: 8,
                        ),
                        Text("Branches",
                            style: TextStyle(fontFamily: "Montserrat"))
                      ],
                    ),
                    children: [
                      Column(
                        children: [
                          Row(children: [
                            SizedBox(
                              width: 20,
                            ),
                            InkWell(
                              child: Text("Manage Branch",
                                  style: TextStyle(fontFamily: "Montserrat")),
                              onTap: () {},
                            ),
                          ]),
                          SizedBox(
                            width: 20,
                            height: 17,
                          ),
                          Row(children: [
                            SizedBox(
                              width: 20,
                            ),
                            InkWell(
                              child: Text("Approve Branch",
                                  style: TextStyle(fontFamily: "Montserrat")),
                              onTap: () {},
                            ),
                          ]),
                          SizedBox(
                            width: 20,
                            height: 17,
                          ),
                          Row(children: [
                            SizedBox(
                              width: 20,
                            ),
                            InkWell(
                              child: Text("Active Branch",
                                  style: TextStyle(fontFamily: "Montserrat")),
                              onTap: () {},
                            ),
                          ]),
                          SizedBox(
                            width: 20,
                            height: 17,
                          ),
                          Row(children: [
                            SizedBox(
                              width: 20,
                            ),
                            InkWell(
                              child: Text("Block/Unblock Branch",
                                  style: TextStyle(fontFamily: "Montserrat")),
                              onTap: () {},
                            ),
                          ]),
                          SizedBox(
                            width: 20,
                            height: 17,
                          ),
                        ],
                      ),
                    ],
                  ),
                ]),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
