import 'package:completeproject/cubit/bloc.dart';
import 'package:completeproject/cubit/states.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:google_fonts/google_fonts.dart';

class ArchivedNote extends StatelessWidget {
  const ArchivedNote({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<AppCubit,AppStates>(
      listener: (context,state){},
      builder: (context,state){
        var cubit=AppCubit.get(context);
        return Scaffold(
          appBar: AppBar(
            titleSpacing: 0.0,
            elevation: 2,
            iconTheme: const IconThemeData(
              color: Colors.black,
            ),
            backwardsCompatibility: false,
            systemOverlayStyle: const SystemUiOverlayStyle(
                statusBarColor:Colors.white,
                statusBarIconBrightness: Brightness.dark
            ),
            backgroundColor: Colors.white,
            title: Text('Archived Notes',style: GoogleFonts.barlow(
              fontSize: 22,
              color: Colors.black,
            ),),
          ),
          body: cubit.noteArchived.isNotEmpty?  Container(
            color:Colors.grey[50],
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Expanded(
                  child: GridView.count(
                    crossAxisCount:2,
                    physics: BouncingScrollPhysics(),
                    childAspectRatio: 1/1.1,
                    children:List.generate(cubit.noteArchived.length  , (index) => Container(
                      decoration: BoxDecoration(
                        color: cubit.noteColors[cubit.noteArchived[index]['color']],
                        borderRadius: BorderRadius.circular(10),

                      ),
                      padding: const EdgeInsets.fromLTRB(15, 20, 0, 5),
                      margin: const EdgeInsets.fromLTRB(10, 15, 5, 15),

                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text('${cubit.noteArchived[index]['title']}',style: GoogleFonts.barlowCondensed(
                            fontSize: 22,
                            color: Colors.white,
                          ),
                            maxLines: 1,
                            overflow: TextOverflow.ellipsis,
                          ),
                          const SizedBox(height: 10,),
                          Expanded(
                            child: Text('${cubit.noteArchived[index]['content']}',style: GoogleFonts.barlowCondensed(
                              fontSize: 19,
                              color: Colors.white,
                            ),
                                maxLines: 4,
                                overflow: TextOverflow.visible,
                              ),
                          ),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.end,
                            children: [
                              IconButton(
                                onPressed: (){

                                  cubit.updateDatabase(S: 'new', id: cubit.noteArchived[index]['id']);

                                },
                                icon: const Icon(
                                  Icons.archive,
                                  color: Colors.white,
                                ),
                              ),
                              IconButton(
                                onPressed: (){

                                  cubit.deleteDatabase(id: cubit.noteArchived[index]['id']);

                                },
                                icon: const Icon(
                                  Icons.delete,
                                  color: Colors.white,
                                ),
                              ),
                            ],
                          )
                        ],
                      ),
                    )
                    )  ,
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
                Text('Archive notes you add appear here',style: GoogleFonts.barlowCondensed(
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

// Widget  Block_archivedItem(Map model){
//
//   return Container(
//     decoration: BoxDecoration(
//       color: Colors.amberAccent,
//       borderRadius: BorderRadius.circular(10),
//
//     ),
//     padding: const EdgeInsets.fromLTRB(15, 20, 0, 5),
//     margin: const EdgeInsets.fromLTRB(10, 15, 5, 15),
//
//     child: Column(
//       crossAxisAlignment: CrossAxisAlignment.start,
//       children: [
//         Text('${model['title']}',style: GoogleFonts.openSans(
//           fontSize: 19,
//           color: Colors.black,
//         ),),
//         const SizedBox(height: 15,),
//         Text('${model['content']}',style: GoogleFonts.openSans(
//           fontSize: 19,
//           color: Colors.black,
//         ),),
//       ],
//     ),
//   );
//
// }
