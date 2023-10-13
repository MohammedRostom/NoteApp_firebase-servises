import 'package:flutter/material.dart';

class NoteScreen extends StatefulWidget {
  @override
  _NoteScreenState createState() => _NoteScreenState();
}

class _NoteScreenState extends State<NoteScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Note App'),
      ),
      body: ListView(
        children: <Widget>[
          ListTile(
            title: Text('Title'),
            subtitle: Text('Subtitle'),
          ),
          ListTile(
            title: Text('Title'),
            subtitle: Text('Subtitle'),
          ),
          ListTile(
            title: Text('Title'),
            subtitle: Text('Subtitle'),
          ),
        ],
      ),
    );
  }
}
