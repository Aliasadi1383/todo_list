import 'package:flutter/material.dart';
import 'package:todo/add_task.dart';
import 'package:todo/custom_widget_button.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
  final ThemeData theme=Theme.of(context);

    return MaterialApp(

      debugShowCheckedModeBanner: false,
      theme: ThemeData(

       colorScheme: ColorScheme.light(
        primary: Colors.deepPurple,
        onPrimary: Colors.white,
        surface: const Color.fromARGB(255, 225, 225, 225),
       ),

       textTheme: TextTheme(
        bodyLarge: TextStyle(fontSize: 30,fontWeight: FontWeight.bold),
        titleLarge: TextStyle(fontWeight: FontWeight.w600),
        titleMedium: TextStyle(fontSize: 18,fontWeight: FontWeight.w700)
       ),

       cardTheme: CardThemeData(
        color: Colors.white
       ),

       elevatedButtonTheme: ElevatedButtonThemeData(
        style: ButtonStyle(
          backgroundColor: WidgetStateProperty.all(
          theme.colorScheme.primary
          ),
          foregroundColor: WidgetStateProperty.all(
           theme.colorScheme.onPrimary
          ),
          minimumSize: WidgetStateProperty.all(
            Size(370, 50)
          ),
        ),
        
       )
       
      ),
      home: TodoList(),
    );
  }
}

class TodoList extends StatelessWidget{
  const TodoList({super.key});

  @override
  Widget build(BuildContext context) {
      final ThemeData theme=Theme.of(context);

    return Scaffold(
      appBar: AppBar(
         title: Center(child:Text('My Todo List',style: theme.textTheme.bodyLarge!.copyWith(
          color:theme.colorScheme.onPrimary
         ),)),
        toolbarHeight: 100,
        backgroundColor: theme.colorScheme.primary,
      ),
      
      body:Column(
        children: [
          Expanded(
            child: ListView.builder(
              
              itemCount: 5,
              itemBuilder: (context, index) {
              return Padding(
                padding: const EdgeInsets.all(2.0),
                child: SizedBox(
                  height: 60,
                  child: Card(
                    
                  ),
                ),
              );
            },
            
            ),
            
          ),
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: button(Text('Add New Task',style: theme.textTheme.titleMedium!.copyWith(
              color: theme.colorScheme.onPrimary
            ),),() {
              Navigator.push(context,MaterialPageRoute(builder: (context) => AddTask(),),);
            },),
          )
        ],
      ),
      
    );
  }
}
