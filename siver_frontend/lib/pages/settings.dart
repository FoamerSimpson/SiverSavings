import 'package:flutter/material.dart';
import 'dart:async';
import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';


class settings extends StatefulWidget {
  const settings({super.key});

  @override
  State<settings> createState() => _toolsState();
}



class _toolsState extends State<settings> {

  void _showErrorMessage(String message) {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text(message),
        backgroundColor: Colors.red,
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Center(child: Text('Settings')),
      ),
      body: Center(
        child: Column(children: [
          SizedBox(
            width: 350,
            child: TextButton(
              onPressed: () {
                Navigator.pushNamed(context, '/register');
              },
              style: ButtonStyle(
                shadowColor: WidgetStateProperty.all<Color>(const Color.fromARGB(255, 173, 96, 152)),
                backgroundColor: WidgetStateProperty.all<Color>(const Color.fromARGB(255, 137, 211, 141)),
                shape: WidgetStateProperty.all<RoundedRectangleBorder>(
                  const RoundedRectangleBorder(
                  borderRadius: BorderRadius.zero,
                  side: BorderSide(color: Colors.red)
                  )
                ),
              ),
              child: const Text('Register an account'),
            ),
          ),
          SizedBox(
            width: 350,
            child: TextButton(
              onPressed: () {
                Navigator.pushNamed(context, '/login');
              },
              style: ButtonStyle(
                shadowColor: WidgetStateProperty.all<Color>(const Color.fromARGB(255, 173, 96, 152)),
                backgroundColor: WidgetStateProperty.all<Color>(const Color.fromARGB(255, 137, 211, 141)),
                shape: WidgetStateProperty.all<RoundedRectangleBorder>(
                  const RoundedRectangleBorder(
                  borderRadius: BorderRadius.zero,
                  side: BorderSide(color: Colors.red)
                  )
                ),
              ),
              child: const Text('Log in'),
            ),
          ),
          SizedBox(
            width: 350,
            child: TextButton(
              onPressed: () async {
                try {
                  final prefs = await SharedPreferences.getInstance();
                  final sessionCookie = prefs.getString('sessionCookie');

                  if (sessionCookie == null || sessionCookie.isEmpty) {
                    _showErrorMessage('You are not logged in');
                    return;
                  }

                  final response = await http.get(
                    Uri.parse('http://10.0.2.2:5000/logout'),
                    headers: {
                      'Content-Type': 'application/json',
                      'Cookie': sessionCookie,
                    },
                  ).timeout(const Duration(seconds: 3));

                  if (response.statusCode == 200) {
                    await prefs.remove('sessionCookie');

                    if (mounted) {
                      _showErrorMessage('Logout successful');
                    }
                  } else {
                    if (mounted) {
                      ScaffoldMessenger.of(context).showSnackBar(
                        SnackBar(content: Text('Logout failed: ${response.statusCode}')),
                      );
                    }
                  }
                } on TimeoutException {
                  if (mounted) {
                    ScaffoldMessenger.of(context).showSnackBar(
                      const SnackBar(content: Text('Request timed out')),
                    );
                  }
                } catch (e) {
                  if (mounted) {
                    ScaffoldMessenger.of(context).showSnackBar(
                      SnackBar(content: Text('Error during logout: $e')),
                    );
                  }
  }
              },
              style: ButtonStyle(
                shadowColor: WidgetStateProperty.all<Color>(const Color.fromARGB(255, 173, 96, 152)),
                backgroundColor: WidgetStateProperty.all<Color>(const Color.fromARGB(255, 137, 211, 141)),
                shape: WidgetStateProperty.all<RoundedRectangleBorder>(
                  const RoundedRectangleBorder(
                  borderRadius: BorderRadius.zero,
                  side: BorderSide(color: Colors.red)
                  )
                ),
              ),
              child: const Text('Log Out'),
            ),
          ),
          

        ],),
      ),
    );
}
}