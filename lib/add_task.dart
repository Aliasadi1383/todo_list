import 'package:flutter/material.dart';
import 'package:hive_flutter/adapters.dart';
import 'package:todo/custom_widget_button.dart';
import 'package:todo/priority_selector.dart';
import 'package:todo/task_model.dart';

class AddTask extends StatefulWidget {
  final TaskModel? task;
  const AddTask({super.key,this.task});

  @override
  State<AddTask> createState() => _AddTask();
}

class _AddTask extends State<AddTask> {
  TextEditingController textEditingController = TextEditingController();
    late int selectedPriority;

  @override
  void initState() {
    super.initState();
    if (widget.task != null) {
    textEditingController.text = widget.task!.text;
    selectedPriority = widget.task!.priority;
  }else {
    selectedPriority=3;
  }
  }
  @override
  Widget build(BuildContext context) {
    final ThemeData theme = Theme.of(context);

    final box = Hive.box<TaskModel>('tasksBox');


    return Scaffold(
      appBar: AppBar(
        title: Center(
          child: Text(
            'Add New Task',
            style: theme.textTheme.titleLarge!.copyWith(
              color: theme.colorScheme.onPrimary,
            ),
          ),
        ),
        backgroundColor: theme.colorScheme.primary,
        toolbarHeight: 70,
        iconTheme: IconThemeData(),
        leading: IconButton(
          onPressed: () {
            Navigator.pop(context);
          },
          icon: Icon(
            Icons.cancel_rounded,
            color: theme.colorScheme.onPrimary,
            size: 45,
          ),
        ),
      ),
      body: Padding(
        padding: const EdgeInsets.all(20),
        child: Column(
          children: [
            PrioritySelector(
              initalPriority: selectedPriority,
              onPriorityChanged: (p) {
                selectedPriority = p;
              },
            ),
            Expanded(
              child: TextField(
                controller: textEditingController,
                decoration: InputDecoration(
                  hintText: 'Add New Task',
                  border: InputBorder.none,
                ),
                style: TextStyle(fontSize: 17, fontWeight: FontWeight.w400),
              ),
            ),
            button(
              Text(
                'Save',
                style: theme.textTheme.titleMedium!.copyWith(
                  color: theme.colorScheme.onPrimary,
                ),
              ),
              () {
                if (widget.task!=null) {
                   widget.task!.text = textEditingController.text;
                  widget.task!.priority = selectedPriority;
                  widget.task!.save();
                }else{
                final task = TaskModel(
                  text: textEditingController.text,
                  priority: selectedPriority,
                );
                box.add(task);
                }
                Navigator.pop(context);
              },
            ),
          ],
        ),
      ),
    );
  }
}
