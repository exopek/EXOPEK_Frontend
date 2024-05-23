import 'dart:io';

import 'package:dio/dio.dart';
import 'package:exopek_workout_app/components/CtaButton.dart';
import 'package:exopek_workout_app/components/CustomTextField.dart';
import 'package:exopek_workout_app/components/CustomTextFieldButton.dart';
import 'package:exopek_workout_app/dependencyInjection/userProvider/UserProvider.dart';
import 'package:exopek_workout_app/domain/Models/Enums/SportType.dart';
import 'package:exopek_workout_app/domain/Models/Enums/TrainingFrequencyType.dart';
import 'package:exopek_workout_app/domain/Models/User.dart';
import 'package:exopek_workout_app/theme/ThemeBase.dart';
import 'package:exopek_workout_app/utils/AppRouter.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:image_picker/image_picker.dart';

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

  final ImagePicker _picker = ImagePicker();

  Future<XFile?> getImageFromGallery(User user) async {
    final XFile? image = await _picker.pickImage(
        source: ImageSource.gallery,
        imageQuality: 50,
        maxWidth: 800,
        maxHeight: 600);
    if (image != null) {
      return image;
    }
    return null;
  }

  @override
  Widget build(BuildContext context) {
    ref.listen(uploadProfilImageButtonControllerProvider, (previous, next) {
      if (next is AsyncData) {
        ScaffoldMessenger.of(context).showSnackBar(SnackBar(
          content: Text('Image uploaded'),
        ));
        ref.invalidate(asyncProfilEditPageControllerProvider);
      }
      if (next is AsyncError) {
        ScaffoldMessenger.of(context).showSnackBar(SnackBar(
          content: Text(next.error.toString()),
        ));
      }
    });
    ref.listen(asyncProfilEditPageUpdateUserButtonControllerProvider,
        (previous, next) {
      if (next is AsyncData) {
        ref.invalidate(asyncProfilEditPageControllerProvider);
        ScaffoldMessenger.of(context).showSnackBar(SnackBar(
            backgroundColor: ThemeBase.of(context).primaryBackground,
            behavior: SnackBarBehavior.floating,
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(10),
            ),
            
            content: Row(
              children: [
                const Icon(Icons.check, color: Colors.green),
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Text('Update erfolgreich!',
                  style: TextStyle(
                    color: ThemeBase.of(context).primaryText,
                    fontSize: 12,
                    fontFamily: 'Inter',
                    fontWeight: FontWeight.w600,
                    height: 0,
                  ),),
                ),
              ],
            ),
          ));
      } else if (next is AsyncError) {
        next.whenOrNull(
            error: (error, stackTrace) =>
                ScaffoldMessenger.of(context).showSnackBar(SnackBar(
            backgroundColor: ThemeBase.of(context).primaryBackground,
            behavior: SnackBarBehavior.floating,
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(10),
            ),
            
            content: Row(
              children: [
                const Icon(Icons.error, color: Colors.red),
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Text(error.toString(),
                  style: TextStyle(
                    color: ThemeBase.of(context).primaryText,
                    fontSize: 12,
                    fontFamily: 'Inter',
                    fontWeight: FontWeight.w600,
                    height: 0,
                  ),),
                ),
              ],
            ),
          )));
      }
    });
    final profilEditPageControllerProvider =
        ref.watch(asyncProfilEditPageControllerProvider);
    final state =
        ref.watch(asyncProfilEditPageUpdateUserButtonControllerProvider);
    return Scaffold(
        backgroundColor: Color(0xFF0C0C0C),
        appBar: AppBar(
          centerTitle: false,
          backgroundColor: Color(0xFF212326),
          title: Text('Profil bearbeiten'),
        ),
        body: profilEditPageControllerProvider.when(
            data: (data) {
              /// <summary>
              /// If Page refreshes, all changes are lost
              /// </summary>
              usernameController.text = data.user.username;
              firstnameController.text = data.user.firstname;
              lastnameController.text = data.user.lastname;
              emailController.text = data.user.email;
              ageController.text =
                  data.user.age == null ? "---" : data.user.age.toString();
              heightController.text = data.user.height == null
                  ? "---"
                  : data.user.height.toString();
              sportController.text = data.user.sport == SportType.None
                  ? "---"
                  : data.user.sport.name;
              trainingFrequencyController.text =
                  data.user.previousTrainingFrequency == TrainingFrequencyType.None
                      ? "---"
                      : data.user.previousTrainingFrequency!.name;
              return SingleChildScrollView(
                physics: ClampingScrollPhysics(),
                child: Column(
                  children: [
                    const SizedBox(
                      height: 20,
                    ),
                    Builder(builder: (context) {
                      if (data.user.imageUrl != null) {
                        return Container(
                          width: 150,
                          height: 150,
                          decoration: ShapeDecoration(
                            image: DecorationImage(
                              image: NetworkImage(data.user.imageUrl!),
                              fit: BoxFit.cover,
                            ),
                            shape: const OvalBorder(),
                          ),
                          child: TextButton(
                              onPressed: () async {
                                var image =
                                    await getImageFromGallery(data.user);
                                if (image != null) {
                                  ref
                                      .read(
                                          uploadProfilImageButtonControllerProvider
                                              .notifier)
                                      .updateUserImage(
                                        file: File(image.path),
                                      );
                                }
                              },
                              child: Container()),
                        );
                      } else {
                        return Container(
                          width: 150,
                          height: 150,
                          decoration: const ShapeDecoration(
                            shape: OvalBorder(
                              side: BorderSide(
                                color: Color(0xFF262424),
                                width: 2,
                              ),
                            ),
                          ),
                          child: TextButton(
                            onPressed: () async {
                              var image = await getImageFromGallery(data.user);
                              if (image != null) {
                                ref
                                    .read(
                                        uploadProfilImageButtonControllerProvider
                                            .notifier)
                                    .updateUserImage(
                                      file: File(image.path),
                                    );
                              }
                            },
                            child: const Icon(Icons.person,
                                color: Colors.white, size: 100),
                          ),
                        );
                      }
                    }),
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
                        onTap: () => AppRouter.goToTrainingFrequencySelection(
                          (trainingFrequencyType) {
                            trainingFrequencyController.text =
                                trainingFrequencyType.name;
                          },
                        )
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
                        onTap: () => AppRouter.goToSportTypeSelection(
                          (sportType) {
                            sportController.text = sportType.name;
                          },
                        ),
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
                              .read(
                                  asyncProfilEditPageUpdateUserButtonControllerProvider
                                      .notifier)
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
                                sport: sportController.text == "---"
                                    ? SportType.None
                                    : SportType.values.firstWhere((element) =>
                                        element.name ==
                                        sportController
                                            .text), 
                                previousTrainingFrequency: trainingFrequencyController.text == "---"
                                    ? TrainingFrequencyType.None
                                    : TrainingFrequencyType.values.firstWhere((element) =>
                                        element.name ==
                                        trainingFrequencyController
                                            .text),
                                trainingFrequency: data.user.trainingFrequency,
                              ));
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
                    color: ThemeBase.of(context).secondary,
                    strokeWidth: 0.5,
                  ),
                ),
            error: (error, stack) => Center(
                  child: Text("Error: $error"),
                )));
  }
}