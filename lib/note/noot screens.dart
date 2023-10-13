import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter_applicatioaserwerwr/model/massagemodel.dart';
import 'package:flutter_applicatioaserwerwr/not/addnote/editnot.dart';

class NoxteScreen extends StatefulWidget {
  const NoxteScreen({Key? key});

  @override
  State<NoxteScreen> createState() => _NoteScreenState();
}

class _NoteScreenState extends State<NoxteScreen> {
  CollectionReference messagesInstanceFromObject =
      FirebaseFirestore.instance.collection("users");

  bool showOnlyAge20 = false;
  bool showAbove20 = false;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      floatingActionButton: FloatingActionButton.extended(
        onPressed: () {
          Navigator.pushReplacementNamed(context, 'addNote');
        },
        label: Text("Add"),
      ),
      appBar: AppBar(
        actions: [
          Checkbox(
            value: showAbove20,
            onChanged: (value) {
              setState(() {
                showAbove20 = value!;
              });
            },
          ),
        ],
      ),
      body: StreamBuilder<QuerySnapshot>(
        stream: showOnlyAge20
            ? messagesInstanceFromObject
                .where("age", isEqualTo: "20")
                .snapshots()
            : showAbove20
                ? messagesInstanceFromObject
                    .where("age", isGreaterThan: "20")
                    .snapshots()
                : messagesInstanceFromObject.snapshots(),
        builder: (context, AsyncSnapshot<QuerySnapshot> snapshot) {
          if (snapshot.hasError) {
            return Text('Error: ${snapshot.error}');
          }

          if (snapshot.connectionState == ConnectionState.waiting) {
            return Center(child: CircularProgressIndicator());
          }

          List<Note> messagesListData = [];
          List<DocumentSnapshot> datalest = snapshot.data!.docs;

          datalest.forEach((doc) {
            messagesListData.add(Note.fromjson(doc.data()));
          });

          return ListView.builder(
            itemCount: messagesListData.length,
            itemBuilder: (_, index) {
              return GestureDetector(
                onTap: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (_) => EditNote(
                        document: datalest[index],
                      ),
                    ),
                  );
                },
                child: NewWidget(modelNotes: messagesListData[index]),
              );
            },
          );
        },
      ),
    );
  }
}

class NewWidget extends StatelessWidget {
  NewWidget({required this.modelNotes});

  final Note modelNotes;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(15),
      child: Container(
        decoration: BoxDecoration(color: Colors.grey),
        child: ListTile(
          title: Text("${modelNotes.nameid}"),
          subtitle: Text("${modelNotes.age}"),
          leading: CircleAvatar(
            backgroundImage: NetworkImage("${modelNotes.nameid}"),
          ),
        ),
      ),
    );
  }
}
