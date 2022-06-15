import 'package:cloud_firestore/cloud_firestore.dart';

class Task {
  int? id;
  // String? title;
  String? titl2;
  String? price;
  String? location;
  String? note;
  int? isCompleted;
  String? date;
  String? startTime;
  String? endTime;
  int? color;
  int? remind;
  String? repeat;
  Timestamp? createTime;
  String? docId;
  int? taskLikes;
  List<String>? favoriteUsers;

  Task({
    this.id,
    // this.title,
    this.titl2,
    this.price,
    this.location,
    this.note,
    this.isCompleted,
    this.date,
    this.startTime,
    this.endTime,
    this.color,
    this.remind,
    this.repeat,
    this.createTime,
    this.docId,
    this.taskLikes,
    List<String>? favoriteUsers,
  }) : favoriteUsers = favoriteUsers ?? [];

  // Task.fromJson(Map<String, dynamic> json) {
  //   id = json['id'];
  //   // title = json['title'];
  //   titl2 = json['titl2'];

  //   price= json['price'];
  //   location=json['location'];
  //   note = json['note'];
  //   isCompleted = json['isCompleted'];
  //   date = json['date'];
  //   startTime = json['startTime'];
  //   endTime = json['endTime'];
  //   color = json['color'];
  //   remind = json['remind'];
  //   repeat = json['repeat'];
  // }
  //TODO Edited

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    //  data['title'] = this.title;
    data['titl2'] = this.titl2;

    data['price'] = this.price;
    data['location'] = this.location;

    data['date'] = this.date;
    data['note'] = this.note;

    data['isCompleted'] = this.isCompleted;
    data['startTime'] = this.startTime;
    data['endTime'] = this.endTime;
    data['color'] = this.color;
    data['remind'] = this.remind;
    data['repeat'] = this.repeat;
    data['createTime'] = this.createTime;
    return data;
  }
}
