import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

class CommentCard extends StatelessWidget {
  final String name;
  final String comment;
  final String createdAt;
  final String lastName;
  const CommentCard(
      {super.key,
      required this.name,
      required this.comment,
      required this.createdAt,
      required this.lastName});

  String get timeAgo {
    final now = DateTime.now();
    DateFormat format = DateFormat('MM.dd.yyyy HH:mm:ss'); // MM/dd/yy HH:mm:ss
    final createdAtDate = format.parseUTC(createdAt);
    final difference = now.difference(createdAtDate);
    if (difference.inDays > 0) {
      return '${difference.inDays}d ago';
    } else if (difference.inHours > 0) {
      return '${difference.inHours}h ago';
    } else if (difference.inMinutes > 0) {
      return '${difference.inMinutes}m ago';
    } else {
      return 'now';
    }
  }

  String get nameInitials {
    return name[0] + lastName[0];
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 390,
      height: 65,
      decoration: BoxDecoration(
        color: Color(0x00D9D9D9),
        border: Border(
          bottom: BorderSide(width: 1, color: Color(0xFF262424)),
        ),
      ),
      child: Stack(
        children: [
          Positioned(
              left: 16,
              top: 10,
              child: Container(
                width: 45,
                height: 45,
                child: Stack(
                  children: [
                    Positioned(
                      left: 0,
                      top: 0,
                      child: Container(
                        width: 45,
                        height: 45,
                        decoration: ShapeDecoration(
                          gradient: LinearGradient(
                            begin: Alignment(0.00, -1.00),
                            end: Alignment(0, 1),
                            colors: [Color.fromARGB(255, 109, 56, 214), Color(0xFF414141)],
                          ),
                          shape: OvalBorder(),
                        ),
                      ),
                    ),
                    Positioned(
                      child: Center(
                        child: Text(
                          nameInitials.toUpperCase(),
                          style: TextStyle(
                            color: Colors.white,
                            fontSize: 12,
                            fontFamily: 'Inter',
                            fontWeight: FontWeight.w600,
                            height: 0,
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
              )),
          Positioned(
            left: 68,
            top: 17,
            child: Text(
              '${name} - ${timeAgo}',
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
            left: 68,
            top: 32,
            child: Text(
              comment,
              style: TextStyle(
                color: Color(0xFFEEEBEB),
                fontSize: 10,
                fontFamily: 'Inter',
                fontWeight: FontWeight.w600,
                height: 0,
              ),
            ),
          ),
        ],
      ),
    );
  }
}
