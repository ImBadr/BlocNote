import 'package:Note/loading.dart';
import 'package:flutter/material.dart';

void main() {
  runApp(new BlocNote());
}

class BlocNote extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return new MaterialApp(
      title: 'Note',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        primarySwatch: Colors.tealAccent[300],
      ),
      home: Loading(),
    );
  }
}
