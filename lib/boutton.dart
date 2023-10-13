import 'package:flutter/material.dart';

Widget btn({
  required String text,
  required VoidCallback onPreontaossed,
  required Null Function() onPressed,
}) =>
    GestureDetector(
      onTap: onPreontaossed,
      child: Container(
          alignment: Alignment.center,
          color: Colors.blue.withOpacity(0.5),
          width: double.infinity,
          height: 50,
          child: Text(text)),
    );
