import 'package:completeproject/cubit/bloc.dart';
import 'package:completeproject/cubit/states.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:google_fonts/google_fonts.dart';

class TodoArchived extends StatelessWidget {
  const TodoArchived({Key? key}) : super(key: key);

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
              'Archived Tasks',style: GoogleFonts.lato(
              color: Colors.black,
              fontSize: 22,
            ),
            ),
          ),
          body: cubit.todoArchived.isNotEmpty? Container(
            padding: const EdgeInsets.all(10),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Expanded(
                  child: ListView.separated(
                      physics: const BouncingScrollPhysics(),
                      itemBuilder: (context,index){
                        return Container(
                          padding: EdgeInsets.all(10),
                          decoration: BoxDecoration(
                            color: const Color(0xF4EC6165),
                            borderRadius: BorderRadius.circular(5),
                          ),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Row(
                                children: [
                                  Container(
                                    child: Text('${cubit.todoArchived[index]['title']}',style: GoogleFonts.lato(
                                        color: Colors.white,
                                        fontSize: 22,
                                        fontWeight: FontWeight.bold

                                    ),),
                                    width: 220,
                                  ),
                                  const Spacer(),
                                  IconButton(
                                      onPressed:(){
                                        cubit.deleteTodoDatabase(id: cubit.todoArchived[index]['idTodo']);

                                      } ,
                                      icon: const Icon(
                                        Icons.delete,
                                        color: Colors.white,
                                      )
                                  ),
                                  IconButton(
                                      onPressed:(){
                                        cubit.updateTodoDatabase(S: 'done', id: cubit.todoArchived[index]['idTodo']);

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
                                  Text('${cubit.todoArchived[index]['date']}',style: GoogleFonts.lato(
                                    color: Colors.white,
                                    fontSize: 17,
                                  ),),
                                  Spacer(),
                                  Text('${cubit.todoArchived[index]['time']}',style: GoogleFonts.lato(
                                    color: Colors.white,
                                    fontSize: 17,
                                  ),),
                                ],
                              ),

                            ],
                          ),
                        );
                      },
                      separatorBuilder: (context,index){
                        return const SizedBox(height: 10,);
                      },
                      itemCount: cubit.todoArchived.length
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
                  Icons.archive_outlined,
                  color: Colors.black,
                  size: 120,
                ),
                const SizedBox(height: 10,),
                Text('There\'s no Archived Tasks yet',style: GoogleFonts.barlowCondensed(
                  fontSize: 20,
                  color: Colors.black,
                ),)
              ],
            ),
          ),




        );
      },

    );
  }
}

