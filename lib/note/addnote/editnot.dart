import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

class EditNote extends StatefulWidget {
  final DocumentSnapshot document;

  EditNote({
    required this.document,
  });

  @override
  State<EditNote> createState() => _EditNoteState();
}

class _EditNoteState extends State<EditNote> {
  final TextEditingController _controller = TextEditingController();
  final TextEditingController _agcontroller = TextEditingController();

  CollectionReference messagesInstanceFromObject =
      FirebaseFirestore.instance.collection("users");

  @override
  void initState() {
    _controller.text = widget.document.get("nameid");
    _agcontroller.text = widget.document.get("age");
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Form(
      child: Scaffold(
        appBar: AppBar(
          actions: [
            Padding(
              padding: const EdgeInsets.all(10),
              child: IconButton(
                onPressed: () {
                  showDialog(
                    context: context,
                    builder: (BuildContext context) {
                      return AlertDialog(
                        title: Text("Confirmation"),
                        content:
                            Text("Are you sure you want to delete this note?"),
                        actions: [
                          TextButton(
                            onPressed: () {
                              Navigator.of(context).pop(); // Dismiss the dialog
                            },
                            child: Text("No"),
                          ),
                          TextButton(
                            onPressed: () {
                              deleteNote(); // Call the function to delete the note
                              Navigator.of(context).pop(); // Dismiss the dialog
                              Navigator.pushReplacementNamed(context, 'noots');
                            },
                            child: Text("Yes"),
                          ),
                        ],
                      );
                    },
                  );
                },
                icon: Container(width: 100, child: Text("Delete")),
              ),
            )
          ],
        ),
        body: Padding(
          padding: const EdgeInsets.all(15),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              TextField(
                decoration: InputDecoration(
                  hintText: "title",
                  border: OutlineInputBorder(),
                ),
                controller: _controller,
              ),
              Expanded(
                child: TextField(
                  decoration: InputDecoration(
                    hintStyle: TextStyle(),
                    hintText: "content",
                    border: OutlineInputBorder(),
                  ),
                  maxLines: null,
                  expands: true,
                  controller: _agcontroller,
                ),
              ),
              ElevatedButton(
                onPressed: () {
                  updateNote(); // Call the function to update the note
                  Navigator.pushReplacementNamed(context, 'noots');
                },
                child: Text("Edit Note"),
              ),
            ],
          ),
        ),
      ),
    );
  }

  void updateNote() {
    widget.document.reference.update({
      "nameid": _controller.text,
      "age": _agcontroller.text,
    });
  }

  void deleteNote() {
    widget.document.reference.delete();
  }
}
