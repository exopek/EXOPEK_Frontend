import 'package:exopek_workout_app/components/Shared/RatingStars.dart';
import 'package:exopek_workout_app/domain/Models/Comment.dart';
import 'package:exopek_workout_app/theme/ThemeBase.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:intl/intl.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

class CommentRatingCard extends StatelessWidget {
  final Comment comment;
  const CommentRatingCard({super.key, required this.comment});

  String _timeAgo(BuildContext context) {
    final now = DateTime.now();
    DateFormat format = DateFormat('MM.dd.yy HH:mm:ss'); // MM.dd.yyyy HH:mm:ss für lokal backend laufend , MM/dd/yy HH:mm:ss für heroku
    final createdAtDate = format.parseUTC(comment.createdAt!);
    final difference = now.difference(createdAtDate);
    if (difference.inDays > 0) {
      return AppLocalizations.of(context).commentRatingCardBefore + ' ' + difference.inDays.toString() + ' ' + AppLocalizations.of(context).commentRatingCardDays;
    } else if (difference.inHours > 0) {
      return AppLocalizations.of(context).commentRatingCardBefore + ' ' + difference.inHours.toString() + ' ' + AppLocalizations.of(context).commentRatingCardHours;
    } else if (difference.inMinutes > 0) {
      return AppLocalizations.of(context).commentRatingCardBefore + ' ' + difference.inMinutes.toString() + ' ' + AppLocalizations.of(context).commentRatingCardMinutes;
    } else {
      return AppLocalizations.of(context).commentRatingCardNow;
    }
  }

  @override
  Widget build(BuildContext context) {
    return Material(
      color: Colors.transparent,
      child: Column(
        children: [
          Row(
            children: [
              Container(
                width: 40,
                height: 40,
                decoration: BoxDecoration(
                  shape: BoxShape.circle,
                  border: Border.fromBorderSide(BorderSide(
                    color: ThemeBase.of(context).secondaryText,
                    width: 1,
                  )),
                ),
                child: Center(
                  child: Text(
                    comment.firstName![0].toUpperCase(),
                    style: ThemeBase.of(context).titleSmall,
                  ),
                )
              ),
              const SizedBox(
                width: 10,
              ),
              Text(
                comment.firstName!,
                style: ThemeBase.of(context).titleSmall,
              ),
            ],
          ),
          const SizedBox(
            height: 10,
          ),
          Row(
            children: [
              RatingStars(
                rating: double.tryParse(comment.rating.toString()) ?? 0,
              ),
              const SizedBox(
                width: 8,
              ),
              // vertical divider
              Container(
                height: 14,
                width: 1,
                color: ThemeBase.of(context).secondaryText,
              ),
              
              const SizedBox(
                width: 8,
              ),
              Text(_timeAgo(context),
                  style: ThemeBase.of(context).labelMedium
                    .copyWith(color: ThemeBase.of(context).secondaryText)),
            ],
          ),
          const SizedBox(
            height: 10,
          ),
          Align(
            alignment: Alignment.centerLeft,
            child: Text(
              comment.comment!,
              style: ThemeBase.of(context).bodySmall,
            ),
          ),
          const SizedBox(
            height: 10,
          ),
          Divider(
            color: ThemeBase.of(context).secondaryText,
            height: 10,
            thickness: 1,
          )
        ],
      ),
    );
  }
}
