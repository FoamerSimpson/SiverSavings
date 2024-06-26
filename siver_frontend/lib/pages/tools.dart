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
    );
}
}