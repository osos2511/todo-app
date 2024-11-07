import 'package:cloud_firestore/cloud_firestore.dart';

class TodoDm{
  static const String collectionName='todo';
  String id;
  String title;
  String description;
  DateTime date;
  bool isDone;
  TodoDm({required this.id,
    required this.title,
    required this.description,
    required this.date,
    required this.isDone,});
  Map<String,dynamic> toJson()=>{
    "id":id,
    "title":title,
    "description":description,
    "date":date,
    "isDone":isDone,
  };

  factory TodoDm.fromJson(Map<String,dynamic>json){
    return TodoDm(
    id:json["id"],
      title: json["title"],
      description: json["description"],
      date: (json["date"] as Timestamp).toDate(),
      isDone:json["isDone"],

    );
  }

  TodoDm copyWith({
    String? id,
    String? updatedName,
    String? updatedDetails,
    DateTime? date,
    bool? isDone,
  }) {
    return TodoDm(
      id: id ?? this.id,
      title: updatedName ?? title,
      description: updatedDetails ?? description,
      date: date ?? this.date,
      isDone: isDone ?? this.isDone,
    );
  }
}