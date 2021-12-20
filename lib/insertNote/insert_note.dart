import 'package:completeproject/cubit/bloc.dart';
import 'package:completeproject/cubit/states.dart';
import 'package:completeproject/favoriteNote/favorite_note.dart';
import 'package:completeproject/showNote/show_note.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:google_fonts/google_fonts.dart';

import '../constants.dart';


class InsertNote extends StatelessWidget {
  var scaffoldKey= GlobalKey<ScaffoldState>();

  var idNote;

  InsertNote({
     this.idNote,
   });

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<AppCubit,AppStates>(
        listener: (context,index){},
        builder: (context,index){
          var cubit= AppCubit.get(context);
          return Scaffold(
            key: scaffoldKey,
            appBar: AppBar(
              backgroundColor: cubit.colorNote,
              backwardsCompatibility: false,
              systemOverlayStyle: SystemUiOverlayStyle(
                statusBarColor: cubit.colorNote!.withOpacity(.5),
                statusBarIconBrightness: Brightness.light,
              ),
              elevation: 0.0,
              leading: IconButton(
                icon: const Icon(
                  Icons.arrow_back_ios,
                  color: Colors.white,
                ),
                onPressed: (){

                  Navigator.pop(context);

                },
              ),
              actions: [
                IconButton(
                    onPressed: (){
                     if(cubit.upNote==false){
                       cubit.insertArchivedDatabase(title: cubit.titleController.text, content: cubit.contentController.text,colorN: cubit.colorIndex);
                       cubit.titleController.text='';
                       cubit.contentController.text='';
                     }
                     else{
                       cubit.updateMemberDatabase(S: 'archived',title: cubit.titleController.text ,content: cubit.contentController.text,color: cubit.colorIndex,id: idNote);
                       cubit.titleController.text='';
                       cubit.contentController.text='';

                     }
                    },
                    icon: const Icon(
                      Icons.archive_outlined,
                      color: Colors.white,
                    )
                ),

                IconButton(
                    onPressed: (){
                      if(cubit.upNote==false){
                        cubit.insertStarDatabase(title: cubit.titleController.text, content: cubit.contentController.text,colorN: cubit.colorIndex);
                        cubit.titleController.text='';
                        cubit.contentController.text='';
                      }
                      else{
                        cubit.updateMemberDatabase(S: 'star',title: cubit.titleController.text ,content: cubit.contentController.text,color: cubit.colorIndex,id: idNote);
                        cubit.titleController.text='';
                        cubit.contentController.text='';

                      }
                    },
                    icon: const Icon(
                      Icons.star_border,
                      color: Colors.white,
                    )
                ),

                IconButton(
                    onPressed: (){
                      if(cubit.upNote==false){
                        cubit.insertDatabase(title: cubit.titleController.text, content: cubit.contentController.text,colorN: cubit.colorIndex);
                        cubit.titleController.text='';
                        cubit.contentController.text='';
                        navigateAndFinish(context, ShowNote());

                      }
                      else{
                        cubit.updateMemberDatabase(S: 'new',title: cubit.titleController.text ,content: cubit.contentController.text,color: cubit.colorIndex,id: idNote);
                        cubit.titleController.text='';
                        cubit.contentController.text='';
                      }

                    },
                    icon:  const Icon(
                      Icons.done,
                      size: 30,
                      color: Colors.white,
                    )
                ),


              ],
            ),
            body: Container(
              color: cubit.colorNote,
              child: Column(
                children: [
                  Container(
                    padding: const EdgeInsets.fromLTRB(20, 15, 0, 0),
                    child: Column(
                      children: [
                        TextFormField(
                          decoration: InputDecoration(
                            hintText: 'Title',
                            hintStyle: GoogleFonts.openSans(
                                fontSize: 25,
                                // fontWeight: FontWeight.bold,
                                color: Colors.white
                            ),
                            border: InputBorder.none,
                          ),
                          controller: cubit.titleController,
                          style: GoogleFonts.lato(
                              fontSize: 22,
                              color: Colors.white
                          ),
                        ),
                        TextFormField(
                          decoration: InputDecoration(
                              hintText: 'Note',
                              hintStyle: GoogleFonts.openSans(
                                  fontSize: 22,
                                  // fontWeight: FontWeight.bold,
                                  color: Colors.white
                              ),
                              border: InputBorder.none
                          ),
                          maxLines: 9,
                          controller: cubit.contentController,
                          style: GoogleFonts.lato(
                              fontSize: 18,
                              color: Colors.white
                          ),
                        ),
                      ],
                    ),
                  ),
                  const Spacer(),
                  Row(
                    children: [
                      IconButton(
                          onPressed: (){
                            // scaffoldKey.currentState!.showBottomSheet((context) =>  Container(
                            //   color: const Color(0xf22b2b2b),
                            //   height: 230,
                            //   width: double.infinity,
                            //   child: Column(
                            //     crossAxisAlignment: CrossAxisAlignment.start,
                            //     children: [
                            //       const SizedBox(height: 15,),
                            //       InkWell(
                            //         child: Row(
                            //           children: [
                            //             IconButton(onPressed: (){
                            //             },
                            //                 icon:const Icon(
                            //                   Icons.photo_camera,
                            //                   color: Colors.white,
                            //                 )
                            //             ),
                            //             const SizedBox(width: 10,),
                            //             Text('Take photo',style: GoogleFonts.lato(
                            //                 fontSize: 17,
                            //                 color: Colors.white
                            //             ),)
                            //           ],
                            //         ),
                            //         onTap: (){
                            //
                            //         },
                            //       ),
                            //       InkWell(
                            //         child: Row(
                            //           children: [
                            //             IconButton(onPressed: (){
                            //             },
                            //                 icon:const Icon(
                            //                   Icons.photo_camera_back,
                            //                   color: Colors.white,
                            //                 )
                            //             ),
                            //             const SizedBox(width: 10,),
                            //             Text('Add image',style: GoogleFonts.lato(
                            //                 fontSize: 17,
                            //                 color: Colors.white
                            //             ),)
                            //           ],
                            //         ),
                            //         onTap: (){
                            //
                            //         },
                            //       ),
                            //       InkWell(
                            //         child: Row(
                            //           children: [
                            //             IconButton(onPressed: (){
                            //             },
                            //                 icon:const Icon(
                            //                   Icons.colorize,
                            //                   color: Colors.white,
                            //                 )
                            //             ),
                            //             const SizedBox(width: 10,),
                            //             Text('Drawing',style: GoogleFonts.lato(
                            //                 fontSize: 17,
                            //                 color: Colors.white
                            //             ),)
                            //           ],
                            //         ),
                            //         onTap: (){
                            //
                            //         },
                            //       ),
                            //       InkWell(
                            //         child: Row(
                            //           children: [
                            //             IconButton(onPressed: (){
                            //             },
                            //                 icon:const Icon(
                            //                   Icons.keyboard_voice_rounded,
                            //                   color: Colors.white,
                            //                 )
                            //             ),
                            //             const SizedBox(width: 10,),
                            //             Text('Recording',style: GoogleFonts.lato(
                            //                 fontSize: 17,
                            //                 color: Colors.white
                            //             ),)
                            //           ],
                            //         ),
                            //         onTap: (){
                            //
                            //         },
                            //       ),
                            //
                            //     ],
                            //   ),
                            // ),
                            // );
                          }, icon:const Icon(
                        Icons.add_box,
                        color: Colors.white,
                      )),
                      IconButton(
                          onPressed: (){
                            showModalBottomSheet(context: context, builder: (_){
                              return Container(
                                  color: const Color(0xf22b2b2b),
                                  height: 140,
                                  width: double.infinity,
                                  child: Column(
                                    crossAxisAlignment: CrossAxisAlignment.start,
                                    children: [
                                      const SizedBox(height: 15,),
                                      Text('   Color',style: GoogleFonts.lato(
                                          color: Colors.white,
                                          fontSize: 18
                                      ),),
                                      Expanded(
                                        child: ListView.separated(
                                            scrollDirection: Axis.horizontal,
                                            physics: const BouncingScrollPhysics(),
                                            itemBuilder: (context,index){
                                              return InkWell(
                                                onTap: (){
                                                  cubit.changeColor(index);
                                                },
                                                child: Padding(
                                                  padding: const EdgeInsets.fromLTRB(5, 0, 5, 0),
                                                  child: CircleAvatar(
                                                    radius: 24,
                                                    backgroundColor: Colors.white,
                                                    child: CircleAvatar(
                                                      radius: 20,
                                                      backgroundColor: cubit.noteColors[index],
                                                    ),
                                                  ),
                                                ),
                                              );
                                            },
                                            separatorBuilder: (context,index){
                                              return const SizedBox(width: 5,);
                                            },
                                            itemCount: cubit.noteColors.length),
                                      ),
                                    ],
                                  )
                              );
                            });
                          }, icon: const Icon(
                        Icons.color_lens,
                        color: Colors.white,
                      )),
                      const SizedBox(width: 40,),
                      Text(
                        'Edited ',
                        style: GoogleFonts.lato(
                            fontSize: 14,
                            color: Colors.white
                        ),
                      ),
                      Text(
                        TimeOfDay.now().format(context).toString(),
                        style: GoogleFonts.lato(
                            fontSize: 15,
                            color: Colors.white
                        ),
                      ),
                      const Spacer(),
                      IconButton(
                          onPressed: (){
                            showModalBottomSheet(context: context, builder: (_){
                              return Container(
                                color: const Color(0xf22b2b2b),
                                height: 80,
                                width: double.infinity,
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    const SizedBox(height: 15,),
                                    InkWell(
                                      child: Row(
                                        children: [
                                          IconButton(onPressed: (){
                                          },
                                              icon:const Icon(
                                                Icons.delete,
                                                color: Colors.white,
                                              )
                                          ),
                                          const SizedBox(width: 10,),
                                          Text('Delete',style: GoogleFonts.lato(
                                              fontSize: 17,
                                              color: Colors.white
                                          ),)
                                        ],
                                      ),
                                      onTap: (){
                                        cubit.deleteDatabase(id: idNote);
                                        cubit.titleController.text='';
                                        cubit.contentController.text='';

                                      },
                                    ),

                                  ],
                                ),
                              );
                            }).then((value) {


                            });
                          }, icon: Icon(
                          Icons.more_vert,
                          color: Colors.white
                      )),
                    ],
                  )
                ],
              ),
            ),
          );
    },
    );
  }
}
