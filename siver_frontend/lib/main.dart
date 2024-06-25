import 'package:flutter/material.dart';

void main() => runApp(MaterialApp(
  home: homeScreen(),
));
  
class homeScreen extends StatelessWidget {
  const homeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color.fromARGB(255, 134, 130, 154),
      appBar: AppBar(
        backgroundColor: Color.fromRGBO(232, 117, 108, 1),
        title: Center(
          child: Text(
            "SiverSaver",
            style: TextStyle(
              color: Colors.white,
              fontFamily: 'Sivir',
            ),
          ),
        ),
      ),

      bottomNavigationBar: NavigationBar(
        backgroundColor: Color.fromRGBO(232, 117, 108, 1),
        animationDuration: const Duration(milliseconds: 1000),
        destinations: const <Widget>[
          NavigationDestination(
            icon: Icon(Icons.home),
            label: 'Home',
          ),
          NavigationDestination(
            icon: Icon(Icons.architecture_outlined),
            label: 'Tools',
          ),
          NavigationDestination(
            icon: Icon(Icons.settings),
            label: 'Settings',
          ),
        ]
      ),
    );
  }
}