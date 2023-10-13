import 'dart:io';
import 'package:flutter_applicatioaserwerwr/model/massagemodel.dart';
import 'package:path/path.dart';
import 'package:flutter/material.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:image_picker/image_picker.dart';

class UploadFileFirebaseStorage extends StatefulWidget {
  const UploadFileFirebaseStorage({Key? key}) : super(key: key);

  @override
  State<UploadFileFirebaseStorage> createState() =>
      _UploadFileFirebaseStorageState();
}

class _UploadFileFirebaseStorageState extends State<UploadFileFirebaseStorage> {
  File? fileImage;
  var imgPicker = ImagePicker();
  var downloadURL;

  Future<void> uploadImageFromCamera() async {
    var pickedImage = await imgPicker.pickImage(source: ImageSource.camera);

    if (pickedImage != null) {
      var imagePath = pickedImage.path;
      fileImage = File(imagePath);
      var imageName = basename(imagePath);

      // Start uploading to Firebase Storage
      var storageReference = FirebaseStorage.instance.ref("images/$imageName");
      await storageReference.putFile(fileImage!);
      downloadURL = await storageReference.getDownloadURL();

      print(downloadURL);

      // End uploading to Firebase Storage
      setState(() {});
    }
  }

  Future<void> uploadImageFromGallery() async {
    var pickedImage = await imgPicker.pickImage(source: ImageSource.gallery);

    if (pickedImage != null) {
      var imagePath = pickedImage.path;
      fileImage = File(imagePath);
      var imageName = basename(imagePath);

      // Start uploading to Firebase Storage
      var storageReference = FirebaseStorage.instance.ref("images/$imageName");
      await storageReference.putFile(fileImage!);
      downloadURL = await storageReference.getDownloadURL();

      print(downloadURL);

      // End uploading to Firebase Storage
      setState(() {});
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(),
      body: Center(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Container(
              decoration: BoxDecoration(
                image: downloadURL != null
                    ? DecorationImage(
                        image: NetworkImage(downloadURL!),
                        fit: BoxFit.cover,
                      )
                    : null,
              ),
              width: 400,
              height: 400,
            ),
            ElevatedButton(
              onPressed: () async {
                showModalBottomSheet(
                  context: context,
                  builder: (_) => Container(
                    child: Column(
                      children: [
                        GestureDetector(
                          onTap: () async {
                            Navigator.pop(context);
                            await uploadImageFromCamera();
                          },
                          child: Text("From Camera"),
                        ),
                        SizedBox(
                          height: 15,
                        ),
                        GestureDetector(
                          onTap: () async {
                            Navigator.pop(context);
                            await uploadImageFromGallery();
                          },
                          child: Text("From Gallery"),
                        ),
                        SizedBox(
                          height: 15,
                        ),
                      ],
                    ),
                  ),
                );
              },
              child: Text("Upload"),
            ),
          ],
        ),
      ),
    );
  }
}
