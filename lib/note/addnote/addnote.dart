import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'dart:io';
import 'package:path/path.dart';
import 'package:flutter/material.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:image_picker/image_picker.dart';

class AddNote extends StatefulWidget {
  const AddNote({Key? key});

  @override
  State<AddNote> createState() => _AddNoteState();
}

class _AddNoteState extends State<AddNote> {
  final TextEditingController _controller = TextEditingController();
  final TextEditingController _agcontroller = TextEditingController();
  GlobalKey<FormState> _GlobalKey = GlobalKey();
  CollectionReference messagesInstanceFromObject =
      FirebaseFirestore.instance.collection("users");

  File? fileImage;
  var imgPicker = ImagePicker();
  var downloadURL;

  Future<String?> uploadImageFromGallery() async {
    var pickedImage = await imgPicker.pickImage(source: ImageSource.gallery);

    if (pickedImage != null) {
      var imagePath = pickedImage.path;
      fileImage = File(imagePath);
      var imageName = basename(imagePath);

      // Start uploading to Firebase Storage
      var storageReference = FirebaseStorage.instance.ref("images/$imageName");
      await storageReference.putFile(fileImage!);
      downloadURL = await storageReference.getDownloadURL();

      return downloadURL;
    }
  }

  @override
  Widget build(BuildContext context) {
    return Form(
      key: _GlobalKey,
      child: Scaffold(
        appBar: AppBar(),
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
              if (downloadURL != null)
                Container(
                  decoration: BoxDecoration(
                    image: DecorationImage(
                      image: NetworkImage(downloadURL!),
                      fit: BoxFit.cover,
                    ),
                  ),
                  width: 200,
                  height: 200,
                ),
              ElevatedButton(
                onPressed: () async {
                  var url = await uploadImageFromGallery();
                  if (url != null) {
                    setState(() {
                      downloadURL = url;
                    });
                  }
                },
                child: Text("Upload"),
              ),
              ElevatedButton(
                onPressed: () {
                  messagesInstanceFromObject.add({
                    "nameid": _controller.text,
                    "age": _agcontroller.text,
                    "url": downloadURL ?? ""
                  });

                  Navigator.pushReplacementNamed(context, 'noots');
                },
                child: Text("Add"),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
