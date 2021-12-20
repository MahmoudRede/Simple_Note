import 'package:completeproject/cubit/bloc.dart';
import 'package:completeproject/cubit/states.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:google_fonts/google_fonts.dart';

import '../constants.dart';

class TodoTasks extends StatelessWidget {

  int ?idTodoTask;
  String ?todoTaskName;

  TodoTasks({
   this.idTodoTask,
   this.todoTaskName,
   });




  @override
  Widget build(BuildContext context) {
    return BlocConsumer<AppCubit,AppStates>(
      listener: (context,state){},
      builder: (context,state){
      var cubit=AppCubit.get(context);
      return Scaffold(
        appBar:AppBar(
          iconTheme: const IconThemeData(
            color: Colors.black,
            size: 0,
          ),
          elevation: 2,
          backwardsCompatibility: false,
          systemOverlayStyle: const SystemUiOverlayStyle(
              statusBarColor:Colors.white,
              statusBarIconBrightness: Brightness.dark
          ),
          backgroundColor: Colors.white,
          title: Text(
            'Task Details',style: GoogleFonts.lato(
            color: Colors.black,
            fontSize: 22,
          ),
          ),
          actions: [
            CircleAvatar(
              radius: 20,
              backgroundColor: const Color(0xd8383838),


              child: IconButton(
                  onPressed: (){


                      cubit.insertTaskDatabase(title: cubit.titleTaskController.text,todoId: idTodoTask!);

                  },
                  icon:  const Icon(
                    Icons.done,
                    size: 25,
                    color: Colors.white,
                  )
              ),
            ),
            SizedBox(width: 10,),

          ],
        ),
        body: Container(
          height: double.infinity,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const SizedBox(height: 20,),
              Container(
                padding: const EdgeInsets.fromLTRB(30, 20, 0, 20),
                child: Row(
                  children:  [
                    const CircleAvatar(
                      radius: 5,
                      backgroundColor: Colors.redAccent,

                    ),
                    const SizedBox(width: 15,),
                    Text('${todoTaskName}',style: GoogleFonts.barlow(
                        fontSize: 25,
                        color: Colors.black
                    ),),
                    const SizedBox(width: 5,),
                  ],
                ),
              ),
              Expanded(
                child: Container(
                  padding: const EdgeInsets.only(left: 15),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                       Expanded(
                          child: ListView.separated(
                              itemBuilder: (context,index){
                                return  Row(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    // Checkbox(
                                    //     value: cubit.checkBoxValue,
                                    //     onChanged: (value){
                                    //       cubit.changeCheckBoxValue(value);
                                    //     }
                                    // ),
                                    const SizedBox(width: 10,),

                                    Container(
                                      child: TextFormField(
                                        decoration: InputDecoration(
                                            hintText:'new task',
                                            hintStyle: GoogleFonts.lato(
                                              fontSize: 17,
                                              color: Colors.grey,
                                            ),
                                            border: InputBorder.none
                                        ),
                                        controller: cubit.titleTaskController,
                                        keyboardType: TextInputType.text,
                                        validator: (value){
                                          if(value!.isEmpty){
                                            return 'enter new task';
                                          }
                                        },
                                      ),
                                      width: 100,
                                    ),
                                  ],
                                );
                              },
                              separatorBuilder: (context,index){
                                return SizedBox(height: 5,);
                              },
                              itemCount: 5
                          ),
                        ),

                    ],
                  ),
                ),
              ),



            ],
          ),
        ),
      );
      },
    );
  }
}
