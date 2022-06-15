import 'package:get/get.dart';
import '../db/db_helper.dart';
import '../models/task.dart';

class TaskController extends GetxController {
  // pastrează informațiile si updatează ui

  @override
  void onReady() {
    getTasks();
    super.onReady();
  }

  final RxList<Task> taskList = List<Task>.empty().obs;

  // adaugă date in tabel

  Future<void> addTask({required Task task}) async {
     await DBHelper.insert(task);
  }

  // primește toate data

  void getTasks() async { //TODO Edited
    List<Map<String, dynamic>> tasks = await DBHelper.query();
   // taskList.assignAll(tasks.map((data) => new Task.fromJson(data)).toList());
  }

  // sterge
  void deleteTask(Task task) async {
    await DBHelper.delete(task);
    getTasks();
  }

  // updatează
  void markTaskCompleted(int? id) async {
    await DBHelper.update(id);
    getTasks();
  }
  
  // void statsTask() async {
  //   await DBHelper.
  //   getTasks();
  // }
}

// SE OCUPA DE PARTEA CU TASK URILE - CRUD PE DB SQLLITE