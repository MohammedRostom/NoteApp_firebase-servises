// import 'package:chatapp/firebase_options.dart';

import 'dart:math';

import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter_applicatioaserwerwr/chat.dart';

import 'package:flutter_applicatioaserwerwr/firebase_options.dart';
import 'package:flutter_applicatioaserwerwr/hom.dart';
import 'package:flutter_applicatioaserwerwr/login.dart';
import 'package:flutter_applicatioaserwerwr/not/addnote/addnote.dart';
import 'package:flutter_applicatioaserwerwr/not/addnote/editnot.dart';
import 'package:flutter_applicatioaserwerwr/not/noot%20screens.dart';

import 'package:flutter_applicatioaserwerwr/numpervvvvvvv.dart';
import 'package:flutter_applicatioaserwerwr/sgin.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter_applicatioaserwerwr/testcreare.dart';
import 'package:flutter_applicatioaserwerwr/treatme.dart';
import 'package:flutter_applicatioaserwerwr/uploadfile_firebasesstorge/uploadfile_firebasesstorge.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  await Firebase.initializeApp(options: DefaultFirebaseOptions.currentPlatform);

  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      routes: {
        "home": (_) => const homepage(),
        "log": (_) => LoginPage(),
        "sgin": (_) => sgin(),
        "chat": (_) => chatscreen(),
        "noots": (_) => NoxteScreen(),
        "addNote": (_) => AddNote(),
        "UploadFileFirebaseStorage": (_) => UploadFileFirebaseStorage(),
        "PostApp": (_) => PostApp(),
      },
      initialRoute: "noots"
    );
  }
}
