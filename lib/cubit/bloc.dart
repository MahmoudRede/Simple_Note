import 'package:bloc/bloc.dart';
import 'package:completeproject/cubit/states.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:sqflite/sqflite.dart';

class AppCubit extends Cubit<AppStates>{

  AppCubit() : super(InitialState());

  static AppCubit get(context) => BlocProvider.of(context);


  TextEditingController? nameController;
  TextEditingController? emailController;
  TextEditingController? passController;
  TextEditingController? confirmPassController;

  var height=70.0;
  void formValidate(context){
    height=(MediaQuery.of(context).size.height*.115);
    emit(ValidateState());


  }

  bool showPass=true;
  bool showConPass=true;

  void showPassword(){
    showPass=!showPass;
    emit(ShowPasswordState());

  }
  void showConPassword(){
    showConPass=!showConPass;
    emit(ShowPasswordState());

  }

  var titleController=TextEditingController();
  var contentController=TextEditingController();

  Database ?database;
  List <Map> noteItems=[];
  List <Map> noteStars=[];
  List <Map> noteArchived=[];



  void createDatabase() async {

    return await openDatabase(
      'notes.db',
      version: 1,
      onCreate: (database,version){
        database.execute(
          'CREATE TABLE notes (id INTEGER PRIMARY KEY , title TEXT , content TEXT,state TEXT,color INTEGER )'
        ).then((value) {
          print('Table Created');
          emit(CreateNoteTableState());
        });
      },
      onOpen: (database){
        getDatabase(database).then((value){
          noteItems=value;
        }).catchError((error){
          print('error i ${error.toString()}');
        });
        print('Database Opened');
    }

    ).then((value) {
      database=value;
      print('Database Created');
      emit(CreateNoteDatabaseState());
    }).catchError((error){
      print('error is ${error.toString()}');
    });
  }

  Future insertDatabase(
      {
        required String title,
        required String content,
        int ?colorN,
      }) async{

   return database?.transaction((txn) {
     return txn.rawInsert(
          'INSERT INTO notes (title,content,state,color) VALUES ( "${title}" , "${content}" ,"new","${colorN}")'
      ).then((value) {
        print("${value} Insert Success");
        emit(InsertNoteDatabaseState());
        getDatabase(database).then((value){
          noteItems=value;

        });
        emit(InsertNoteDatabaseState());

     }).catchError((error){
       print('Error is ${error.toString()}');
     });

    });

  }


  Future insertStarDatabase(
      {
        required String title,
        required String content,
        int ?colorN,
      }) async{

    return database?.transaction((txn) {
      return txn.rawInsert(
          'INSERT INTO notes (title,content,state,color) VALUES ( "${title}" , "${content}" ,"star","${colorN}")'
      ).then((value) {
        print("${value} Insert Success");
        emit(InsertNoteDatabaseState());
        getDatabase(database).then((value){
          noteStars=value;
          print(noteStars);
        });
        emit(InsertNoteDatabaseState());

      }).catchError((error){
        print('Error is ${error.toString()}');
      });

    });

  }

  Future insertArchivedDatabase(
      {
        required String title,
        required String content,
        int ?colorN,

      }) async{

    return database?.transaction((txn) {
      return txn.rawInsert(
          'INSERT INTO notes (title,content,state,color) VALUES ( "${title}" , "${content}" ,"archived","${colorN}")'
      ).then((value) {
        print("${value} Insert Archived");
        emit(InsertNoteDatabaseState());
        getDatabase(database).then((value){
          noteArchived=value;
          print(noteArchived);
        });
        emit(InsertNoteDatabaseState());

      }).catchError((error){
        print('Error is ${error.toString()}');
      });

    });

  }



  Future <List<Map>> getDatabase(database)async {

   noteStars=[];
   noteItems=[];
   noteArchived=[];


    return await database?.rawQuery(
      'SELECT * FROM notes'
    ).then((value) {
      print(value[0]['color']);


      value.forEach((element){

        if(element['state']=='new')
          {
            noteItems.add(element);
          }
        else if(element['state']=='star')
        {
          noteStars.add(element);
        }
        else if(element['state']=='archived')
        {
          noteArchived.add(element);
        }

      });

      emit(GetNoteDatabaseState());
     }).catchError((error){
       print('GetError is ${error.toString()}');
    });
  }


  void updateDatabase(
      {
        required String S,
        required int id,
      }
      ) async{

      database?.rawUpdate(

        'UPDATE notes SET state = ? WHERE id = ?',
        ['$S', '$id']).then((value) {
          print('Update Done');
          getDatabase(database);
          emit(UpdateNoteDatabaseState());
      }).catchError((error){
        print('error is ${error.toString()}');
      });

  }

  void updateMemberDatabase(
      {
        String ?title,
        String ?content,
        int ?color,
        required String S,
        required int id,
      }
      ) async{

    database?.rawUpdate(

        'UPDATE notes SET state = ?, title = ? , content = ?,color = ? WHERE id = ?',
        ['$S','$title','$content','$color', '$id']).then((value) {
      print('Update Done');
      getDatabase(database);
      emit(UpdateNoteDatabaseState());
    }).catchError((error){
      print('error is ${error.toString()}');
    });

  }

  void deleteDatabase(
      {
        required int id,
      }
      ) async{

    database?.rawDelete(
        'DELETE FROM notes WHERE id = ?', ['$id'])
        .then((value) {
      getDatabase(database);
      emit(DeleteNoteDatabaseState());
    }).catchError((error){
      print('error is ${error.toString()}');
    });

  }

  bool upNote =false;
  Color ?colorNote=const Color(0xf2353536);
  int ?colorIndex=0;


  void changeColor(index){
     if(index==0)
    {
    colorNote=Color(0xf2353536);
    colorIndex=index;
    }
    else if(index==1)
    {
      colorNote=Colors.red;
      colorIndex=index;
    }
    else if(index==2)
    {
      colorNote=Colors.blue;
      colorIndex=index;

    }
    else if(index==3)
    {
      colorNote=Colors.green;
      colorIndex=index;

    }
    else if(index==4)
    {
      colorNote=Colors.yellow;
      colorIndex=index;

    }
    else if(index==5)
    {
      colorNote=Colors.deepPurple;
      colorIndex=index;

    }
    else if(index==6)
    {
      colorNote=Colors.pink;
      colorIndex=index;

    }
    else if(index==7)
    {
      colorNote=Colors.deepOrange;
      colorIndex=index;

    }

    emit(ChangeColorState());

  }

  List <Color> noteColors =[
    const Color(0xd8383838),
    Colors.red,
    Colors.blue,
    Colors.green,
    Colors.yellow,
    Colors.deepPurple,
    Colors.pink,
    Colors.deepOrange,
  ];



  // to-do List

  Database ?databaseTodo;
  List <Map> todoItems=[];
  List <Map> todoDone=[];
  List <Map> todoArchived=[];

  var taskName=TextEditingController();
  var taskTime=TextEditingController();
  var taskDate=TextEditingController();

  bool checkBottomSheet=false;

  void changeChechBottomSheet(){
    checkBottomSheet=!checkBottomSheet;
    emit(ChangeChechBottomState());
  }




  void createToDoDatabase() async {

    return await openDatabase(
        'todo.db',
        version: 1,
        onCreate: (database,version){
          database.execute(
              'CREATE TABLE todo (idTodo INTEGER PRIMARY KEY , title TEXT, date TEXT, time TEXT,state TEXT)'
          ).then((value) {
            print('Table Todo Created');
            emit(CreateTodoDatabaseState());
          });
        },
        onOpen: (database){
          getToDoDatabase(database).then((value){
            todoItems=value;
          }).catchError((error){
            print('error i ${error.toString()}');
          });
          print('Database ToDO Opened');
        }

    ).then((value) {
      databaseTodo=value;
      print('Database Todo Created');
      emit(CreateTodoDatabaseState());
    }).catchError((error){
      print('error is ${error.toString()}');
    });
  }

  Future insertToDoDatabase(
      {
        required String title,
        required String time,
        required String date,
      }) async{

    return databaseTodo?.transaction((txn) {
      return txn.rawInsert(
          'INSERT INTO todo (title,time,date,state) VALUES ( "${title}" , "${time}","${date}" ,"new")'
      ).then((value) {
        print("${value} Insert Todo Success");
        emit(InsertTodoDatabaseState());
        getToDoDatabase(databaseTodo).then((value){
          todoItems=value;
        });
          emit(InsertTodoDatabaseState());

      }).catchError((error){
        print('Error is ${error.toString()}');
      });

    });

  }



  Future <List<Map>> getToDoDatabase(database)async {

    todoDone=[];
    todoItems=[];
    todoArchived=[];


    return await database?.rawQuery(
        'SELECT * FROM todo'
    ).then((value) {

      value.forEach((element){

        if(element['state']=='new')
        {
          todoItems.add(element);
        }
        else if(element['state']=='done')
        {
          todoDone.add(element);
        }
        else if(element['state']=='archived')
        {
          todoArchived.add(element);
        }

      });

      emit(GetTodoDatabaseState());
    }).catchError((error){
      print('GetError is ${error.toString()}');
    });
  }

  void updateTodoDatabase(
      {
        required String S,
        required int id,
      }
      ) async{

    databaseTodo?.rawUpdate(

        'UPDATE todo SET state = ? WHERE idTodo = ?',
        ['$S', '$id']).then((value) {
      print('Update Done');
      getToDoDatabase(databaseTodo);
      emit(UpdateTodoDatabaseState());
    }).catchError((error){
      print('error is ${error.toString()}');
    });

  }

  void deleteTodoDatabase(
      {
        required int id,
      }
      ) async{

    databaseTodo?.rawDelete(
        'DELETE FROM todo WHERE idTodo = ?', ['$id'])
        .then((value) {
      getToDoDatabase(databaseTodo);
      emit(DeleteTodoDatabaseState());
    }).catchError((error){
      print('error is ${error.toString()}');
    });

  }

  // void updateTodoMemberDatabase(
  //     {
  //       String ?name,
  //       String ?date,
  //       int ?time,
  //       int ?id,
  //
  //     }
  //     ) async{
  //
  //   databaseTodo?.rawUpdate(
  //
  //       'UPDATE todo SET name = ? , date = ? ,time = ? WHERE idTodo = ?',
  //       ['$name','$date','$time','$id']).then((value) {
  //     print('Update Done');
  //     getToDoDatabase(databaseTodo);
  //     emit(UpdateTodoDatabaseState());
  //   }).catchError((error){
  //     print('error is ${error.toString()}');
  //   });

   // Anther taskTodo


  var titleTaskController=TextEditingController();
  // bool checkBoxValue=false;
  // int intCheckBoxValue=0;
  //
  // void changeCheckBoxValue(value){
  //
  //   checkBoxValue=value;
  //   if(checkBoxValue==true){
  //     intCheckBoxValue=1;
  //   }
  //   else{
  //     intCheckBoxValue=0;
  //   }
  //   emit(CheckBoxValueState());
  // }


  var titleTaskController2=TextEditingController();
  // bool checkBoxValue2=false;
  // int intCheckBoxValue2=0;
  //
  // void changeCheckBoxValue2(value){
  //
  //   checkBoxValue2=value;
  //   if(checkBoxValue2==true){
  //     intCheckBoxValue2=1;
  //   }
  //   else{
  //     intCheckBoxValue2=0;
  //   }
  //   emit(CheckBoxValueState());
  // }


  var titleTaskController3=TextEditingController();
  // bool checkBoxValue3=false;
  // int intCheckBoxValue3=0;
  //
  // void changeCheckBoxValue3(value){
  //
  //   checkBoxValue3=value;
  //   if(checkBoxValue3==true){
  //     intCheckBoxValue3=1;
  //   }
  //   else{
  //     intCheckBoxValue3=0;
  //   }
  //   emit(CheckBoxValueState());
  // }


  var titleTaskController4=TextEditingController();
  // bool checkBoxValue4=false;
  // int intCheckBoxValue4=0;
  //
  // void changeCheckBoxValue4(value){
  //
  //   checkBoxValue4=value;
  //   if(checkBoxValue4==true){
  //     intCheckBoxValue4=1;
  //   }
  //   else{
  //     intCheckBoxValue4=0;
  //   }
  //   emit(CheckBoxValueState());
  // }


  var titleTaskController5=TextEditingController();
  // bool checkBoxValue5=false;
  // int intCheckBoxValue5=0;
  //
  // void changeCheckBoxValue5(value){
  //
  //   checkBoxValue5=value;
  //   if(checkBoxValue5==true){
  //     intCheckBoxValue5=1;
  //   }
  //   else{
  //     intCheckBoxValue5=0;
  //   }
  //   emit(CheckBoxValueState());
  // }



  // Task Content

  Database ?databaseTaskTodo;
  List <Map> taskTodoItems=[];
  List <Map> taskTodoDone=[];



  void createTaskDatabase() async {

    return await openDatabase(
        'task.db',
        version: 1,
        onCreate: (database,version){
          database.execute(
              'CREATE TABLE task ( idTask INTEGER PRIMARY KEY , todoId INTEGER , title TEXT , state TEXT)'
          ).then((value) {
            print('Table Task Created');
            emit(CreateTaskTableState());
          });
        },
        onOpen: (database){
          getTaskDatabase(database).then((value){
          }).catchError((error){
            print('error i ${error.toString()}');
          });
          print('Database Task Opened');
        }

    ).then((value) {
      databaseTaskTodo=value;
      print('Database Task Created');
      emit(CreateTaskDatabaseState());
    }).catchError((error){
      print('error is ${error.toString()}');
    });
  }

  Future insertTaskDatabase(
      {
        required String title,
        required int todoId,
      }) async{

    return databaseTaskTodo?.transaction((txn) {
      return txn.rawInsert(
          'INSERT INTO task ( title , todoId , state ) VALUES ( "${title}" , "${todoId}","new")'
      ).then((value) {
        print("${value} Insert Task Success");
        emit(InsertTaskDatabaseState());
        getTaskDatabase(databaseTaskTodo).then((value){
        }).catchError((error){
          print('error in getTask ${error.toString()}');
        });
        emit(InsertTaskDatabaseState());

      }).catchError((error){
        print('Error is ${error.toString()}');
      });

    });

  }


  Future <List<Map>> getTaskDatabase(database)async {

    taskTodoItems=[];

    taskTodoDone=[];


    return await database?.rawQuery(
        'SELECT * FROM task'
    ).then((value) {

      value.forEach((element){


        if(element['state']=='new')
        {
          taskTodoItems.add(element);
        }
        else if(element['state']=='done')
        {
          taskTodoDone.add(element);
        }

      });
      emit(GetTaskDatabaseState());
    }).catchError((error){
      print('GetError is ${error.toString()}');
    });
  }




  }





