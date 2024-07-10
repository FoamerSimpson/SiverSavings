import 'package:flutter/material.dart';

class tools extends StatefulWidget {
  const tools({super.key});

  @override
  State<tools> createState() => _toolsState();
}

class _toolsState extends State<tools> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Center(child: Text('Financial Tools')),
      ),
      body: Center(
        child: Column(children: [
          SizedBox(
            width: 350,
            child: TextButton(
              onPressed: () {
                Navigator.pushNamed(context, '/investmentcalc');
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
              child: const Text('Investment Calculator'),
            ),
          ),
          SizedBox(
            width: 350,
            child: TextButton(
              onPressed: () {
                Navigator.pushNamed(context, '/morgagecalc');
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
              child: const Text('Morgage Calculator'),
            ),
          ),
        ],),
      ),
    );
}
}