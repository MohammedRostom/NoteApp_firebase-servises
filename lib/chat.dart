import 'package:flutter/material.dart';
import 'package:flutter_applicatioaserwerwr/formfild.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter_applicatioaserwerwr/model/massagemodel.dart';

class chatscreen extends StatefulWidget {
  const chatscreen({Key? key}) : super(key: key);

  @override
  State<chatscreen> createState() => _chatscreenState();
}

TextEditingController CONR = TextEditingController();
ScrollController scrollController = ScrollController();

class _chatscreenState extends State<chatscreen> {
  static const Kmasegeside = 'masseges';

// { FirebaseFirestore ابجكت من نوع }111111111111111111111
  CollectionReference massegesInstansfromOject =
      FirebaseFirestore.instance.collection(Kmasegeside);

  @override
  static const Kcrunnttime = "currntTime";
  Widget build(BuildContext context) {
//(read from firbasesStore )
    return StreamBuilder<QuerySnapshot>(
      stream: massegesInstansfromOject.orderBy(Kcrunnttime).snapshots(),
      builder: (context, snapshot) {
        if (snapshot.hasData) {

          List<classMAssge> massegeslistdata = [];



          for (int i = 0; i < snapshot.data!.docs.length; i++) {
            massegeslistdata.add(classMAssge.fromjson(snapshot.data!.docs[i]));
            print(i);

          }


          return Scaffold(
            appBar: AppBar(),
            body: Column(
              children: [
                Expanded(
                  child: ListView.builder(
                    controller: scrollController,
                    itemCount: massegeslistdata.length,
                    itemBuilder: (context, index) => chatbuble(
                      masssssssss: massegeslistdata[index],
                    ),
                  ),
                ),
                Padding(
                  padding: EdgeInsets.all(15),
                  child: TextField(
                    controller: CONR,
                    onSubmitted: (value) {
                      massegesInstansfromOject
                          .add({"name": value, Kcrunnttime: DateTime.now()});

                      CONR.clear();
                      scrollController.animateTo(
                          scrollController.position.maxScrollExtent,
                          duration: Duration(microseconds: 500),
                          curve: Curves.fastOutSlowIn);
                    },
                    decoration: InputDecoration(
                      hintText: "Send message",
                      suffixIcon: IconButton(
                        onPressed: () {},
                        icon: Icon(Icons.send),
                      ),
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(15),
                      ),
                    ),
                  ),
                ),
              ],
            ),
          );
        } else {
          return Scaffold(
            appBar: AppBar(),
            body: Center(
              child: CircularProgressIndicator(),
            ),
          );
        }
      },
    );
  }
}
