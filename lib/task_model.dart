import'package:hive/hive.dart';

part 'task_model.g.dart';

 @HiveType(typeId:0)

 class TaskModel extends HiveObject {

  @HiveField(0)

  String text;

  @HiveField(1)
  int priority;
  
  @HiveField(2)
  bool isSelected;

  TaskModel({required this.text,required this.priority, this.isSelected=false});

 }