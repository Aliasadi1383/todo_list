import 'package:flutter/material.dart';

Widget button(Text buttonName,VoidCallback onPressed) {
  return ElevatedButton(
    onPressed: onPressed,
   child: buttonName);
}
