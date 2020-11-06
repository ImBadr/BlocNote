import 'package:Note/Model/Note.dart';
import 'package:Note/addNote.dart';
import 'package:Note/db/DBProvider.dart';
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
      body: Center(
        child: ListView.builder(
            itemCount: items.length,
            padding: const EdgeInsets.all(15.0),
            itemBuilder: (context, position) {
              return Column(
                children: <Widget>[
                  Divider(height: 5.0),
                  ListTile(
                    title: Text(
                      '${items[position].title}',
                      style: TextStyle(
                        fontSize: 22.0,
                        color: Colors.deepOrangeAccent,
                      ),
                    ),
                    subtitle: Text(
                      '${items[position].content}',
                      style: new TextStyle(
                        fontSize: 18.0,
                        fontStyle: FontStyle.italic,
                      ),
                    ),
                    leading: Column(
                      children: <Widget>[
                        Padding(padding: EdgeInsets.all(10.0)),
                        CircleAvatar(
                          backgroundColor: Colors.blueAccent,
                          radius: 15.0,
                          child: Text(
                            '${items[position].id}',
                            style: TextStyle(
                              fontSize: 22.0,
                              color: Colors.white,
                            ),
                          ),
                        ),
                        IconButton(
                            icon: const Icon(Icons.remove_circle_outline),
                            onPressed: () => _deleteNote(
                                context, items[position], position)),
                      ],
                    ),
                  ),
                ],
              );
            }),
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,
      floatingActionButton: FloatingActionButton.extended(
        elevation: 10.0,
        icon: const Icon(Icons.mode_edit),
        label: const Text('Create'),
        onPressed: () {
          createNote();
        },
      ),
      bottomNavigationBar: BottomAppBar(
        shape: AutomaticNotchedShape(
            RoundedRectangleBorder(
                borderRadius: BorderRadius.vertical(top: Radius.circular(30))),
            StadiumBorder(side: BorderSide())),
        color: Hexcolor('#0B409C'),
        child: new Row(
          mainAxisSize: MainAxisSize.max,
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: <Widget>[
            IconButton(
              icon: Icon(Icons.delete),
              color: Colors.white,
              onPressed: () {},
            ),
          ],
        ),
      ),
    );
  }

  void _deleteNote(BuildContext context, Note note, int position) async {
    DBProvider.db.delete(note.id).then((notes) {
      setState(() {
        items.removeAt(position);
      });
    });
  }

  createNote() {
    Navigator.pushReplacement(
        context, MaterialPageRoute(builder: (context) => AddNote()));
  }
}
