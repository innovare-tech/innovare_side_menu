import 'package:flutter/material.dart';

void main() {
  runApp(const ExampleApp());
}

class ExampleApp extends StatelessWidget {
  const ExampleApp({super.key});

  @override
  Widget build(BuildContext context) {
    return const MaterialApp(
      title: 'Innovare Side Menu Example',
      home: Scaffold(
        body: Center(
          child: Text('Innovare Side Menu Example — Coming Soon'),
        ),
      ),
    );
  }
}
