import 'dart:io';

import 'package:exopek_workout_app/components/Profil/CustomTimelineTile.dart';
import 'package:exopek_workout_app/components/WorkoutLists/WorkoutCardHorizontal.dart';
import 'package:exopek_workout_app/data/AppStateProvider.dart';
import 'package:exopek_workout_app/dependencyInjection/userProvider/UserProvider.dart';
import 'package:exopek_workout_app/domain/Models/User.dart';
import 'package:exopek_workout_app/utils/AppRouter.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:image_picker/image_picker.dart';
import 'package:timeline_tile/timeline_tile.dart';

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
        maxHeight: 600
      );
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
        ref.invalidate(asyncProfilPageControllerProvider);
        /* setState(() {
          
        }); */
      }
      if (next is AsyncError) {
        ScaffoldMessenger.of(context).showSnackBar(SnackBar(
          content: Text(next.error.toString()),
        ));
      }
     });
    final profilPageControllerProvider =
        ref.watch(asyncProfilPageControllerProvider);
    return profilPageControllerProvider.when(
      data: (data) {
        return Scaffold(
            backgroundColor: Color(0xFF0C0C0C),
            appBar: AppBar(
                backgroundColor: Color(0xFF212326),
                actions: [IconButton(onPressed: () {
                  AppRouter.goToSettings(data.user);
                }, icon: Icon(Icons.settings))],
                title: Text('Profil')),
            body: Container(
                      height: MediaQuery.of(context).size.height,
                      width: MediaQuery.of(context).size.width,
                      child: Container(
                        width: MediaQuery.of(context).size.width,
                        height: 1310,
                        clipBehavior: Clip.antiAlias,
                        decoration: BoxDecoration(color: Color(0xFF0C0C0C)),
                        child: Stack(
                          children: [
                            Positioned(
                              left: 93,
                              top: 91,
                              child: Builder(builder: (context) {
                                if (data.user.imageUrl != null) {
                                  return Container(
                                    width: 200,
                                    height: 200,
                                    decoration: ShapeDecoration(
                                      image: DecorationImage(
                                        image: NetworkImage(data.user.imageUrl!),
                                        fit: BoxFit.cover,
                                      ),
                                      shape: OvalBorder(),
                                    ),
                                    child: TextButton(
                                      onPressed: () async {
                                        var image = await getImageFromGallery(data.user);
                                        if (image != null) {
                                          ref.read(uploadProfilImageButtonControllerProvider.notifier).updateUserImage(
                                              file: File(image.path),
                                            );
                                        }
                                      },
                                       child: Container()),
                                  );
                                } else {
                                  return Container(
                                    width: 200,
                                    height: 200,
                                    decoration: ShapeDecoration(
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
                                          ref.read(uploadProfilImageButtonControllerProvider.notifier).updateUserImage(
                                              file: File(image.path),
                                            );
                                        }
                                      },
                                      child: Icon(Icons.person,
                                          color: Colors.white, size: 100),
                                    ),
                                  );
                                }
                              }),
                            ),
                            Positioned(
                              left: 38,
                              top: 593,
                              child: Container(
                                width: 309,
                                height: 43,
                                decoration: BoxDecoration(color: Color(0x00D9D9D9)),
                              ),
                            ),
                            Positioned(
                              left: 16,
                              top: 36,
                              child: Text(
                                data.user.firstname + ' ' + data.user.lastname,
                                style: TextStyle(
                                  color: Colors.white,
                                  fontSize: 16,
                                  fontFamily: 'Inter',
                                  fontWeight: FontWeight.w600,
                                  height: 0,
                                ),
                              ),
                            ),
                            Positioned(
                              left: 16,
                              top: 55,
                              child: Text(
                                'EXOPEK Athlet',
                                style: TextStyle(
                                  color: Color(0xFF838282),
                                  fontSize: 10,
                                  fontFamily: 'Inter',
                                  fontWeight: FontWeight.w600,
                                  height: 0,
                                ),
                              ),
                            ),
                            Positioned(
                              left: 16,
                              top: 341,
                              child: Text(
                                'Letzten Workouts',
                                style: TextStyle(
                                  color: Colors.white,
                                  fontSize: 20,
                                  fontFamily: 'Inter',
                                  fontWeight: FontWeight.w600,
                                  height: 0,
                                ),
                              ),
                            ),
                            Positioned(
                              left: 4,
                              top: 371,
                              child: Container(
                                  width: MediaQuery.of(context).size.width,
                                  height: 360,
                                  child: ListView.builder(
                                    scrollDirection: Axis.vertical,
                                    itemCount: data.workouts.length,
                                    itemBuilder: (context, index) {
                                      return CustomTimelineTile(
                                        workoutName: data.workouts[index].workout.name,
                                        date: data.workouts[index].createdAt.toIso8601String().split("T")[0],
                                        isFirst: index == 0,
                                        isLast: index == data.workouts.length - 1,
                                        isPast: index > 0 && index < data.workouts.length - 1,
                                      );
                                      /* TextButton(
                                        onPressed: () {
                                          ref
                                              .read(selectedWorkoutIdProvider
                                                  .notifier)
                                              .state = data.workouts[index].workout.id;
                                          AppRouter.goToWorkoutDetail();
                                        },
                                        child: SizedBox(
                                          width: MediaQuery.of(context).size.width *
                                              0.8,
                                          child: WorkoutCardHorizontal(
                                              workout: data.workouts[index].workout),
                                        ),
                                      ); */
                                    },
                                  )),
                            ),
                          ],
                        ),
                      ))
                
               );
      },
      loading: () {
        return Scaffold(
          body: Center(
            child: CircularProgressIndicator(),
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
