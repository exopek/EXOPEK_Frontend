import 'dart:io';
import 'package:exopek_workout_app/components/CtaButton.dart';
import 'package:exopek_workout_app/components/CustomTextField.dart';
import 'package:exopek_workout_app/components/CustomTextFieldButton.dart';
import 'package:exopek_workout_app/components/GenericDialog.dart';
import 'package:exopek_workout_app/components/GenericSnackBar.dart';
import 'package:exopek_workout_app/components/Shared/GenericAppBar.dart';
import 'package:exopek_workout_app/dependencyInjection/userProvider/UserProvider.dart';
import 'package:exopek_workout_app/domain/Models/Enums/SportType.dart';
import 'package:exopek_workout_app/domain/Models/Enums/TrainingFrequencyType.dart';
import 'package:exopek_workout_app/domain/Models/User.dart';
import 'package:exopek_workout_app/theme/ThemeBase.dart';
import 'package:exopek_workout_app/utils/AppRouter.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:image_picker/image_picker.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:intl/intl.dart';
import 'package:permission_handler/permission_handler.dart';

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
    /* Map<Permission, PermissionStatus> statues = await [
      Permission.camera,
      Permission.storage,
      Permission.photos
    ].request();
    PermissionStatus? statusCamera = statues[Permission.camera];
    PermissionStatus? statusStorage = statues[Permission.storage];
    PermissionStatus? statusPhotos = statues[Permission.photos];
    bool isGranted = statusCamera == PermissionStatus.granted &&
        statusStorage == PermissionStatus.granted &&
        statusPhotos == PermissionStatus.granted; */
    /* if (!isGranted) {
      GenericDialog.showPermissionDialog(context, AppLocalizations.of(context).galleryPermissionTitle, AppLocalizations.of(context).gallerypermissionContent, openAppSettings);
    } else { */
      final XFile? image = await _picker.pickImage(
        source: ImageSource.gallery,
        imageQuality: 50,
        maxWidth: 800,
        maxHeight: 600);
    if (image != null) {
      return image;
    }
    //}
    
    return null;
  }

  @override
  Widget build(BuildContext context) {
    ref.listen(uploadProfilImageButtonControllerProvider, (previous, next) {
      if (next is AsyncData) {
        GenericSnackBar.showSuccedSnackBar(
            context: context,
            text: AppLocalizations.of(context).editProfilPageImageUploadSucced);
        ref.invalidate(asyncProfilEditPageControllerProvider);
      }
      if (next is AsyncError) {
        next.whenOrNull(
            error: (error, stackTrace) => GenericSnackBar.showErrorSnackBar(
                context: context, text: error.toString()));
      }
    });
    ref.listen(asyncProfilEditPageUpdateUserButtonControllerProvider,
        (previous, next) {
      if (next is AsyncData) {
        ref.invalidate(asyncProfilEditPageControllerProvider);
        GenericSnackBar.showSuccedSnackBar(
            context: context,
            text: AppLocalizations.of(context).editProfilPageUpdateSucced);
      } else if (next is AsyncError) {
        next.whenOrNull(
            error: (error, stackTrace) => GenericSnackBar.showErrorSnackBar(
                context: context, text: error.toString()));
      }
    });
    final profilEditPageControllerProvider =
        ref.watch(asyncProfilEditPageControllerProvider);
    final state =
        ref.watch(asyncProfilEditPageUpdateUserButtonControllerProvider);
    return Scaffold(
        backgroundColor: ThemeBase.of(context).primaryBackground,
        appBar: GenericAppBar.build(
            context, AppLocalizations.of(context).editProfilPageTitle),
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
                  data.user.birthDate == null ? "---" : 
                  DateFormat.yMMMMd(AppLocalizations.of(context).localeName).format(DateTime.parse(data.user.birthDate!).toLocal());
              heightController.text = data.user.height == null
                  ? "---"
                  : data.user.height.toString();
              sportController.text = data.user.sport.name(context);
              trainingFrequencyController.text =
                  data.user.previousTrainingFrequency!.name(context);
              return SingleChildScrollView(
                physics: const ClampingScrollPhysics(),
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
                                // ask for permission
                                
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
                              //var permission = await Permissions
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
                    const Divider(
                      height: 32,
                      thickness: 2,
                      color: Color(0xFF212326),
                    ),
                    Padding(
                      padding: const EdgeInsets.only(left: 16.0),
                      child: Align(
                        alignment: Alignment.centerLeft,
                        child: Text(
                          AppLocalizations.of(context)
                              .editProfilPageProfilSectionTitle,
                          textAlign: TextAlign.left,
                          style: ThemeBase.of(context).headlineSmall,
                        ),
                      ),
                    ),
                    const SizedBox(
                      height: 16,
                    ),
                    Padding(
                      padding: const EdgeInsets.only(left: 16.0, right: 16.0),
                      child: CustomTextField(
                        controller: usernameController,
                        focusNode: usernameFocusNode,
                        hint:
                            AppLocalizations.of(context).textFieldHintUsername,
                      ),
                    ),
                    const SizedBox(
                      height: 16,
                    ),
                    Padding(
                      padding: const EdgeInsets.only(left: 16.0, right: 16.0),
                      child: CustomTextField(
                        controller: firstnameController,
                        focusNode: firstnameFocusNode,
                        hint:
                            AppLocalizations.of(context).textFieldHintFirstname,
                      ),
                    ),
                    const SizedBox(
                      height: 16,
                    ),
                    Padding(
                      padding: const EdgeInsets.only(left: 16.0, right: 16.0),
                      child: CustomTextField(
                        controller: lastnameController,
                        focusNode: lastnameFocusNode,
                        hint:
                            AppLocalizations.of(context).textFieldHintLastname,
                      ),
                    ),
                    const SizedBox(
                      height: 16,
                    ),
                    Padding(
                      padding: const EdgeInsets.only(left: 16.0, right: 16.0),
                      child: CustomTextField(
                        controller: emailController,
                        focusNode: emailFocusNode,
                        hint: AppLocalizations.of(context).textFieldHintEmail,
                      ),
                    ),
                    const SizedBox(
                      height: 16,
                    ),
                    Padding(
                      padding: const EdgeInsets.only(left: 16.0, right: 16.0),
                      child: CustomTextField(
                        enabled: false,
                        controller: ageController,
                        focusNode: ageFocusNode,
                        hint: AppLocalizations.of(context).textFieldHintBirthDate,
                      ),
                    ),
                    const SizedBox(
                      height: 16,
                    ),
                    Padding(
                      padding: const EdgeInsets.only(left: 16.0, right: 16.0),
                      child: CustomTextField(
                        controller: heightController,
                        focusNode: heightFocusNode,
                        hint: AppLocalizations.of(context).textFieldHintHight,
                      ),
                    ),
                    const Divider(
                      height: 32,
                      thickness: 2,
                      color: Color(0xFF212326),
                    ),
                    Padding(
                      padding: const EdgeInsets.only(left: 16.0),
                      child: Align(
                        alignment: Alignment.centerLeft,
                        child: Text(
                          AppLocalizations.of(context)
                              .editProfilPageTrainingProfilSectionTitle,
                          textAlign: TextAlign.left,
                          style: ThemeBase.of(context).headlineSmall,
                        ),
                      ),
                    ),
                    const SizedBox(
                      height: 16,
                    ),
                    Padding(
                      padding: const EdgeInsets.only(left: 16.0, right: 16.0),
                      child: CustomTextFieldButton(
                          controller: trainingFrequencyController,
                          hint: AppLocalizations.of(context)
                              .textFieldHintTrainingFrequency,
                          suffixIcon: Icons.chevron_right,
                          onTap: () => AppRouter.goToTrainingFrequencySelection(
                                  (trainingFrequencyType) {
                                trainingFrequencyController.text =
                                    trainingFrequencyType.name(context);
                              },
                                  TrainingFrequencyType.values.asMap().map(
                                      (key, value) => MapEntry(
                                          value.name(context).toString(),
                                          false)))),
                    ),
                    const SizedBox(
                      height: 16,
                    ),
                    Padding(
                      padding: const EdgeInsets.only(left: 16.0, right: 16.0),
                      child: CustomTextFieldButton(
                        controller: sportController,
                        hint: AppLocalizations.of(context)
                            .textFieldHintSelectedSports,
                        suffixIcon: Icons.chevron_right,
                        onTap: () => AppRouter.goToSportTypeSelection(
                            (sportType) {
                          sportController.text = sportType.name(context);
                        },
                            SportType.values.asMap().map((key, value) =>
                                MapEntry(value.name(context), false))),
                      ),
                    ),
                    const SizedBox(
                      height: 64,
                    ),
                    Padding(
                      padding: const EdgeInsets.only(left: 16.0, right: 16.0),
                      child: CtaButton(
                        isLoading: state.isLoading,
                        label: AppLocalizations.of(context)
                            .editProfilPageSaveButton,
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
                                sport: SportType.values.firstWhere((element) =>
                                    element.name(context) ==
                                    sportController.text),
                                previousTrainingFrequency:
                                    TrainingFrequencyType.values
                                            .firstWhere((element) =>
                                                element.name(context) ==
                                                trainingFrequencyController
                                                    .text),
                                trainingFrequency: data.user.trainingFrequency,
                              ));
                        },
                      ),
                    ),
                    const SizedBox(
                      height: 64,
                    ),
                  ],
                ),
              );
            },
            loading: () => Center(
                  child: CircularProgressIndicator(
                    color: ThemeBase.of(context).primaryText,
                    strokeWidth: 0.5,
                  ),
                ),
            error: (error, stack) => Center(
                  child: Text("Error: $error"),
                )));
  }
}
