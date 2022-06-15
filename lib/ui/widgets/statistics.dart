import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:like_button/like_button.dart';
import 'package:loginv1/constants/theme.dart';
import 'package:loginv1/models/task.dart';
import 'package:loginv1/ui/pages/statsPage.dart';

class StatsW extends StatefulWidget {
  const StatsW({Key? key, required this.task}) : super(key: key);
  final Task task;
  @override
  // ignore: no_logic_in_create_state
  _StatsWState createState() => _StatsWState();
}

class _StatsWState extends State<StatsW> {
  bool isLiked = false;
  bool hasBackground = false;

  final key = GlobalKey<LikeButtonState>();

  @override
  Widget build(BuildContext context) {
    final double size = 18;
    final animationDuration = Duration(milliseconds: 1500);

    return OutlinedButton(
      style: OutlinedButton.styleFrom(
        fixedSize: Size.fromWidth(100),
        padding: EdgeInsets.zero,
      ),
      onPressed: () async {
        key.currentState!.onTap();
      },
      child: IgnorePointer(
        child: LikeButton(
            key: key,
            padding: EdgeInsets.all(6),
            size: size,
            isLiked: isLiked,
            circleColor: CircleColor(
              start: Colors.blue,
              end: Colors.blue,
            ),
            bubblesColor: BubblesColor(
              dotPrimaryColor: Colors.green,
              dotSecondaryColor: Colors.greenAccent,
            ),
            likeBuilder: (isLiked) {
              final color = isLiked ? Colors.black : Colors.black;
              return Icon(Icons.add_chart, color: color, size: size);
            },
            animationDuration: animationDuration,
            likeCountPadding: EdgeInsets.only(left: 6),
            onTap: (isLiked) async {
              this.isLiked = !isLiked;

              Future.delayed(animationDuration)
                  .then((_) => setState(() => hasBackground = !isLiked));

              Get.to(statsPage(task: widget.task,));
              return !isLiked;
            }),
      ),
    );
  }
}
