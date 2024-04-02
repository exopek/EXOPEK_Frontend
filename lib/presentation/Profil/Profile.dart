import 'package:exopek_workout_app/components/Profil/CustomTimelineTile.dart';
import 'package:exopek_workout_app/components/WorkoutLists/WorkoutCardHorizontal.dart';
import 'package:exopek_workout_app/data/AppStateProvider.dart';
import 'package:exopek_workout_app/dependencyInjection/userProvider/UserProvider.dart';
import 'package:exopek_workout_app/utils/AppRouter.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:timeline_tile/timeline_tile.dart';

class Profile extends ConsumerStatefulWidget {
  const Profile({super.key});

  @override
  ConsumerState<Profile> createState() => _ProfileState();
}

class _ProfileState extends ConsumerState<Profile> {
  @override
  Widget build(BuildContext context) {
    final profilPageControllerProvider =
        ref.watch(asyncProfilPageControllerProvider);
    return Scaffold(
        backgroundColor: Color(0xFF0C0C0C),
        appBar: AppBar(
            backgroundColor: Color(0xFF212326),
            actions: [IconButton(onPressed: () {}, icon: Icon(Icons.settings))],
            title: Text('Profile')),
        body: profilPageControllerProvider.when(
            data: (data) {
              return Container(
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
                                child: Icon(Icons.person,
                                    color: Colors.white, size: 100),
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
                            'Last Sessions',
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
                  ));
            },
            loading: () => const Center(child: CircularProgressIndicator()),
            error: (error, stackTrace) =>
                Center(child: Text('Error: $error'))));
  }
}
