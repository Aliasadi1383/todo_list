import'package:hive/hive.dart';

part 'task_model.g.dart';

 @HiveType(typeId:0)

 class TaskModel {

  @HiveField(0)

  String text;

  @HiveField(1)
  int priority;

  TaskModel({required this.text,required this.priority});

 }