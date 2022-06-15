import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:like_button/like_button.dart';
import 'package:loginv1/constants/theme.dart';
import 'package:loginv1/controllers/auth_controller.dart';
import 'package:loginv1/models/modele.dart';
import 'package:loginv1/models/task.dart';
import 'package:loginv1/services/Database.dart';

class LikeButtonW extends StatefulWidget {
  LikeButtonW({required this.task});
  final Task task;
  @override
  // ignore: no_logic_in_create_state
  _LikeButtonWState createState() => _LikeButtonWState();
}

class _LikeButtonWState extends State<LikeButtonW> {
  bool isLiked = false;
  bool hasBackground = false;
  int likeCount = 0;
  final key = GlobalKey<LikeButtonState>();

  @override
  Widget build(BuildContext context) {
    final double size = 18;
    final animationDuration = Duration(milliseconds: 1500);

    return GetBuilder<AuthController>(
      init: AuthController(),
      builder: (controller) => controller.firestoreUser.value!.uid == null
          ? Center(
              child: CircularProgressIndicator(),
            )
          : StreamBuilder<Task>(
              stream: DatabaseService(docid: widget.task.docId).singleTask,
              builder: (context, snapshot) {
                if (!snapshot.hasData) return const SizedBox.shrink();
                return Builder(
                  builder: (context) {
                    final likesCountFb = snapshot.data!.taskLikes;
                    final userData = controller.firestoreUser.value;
                    final isFav =
                        userData?.isFavorite?.contains(widget.task.docId);
                    return OutlinedButton(
                      style: OutlinedButton.styleFrom(
                        fixedSize: Size.fromWidth(100),
                        padding: EdgeInsets.zero,
                      ),
                      onPressed: () async {
                        key.currentState!.onTap();
                        if (isFav == true) {
                          await DatabaseService(uid: userData!.uid)
                              .removeFavorite(widget.task.docId);
                          await DatabaseService(docid: widget.task.docId)
                              .decreaseTaskLikes();
                          await DatabaseService(
                                  docid: widget.task.docId, uid: userData.uid)
                              .removeFavUserFromTask();
                        } else {
                          await DatabaseService(uid: userData!.uid)
                              .addFavorite(widget.task.docId);
                          await DatabaseService(docid: widget.task.docId)
                              .increaseTaskLikes();
                          await DatabaseService(
                                  docid: widget.task.docId, uid: userData.uid)
                              .addFavUserToTask();
                        }
                      },
                      child: IgnorePointer(
                        child: LikeButton(
                            key: key,
                            padding: EdgeInsets.all(6),
                            size: size,
                            isLiked: isFav,
                            likeCount: likesCountFb,
                            circleColor: CircleColor(
                              start: Colors.blue,
                              end: Colors.blue,
                            ),
                            bubblesColor: BubblesColor(
                              dotPrimaryColor: Colors.green,
                              dotSecondaryColor: Colors.greenAccent,
                            ),
                            likeBuilder: (isLiked) {
                              final color =
                                  isLiked ? Colors.black : Colors.grey;

                              return Icon(Icons.favorite,
                                  color: color, size: size);
                            },
                            animationDuration: animationDuration,
                            likeCountPadding: EdgeInsets.only(left: 6),
                            countBuilder: (count, isLiked, text) {
                              final color =
                                  isLiked ? Colors.black : Colors.grey;

                              return Text(
                                text,
                                style: TextStyle(
                                  color: color,
                                  fontSize: 18,
                                  fontWeight: FontWeight.bold,
                                ),
                              );
                            },
                            onTap: (isLiked) async {
                              this.isLiked = !isLiked;
                              likeCount += this.isLiked ? 1 : -1;
                              // Future.delayed(animationDuration).then((_) =>
                              //     setState(() => hasBackground = !isLiked));

                              return !isLiked;
                            }),
                      ),
                    );
                  },
                );
              },
            ),
    );
  }
}
