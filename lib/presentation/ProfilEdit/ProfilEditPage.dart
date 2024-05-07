import 'package:exopek_workout_app/components/CtaButton.dart';
import 'package:exopek_workout_app/components/CustomTextField.dart';
import 'package:exopek_workout_app/components/CustomTextFieldButton.dart';
import 'package:exopek_workout_app/dependencyInjection/userProvider/UserProvider.dart';
import 'package:exopek_workout_app/domain/Models/Enums/SportType.dart';
import 'package:exopek_workout_app/domain/Models/User.dart';
import 'package:exopek_workout_app/theme/ThemeBase.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class ProfilEditPage extends ConsumerStatefulWidget {
  const ProfilEditPage({super.key});

  @override
  ConsumerState<ProfilEditPage> createState() => _ProfilEditPageState();
}

class _ProfilEditPageState extends ConsumerState<ProfilEditPage> {
  TextEditingController usernameController = TextEditingController();
  TextEditingController firstnameController = TextEditingController();
  TextEditingController lastnameController = TextEditingController();
  TextEditingController emailController = TextEditingController();
  TextEditingController ageController = TextEditingController();
  TextEditingController heightController = TextEditingController();
  TextEditingController sportController = TextEditingController();
  TextEditingController trainingFrequencyController = TextEditingController();

  FocusNode usernameFocusNode = FocusNode();
  FocusNode firstnameFocusNode = FocusNode();
  FocusNode lastnameFocusNode = FocusNode();
  FocusNode emailFocusNode = FocusNode();
  FocusNode ageFocusNode = FocusNode();
  FocusNode heightFocusNode = FocusNode();

  @override
  Widget build(BuildContext context) {
    ref.listen(asyncProfilEditPageUpdateUserButtonControllerProvider, (previous, next) { 
      if (next is AsyncData) {
        ref.invalidate(asyncProfilEditPageControllerProvider);
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(
            content: Text("Update erfolgreich."),
          ),
        );
      } else if (next is AsyncError) {
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(
            content: Text("Update fehlgeschlagen."),
          ),
        );
      }
    });
    final profilEditPageControllerProvider =
        ref.watch(asyncProfilEditPageControllerProvider);
    final state = ref.watch(asyncProfilEditPageUpdateUserButtonControllerProvider);
    return Scaffold(
        backgroundColor: Color(0xFF0C0C0C),
        appBar: AppBar(
          backgroundColor: Color(0xFF212326),
          title: Text('Profil bearbeiten'),
        ),
        body: profilEditPageControllerProvider.when(
            data: (data) {
              usernameController.text = data.user.username;
              firstnameController.text = data.user.firstname;
              lastnameController.text = data.user.lastname;
              emailController.text = data.user.email;
              ageController.text = data.user.age == null ? "---" : data.user.age.toString();
              heightController.text = data.user.height == null ? "---" : data.user.height.toString();
              sportController.text = data.user.sport == SportType.None ? "---" : data.user.sport.name;
              trainingFrequencyController.text = data.user.trainingFrequency == null ? "---" : data.user.trainingFrequencyTypeAsString.toString();
              return SingleChildScrollView(
                physics: ClampingScrollPhysics(),
                child: Column(
                  children: [
                    Divider(
                      height: 32,
                      thickness: 2,
                      color: Color(0xFF212326),
                    ),
                    Padding(
                      padding: const EdgeInsets.only(left: 16.0),
                      child: Align(
                        alignment: Alignment.centerLeft,
                        child: Text(
                          "Profil",
                          textAlign: TextAlign.left,
                          style: ThemeBase.of(context).headlineSmall,
                        ),
                      ),
                    ),
                    SizedBox(
                      height: 16,
                    ),
                    Padding(
                      padding: const EdgeInsets.only(left: 16.0, right: 16.0),
                      child: CustomTextField(
                        controller: usernameController,
                        focusNode: usernameFocusNode,
                        hint: "Benutzername",
                      ),
                    ),
                    SizedBox(
                      height: 16,
                    ),
                    Padding(
                      padding: const EdgeInsets.only(left: 16.0, right: 16.0),
                      child: CustomTextField(
                        controller: firstnameController,
                        focusNode: firstnameFocusNode,
                        hint: "Vorname",
                      ),
                    ),
                    SizedBox(
                      height: 16,
                    ),
                    Padding(
                      padding: const EdgeInsets.only(left: 16.0, right: 16.0),
                      child: CustomTextField(
                        controller: lastnameController,
                        focusNode: lastnameFocusNode,
                        hint: "Nachname",
                      ),
                    ),
                    SizedBox(
                      height: 16,
                    ),
                    Padding(
                      padding: const EdgeInsets.only(left: 16.0, right: 16.0),
                      child: CustomTextField(
                        controller: emailController,
                        focusNode: emailFocusNode,
                        hint: "Email",
                      ),
                    ),
                    SizedBox(
                      height: 16,
                    ),
                    Padding(
                      padding: const EdgeInsets.only(left: 16.0, right: 16.0),
                      child: CustomTextField(
                        controller: ageController,
                        focusNode: ageFocusNode,
                        hint: "Alter (Jahre)",
                      ),
                    ),
                    SizedBox(
                      height: 16,
                    ),
                    Padding(
                      padding: const EdgeInsets.only(left: 16.0, right: 16.0),
                      child: CustomTextField(
                        controller: heightController,
                        focusNode: heightFocusNode,
                        hint: "Größe (cm)",
                      ),
                    ),
                    Divider(
                      height: 32,
                      thickness: 2,
                      color: Color(0xFF212326),
                    ),
                    Padding(
                      padding: const EdgeInsets.only(left: 16.0),
                      child: Align(
                        alignment: Alignment.centerLeft,
                        child: Text(
                          "Trainingsprofil",
                          textAlign: TextAlign.left,
                          style: ThemeBase.of(context).headlineSmall,
                        ),
                      ),
                    ),
                    SizedBox(
                      height: 16,
                    ),
                    Padding(
                      padding: const EdgeInsets.only(left: 16.0, right: 16.0),
                      child: CustomTextFieldButton(
                        controller: trainingFrequencyController,
                        hint: "Wie oft trainierts du pro Woche?",
                        suffixIcon: Icons.chevron_right,
                        onTap: () => print("object"),
                      ),
                    ),
                    SizedBox(
                      height: 16,
                    ),
                    Padding(
                      padding: const EdgeInsets.only(left: 16.0, right: 16.0),
                      child: CustomTextFieldButton(
                        controller: sportController,
                        hint: "Deine Sportart?",
                        suffixIcon: Icons.chevron_right,
                        onTap: () => print("object"),
                      ),
                    ),
                    SizedBox(
                      height: 64,
                    ),
                    Padding(
                      padding: const EdgeInsets.only(left: 16.0, right: 16.0),
                      child: CtaButton(
                        isLoading: state.isLoading,
                        label: "Speichern",
                        onPressed: () {
                          
                          ref
                              .read(asyncProfilEditPageUpdateUserButtonControllerProvider.notifier)
                              .updateUser(
                                  user: UpdateUserDto(
                                      id: data.user.id,
                                      firstname: firstnameController.text,
                                      lastname: lastnameController.text,
                                      username: usernameController.text,
                                      email: emailController.text,
                                      password: data.user.password,
                                      imageUrl: data.user.imageUrl,
                                      age: int.parse(ageController.text),
                                      height: double.parse(heightController.text),
                                      sport: sportController.text == "---" ? SportType.None : SportType.values.firstWhere((element) => element.name == sportController.text),
                                      trainingFrequency: int.parse(TrainingFrequencyType.values.firstWhere((element) => element.name == trainingFrequencyController.text).toString())));
                        },
                      ),
                    ),
                    SizedBox(
                      height: 64,
                    ),
                  ],
                ),
              );
            },
            loading: () => Center(
                  child: CircularProgressIndicator(
                    color: Colors.white,
                  ),
                ),
            error: (error, stack) => Center(
                  child: Text("Error: $error"),
                )));
  }
}
