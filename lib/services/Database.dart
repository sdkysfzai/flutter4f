import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:loginv1/models/modele.dart';

class DatabaseService {
  DatabaseService({this.uid, this.docid});

  String? uid;
  String? docid;

  final FirebaseFirestore _firestore = FirebaseFirestore.instance;

  Future createTask(
    String? note,
    String? title,
    String? price,
    String? location,
    String? date,
    String? startTime,
    String? endTime,
    int? remind,
    String? repeat,
    int? color,
    int? isCompleted,
    Timestamp? createTime,
    int? taskLikes,
    List<String> favoriteUsers,
  ) async {
    return await _firestore.collection('tasks').add({
      'note': note,
      'title': title,
      'price': price,
      'location': location,
      'date': date,
      'startTime': startTime,
      'endTime': endTime,
      'remind': remind,
      'repeat': repeat,
      'color': color,
      'isCompleted': isCompleted,
      'createTime': createTime,
      'taskLikes': taskLikes,
      'favoriteUsers': favoriteUsers,
    });
  }

  Stream<Task> get singleTask {
    return _firestore
        .collection('tasks')
        .doc(docid)
        .snapshots()
        .map(_singleTaskFromSnapshot);
  }

  Task _singleTaskFromSnapshot(DocumentSnapshot doc) {
    return Task(
        note: doc.get('note') ?? '',
        titl2: doc.get('title') ?? '',
        price: doc.get('price') ?? 0,
        location: doc.get('location') ?? '',
        date: doc.get('date') ?? '',
        startTime: doc.get('startTime') ?? '',
        endTime: doc.get('endTime') ?? '',
        remind: doc.get('remind') ?? 0,
        repeat: doc.get('repeat') ?? '',
        color: doc.get('color') ?? 0,
        isCompleted: doc.get('isCompleted') ?? false,
        createTime: doc.get('createTime'),
        taskLikes: doc.get('taskLikes') ?? 0,
        favoriteUsers: List.from(doc.data().toString().contains('favoriteUsers')
            ? doc.get('favoriteUsers')
            : []),
        docId: doc.id);
  }

  Stream<List<Task>> get tasks {
    return _firestore
        .collection('tasks')
        .orderBy('createTime', descending: true)
        .snapshots()
        //.map((snapshot) => Task.fromJson(snapshot.data()!));
        .map(_tasksFromSnapshot);
  }

  List<Task> _tasksFromSnapshot(QuerySnapshot snapshot) {
    return snapshot.docs.map((doc) {
      return Task(
        note: doc.get('note') ?? '',
        titl2: doc.get('title') ?? '',
        price: doc.get('price') ?? 0,
        location: doc.get('location') ?? '',
        date: doc.get('date') ?? '',
        startTime: doc.get('startTime') ?? '',
        endTime: doc.get('endTime') ?? '',
        remind: doc.get('remind') ?? 0,
        repeat: doc.get('repeat') ?? '',
        color: doc.get('color') ?? 0,
        isCompleted: doc.get('isCompleted') ?? false,
        createTime: doc.get('createTime'),
        taskLikes: doc.get('taskLikes') ?? 0,
        docId: doc.id,
        favoriteUsers: List.from(doc.data().toString().contains('favoriteUsers')
            ? doc.get('favoriteUsers')
            : []),
      );
    }).toList();
  }

  Future<void> increaseTaskLikes() {
    return _firestore.collection('tasks').doc(docid).update({
      'taskLikes': FieldValue.increment(1),
    });
  }

  //decrease task likes
  Future<void> decreaseTaskLikes() {
    return _firestore.collection('tasks').doc(docid).update({
      'taskLikes': FieldValue.increment(-1),
    });
  }

  Future addFavorite(String? taskId) {
    return _firestore.collection('users').doc(uid).set({
      "favoriteTasks": FieldValue.arrayUnion([taskId])
    }, SetOptions(merge: true));
  }

  Future removeFavorite(String? taskId) {
    return _firestore.collection('users').doc(uid).set({
      "favoriteTasks": FieldValue.arrayRemove([taskId])
    }, SetOptions(merge: true));
  }

  Future addFavUserToTask() {
    return _firestore.collection('tasks').doc(docid).set({
      "favoriteUsers": FieldValue.arrayUnion([uid])
    }, SetOptions(merge: true));
  }

  Future removeFavUserFromTask() {
    return _firestore.collection('tasks').doc(docid).set({
      "favoriteUsers": FieldValue.arrayRemove([uid])
    }, SetOptions(merge: true));
  }
}
