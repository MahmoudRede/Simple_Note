import 'package:completeproject/archivedTodo/archived_todo.dart';
import 'package:completeproject/cubit/bloc.dart';
import 'package:completeproject/cubit/states.dart';
import 'package:completeproject/todoDone/todo_done.dart';
import 'package:completeproject/todoTasks/todo_tasks.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:intl/intl.dart';

import '../constants.dart';

class TodoHome extends StatelessWidget {

  var keyForm= GlobalKey<FormState>();
  var keyScaffold= GlobalKey<ScaffoldState>();

  int ?idTodoTodo;



  @override
  Widget build(BuildContext context) {
    return BlocConsumer<AppCubit,AppStates>(
        listener: (context,state){},
        builder: (context,state){
          var cubit=AppCubit.get(context);
          return Form(
            key: keyForm,
            child: Scaffold(
              key: keyScaffold,
              appBar:AppBar(
                iconTheme: const IconThemeData(
                  color: Colors.black,
                ),
                elevation: 2,
                backwardsCompatibility: false,
                systemOverlayStyle: const SystemUiOverlayStyle(
                    statusBarColor:Colors.white,
                    statusBarIconBrightness: Brightness.dark
                ),
                backgroundColor: Colors.white,
                title: Text(
                  'TO-Do List',style: GoogleFonts.lato(
                  color: Colors.black,
                  fontSize: 22,
                ),
                ),
              ),
              body: cubit.todoItems.isNotEmpty? Container(
                padding: const EdgeInsets.all(10),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Expanded(
                      child: ListView.separated(
                          physics: const BouncingScrollPhysics(),
                          itemBuilder: (context,index){
                            return InkWell(
                              onTap: (){
                                idTodoTodo=cubit.todoItems[index]['idTodo'];
                                print(idTodoTodo);
                                navigateTo(context, TodoTasks(idTodoTask: cubit.todoItems[index]['idTodo'],todoTaskName:'${cubit.todoItems[index]['title']}',));
                              },
                              child: Container(
                                padding: EdgeInsets.all(10),
                                decoration: BoxDecoration(
                                  color: Colors.blue,
                                  borderRadius: BorderRadius.circular(5),
                                ),
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Row(
                                      children: [
                                        Container(
                                          child: Text('${cubit.todoItems[index]['title']}',style: GoogleFonts.lato(
                                              color: Colors.white,
                                              fontSize: 22,
                                              fontWeight: FontWeight.bold

                                          ),),
                                          width: 220,
                                        ),
                                        const Spacer(),
                                        IconButton(
                                            onPressed:(){
                                              cubit.updateTodoDatabase(S: 'archived', id: cubit.todoItems[index]['idTodo']);
                                            } ,
                                            icon: const Icon(
                                              Icons.archive_outlined,
                                              color: Colors.white,
                                            )
                                        ),
                                        IconButton(
                                            onPressed:(){
                                              cubit.updateTodoDatabase(S: 'done', id: cubit.todoItems[index]['idTodo']);
                                            } ,
                                            icon: const Icon(
                                              Icons.done,
                                              color: Colors.white,
                                            )
                                        ),


                                      ],
                                    ),
                                    const SizedBox(height: 10,),
                                    Row(
                                      mainAxisAlignment: MainAxisAlignment.start,
                                      children: [
                                        Text('${cubit.todoItems[index]['date']}',style: GoogleFonts.lato(
                                          color: Colors.white,
                                          fontSize: 17,
                                        ),),
                                        Spacer(),
                                        Text('${cubit.todoItems[index]['time']}',style: GoogleFonts.lato(
                                          color: Colors.white,
                                          fontSize: 17,
                                        ),),
                                      ],
                                    ),

                                  ],
                                ),
                              ),
                            );
                          },
                          separatorBuilder: (context,index){
                            return const SizedBox(height: 10,);
                          },
                          itemCount: cubit.todoItems.length
                      ),
                    ),
                  ],
                ),

              )
              :Container(
                width: double.infinity,
                child: Column(
                  children: [
                    const SizedBox(height: 190,),
                    const Icon(
                      Icons.menu,
                      color: Colors.black,
                      size: 120,
                    ),
                    const SizedBox(height: 10,),
                    Text('There\'s no tasks yet',style: GoogleFonts.barlowCondensed(
                      fontSize: 20,
                      color: Colors.black,
                    ),)
                  ],
                ),
              ),
              
              drawer: Drawer(
                child: Container(
                  color:  const Color(0xd8181818),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      const SizedBox(height: 80,),
                      Container(
                        margin: const EdgeInsets.fromLTRB(95, 0, 0, 30),
                        height: 120,
                        child: const CircleAvatar(
                          radius: 53,
                          backgroundColor: Colors.blue,
                          child: CircleAvatar(
                            radius: 50,
                            backgroundImage: NetworkImage(
                              'https://image.freepik.com/free-vector/kanban-board-with-lists-task-time-management-method-project-process-workflow-optimization-organization-kpi-performance-efficiency_335657-175.jpg'
                            ),
                          ),
                        ),
                      ),
                      const SizedBox(height: 20,),
                      Container(
                        height: 1,
                        color: Colors.black,
                      ),
                      const SizedBox(height: 30,),

                      Container(
                        padding: const EdgeInsets.fromLTRB(25, 5, 0, 5),
                        child: InkWell(
                          onTap: (){
                            navigateAndFinish(context, TodoHome());
                          },
                          child: Row(
                            children:  [
                              const Icon(
                                Icons.all_inbox,
                                color: Colors.white,
                              ),
                              const SizedBox(width: 10,),
                              Text('All',style: GoogleFonts.lato(
                                color: Colors.white,
                                fontSize: 19,
                              ),)
                            ],
                          ),
                        ),
                      ),
                      const SizedBox(height: 25,),
                      Container(
                        padding: const EdgeInsets.fromLTRB(25, 5, 0, 5),
                        child: InkWell(
                          onTap: (){
                            navigateTo(context, const TodoDone());
                          },
                          child: Row(
                            children:  [
                              const Icon(
                                Icons.done_outline_rounded,
                                color: Colors.white,
                              ),
                              const SizedBox(width: 10,),
                              Text('Done',style: GoogleFonts.lato(
                                color: Colors.white,
                                fontSize: 19,
                              ),)
                            ],
                          ),
                        ),
                      ),
                      const SizedBox(height: 25,),
                      Container(
                        padding: const EdgeInsets.fromLTRB(25, 5, 0, 5),
                        child: InkWell(
                          onTap: (){
                            navigateTo(context, const TodoArchived());
                          },
                          child: Row(
                            children:  [
                              const Icon(
                                Icons.archive_outlined,
                                color: Colors.white,
                              ),
                              const SizedBox(width: 10,),
                              Text('Archived',style: GoogleFonts.lato(
                                color: Colors.white,
                                fontSize: 19,
                              ),)
                            ],
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ),


              floatingActionButton: FloatingActionButton(
                backgroundColor:  const Color(0xf2353536),
                onPressed: (){
                  if(cubit.checkBottomSheet==false){
                    cubit.checkBottomSheet=true;
                    keyScaffold.currentState!.showBottomSheet(
                          (context) =>  SingleChildScrollView(
                            child: Expanded(
                              child: Container(
                              padding: EdgeInsets.all(10),
                              color: Colors.grey[100],
                              child: Column(
                                mainAxisSize: MainAxisSize.min,
                                children: [
                                  dafaultFormField(
                                    hint: 'Task Name',
                                    icon: const Icon(
                                      Icons.menu,
                                      color: Colors.black,
                                    ),
                                    textValidator: 'Please enter task name',
                                    textInputType: TextInputType.text,
                                    controller: cubit.taskName,
                                  ),
                                  SizedBox(height: 10,),
                                  dafaultFormField(
                                      hint: 'Task Time',
                                      icon: const Icon(
                                        Icons.timelapse,
                                        color: Colors.black,
                                      ),
                                      textValidator: 'Please enter task time',
                                      textInputType: TextInputType.text,
                                      controller: cubit.taskTime,
                                      function: (){
                                        showTimePicker(
                                          context: context,
                                          initialTime: TimeOfDay.now(),

                                        ).then((value) {
                                          cubit.taskTime.text=value!.format(context).toString();
                                        });
                                      }
                                  ),
                                  SizedBox(height: 10,),
                                  dafaultFormField(
                                      hint: 'Task Date',
                                      icon: const Icon(
                                        Icons.date_range,
                                        color: Colors.black,
                                      ),
                                      textValidator: 'Please enter task date',
                                      textInputType: TextInputType.text,
                                      controller: cubit.taskDate,
                                      function: (){
                                        showDatePicker(
                                          context: context,
                                          initialDate: DateTime.now(),
                                          firstDate: DateTime.now(),
                                          lastDate: DateTime.parse('2050-12-30'),
                                        ).then((value) {
                                          cubit.taskDate.text= DateFormat.yMMMEd().format(value!);
                                        });
                                      }
                                  ),

                                ],
                              ),
                        ),
                            ),
                          ),
                    ).closed.then((value) {
                      cubit.checkBottomSheet=false;
                      cubit.taskName.text='';
                      cubit.taskTime.text='';
                      cubit.taskDate.text='';
                    });
                  }
                  else{
                    if(keyForm.currentState!.validate()){
                       cubit.insertToDoDatabase(title: cubit.taskName.text, time: cubit.taskTime.text, date: cubit.taskDate.text).then((value) {
                         cubit.checkBottomSheet=false;
                         cubit.taskName.text='';
                         cubit.taskTime.text='';
                         cubit.taskDate.text='';
                       });
                    }
                  }
                },
                child: const Icon(
                  Icons.add,
                  color: Colors.white,
                  size: 30,
                ),
              ),
            ),
          );
        },

    );
  }
}
