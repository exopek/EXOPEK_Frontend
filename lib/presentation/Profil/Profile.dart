import 'dart:io';

import 'package:exopek_workout_app/components/PlanCardHorizontal.dart';
import 'package:exopek_workout_app/components/PlanProgressWithImageCard.dart';
import 'package:exopek_workout_app/components/Profil/UserInsightsCard.dart';
import 'package:exopek_workout_app/components/WorkoutLists/WorkoutCardHorizontal.dart';
import 'package:exopek_workout_app/dependencyInjection/userProvider/UserProvider.dart';
import 'package:exopek_workout_app/domain/Models/User.dart';
import 'package:exopek_workout_app/theme/ThemeBase.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:image_picker/image_picker.dart';

class Profile extends ConsumerStatefulWidget {
  const Profile({super.key});

  @override
  ConsumerState<Profile> createState() => _ProfileState();
}

class _ProfileState extends ConsumerState<Profile> {
  final ImagePicker _picker = ImagePicker();
  XFile? _image;

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
    final profilPageControllerProvider =
        ref.watch(asyncProfilPageControllerProvider);
    return profilPageControllerProvider.when(
      data: (data) {
        return Scaffold(
            backgroundColor: Color(0xFF0C0C0C),
            appBar: AppBar(
                centerTitle: false,
                backgroundColor: Color(0xFF212326),
                title: Text('Profil')),
            body: Container(
                height: MediaQuery.of(context).size.height,
                width: MediaQuery.of(context).size.width,
                child: Container(
                  width: MediaQuery.of(context).size.width,
                  height: 1310,
                  clipBehavior: Clip.antiAlias,
                  decoration: BoxDecoration(color: Color(0xFF0C0C0C)),
                  child: Column(
                    children: [
                      const SizedBox(height: 20),
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
                            child: const Icon(Icons.person,
                                  color: Colors.white, size: 100)
                          );
                        }
                      }),
                      const SizedBox(height: 16),
                      Text(
                        data.user.firstname + ' ' + data.user.lastname,
                        style: ThemeBase.of(context).bodyLarge,
                      ),
                      const SizedBox(height: 2.5),
                      Text(
                        'EXOPEK Athlet',
                        style: ThemeBase.of(context).bodySmall.copyWith(
                            color: ThemeBase.of(context).secondaryText,
                            fontSize: 12.0),
                      ),
                      const SizedBox(height: 20),
                      Padding(
                        padding: EdgeInsets.only(left: 16.0, right: 16.0),
                        child: Row(
                          children: [
                            Expanded(
                                child: UserInsightsCard(
                                    insightName: 'Workouts',
                                    insightValue:
                                        data.workouts.length.toString())),
                            SizedBox(width: 10),
                            Expanded(
                                child: UserInsightsCard(
                                    insightName: 'Pläne',
                                    insightValue:
                                        data.plans.length.toString())),
                          ],
                        ),
                      ),
                      const SizedBox(height: 20),
                      if (data.workouts.isNotEmpty)
                        Align(
                          alignment: Alignment.centerLeft,
                          child: Padding(
                            padding: EdgeInsets.only(left: 16.0),
                            child: Text(
                              'Letzten Workouts',
                              style: ThemeBase.of(context).headlineSmall,
                            ),
                          ),
                        ),
                      const SizedBox(height: 10),
                      SizedBox(
                          width: MediaQuery.of(context).size.width,
                          height: 105,
                          child: ListView.builder(
                            padding: const EdgeInsets.only(left: 16.0),
                            scrollDirection: Axis.horizontal,
                            itemCount: data.workouts.take(3).length,
                            itemBuilder: (context, index) {
                              return Padding(
                                padding: const EdgeInsets.only(right: 16.0),
                                child: SizedBox(
                                  width:
                                      MediaQuery.of(context).size.width * 0.8,
                                  child: WorkoutCardHorizontal(
                                    workout: data.workouts[index].workout,
                                    lastTrained: data.workouts[index].createdAt
                                        .toIso8601String()
                                        .split("T")[0],
                                  ),
                                ),
                              );
                            },
                          )),
                      const SizedBox(height: 20),
                      if (data.plans.isNotEmpty)
                        Align(
                          alignment: Alignment.centerLeft,
                          child: Padding(
                            padding: EdgeInsets.only(left: 16.0),
                            child: Text(
                              'Abgeschlossene Pläne',
                              style: ThemeBase.of(context).headlineSmall,
                            ),
                          ),
                        ),
                      const SizedBox(height: 10),
                      SizedBox(
                          width: MediaQuery.of(context).size.width,
                          height: 156,
                          child: ListView.builder(
                            padding: const EdgeInsets.only(left: 16.0),
                            scrollDirection: Axis.horizontal,
                            itemCount: data.plans.take(3).length,
                            itemBuilder: (context, index) {
                              return Padding(
                                padding: const EdgeInsets.only(right: 16.0),
                                child: SizedBox(
                                  width:
                                      MediaQuery.of(context).size.width * 0.8,
                                  child: PlanProgressWithImageCard(
                                      planStatus: data.planStatuses.firstWhere(
                                          (element) =>
                                              element.planId ==
                                              data.plans[index].id),
                                      plan: data.plans[index]),
                                ),
                              );
                            },
                          )),
                    ],
                  ),
                )));
      },
      loading: () {
        return Scaffold(
          backgroundColor: ThemeBase.of(context).primaryBackground,
          body: Center(
            child: CircularProgressIndicator(
              color: ThemeBase.of(context).secondary,
              strokeWidth: 0.5,
            ),
          ),
        );
      },
      error: (error, stackTrace) {
        return Scaffold(
          body: Center(
            child: Text('Error: $error'),
          ),
        );
      },
    );
  }
}
