import 'package:flutter/material.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {

    return MaterialApp(

      debugShowCheckedModeBanner: false,
      theme: ThemeData(

       colorScheme: ColorScheme.light(
        primary: Colors.deepPurple,
        onPrimary: Colors.white,
        surface: const Color.fromARGB(255, 225, 225, 225),
       ),

       textTheme: TextTheme(
        bodyLarge: TextStyle(fontSize: 30,fontWeight: FontWeight.bold)
       ),

       cardTheme: CardThemeData(
        color: Colors.white
       ),

       elevatedButtonTheme: ElevatedButtonThemeData(
        style: ButtonStyle(
          backgroundColor: WidgetStateProperty.all(
          Theme.of(context).colorScheme.primary
          ),
          foregroundColor: WidgetStateProperty.all(
            Theme.of(context).colorScheme.onPrimary
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
    return Scaffold(
      appBar: AppBar(
         title: Center(child:Text('My Todo List',style: Theme.of(context).textTheme.bodyLarge!.copyWith(
          color: Theme.of(context).colorScheme.onPrimary
         ),)),
        toolbarHeight: 100,
        backgroundColor: Theme.of(context).colorScheme.primary,
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
            child: ElevatedButton(onPressed: () {
              
            }, child: Text('Add New Task')),
          )
        ],
      ),
      
    );
  }
}
