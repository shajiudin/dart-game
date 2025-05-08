library globals;

import 'package:flutter/material.dart';

const Color pink = Color.fromARGB(255, 162, 90, 105);
const Color yellow = Color.fromARGB(255, 242, 228, 183);
const String purpleSmileFont = "Purple Smile";
const String mainFont = "Helvetica Rounded Bold";

Widget standardButton(void Function() onTap, String text) {
  return Container(
    height: 44.0,
    width: 150,
    margin: const EdgeInsets.only(top: 35),
    decoration: const BoxDecoration(
      borderRadius: BorderRadius.all(Radius.circular(25)),
      gradient: LinearGradient(colors: [
        Color.fromARGB(255, 253, 239, 191),
        Color.fromARGB(255, 253, 232, 194),
      ], begin: Alignment.topCenter, end: Alignment.bottomCenter),
    ),
    child: ElevatedButton(
      onPressed: onTap,
      style: ElevatedButton.styleFrom(
        backgroundColor: Colors.transparent,
        shadowColor: Colors.transparent,
      ),
      child: Text(
        text,
        style: const TextStyle(color: Colors.black),
      ),
    ),
  );
}

AppBar defaultAppBar(String text, BuildContext context, void Function() onPress, bool displayReturnButton) {
  return AppBar(
    backgroundColor: Colors.transparent,
    shadowColor: Colors.transparent,
    title: Text(
      text,
      style: const TextStyle(color: Color.fromARGB(255, 182, 88, 109), fontFamily: mainFont, fontSize: 35),
    ),
    centerTitle: true,
    leading: displayReturnButton
        ? InkWell(onTap: onPress, child: const Icon(Icons.arrow_back))
        : null,
    iconTheme: const IconThemeData(color: Color.fromARGB(255, 169, 90, 107), size: 35),
  );
} 
