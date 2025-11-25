import 'package:flutter/material.dart';
import 'package:hive_flutter/adapters.dart';
import 'package:todo/add_task.dart';
import 'package:todo/custom_widget_button.dart';
import 'package:todo/task_model.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Hive.initFlutter();
  Hive.registerAdapter(TaskModelAdapter());
  await Hive.openBox<TaskModel>('tasksBox');

  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    final ThemeData theme = Theme.of(context);

    return MaterialApp(
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        colorScheme: ColorScheme.light(
          primary: Colors.deepPurple,
          onPrimary: Colors.white,
          surface: const Color.fromARGB(255, 225, 225, 225),
        ),

        textTheme: TextTheme(
          bodyLarge: TextStyle(fontSize: 30, fontWeight: FontWeight.bold),
          titleLarge: TextStyle(fontWeight: FontWeight.w600),
          titleMedium: TextStyle(fontSize: 18, fontWeight: FontWeight.w700),
        ),

        cardTheme: CardThemeData(color: Colors.white),

        elevatedButtonTheme: ElevatedButtonThemeData(
          style: ButtonStyle(
            backgroundColor: WidgetStateProperty.all(theme.colorScheme.primary),
            foregroundColor: WidgetStateProperty.all(
              theme.colorScheme.onPrimary,
            ),
            minimumSize: WidgetStateProperty.all(Size(370, 50)),
          ),
        ),
      ),
      home: TodoList(),
    );
  }
}

class TodoList extends StatefulWidget {
  const TodoList({super.key});

  @override
  State<TodoList> createState() => _TodoListState();
}

class _TodoListState extends State<TodoList> {
  @override
  Widget build(BuildContext context) {
    final ThemeData theme = Theme.of(context);
    final taskBox = Hive.box<TaskModel>('tasksBox');
    return Scaffold(
      appBar: AppBar(
        title: Center(
          child: Text(
            'My Todo List',
            style: theme.textTheme.bodyLarge!.copyWith(
              color: theme.colorScheme.onPrimary,
            ),
          ),
        ),
        toolbarHeight: 100,
        backgroundColor: theme.colorScheme.primary,
      ),

      body: ValueListenableBuilder(
        valueListenable: taskBox.listenable(),

        builder: (context, Box<TaskModel> box, _) {
          return Column(
            children: [
              Expanded(
                child: box.isEmpty
                    ? Center(child: Text('No tasks yet!',style: theme.textTheme.titleLarge,))
                    : ListView.builder(
                        itemCount: box.length,
                        itemBuilder: (context, index) {
                          final task = box.getAt(index)!;
                          return Padding(
                            padding: index == 0
                                ? EdgeInsets.only(left: 20, right: 20, top: 20)
                                : EdgeInsetsGeometry.only(
                                    left: 20,
                                    right: 20,
                                    bottom: 3,
                                  ),
                            child: SizedBox(
                              height: 80,
                              child: GestureDetector(
                                onLongPress: () {
                                  box.delete(task.key);
                                },
                                onTap: () {
                                  Navigator.push(context, MaterialPageRoute(builder: (context) =>AddTask(task: task,) ,));
                                },
                                child: Card(
                                  shape: RoundedRectangleBorder(
                                    borderRadius: BorderRadiusGeometry.circular(
                                      8,
                                    ),
                                  ),
                                  child: Row(
                                    children: [
                                      GestureDetector(
                                        onTap: () {
                                          setState(() {
                                            task.isSelected = !task.isSelected;
                                            task.save();
                                          });
                                        },
                                        
                                        child: Padding(
                                          padding: const EdgeInsets.only(
                                            right: 10,
                                            left: 10,
                                          ),
                                          child: Container(
                                            width: 20,
                                            height: 20,
                                
                                            decoration: BoxDecoration(
                                              shape: BoxShape.circle,
                                              color: task.isSelected
                                                  ? theme.colorScheme.primary
                                                  : theme.colorScheme.onPrimary,
                                
                                              border: BoxBorder.all(
                                                width: 1.5,
                                                color: task.isSelected
                                                    ? theme.colorScheme.primary
                                                    : Colors.grey,
                                              ),
                                            ),
                                            child: task.isSelected
                                                ? Icon(
                                                    Icons.check,
                                                    size: 17,
                                                    color: theme
                                                        .colorScheme
                                                        .onPrimary,
                                                  )
                                                : null,
                                          ),
                                        ),
                                      ),
                                      Expanded(
                                        child: Text(
                                          task.text,
                                          maxLines: 1,
                                          overflow: TextOverflow.ellipsis,
                                          style: TextStyle(
                                            decoration: task.isSelected
                                                ? TextDecoration.lineThrough
                                                : null,
                                            fontSize: 20,

                                          ),
                                        ),
                                      ),
                                      Container(
                                        width: 6,
                                        height: double.infinity,
                                        decoration: BoxDecoration(
                                          color: _getPriorityColor(task.priority),
                                          borderRadius: BorderRadius.only(
                                            bottomRight: Radius.circular(8),
                                            topRight: Radius.circular(8),
                                          ),
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                              ),
                            ),
                          );
                        },
                      ),
              ),
              Padding(
                padding: const EdgeInsets.only(bottom: 20, left: 20, right: 20),
                child: button(
                  Text(
                    'Add New Task',
                    style: theme.textTheme.titleMedium!.copyWith(
                      color: theme.colorScheme.onPrimary,
                    ),
                  ),
                  () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(builder: (context) => AddTask()),
                    );
                  },
                ),
              ),
            ],
          );
        },
      ),
    );
  }

  Color _getPriorityColor(int priority) {
    switch (priority) {
      case 1:
        return Colors.deepPurple;
      case 2:
        return Colors.orange;
      default:
        return Colors.blue;
    }
  }
}
