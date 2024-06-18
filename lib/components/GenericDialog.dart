import 'dart:io';
import 'package:exopek_workout_app/utils/AppRouter.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class GenericDialog {
  static void showPermissionDialog(BuildContext context, String title,
      String message, Function onOkPressed) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        if (Platform.isAndroid) {
          return AlertDialog(
            title: Text(title),
            content: Text(message),
            actions: <Widget>[
              TextButton(
                onPressed: () {
                  onOkPressed();
                },
                child: const Text('OK'),
              ),
              TextButton(
                onPressed: () {
                  Navigator.of(context).pop();
                },
                child: const Text('Cancel'),
              ),
            ],
          );
        } else {
          return CupertinoAlertDialog(
            title: Text(title),
            content: Text(message),
            actions: <Widget>[
              CupertinoDialogAction(
                onPressed: () {
                  onOkPressed();
                },
                child: const Text('OK'),
              ),
              CupertinoDialogAction(
                onPressed: () {
                  Navigator.of(context).pop();
                },
                child: const Text('Cancel'),
              ),
            ],
          );
        }
      },
    );
  }

  static void showCloseWorkoutDialog(
      BuildContext context, String title, String message) {
    showDialog(
        context: context,
        builder: (_) {
          if (Platform.isAndroid) {
            return AlertDialog(
              title: Text(title),
              content: Text(message),
              actions: <Widget>[
                TextButton(
                  onPressed: () {
                    AppRouter.goToMainPage();
                  },
                  child: const Text('OK'),
                ),
                TextButton(
                  onPressed: () {
                    Navigator.of(context).pop();
                  },
                  child: const Text('Cancel'),
                ),
              ],
            );
          } else {
            return CupertinoAlertDialog(
              title: Text(title),
              content: Text(message),
              actions: <Widget>[
                CupertinoDialogAction(
                  onPressed: () {
                    AppRouter.goToMainPage();
                  },
                  child: const Text('OK'),
                ),
                CupertinoDialogAction(
                  onPressed: () {
                    Navigator.of(context).pop();
                  },
                  child: const Text('Cancel'),
                ),
              ],
            );
          }
        });
  }
}
