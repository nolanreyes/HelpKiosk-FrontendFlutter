import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';
import 'package:helpkiosk_frontend/constants.dart';

class BalanceDisplay extends StatefulWidget {
  const BalanceDisplay({Key? key}) : super(key: key);

  @override
  BalanceDisplayState createState() => BalanceDisplayState();
}

class BalanceDisplayState extends State<BalanceDisplay> {
  double? _userBalance;
  bool _isBalanceHidden = true;
  bool _isButtonPressed = false;

  void getUserBalance() async {
    final response =
        await http.get(Uri.parse('$apiUrl/helpfinance/get_user_balance/'));

    if (response.statusCode == 200) {
      // If the server returns a 200 OK response, parse the JSON.
      Map<String, dynamic> json = jsonDecode(response.body);
      setState(() {
        _userBalance =
            double.parse(json['balance']); // Convert String to double
        _isButtonPressed = true; // Set _isButtonPressed to true
        _isBalanceHidden = false; // Set _isBalanceHidden to false
      });
      print('User balance: $_userBalance');
    } else {
      // If the server returns an unsuccessful response code, throw an exception.
      throw Exception('Failed to load user balance');
    }
  }

  void toggleBalanceVisibility() {
    if (_isBalanceHidden && !_isButtonPressed) {
      getUserBalance();
    } else {
      setState(() {
        _isBalanceHidden = !_isBalanceHidden;
        _isButtonPressed = _isBalanceHidden;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        color: Colors.white, // Change the background color here
        borderRadius: BorderRadius.circular(10.0), // Set the corners as rounded
      ),
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 50.0),
        child: Row(
          children: <Widget>[
            Expanded(
              child: Text(
                'Balance: ${_isBalanceHidden ? '****' : (_userBalance?.toString() ?? 'Loading...')}',
                style: TextStyle(fontSize: 24),
              ),
            ),
            Container(
              width: 70,
              height: 70,
              child: FloatingActionButton(
                onPressed: toggleBalanceVisibility,
                backgroundColor: Color(0xFF8247FF),
                foregroundColor: Colors.white,// Call the new method here
                child: Icon(
                  _isBalanceHidden ? Icons.credit_card : Icons.visibility_off,
                  // Changes the icon based on _isBalanceHidden
                  size: 40,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
