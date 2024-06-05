import 'package:exopek_workout_app/theme/ThemeBase.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

abstract class GenericAppBar {
  static PreferredSizeWidget build(BuildContext context, String title,
          {bool? hasDivider = true, List<Widget>? actions = const []}) =>
      PreferredSize(
        preferredSize: const Size.fromHeight(56.0),
        child: Column(
          children: [
            AppBar(
              elevation: 0,
              centerTitle: false,
              backgroundColor: Colors.transparent,
              titleSpacing: 0,
              title: Text(
                title,
                style: ThemeBase.of(context).titleSmall.copyWith(
                      color: ThemeBase.of(context).primaryText,
                    ),
              ),
              actions: actions,
            ),
            if (hasDivider == true)
              Divider(
                height: 0,
                color: ThemeBase.of(context).secondaryText,
                thickness: 1,
              )
          ],
        ),
      );
}
