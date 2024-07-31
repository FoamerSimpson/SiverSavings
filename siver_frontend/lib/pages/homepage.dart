import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../sessionprovider.dart';

class homePage extends StatefulWidget {
  const homePage({super.key});

  @override
  State<homePage> createState() => _HomePageState();
}

class _HomePageState extends State<homePage> {
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
            ElevatedButton(
              onPressed: () {
                // Access the session cookie from the SessionProvider
                final sessionCookie = Provider.of<SessionProvider>(context, listen: false).sessionCookie;
                print("Session Cookie: $sessionCookie");
              },
              child: const Text('Print Session Cookie'),
            ),
          ],
        ),
      ),
    );
  }
}