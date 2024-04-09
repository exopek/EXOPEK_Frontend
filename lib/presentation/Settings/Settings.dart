import 'package:exopek_workout_app/components/Settings/SettingsCtaButton.dart';
import 'package:exopek_workout_app/components/Settings/SettingsCtaButtonProfilEdit.dart';
import 'package:exopek_workout_app/domain/Models/User.dart';
import 'package:exopek_workout_app/utils/AppRouter.dart';
import 'package:exopek_workout_app/utils/AppUtil.dart';
import 'package:flutter/material.dart';
import 'package:url_launcher/url_launcher.dart';
import 'package:url_launcher/url_launcher_string.dart';

class SettingsPage extends StatefulWidget {
  final User user;
  const SettingsPage({super.key, required this.user});

  @override
  State<SettingsPage> createState() => _SettingsPageState();
}

class _SettingsPageState extends State<SettingsPage> {

  String version = "";

  @override
  void initState() {
    version = "1.0.16";
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          backgroundColor: Color(0xFF212326),
          title: Text('Einstellungen'),
        ),
        body: Container(
          width: MediaQuery.of(context).size.width,
          height: 1310,
          clipBehavior: Clip.antiAlias,
          decoration: BoxDecoration(color: Color(0xFF0C0C0C)),
          child: Stack(
            children: [
              Positioned(
                top: 31,
                  left: 16,
                  child: SettingsCtaButtonProfilEdit(imageUrl: widget.user.imageUrl ,userName: widget.user.firstname + " " + widget.user.lastname, onPressed: () => AppRouter.goToProfilEdit(),)),
              Positioned(
                left: 16,
                top: 140,
                child: Text(
                  'System',
                  style: TextStyle(
                    color: Color(0xFF838282),
                    fontSize: 18,
                    fontFamily: 'Inter',
                    fontWeight: FontWeight.w600,
                    height: 0,
                  ),
                ),
              ),
              Positioned(
                  left: 16,
                  top: 171,
                  child: SettingsCtaButton(
                      title: "AGB",
                      icon: Icon(Icons.chevron_right),
                      onPressed: () =>
                          launchUrlString("https://exopek.de/agb/"))),
              Positioned(
                  left: 16,
                  top: 216,
                  child: SettingsCtaButton(
                      title: "Impressum",
                      icon: Icon(Icons.chevron_right),
                      onPressed: () =>
                          launchUrlString("https://exopek.de/impressum/"))),
              Positioned(
                  left: 16,
                  top: 261,
                  child: SettingsCtaButton(
                    title: "Datenschutzbestimmung",
                    icon: Icon(Icons.chevron_right),
                    onPressed: () =>
                        launchUrlString("https://exopek.de/datenschutz/"),
                  )),
              Positioned(
                  left: 16,
                  top: 306,
                  child: SettingsCtaButton(title: "Version: ${version}")),
              Positioned(
                left: 16,
                top: 382,
                child: Text(
                  'Konto',
                  style: TextStyle(
                    color: Color(0xFF838282),
                    fontSize: 18,
                    fontFamily: 'Inter',
                    fontWeight: FontWeight.w600,
                    height: 0,
                  ),
                ),
              ),
              Positioned(
                  left: 16,
                  top: 413,
                  child: SettingsCtaButton(
                      title: "Konto löschen", icon: Icon(Icons.chevron_right))),
              Positioned(
                  left: 16,
                  top: 458,
                  child: SettingsCtaButton(
                    title: "Abmelden",
                    icon: Icon(
                      Icons.chevron_right,
                      color: Colors.red,
                    ),
                    color: Colors.red,
                  )),
            ],
          ),
        ));
  }
}
