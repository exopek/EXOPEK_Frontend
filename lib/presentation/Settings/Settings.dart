import 'package:exopek_workout_app/components/Settings/SettingsCtaButton.dart';
import 'package:exopek_workout_app/components/Settings/SettingsCtaButtonProfilEdit.dart';
import 'package:exopek_workout_app/components/Shared/GenericAppBar.dart';
import 'package:exopek_workout_app/dependencyInjection/userProvider/UserProvider.dart';
import 'package:exopek_workout_app/domain/Models/User.dart';
import 'package:exopek_workout_app/utils/AppRouter.dart';
import 'package:exopek_workout_app/utils/AppUtil.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:url_launcher/url_launcher.dart';
import 'package:url_launcher/url_launcher_string.dart';

class SettingsPage extends ConsumerStatefulWidget {
  const SettingsPage({super.key});

  @override
  ConsumerState<SettingsPage> createState() => _SettingsPageState();
}

class _SettingsPageState extends ConsumerState<SettingsPage> {

  void _showDialog() {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        var state = ref.watch(asyncDeleteUserControllerProvider);
        return AlertDialog(
          title: Text("Konto löschen"),
          content: Text("Möchtest du dein Konto wirklich löschen?"),
          actions: [
            TextButton(
              onPressed: () {
                Navigator.of(context).pop();
              },
              child: Text("Abbrechen"),
            ),
            TextButton(
              onPressed: () async {
                ref.read(asyncDeleteUserControllerProvider.notifier).deleteUser();
              },
              child: state.isLoading ? CircularProgressIndicator() : Text("Löschen"),
            ),
          ],
        );
      },
    );
  }

  String version = "";

  @override
  void initState() {
    version = "1.0.16";
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    ref.listen(asyncDeleteUserControllerProvider, (previous, next) {
      if (next is AsyncData) {
        AppRouter.goToOnBoarding0AndRemoveLastRoute();
      }
      if (next is AsyncError) {
        ScaffoldMessenger.of(context).showSnackBar(SnackBar(
          content: Text(next.error.toString()),
        ));
      }
    });
    final user = ref.watch(userStateProvider);
    return Scaffold(
        appBar: GenericAppBar.build(context, 'Einstellungen'),
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
                  child: SettingsCtaButtonProfilEdit(imageUrl: user!.imageUrl ,userName: user.firstname + " " + user.lastname, onPressed: () => AppRouter.goToProfilEdit(),)),
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
                    onPressed: () {
                      _showDialog();
                    },
                      title: "Konto löschen", icon: Icon(Icons.chevron_right))),
              Positioned(
                  left: 16,
                  top: 458,
                  child: SettingsCtaButton(
                    onPressed: () async {
                      var success = await ref.read(userRepositoryProvider).logout();
                      if (success) {
                        AppRouter.goToLoginAndRemoveLastRoute();
                      }
                    },
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
