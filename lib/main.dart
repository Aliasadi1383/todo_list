import 'package:flutter/material.dart';
import 'package:hive_flutter/adapters.dart';
import 'package:todo/add_task.dart';
import 'package:todo/custom_widget_button.dart';
import 'package:todo/task_model.dart';

void main() async{
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
        builder: (context,Box<TaskModel> box, _) {
          
          if (box.isEmpty) {
            return Center(child: Text("No tasks yet!"));
          }
        return Column(
          children: [
            Expanded(
              child: ListView.builder(
                itemCount: box.length,
                itemBuilder: (context, index) {

                  final task=box.getAt(index)!;

                  return Padding(
                    padding: const EdgeInsets.all(2.0),
                    child: SizedBox(height: 60, child: Card(child: Row(children: [
                      Text(task.text),
                      SizedBox(width: 10,),
                      Text(task.priority.toString())
                    ],))),
                  );
                },
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(20),
              child: button(
                Text(
                  'Add New Task',
                  style: theme.textTheme.titleMedium!.copyWith(
                    color: theme.colorScheme.onPrimary,
                  ),
                ),
                ()  {
                    Navigator.push(context, MaterialPageRoute(builder: (context) => AddTask(),));
                },
              ),
            ),
          ],
        );
        }
      )
    
    );
  }
}
