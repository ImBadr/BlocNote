import 'package:Note/Home.dart';
import 'package:Note/Model/Note.dart';
import 'package:hexcolor/hexcolor.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:flutter/material.dart';
import 'package:Note/db/DB.dart';

class AddNote extends StatefulWidget {
  @override
  _AddNoteState createState() => _AddNoteState();
}

class _AddNoteState extends State<AddNote> {
  final theTitle = TextEditingController();
  final theContent = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: HexColor('#0B409C'),
      appBar: AppBar(
        elevation: 0.0,
        leading: BackButton(
          onPressed: () {
            back();
          },
        ),
        title: Image(
          image: AssetImage('./assets/Images/Logo.png'),
          width: 100,
          height: 50,
        ),
        backgroundColor: HexColor('#0B409C'),
        centerTitle: true,
      ),
      body: Container(
        color: HexColor('#0B409C'),
        child: Padding(
          padding:
              EdgeInsets.only(top: 30.0, bottom: 25.0, left: 20.0, right: 20.0),
          child: Padding(
            padding: EdgeInsets.all(0.0),
            child: new SingleChildScrollView(
                scrollDirection: Axis.vertical,
                reverse: false,
                child: Column(
                  children: <Widget>[
                    SizedBox(height: 5.0),
                    TextFormField(
                      controller: theTitle,
                      maxLength: 39,
                      cursorColor: Colors.white,
                      style: GoogleFonts.roboto(
                        fontSize: 20.0,
                        fontWeight: FontWeight.bold,
                        color: Colors.white,
                      ),
                      decoration: InputDecoration(
                        counterStyle:
                            TextStyle(color: Colors.white, fontSize: 13.0),
                        labelText: "Title",
                        labelStyle: TextStyle(
                          color: Colors.white.withOpacity(0.8),
                          fontSize: 20.0,
                          fontWeight: FontWeight.bold,
                        ),
                        fillColor: Colors.white,
                        enabledBorder: OutlineInputBorder(
                          borderRadius:
                              BorderRadius.all(Radius.circular(100.0)),
                          borderSide: BorderSide(
                              color: Colors.white.withOpacity(0.3), width: 2),
                        ),
                        focusedBorder: OutlineInputBorder(
                          borderSide:
                              BorderSide(color: Colors.white, width: 2.0),
                          borderRadius: BorderRadius.circular(100.0),
                        ),
                      ),
                    ),
                    SizedBox(height: 20.0),
                    TextFormField(
                      controller: theContent,
                      cursorColor: Colors.white,
                      minLines: 20,
                      maxLines: 40,
                      maxLength: 5000,
                      style: GoogleFonts.roboto(
                          fontSize: 20.0, color: Colors.white),
                      decoration: InputDecoration(
                        counterStyle:
                            TextStyle(color: Colors.white, fontSize: 13.0),
                        labelText: "Content ...",
                        alignLabelWithHint: true,
                        labelStyle: TextStyle(
                          color: Colors.white.withOpacity(0.8),
                          fontSize: 20.0,
                        ),
                        fillColor: Colors.white,
                        enabledBorder: OutlineInputBorder(
                          borderRadius: BorderRadius.all(Radius.circular(25.0)),
                          borderSide: BorderSide(
                              color: Colors.white.withOpacity(0.3), width: 2),
                        ),
                        focusedBorder: OutlineInputBorder(
                          borderSide:
                              BorderSide(color: Colors.white, width: 2.0),
                          borderRadius: BorderRadius.circular(25.0),
                        ),
                      ),
                    ),
                  ],
                )),
          ),
        ),
      ),
      floatingActionButton: FloatingActionButton.extended(
        backgroundColor: HexColor('#0B409C'),
        elevation: 10.0,
        icon: const Icon(Icons.save),
        label: const Text('Save'),
        onPressed: () {
          back();
        },
      ),
    );
  }

  back() {
    if (theTitle.text.isEmpty && theContent.text.isEmpty) {
      Navigator.pushReplacement(
          context, MaterialPageRoute(builder: (context) => Home()));
    } else {
      DB.db.insert(new Note(
        title: theTitle.toString(),
        content: theContent.toString(),
        date: DateTime.now().toIso8601String(),
      ));
      Navigator.pushReplacement(
          context, MaterialPageRoute(builder: (context) => Home()));
    }
  }
}
