import 'dart:io';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

void showLoadingMessage(BuildContext context) {
  if (Platform.isAndroid) {
    showDialog(
      context: context,
      barrierDismissible: false,
      builder: (BuildContext context) {
        return const AlertDialog(
          title: Text(
            "Wait please...",
            style: TextStyle(fontSize: 13),
          ),
          content: Row(
            children: [
              CircularProgressIndicator(strokeWidth: 3),
              SizedBox(width: 20),
              Text("Calculating route...", style: TextStyle(fontSize: 11)),
            ],
          ),
        );
      },
    );
    return;
  }
  showCupertinoDialog(
    context: context,
    builder: (BuildContext context) {
      return const AlertDialog(
        title: Text(
          "Wait please...",
          style: TextStyle(fontSize: 13),
        ),
        content: Row(
          children: [
            Padding(
              padding: EdgeInsets.all(8.0),
              child: CircularProgressIndicator(strokeWidth: 3),
            ),
            SizedBox(width: 20),
            Text("Calculating route...", style: TextStyle(fontSize: 11)),
          ],
        ),
      );
    },
  );
}
