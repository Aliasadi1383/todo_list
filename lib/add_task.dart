import 'package:flutter/material.dart';
import 'package:todo/priority_selector.dart';

class AddTask extends StatefulWidget {
  const AddTask({super.key});

  @override
  State<AddTask> createState() => _AddTask();
}

class _AddTask extends State<AddTask> {
  @override
  Widget build(BuildContext context) {
    final ThemeData theme = Theme.of(context);
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
        padding: const EdgeInsets.only(right: 20, left: 20),
        child: Column(
          children: [
            Padding(padding: EdgeInsets.only(top: 20)),
            PrioritySelector(),
            TextField(
              
              decoration:InputDecoration(
                hintText: 'Add New Task',
                border: InputBorder.none
              ),
              style:TextStyle(fontSize: 17,fontWeight: FontWeight.w400) ,
            )
          ],
        ),
      ),
    );
  }
}
