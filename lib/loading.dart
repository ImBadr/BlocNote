import 'dart:async';
import 'package:Note/Home.dart';
import 'package:flutter/material.dart';
import 'package:hexcolor/hexcolor.dart';

class Loading extends StatefulWidget {
  @override
  _LoadingState createState() => _LoadingState();
}

class _LoadingState extends State<Loading> {
  @override
  void initState() {
    super.initState();
    startTime();
  }

  startTime() async {
    var duration = new Duration(milliseconds: 300);
    return new Timer(duration, route);
  }

  route() {
    Navigator.pushReplacement(
        context, MaterialPageRoute(builder: (context) => Home()));
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Hexcolor('#0B409C'),
      body: Container(
        child: Center(
            child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            Image.asset('./assets/Images/Logo.png'),
          ],
        )),
      ),
    );
  }
}
