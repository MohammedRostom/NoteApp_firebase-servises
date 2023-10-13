import 'package:flutter/material.dart';
import 'package:flutter_applicatioaserwerwr/model/massagemodel.dart';

class formfild extends StatelessWidget {
  const formfild({
    Key? key,
    required this.label,
    required this.hintText,
    required this.onChanged,
  }) : super(key: key);

  final String label;
  final String hintText;
  final Function(String) onChanged;

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      onChanged: onChanged,
      decoration: InputDecoration(
        border: OutlineInputBorder(),
        labelText: label,
        hintText: hintText,
      ),
    );
  }
}

class chatbuble extends StatelessWidget {
  const chatbuble(
      {
      //3333333333333333333333######################################
      super.key,
      required this.masssssssss});

//@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@
  final classMAssge masssssssss;
  @override
  Widget build(BuildContext context) {
    return Align(
      alignment: Alignment.centerLeft,
      child: Container(
        margin: EdgeInsets.all(15),
        decoration: BoxDecoration(
            color: Colors.blue,
            borderRadius: BorderRadius.only(
              topLeft: Radius.circular(25),
              bottomRight: Radius.circular(25),
              topRight: Radius.circular(25),
            )),
        child: Padding(
          padding: const EdgeInsets.all(15),
          child: Text(masssssssss.massge),
        ),
      ),
    );
  }
}
