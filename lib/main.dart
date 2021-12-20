import 'dart:ui';
import 'package:completeproject/archivedNote/archived_note.dart';
import 'package:completeproject/archivedTodo/archived_todo.dart';
import 'package:completeproject/cubit/bloc.dart';
import 'package:completeproject/cubit/states.dart';
import 'package:completeproject/favoriteNote/favorite_note.dart';
import 'package:completeproject/showNote/show_note.dart';
import 'package:completeproject/todoDone/todo_done.dart';
import 'package:completeproject/todoHome/todo_home.dart';
import 'package:completeproject/todoTasks/todo_tasks.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'onBoarding/on_boarding.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return  BlocProvider(
      create: (BuildContext context) =>AppCubit()..createDatabase()..createToDoDatabase()..createTaskDatabase(),
      child: BlocConsumer<AppCubit,AppStates>(
        listener: (context,state){},
        builder: (context,state){
          return MaterialApp(
            theme:  ThemeData(
                appBarTheme: const AppBarTheme(
                    color: Color.fromARGB(255, 49, 124, 246),
                    backwardsCompatibility: false,
                    systemOverlayStyle: SystemUiOverlayStyle(
                      statusBarColor:Color.fromARGB(255, 49, 124, 246),
                      statusBarIconBrightness: Brightness.light,
                    )

                )
            ),
            debugShowCheckedModeBanner: false,
            home:TodoHome(),
          );
        },
      ),
    );
  }
}
