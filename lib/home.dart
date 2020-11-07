import 'package:Note/Model/Note.dart';
import 'package:Note/AddNote.dart';
import 'package:flutter/material.dart';
import 'package:hexcolor/hexcolor.dart';

class Home extends StatefulWidget {
  @override
  _HomeState createState() => _HomeState();
}

class _HomeState extends State<Home> {
  List<Note> items = new List();

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: new AppBar(
        title: Image(
          image: AssetImage('./assets/Images/Logo.png'),
          width: 100,
          height: 50,
        ),
        shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.vertical(bottom: Radius.circular(30))),
        backgroundColor: Hexcolor('#0B409C'),
        centerTitle: true,
      ),
      body: Center(),
      floatingActionButton: FloatingActionButton.extended(
        elevation: 10.0,
        icon: const Icon(Icons.mode_edit),
        label: const Text('Create'),
        onPressed: () {
          openAddNote();
        },
      ),
    );
  }

  openAddNote() {
    Navigator.pushReplacement(
        context, MaterialPageRoute(builder: (context) => AddNote()));
  }
}
