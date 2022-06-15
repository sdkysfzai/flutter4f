import 'package:flutter/material.dart';
import 'package:flutter_staggered_animations/flutter_staggered_animations.dart';
import 'package:get/get.dart';
import 'package:get/get_state_manager/src/simple/get_state.dart';
import '../../constants/size_config.dart';
import '../../constants/theme.dart';
import '../../controllers/auth_controller.dart';
import '../../controllers/task_controller.dart';
import '../../models/task.dart';
import '../../services/Database.dart';
import 'package:intl/intl.dart';

import '../widgets/task_tile.dart';

class Fav extends StatefulWidget {
  const Fav({Key? key}) : super(key: key);

  @override
  _FavState createState() => _FavState();
}

class _FavState extends State<Fav> {
  late Stream<List<Task>> _tasks;
  @override
  void initState() {
    super.initState();
    _tasks = DatabaseService().tasks;
  }

  @override
  DateTime _selectedDate = DateTime.parse(DateTime.now().toString());
  final _taskController = Get.put(TaskController());
  late var notifyHelper;
  Widget build(BuildContext context) {
    return GetBuilder<AuthController>(
        init: AuthController(),
        builder: (controller) => controller.firestoreUser.value!.uid == null
            ? Center(
                child: CircularProgressIndicator(),
              )
            : StreamBuilder<List<Task>>(
                stream: _tasks,
                builder: (context, snapshot) {
                  if (!snapshot.hasData)
                    return Center(child: CircularProgressIndicator());
                  final tasks = snapshot.data;
                  final favoriteTasks = tasks
                      ?.where((element) => controller
                          .firestoreUser.value!.isFavorite!
                          .contains(element.docId))
                      .toList();
                  if (favoriteTasks!.isEmpty) {
                    return const Center(
                      child: Text('No favorite tasks yet'),
                    );
                  }
                  return ListView.builder(
                      scrollDirection: Axis.vertical,
                      itemCount: favoriteTasks.length,
                      itemBuilder: (context, index) {
                        final task = favoriteTasks[index];
                        if (task.repeat == 'Daily') {
                          var hour = task.startTime.toString().split(":")[0];
                          var minutes = task.startTime.toString().split(":")[1];
                          debugPrint("My time is " + hour);
                          debugPrint("My minute is " + minutes);
                          DateTime date =
                              DateFormat.jm().parse(task.startTime!);
                          var myTime = DateFormat("HH:mm").format(date);
                          /*
                  print("my date "+date.toString());
                  print("my time " +myTime);
                  var t=DateFormat("M/d/yyyy hh:mm a").parse(task.date+" "+task.startTime);
                  print(t);
                  print(int.parse(myTime.toString().split(":")[0]));*/
                          notifyHelper.scheduledNotification(
                              int.parse(myTime.toString().split(":")[0]),
                              int.parse(myTime.toString().split(":")[1]),
                              task);

                          return AnimationConfiguration.staggeredList(
                            position: index,
                            duration: const Duration(milliseconds: 1375),
                            child: SlideAnimation(
                              horizontalOffset: 300.0,
                              child: FadeInAnimation(
                                child: Row(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    GestureDetector(
                                        onTap: () {
                                          showBottomSheet(context, task);
                                        },
                                        child: TaskTile(task)),
                                  ],
                                ),
                              ),
                            ),
                          );
                        }
                        if (task.date ==
                            DateFormat.yMd().format(_selectedDate)) {
                          //notifyHelper.scheduledNotification();
                          return AnimationConfiguration.staggeredList(
                            position: index,
                            duration: const Duration(milliseconds: 1375),
                            child: SlideAnimation(
                              horizontalOffset: 300.0,
                              child: FadeInAnimation(
                                child: Row(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    GestureDetector(
                                        onTap: () {
                                          showBottomSheet(context, task);
                                        },
                                        child: TaskTile(task)),
                                  ],
                                ),
                              ),
                            ),
                          );
                        } else {
                          return Container();
                        }
                      });
                },
              ));
  }

  showBottomSheet(BuildContext context, Task task) {
    Get.bottomSheet(
      Container(
        color: Colors.orange[50],
        padding: EdgeInsets.only(top: 4),
        height: task.isCompleted == 1
            ? SizeConfig.screenHeight * 0.24 * 1 / 2
            : SizeConfig.screenHeight * 0.36 * 1 / 2,
        width: SizeConfig.screenWidth,
        // color: Get.isDarkMode ? darkHeaderClr : Colors.white,
        child: Column(children: [
          Container(
            height: 6,
            width: 120,
            decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(10),
                color: Get.isDarkMode ? Colors.grey[600] : Colors.grey[300]),
          ),
          Spacer(),
          task.isCompleted == 1
              ? Container()
              : _buildBottomSheetButton(
                  label: "I'M GOING",
                  onTap: () {
                    _taskController.markTaskCompleted(task.id);
                    Get.back();
                  },
                  clr: Colors.green),
          _buildBottomSheetButton(
              label: "Not Interested",
              onTap: () {
                _taskController.deleteTask(task);
                Get.back();
              },
              clr: Colors.red[300]),
          SizedBox(
            height: 20,
          ),
        ]),
      ),
    );
  }

  _buildBottomSheetButton(
      {required String label,
      Function? onTap,
      Color? clr,
      bool isClose = false}) {
    return GestureDetector(
      onTap: onTap as void Function()?,
      child: Container(
        margin: EdgeInsets.symmetric(vertical: 4),
        height: 55,
        width: SizeConfig.screenWidth! * 0.9,
        decoration: BoxDecoration(
          border: Border.all(
            width: 2,
            color: isClose
                ? Get.isDarkMode
                    ? Colors.grey[600]!
                    : Colors.grey[300]!
                : clr!,
          ),
          borderRadius: BorderRadius.circular(20),
          color: isClose ? Colors.transparent : clr,
        ),
        child: Center(
            child: Text(
          label,
          style: isClose
              ? titleTextStle
              : titleTextStle.copyWith(color: Colors.white),
        )),
      ),
    );
  }
}
