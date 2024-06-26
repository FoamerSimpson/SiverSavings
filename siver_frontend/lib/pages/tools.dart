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
          Container(
          
            child: TextButton(
              onPressed: () {},
              child: Text('hi'),
              style: ButtonStyle(
                backgroundColor: WidgetStateProperty.all<Color>(const Color.fromARGB(255, 137, 211, 141)),
                shape: WidgetStateProperty.all<RoundedRectangleBorder>(
                  RoundedRectangleBorder(
                  borderRadius: BorderRadius.zero,
                  side: BorderSide(color: Colors.red)
                  )
                ),
              ),
            ),
          ),
          Text("hello"),
        ],),
      ),
    );
}
}