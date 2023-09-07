import 'package:flutter/material.dart';

AlertDialog alert(String title, String content, context) {
  return AlertDialog(
    title: Text(title),
    content: Text(content),
    actions: [
      ElevatedButton(
          onPressed: () {
            Navigator.pop(context);
          },
          child: const Text("ok"))
    ],
  );
}
