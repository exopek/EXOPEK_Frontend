import 'package:exopek_workout_app/components/CommentCard.dart';
import 'package:exopek_workout_app/dependencyInjection/commentsProvider/commentsPageProvider.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../components/WorkoutDetailPage/CommentRatingCard.dart';

class CommentsPage extends ConsumerStatefulWidget {
  const CommentsPage({super.key});

  @override
  ConsumerState<CommentsPage> createState() => _CommentsPageState();
}

class _CommentsPageState extends ConsumerState<CommentsPage> {
  @override
  Widget build(BuildContext context) {
    var result = ref.watch(commentsProvider);
    return result.when(
      data: (data) {
        var sortedData = data.where((element) => element.comment!.isNotEmpty).toList();
        return Scaffold(
          appBar: AppBar(
            backgroundColor: const Color(0xFF212326),
            centerTitle: false,
            title: Text(
              'Bewertungen',
              style: const TextStyle(
                color: Colors.white,
                fontSize: 20,
                fontFamily: 'Inter',
                fontWeight: FontWeight.w400,
                height: 0,
              ),
            ),
          ),
          body: Container(
            width: MediaQuery.of(context).size.width,
            height: MediaQuery.of(context).size.height,
            clipBehavior: Clip.antiAlias,
            decoration: const BoxDecoration(color: Color(0xFF0C0C0C)),
            child: Column(
              children: [
                
                Expanded(
                    child: ListView.builder(
                        physics: const ClampingScrollPhysics(),
                        padding: EdgeInsets.zero,
                        itemCount: sortedData.length,
                        itemBuilder: (context, index) {
                          return Padding(
                            padding: const EdgeInsets.only(left: 16.0, right: 16.0, top: 8.0),
                            child: CommentRatingCard(
                              comment: sortedData[index],
                            ),
                          );
                        }))
              ],
            ),
          ),
        );
      },
      loading: () {
        return const Scaffold(
          body: Center(
            child: CircularProgressIndicator(),
          ),
        );
      },
      error: (error, stackTrace) {
        return Scaffold(
          body: Center(
            child: Text(error.toString()),
          ),
        );
      },
    );
  }
}
