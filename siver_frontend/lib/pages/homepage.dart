import 'package:flutter/material.dart';
import 'package:siver_frontend/settings/login.dart';

class homePage extends StatefulWidget {
  const homePage({super.key});

  @override
  State<homePage> createState() => _homePageState();
}

class _homePageState extends State<homePage> {

   
  @override
  Widget build(BuildContext context) {
    return const Scaffold(
      
      body: Padding(
        padding: EdgeInsets.fromLTRB(20, 40, 20, 0),
        child: Center(
          child: Text(
            'hello, and welcome to the worlds premier finance app',
          ),
        ),
      ),
    );
  }
}