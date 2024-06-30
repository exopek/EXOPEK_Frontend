import 'dart:io';
import 'package:exopek_workout_app/utils/AppRouter.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

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
                child: Text(AppLocalizations.of(context).dialogSubmitButton),
              ),
              TextButton(
                onPressed: () {
                  Navigator.of(context).pop();
                },
                child: Text(AppLocalizations.of(context).dialogCancelButton),
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
                child: Text(AppLocalizations.of(context).dialogSubmitButton),
              ),
              CupertinoDialogAction(
                onPressed: () {
                  Navigator.of(context).pop();
                },
                child: Text(AppLocalizations.of(context).dialogCancelButton),
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
                  child: Text(AppLocalizations.of(context).dialogSubmitButton),
                ),
                TextButton(
                  onPressed: () {
                    Navigator.of(context).pop();
                  },
                  child: Text(AppLocalizations.of(context).dialogCancelButton),
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
                  child: Text(AppLocalizations.of(context).dialogSubmitButton),
                ),
                CupertinoDialogAction(
                  onPressed: () {
                    Navigator.of(context).pop();
                  },
                  child: Text(AppLocalizations.of(context).dialogCancelButton),
                ),
              ],
            );
          }
        });
  }
}
