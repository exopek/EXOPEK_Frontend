import 'package:exopek_workout_app/components/CommentCard.dart';
import 'package:exopek_workout_app/dependencyInjection/commentsProvider/commentsPageProvider.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

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
        return Scaffold(
          body: Container(
            width: MediaQuery.of(context).size.width,
            height: MediaQuery.of(context).size.height,
            clipBehavior: Clip.antiAlias,
            decoration: const BoxDecoration(color: Color(0xFF0C0C0C)),
            child: Column(
              children: [
                Container(
                  width: MediaQuery.of(context).size.width,
                  height: 110,
                  decoration: const BoxDecoration(color: Color(0xFF212326)),
                  child: Padding(
                    padding: EdgeInsets.only(top: 50.0),
                    child: Center(
                      child: Text(
                        'Comments (${data.length})',
                        style: TextStyle(
                          color: Colors.white,
                          fontSize: 20,
                          fontFamily: 'Inter',
                          fontWeight: FontWeight.w400,
                          height: 0,
                        ),
                      ),
                    ),
                  ),
                ),
                Expanded(
                    child: ListView.builder(
                        physics: const ClampingScrollPhysics(),
                        padding: EdgeInsets.zero,
                        itemCount: data.length,
                        itemBuilder: (context, index) {
                          return CommentCard(
                            comment: data[index].comment ?? '',
                            name: data[index].firstName ?? '',
                            createdAt: data[index].createdAt ?? '',
                            lastName: data[index].lastName ?? '',
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
