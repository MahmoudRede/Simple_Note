import 'package:completeproject/constants.dart';
import 'package:completeproject/cubit/bloc.dart';
import 'package:completeproject/cubit/states.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:google_fonts/google_fonts.dart';

class FavoriteNote extends StatelessWidget {
  const FavoriteNote({Key? key}) : super(key: key);

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
              backwardsCompatibility: false,
              iconTheme: const IconThemeData(
                color: Colors.black,
              ),
              systemOverlayStyle: const SystemUiOverlayStyle(
                  statusBarColor:Colors.white,
                  statusBarIconBrightness: Brightness.dark
              ),
              backgroundColor: Colors.white,
              title: Text('Star Notes',style: GoogleFonts.barlow(
                fontSize: 22,
                color: Colors.black,
              ),),
            ),
            body: cubit.noteStars.isNotEmpty? Container(
              color:Colors.grey[50],
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Expanded(
                    child: GridView.count(
                      crossAxisCount:2,
                      physics: BouncingScrollPhysics(),
                      childAspectRatio: 1/1.1,
                      children:List.generate(cubit.noteStars.length  , (index) => InkWell(
                        onTap: (){
                          // navigateTo(context, widget)
                        },
                        child: Container(
                          decoration: BoxDecoration(
                            color: cubit.noteColors[cubit.noteStars[index]['color']],
                            borderRadius: BorderRadius.circular(10),

                          ),
                          padding: const EdgeInsets.fromLTRB(15, 20, 0, 5),
                          margin: const EdgeInsets.fromLTRB(10, 15, 5, 15),

                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Row(
                                children: [
                                  Text('${cubit.noteStars[index]['title']}',style: GoogleFonts.barlowCondensed(
                                    fontSize: 22,
                                    color: Colors.white,
                                  ),
                                    maxLines: 1,
                                    overflow: TextOverflow.ellipsis,
                                  ),

                                ],
                              ),
                              const SizedBox(height: 10,),
                              Expanded(
                                child: Text('${cubit.noteStars[index]['content']}',style: GoogleFonts.barlowCondensed(
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

                                       cubit.updateDatabase(S: 'new', id: cubit.noteStars[index]['id']);

                                    },
                                    icon: const Icon(
                                      Icons.star,
                                      color: Colors.white,
                                    ),
                                  ),
                                  IconButton(
                                    onPressed: (){

                                      cubit.deleteDatabase(id: cubit.noteStars[index]['id']);

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
                    Icons.star_border_purple500_sharp,
                    color: Colors.black,
                    size: 120,
                  ),
                  const SizedBox(height: 10,),
                  Text('Star notes you add appear here',style: GoogleFonts.barlowCondensed(
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

// Widget  Block_favoriteItem(Map model){
//
//   return InkWell(
//     onTap: (){
//       // navigateTo(context, widget)
//     },
//     child: Container(
//       decoration: BoxDecoration(
//         color: Colors.amberAccent,
//         borderRadius: BorderRadius.circular(10),
//
//       ),
//       padding: const EdgeInsets.fromLTRB(15, 20, 0, 5),
//       margin: const EdgeInsets.fromLTRB(10, 15, 5, 15),
//
//       child: Column(
//         crossAxisAlignment: CrossAxisAlignment.start,
//         children: [
//           Row(
//             children: [
//               Text('${model['title']}',style: GoogleFonts.barlowCondensed(
//                 fontSize: 22,
//                 color: Colors.black,
//               ),
//                 maxLines: 1,
//                 overflow: TextOverflow.ellipsis,
//               ),
//
//             ],
//           ),
//           const SizedBox(height: 10,),
//           Expanded(
//             child: Text('${model['content']}',style: GoogleFonts.barlowCondensed(
//               fontSize: 19,
//               color: Colors.black,
//             ),
//               maxLines: 4,
//               overflow: TextOverflow.visible,
//             ),
//           ),
//           Row(
//             mainAxisAlignment: MainAxisAlignment.end,
//             children: [
//               IconButton(
//                 onPressed: (){
//
//
//
//                 },
//                 icon: const Icon(
//                   Icons.star,
//                   color: Color(0xd8383838),
//                 ),
//               ),
//               IconButton(
//                 onPressed: (){
//
//                 },
//                 icon: const Icon(
//                   Icons.delete,
//                   color: Color(0xd8383838),
//                 ),
//               ),
//             ],
//           )
//         ],
//       ),
//     ),
//   );
//
// }
