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

  // Fetches the user balance from the server
  void getUserBalance() async {
    final response =
        await http.get(Uri.parse('$apiUrl/helpfinance/get_user_balance/'));
    if (response.statusCode == 200) {
      Map<String, dynamic> json = jsonDecode(response.body);
      setState(() {
        _userBalance = double.parse(json['balance']);
        _isButtonPressed = true;
        _isBalanceHidden = false;
      });
      print('User balance: $_userBalance');
    } else {
      throw Exception('Failed to load user balance');
    }
  }

  // changes the visibility of the user balance
  void changeBalanceVisibility() {
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
        color: Colors.white,
        borderRadius: BorderRadius.circular(10.0),
      ),
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 10),
        child: Row(
          children: <Widget>[
            Expanded(
              child: Text(
                'Balance: ${_isBalanceHidden ? '****' : (_userBalance?.toString() ?? 'Loading...')}',
                style: TextStyle(fontSize: 18),
              ),
            ),
            Container(
              width: 70,
              height: 70,
              child: FloatingActionButton(
                onPressed: changeBalanceVisibility,
                backgroundColor: Color(0xFF8247FF),
                foregroundColor: Colors.white,
                child: Icon(
                  _isBalanceHidden ? Icons.credit_card : Icons.visibility_off,
                  size: 35,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}