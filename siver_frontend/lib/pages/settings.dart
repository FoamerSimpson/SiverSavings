import 'package:flutter/material.dart';

class settings extends StatefulWidget {
  const settings({super.key});

  @override
  State<settings> createState() => _toolsState();
}

class _toolsState extends State<settings> {
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
                //padding: WidgetStateProperty.all<EdgeInsetsGeometry>(EdgeInsets.symmetric(vertical: 15.0, horizontal: 120.0 )),
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
                //padding: WidgetStateProperty.all<EdgeInsetsGeometry>(EdgeInsets.symmetric(vertical: 15.0, horizontal: 120.0 )),
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
          

        ],),
      ),
    );
}
}