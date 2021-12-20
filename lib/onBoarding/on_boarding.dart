import 'dart:ui';
import 'package:completeproject/showNote/show_note.dart';
import 'package:concentric_transition/page_view.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:google_fonts/google_fonts.dart';

class items{
  String ?title;
  String ?content;
  String ?image;

  items({
    this.title,
    this.image,
    this.content,
  });

}

class OnBoarding extends StatelessWidget {
    OnBoarding({Key? key}) : super(key: key);

   List <items> Items =[
     items(
       title: 'Manage',
       content: 'Notes help you understand and remember the information later , keep you awake',
       image:'accets/images/third.jpg'
     ),

     items(
       title: 'Create',
       content: 'Create Note , Tasks allow you to easily keep and Control it ',
       image:'accets/images/img_4.png'

     ),

     items(

         title: 'Organize',
         content: 'Start enjoying a more organized life and manage life in one visual collaborative space',
       image:'accets/images/one.jpg'

     ),
   ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
       toolbarHeight: 0.0,
        elevation: 0,
      ),
      body: Container(
        color: Colors.white,
        child: ConcentricPageView(
          onChange: (int index){
             if(index== Items.length-1)
               {
                 print('Last');
               }
          },
          onFinish: (){
            Navigator.push(context, MaterialPageRoute(builder: (_){
              return ShowNote();
            })
            );
          },
          colors: const [Colors.white, Color.fromARGB(255, 49, 124, 246), Colors.white],
          itemCount: 3, // null = infinity
          physics: BouncingScrollPhysics(),
          itemBuilder: (index,value) {
            return  Block_PageView( Items[index],index);
          },
        ),
      ),
    );
  }
}

Widget Block_PageView(items item,int index){
  return Container(
    alignment: Alignment.center,
    child: Column(
      crossAxisAlignment: CrossAxisAlignment.center,
      children:  [
        const SizedBox(height: 50,),

        Image(
          height: 220,
          image: AssetImage(
            '${item.image}'
        ),
        ),
        const SizedBox(height: 90,),

        index==1? Text('${item.title}',style:
        GoogleFonts.openSans(
            color: Colors.white,
            fontSize: 30,
            fontWeight: FontWeight.bold
        )
        ): Text('${item.title}',style:
        GoogleFonts.openSans(
            color: Colors.blue,
            fontSize: 30,
            fontWeight: FontWeight.bold
        )
        ),
        const SizedBox(height: 20,),
        Container(
          alignment: Alignment.center,
          padding: const EdgeInsets.fromLTRB(20,0, 10, 0),
          child:   index==1? Text('${item.content}',style:
          GoogleFonts.lato(
              color: Colors.black,
              fontSize: 18,
              fontWeight: FontWeight.bold
          ),
            textAlign: TextAlign.center,

          ): Text('${item.content}',style:
          GoogleFonts.lato(
              color: Colors.black,
              fontSize: 18,
          ),
            textAlign: TextAlign.center,
          ),
        ),
      ],
    ),
  );
}
