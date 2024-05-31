import 'package:exopek_workout_app/data/AppStateProvider.dart';
import 'package:exopek_workout_app/dependencyInjection/userProvider/UserProvider.dart';
import 'package:exopek_workout_app/theme/ThemeBase.dart';
import 'package:exopek_workout_app/utils/AppRouter.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class DashboardSideMenu extends ConsumerStatefulWidget {
  final double dashBoardWidth;
  const DashboardSideMenu(this.dashBoardWidth, {super.key});

  @override
  ConsumerState<DashboardSideMenu> createState() => _DashboardSideMenuState();
}

class _DashboardSideMenuState extends ConsumerState<DashboardSideMenu> {
  @override
  Widget build(BuildContext context) {
    final selectedNavigationBarCustomIndex =
        ref.watch(selectedNavigationBarIndexProvider);
    final user = ref.watch(userStateProvider);
    return Stack(
      children: [
        Container(
          height: MediaQuery.sizeOf(context).height,
          width: MediaQuery.sizeOf(context).width * 0.8,
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.only(
              topRight: Radius.circular(20),
              bottomRight: Radius.circular(20),
            ),
          ),
          child: Column(
            children: <Widget>[
              Material(
                child: Container(
                  height: 200,
                  color: ThemeBase.of(context).secondaryBackground,
                  child: Stack(
                    children: [
                      Positioned(
                        left: 16,
                        top: 100,
                        child: Builder(builder: (context) {
                          if (user!.imageUrl != null) {
                            return Container(
                              width: 65,
                              height: 65,
                              decoration: ShapeDecoration(
                                image: DecorationImage(
                                  image: NetworkImage(
                                      user.imageUrl ?? 'https://via.placeholder.com/150'),
                                  fit: BoxFit.cover,
                                ),
                                shape: OvalBorder(
                                  side: BorderSide(
                                      width: 1, color: Color(0xFF262424)),
                                ),
                              ),
                            );
                          } else {
                            return Container(
                              width: 65,
                              height: 65,
                              decoration: ShapeDecoration(
                                shape: OvalBorder(
                                  side: BorderSide(
                                      width: 1, color: Color(0xFF262424)),
                                ),
                              ),
                              child: Center(
                                child: Text(
                                  'Jan Sugint',
                                  style: TextStyle(
                                    color: Colors.white,
                                    fontSize: 24,
                                    fontFamily: 'Inter',
                                    fontWeight: FontWeight.w400,
                                    height: 0,
                                  ),
                                ),
                              ),
                            );
                          }
                        }),
                      ),
                      Positioned(
                        left: 86,
                        top: 117,
                        child: SizedBox(
                          child: Text(
                            user!.firstname + ' ' + user.lastname,
                            style: TextStyle(
                              color: Colors.white,
                              fontSize: 16,
                              fontFamily: 'Inter',
                              fontWeight: FontWeight.w400,
                              height: 0,
                            ),
                          ),
                        ),
                      ),
                      Positioned(
                        left: 86,
                        top: 137,
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
                    ],
                  ),
                ),
              ),
              Expanded(
                child: Container(
                  color: ThemeBase.of(context).primaryBackground,
                  child: Column(
                    children: [
                      Container(
                        width: double.infinity,
                        child: TextButton(
                          onPressed: () {
                            ref
                                .read(
                                    selectedNavigationBarIndexProvider.notifier)
                                .state = 0;
                            Navigator.pop(context);
                          },
                          child: Row(
                            children: [
                              Icon(
                                Icons.home_filled,
                                color:  Color(0xFFD9D9D9),
                                size: 24,
                              ),
                              const SizedBox(
                                width: 10,
                              ),
                              Text(
                                'Coach',
                                style: TextStyle(
                                  height: 0,
                                  fontSize: 16,
                                  color:  Color(0xFFD9D9D9),
                                ),
                              ),
                            ],
                          ),
                        ),
                      ),
                     /*  Container(
                        width: double.infinity,
                        child: TextButton(
                          onPressed: () {
                            ref
                                .read(
                                    selectedNavigationBarIndexProvider.notifier)
                                .state = 1;
                            Navigator.pop(context);
                          },
                          child: Row(
                            children: [
                              Icon(
                                Icons.search,
                                color: selectedNavigationBarCustomIndex == 1
                                    ? Colors.red
                                    : Color(0xFFD9D9D9),
                                size: 24,
                              ),
                              const SizedBox(
                                width: 10,
                              ),
                              Text(
                                'Discover',
                                style: TextStyle(
                                  fontSize: 16,
                                  height: 0,
                                  color: selectedNavigationBarCustomIndex == 1
                                      ? Colors.red
                                      : Color(0xFFD9D9D9),
                                ),
                              ),
                            ],
                          ),
                        ),
                      ), */
                      Container(
                        width: double.infinity,
                        child: TextButton(
                          onPressed: () {
                            ref
                                .read(
                                    selectedNavigationBarIndexProvider.notifier)
                                .state = 2;
                            AppRouter.goToProfile();
                          },
                          child: Row(
                            children: [
                              Icon(
                                Icons.person_2_rounded,
                                color: Color(0xFFD9D9D9),
                                size: 24,
                              ),
                              const SizedBox(
                                width: 10,
                              ),
                              Text(
                                'Profile',
                                style: TextStyle(
                                  fontSize: 16,
                                  height: 0,
                                  color: Color(0xFFD9D9D9),
                                ),
                              ),
                            ],
                          ),
                        ),
                      ),
                      Container(
                        width: double.infinity,
                        child: TextButton(
                          onPressed: () {
                            AppRouter.goToSettings();
                           /*  ref
                                .read(
                                    selectedNavigationBarIndexProvider.notifier)
                                .state = 3; */
                            
                            
                          },
                          child: Row(
                            children: [
                              Icon(
                                Icons.settings,
                                color:  Color(0xFFD9D9D9),
                                size: 24,
                              ),
                              const SizedBox(
                                width: 10,
                              ),
                              Text(
                                'Einstellungen',
                                style: TextStyle(
                                  fontSize: 16,
                                  height: 0,
                                  color:  Color(0xFFD9D9D9),
                                ),
                              ),
                            ],
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
              Divider(
                color: Colors.black,
                height: 1,
              ),
              Container(
                height: 100,
                color: ThemeBase.of(context).primaryBackground,
              ),
            ],
          ),
        )
      ],
    );
  }
}
