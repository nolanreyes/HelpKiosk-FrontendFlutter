import 'package:flutter/material.dart';

class DonationPage extends StatefulWidget {
  @override
  _DonationPageState createState() => _DonationPageState();
}

class _DonationPageState extends State<DonationPage> {
  int donationAmount = 0;

  void increaseDonation() {
    setState(() {
      donationAmount++;
    });
  }

  void decreaseDonation() {
    setState(() {
      if (donationAmount > 0) {
        donationAmount--;
      }
    });
  }

  void donate() {
    // Implement your donation logic here
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Donation Page'),
        backgroundColor: Colors.green,
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            Text(
              'How much would you like to donate?',
              style: TextStyle(fontSize: 24, color: Colors.green),
            ),
            SizedBox(height: 20),
            Text(
              '\$${donationAmount}',
              style: TextStyle(fontSize: 48, fontWeight: FontWeight.bold),
            ),
            SizedBox(height: 20),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: <Widget>[
                FloatingActionButton(
                  onPressed: decreaseDonation,
                  child: Icon(Icons.remove),
                  backgroundColor: Colors.red,
                ),
                SizedBox(width: 20),
                FloatingActionButton(
                  onPressed: increaseDonation,
                  child: Icon(Icons.add),
                  backgroundColor: Colors.blue,
                ),
              ],
            ),
            SizedBox(height: 20),
            ElevatedButton(
              onPressed: donate,
              style: ButtonStyle(
                backgroundColor: MaterialStateProperty.all(Colors.green),
                padding: MaterialStateProperty.all(
                    EdgeInsets.symmetric(horizontal: 50, vertical: 20)),
              ),
              child: Text(
                'Donate',
                style: TextStyle(color: Colors.white, fontSize: 20),
              ),
            )
          ],
        ),
      ),
    );
  }
}
