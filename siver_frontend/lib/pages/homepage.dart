import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'dart:async';
import 'package:shared_preferences/shared_preferences.dart';


class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  String _savingsGoal = 'Fetching...';

  @override
  void initState() {
    super.initState();
    _fetchSavingsGoal();
  }

  Future<void> _fetchSavingsGoal() async {
  try {
    final prefs = await SharedPreferences.getInstance();
    final sessionCookie = prefs.getString('sessionCookie');

    final response = await http.get(
      Uri.parse('http://10.0.2.2:5000/protected'),
      headers: {
        'Content-Type': 'application/json',
        'Cookie': sessionCookie ?? '', 
      },
    ).timeout(const Duration(seconds: 3));

    if (response.statusCode == 200) {
      final data = jsonDecode(response.body);
      setState(() {
        _savingsGoal = "Savings goal: " + data['message'];
      });
    } else {
      setState(() {
        _savingsGoal = 'Please log in or make an account.';
      });
    }
  } on TimeoutException {
    if (!mounted) return;
    setState(() {
      _savingsGoal = 'Cannot connect';
    });
  } catch (e) {
    setState(() {
      _savingsGoal = 'Failed to fetch data';
    });
  }
}


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Padding(
        padding: const EdgeInsets.fromLTRB(20, 40, 20, 0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            const Center(
              child: Text(
                'Hello, and welcome to the world\'s premier finance app',
                style: TextStyle(fontSize: 24),
                textAlign: TextAlign.center,
              ),
            ),
            const SizedBox(height: 20),
            Text(
              _savingsGoal,
              style: TextStyle(fontSize: 20),
            ),
            const SizedBox(height: 20),
            ElevatedButton(
              onPressed: _fetchSavingsGoal,
              child: const Text('Refresh Savings Goal'),
            ),
          ],
        ),
      ),
    );
  }
}
