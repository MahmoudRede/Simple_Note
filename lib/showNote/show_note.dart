import 'package:completeproject/archivedNote/archived_note.dart';
import 'package:completeproject/constants.dart';
import 'package:completeproject/cubit/bloc.dart';
import 'package:completeproject/cubit/states.dart';
import 'package:completeproject/favoriteNote/favorite_note.dart';
import 'package:completeproject/insertNote/insert_note.dart';
import 'package:elastic_drawer/elastic_drawer.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_staggered_grid_view/flutter_staggered_grid_view.dart';
import 'package:google_fonts/google_fonts.dart';

class drawer_item{
  String ?title;
  IconData ?iconData;
  Function ?function;

  drawer_item({
   this.title,
   this.iconData,
   this.function,
  });

}

class ShowNote extends StatelessWidget {
  

  @override
  Widget build(BuildContext context) {


    List <drawer_item> drawerItems=[

      drawer_item(
          title: 'Notes',
          iconData: Icons.lightbulb_outline,
          function: (){
            print('Notes');
          }
      ),
      drawer_item(
          title: 'Star Notes',
          iconData: Icons.list_alt,
          function: (){
            navigateTo(context, const FavoriteNote());
          }
      ),
      drawer_item(
          title: 'Archive Notes',
          iconData: Icons.archive,
          function: (){
            navigateTo(context, const ArchivedNote());
          }
      ),
      drawer_item(
          title: 'To-Do List',
          iconData: Icons.delete,
          function: (){
            print('To-Do List');
          }
      ),
      drawer_item(
          title: 'Settings',
          iconData: Icons.settings,
          function: (){
            print('Settings');
          }
      ),
      drawer_item(
          title: 'Help & Feedback',
          iconData: Icons.help,
          function: (){
            print('Help & Feedback');
          }
      ),

    ];


    return BlocConsumer<AppCubit,AppStates>(
        listener: (context,state){},
        builder: (context,state){
          var cubit=AppCubit.get(context);
          return ElasticDrawer(
            mainColor: Colors.white,
            drawerColor: const Color(0xff343232),
            drawerChild: Container(
              padding: const EdgeInsets.all(20),
              child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children:  [
                    const SizedBox(height: 70,),
                    Text('Keep Note',style: GoogleFonts.lato(
                      color: Colors.white,
                      fontSize: 22,
                    ),
                      maxLines: 1,
                      overflow: TextOverflow.ellipsis,
                    ),
                    const SizedBox(height: 20,),
                    Expanded(
                      child:ListView.separated(
                          physics: const BouncingScrollPhysics(),
                          itemBuilder: (context,index)=>Block_drawer(drawerItems[index]),
                          separatorBuilder: (context,index){
                            return const SizedBox(height: 10,);
                          },
                          itemCount: drawerItems.length
                      ),
                    ),
                    CircleAvatar(
                      radius: 20,
                      backgroundColor: Colors.white,
                      child: IconButton(
                          onPressed: (){
                            ElasticDrawerKey.drawer.currentState?.closeElasticDrawer(context);
                          },
                          icon: const Icon(
                            Icons.double_arrow,
                            color: Colors.black,
                          )
                      ),
                    ),

                  ]
              ),
            ),
            mainChild:Scaffold(
              backgroundColor: Colors.grey[50],
              appBar: AppBar(
                elevation: 2,
                backwardsCompatibility: false,
                systemOverlayStyle: const SystemUiOverlayStyle(
                    statusBarColor:Colors.white,
                    statusBarIconBrightness: Brightness.dark
                ),
                backgroundColor: Colors.white,
                title: Text(
                  'Notes',style: GoogleFonts.lato(
                  color: Colors.black,
                  fontSize: 22,
                ),
                ),
              ),
              body: cubit.noteItems.isNotEmpty ?
                    Column(
                children: [
                  const SizedBox(height: 15,),
                  Expanded(
                    child: StaggeredGridView.countBuilder(
                      physics: const BouncingScrollPhysics(),
                      crossAxisCount: 4,
                      itemCount: cubit.noteItems.length,
                      itemBuilder: (BuildContext context, int index) =>  InkWell(
                        onTap: (){
                          cubit.titleController.text='${cubit.noteItems[index]['title']}';
                          cubit.contentController.text='${cubit.noteItems[index]['content']}';
                          cubit.colorNote=cubit.noteColors[cubit.noteItems[index]['color']];
                          cubit.upNote=true;
                          navigateTo(context,InsertNote(idNote: cubit.noteItems[index]['id'],));
                          },
                            child: Container(
                              margin: const EdgeInsets.fromLTRB(8, 0, 4, 0),
                              decoration: BoxDecoration(
                                  color: cubit.noteColors[cubit.noteItems[index]['color']],
                                  borderRadius: BorderRadius.circular(10)

                              ),
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  SizedBox(height: 10,),
                                  Row(
                                    children: [
                                      Container(
                                        width: 120,
                                        padding: const EdgeInsets.fromLTRB(10, 10, 0, 0),
                                        child: Text('${cubit.noteItems[index]['title']}',style: GoogleFonts.lato(
                                          color: Colors.white,
                                          fontSize: 20,
                                        ),
                                          maxLines: 1,
                                          overflow: TextOverflow.ellipsis,
                                        ),
                                      ),
                                      IconButton(
                                        padding: EdgeInsets.zero,
                                            onPressed: (){
                                              cubit.updateDatabase(S: 'star', id: cubit.noteItems[index]['id']);
                                            },
                                            icon: const Icon(
                                              Icons.star_border,
                                              color: Colors.white,
                                            )
                                        ),

                                    ],
                                  ),
                                  const SizedBox(height: 5,),
                                  Expanded(
                                    child: Container(
                                      padding: EdgeInsets.fromLTRB(10, 10, 0, 0),
                                      child: Text('${cubit.noteItems[index]['content']}',style: GoogleFonts.lato(
                                        color: Colors.white,
                                        fontSize: 15,
                                      ),
                                        maxLines: 4,
                                        overflow: TextOverflow.ellipsis,
                                      ),
                                    ),
                                  ),
                                  // SizedBox(height: 10,),
                                  // Expanded(
                                  //   child: Container(
                                  //     padding: EdgeInsets.all(10),
                                  //     alignment: Alignment.center,
                                  //     child: const Image(
                                  //         fit: BoxFit.fill,
                                  //         image: AssetImage(
                                  //             'accets/images/note.jpg'
                                  //         )
                                  //
                                  //     ),
                                  //   ),
                                  // ),

                                ],
                              ),
                            ),
                          ),
                      staggeredTileBuilder: (int index) =>
                          StaggeredTile.count(2, index.isEven ? 1.7 : 2.1),
                      mainAxisSpacing: 7.0,
                      crossAxisSpacing: 0,
                    ),
                  ),
                ],
              ) : Container(
                width: double.infinity,
                child: Column(
                  children: [
                    const SizedBox(height: 190,),
                    const Icon(
                      Icons.lightbulb_outline,
                      color: Colors.black,
                      size: 120,
                    ),
                    const SizedBox(height: 10,),
                    Text('Notes you add appear here',style: GoogleFonts.barlowCondensed(
                      fontSize: 20,
                      color: Colors.black,
                    ),)
                  ],
                ),
              ),

              floatingActionButton: FloatingActionButton(
                backgroundColor: const Color(0xf2353536),
                onPressed: (){
                  cubit.contentController.text='';
                  cubit.titleController.text='';
                  cubit.upNote=false;
                  navigateTo(context,  InsertNote());

                  // cubit.createDatabase();
                },
                child: const Icon(
                  Icons.add,
                  color: Colors.white,
                  size: 30,
                ),
              ),
              // bottomNavigationBar: BottomAppBar(
              //   color: const Color(0xff2f2f31),
              // shape: const CircularNotchedRectangle(),
              //  child: Row(
              //    children: [
              //      const SizedBox(width: 10),
              //      IconButton(
              //          onPressed: (){
              //
              //      }, icon: const Icon(
              //        Icons.list_alt_sharp,
              //        color: Colors.white,
              //      )
              //      ),
              //      const SizedBox(width: 10,),
              //      IconButton(
              //          onPressed: (){
              //
              //          }, icon: const Icon(
              //        Icons.colorize,
              //        color: Colors.white,
              //      )
              //      ),
              //    ],
              //  ),
              // ),
              floatingActionButtonLocation: FloatingActionButtonLocation.endFloat,

            ),

          );
        },
    );
  }

}




// Widget Block_Note(Map model,String title,String content,context){
//   return InkWell(
//     onTap: (){
//       title='1';
//       // content='${model['content']}';
//       navigateTo(context,InsertNote());
//     },
//     child: Container(
//       margin: const EdgeInsets.fromLTRB(8, 0, 4, 0),
//       decoration: BoxDecoration(
//         color: Colors.blue,
//         borderRadius: BorderRadius.circular(10)
//
//       ),
//       child: Column(
//         crossAxisAlignment: CrossAxisAlignment.start,
//       mainAxisAlignment: MainAxisAlignment.center,
//       children: [
//         Container(
//           padding: EdgeInsets.fromLTRB(10, 10, 0, 0),
//           child: Text('${model['title']}',style: GoogleFonts.lato(
//             color: Colors.white,
//             fontSize: 22,
//           ),
//             maxLines: 1,
//             overflow: TextOverflow.ellipsis,
//           ),
//         ),
//        const SizedBox(height: 5,),
//         Container(
//           padding: EdgeInsets.fromLTRB(10, 10, 0, 0),
//           child: Text('${model['content']}',style: GoogleFonts.lato(
//             color: Colors.white,
//             fontSize: 13,
//           ),
//           maxLines: 2,
//           overflow: TextOverflow.ellipsis,
//           ),
//         ),
//         // SizedBox(height: 10,),
//         // Expanded(
//         //     child: Container(
//         //       padding: EdgeInsets.all(10),
//         //       alignment: Alignment.center,
//         //       child: const Image(
//         //          fit: BoxFit.fill,
//         //           image: AssetImage(
//         //         'accets/images/note.jpg'
//         //       )
//         //
//         //       ),
//         //     ),
//         //   ),
//
//       ],
//       ),
//     ),
//   );
// }

Widget Block_drawer(drawer_item item ){
  return InkWell(
    onTap: (){
      return item.function!();
    },
    child: Container(
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(10),
      ),
      padding: EdgeInsets.all(10),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.start,
        children: [
          Icon(
            item.iconData,
            color: Colors.white,
          ),
          SizedBox(width: 15,),
          Text('${item.title}',style: GoogleFonts.lato(
            color: Colors.white,
            fontSize: 16,
          ),)
        ],
      ),
    ),
  );
}