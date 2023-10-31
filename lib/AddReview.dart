import 'package:flutter/material.dart';
import 'package:login_project_sample/AddDispute.dart';

void main() {
  runApp(AddReview());
}

class AddReview extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: MyScreen(),
    );
  }
}

class MyScreen extends StatefulWidget {
  @override
  _MyScreenState createState() => _MyScreenState();
}

class _MyScreenState extends State<MyScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.green,
        leading: IconButton(
          icon: Icon(Icons.arrow_back),
          onPressed: () {
            Navigator.of(context).pop();
          },
        ),
        title: Text('Rate Us'),
      ),
      body: SingleChildScrollView(
        child: Column(
          children: [
            SizedBox(
              height: 25,
            ),
            Text(
              'How did you like our service?',
              style: TextStyle(
                fontWeight: FontWeight.bold,
                fontSize: 20,
              ),
              textAlign: TextAlign.center,
            ),
            SizedBox(height: 20),
            Image.asset(
              'assets/images/rating.png', // Replace with your image path
              width: 100,
              height: 100,
            ),
            SizedBox(height: 20),
            RatingBar(),
            SizedBox(height: 20),
            Text(
              'Worst',
              style: TextStyle(
                  color: Colors.purple,

                  fontSize: 17,
                  fontWeight: FontWeight.bold),
            ),
            SizedBox(height: 20),
            Container(
              width: 320,
              height: 230,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(5),
                border: Border.all(color: Colors.grey),
              ),
              child: TextField(
                decoration: InputDecoration(
                  border: InputBorder.none,
                  hintText: 'Tell us what we should improve?',
                  contentPadding: EdgeInsets.all(16),
                ),
                maxLines: null,
              ),
            ),
            SizedBox(height: 90),
            SizedBox(
              width: 320,
              height: 45,
              child: ElevatedButton(
                onPressed: () {
                  Navigator.push(
                      context,
                      MaterialPageRoute(
                          builder: (BuildContext context) => AddDispute()));
                },
                child: Text(
                  'Submit',
                  style: TextStyle(fontWeight: FontWeight.bold, fontSize: 17),
                ),
                style: ElevatedButton.styleFrom(
                  backgroundColor: Colors.green,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(10),
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class RatingBar extends StatefulWidget {
  @override
  RatingBarState createState() => RatingBarState();
}

class RatingBarState extends State<RatingBar> {
  @override
  Widget build(BuildContext context) {
    return Container(
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Icon(Icons.star, color: Colors.grey),
          Icon(Icons.star, color: Colors.grey),
          Icon(Icons.star, color: Colors.grey),
          Icon(Icons.star, color: Colors.grey),
          Icon(Icons.star_half, color: Colors.grey),
        ],
      ),
    );
  }
}
