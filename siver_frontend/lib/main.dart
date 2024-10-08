import 'package:flutter/material.dart';
import 'package:siver_frontend/calculators/morgage.dart';
import 'package:provider/provider.dart';
import 'package:siver_frontend/pages/stocks.dart';
import 'sessionprovider.dart';
import 'package:siver_frontend/pages/homepage.dart';
import 'package:siver_frontend/pages/tools.dart';
import 'package:siver_frontend/pages/settings.dart';
import 'package:siver_frontend/calculators/investment.dart';
import 'package:siver_frontend/settings/login.dart';
import 'package:siver_frontend/settings/register.dart';
void main() { 
  runApp(
    ChangeNotifierProvider(
      create: (context) => SessionProvider(),
      child: MaterialApp(
        initialRoute: '/home',
        routes: {
          '/home': (context) => const homeScreen(),
          '/tools': (context) => const tools(),
          '/settings': (context) => const settings(),
          '/investmentcalc': (context) => const Investment(),
          '/morgagecalc': (context) => const Morgage(),
          '/register': (context) => const Register(),
          '/login': (context) => const Login(),
          '/stocks': (context)=> const Stocks(),
        },
      ),
    ),
  );
}
  
class homeScreen extends StatefulWidget {
  const homeScreen({super.key});

  @override
  State<homeScreen> createState() => _homeScreenState();
}

class _homeScreenState extends State<homeScreen> {
  int myIndex = 0;
  List<Widget> widgetList = [
    const HomePage(),
    const Stocks(),
    const tools(),
    const settings(),
  ];
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color.fromARGB(255, 134, 130, 154),
      appBar: AppBar(
        backgroundColor: const Color.fromRGBO(232, 117, 108, 1),
        title: const Center(
          child: Text(
            "SiverSaver",
            style: TextStyle(
              color: Colors.white,
              fontFamily: 'Sivir',
            ),
          ),
        ),
      ),
      body: widgetList[myIndex],
      bottomNavigationBar: NavigationBar(
        onDestinationSelected: (index){
          setState(() {
            myIndex = index;
          });
        },
        selectedIndex: myIndex,
        backgroundColor: const Color.fromRGBO(232, 117, 108, 1),
        animationDuration: const Duration(milliseconds: 1000),
        destinations:const <Widget>[
          NavigationDestination(
            icon: Icon(Icons.home),
            label: 'Home',
          ),
          NavigationDestination(icon: Icon(Icons.bar_chart), label: 'Stocks'),
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