import 'package:argiserve/Theme/colors.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../layout/cubit/cubit.dart';
import '../../layout/cubit/state.dart';
import '../../model/post_model.dart';
import '../home/home_screen.dart';


class DetailsScreen extends StatelessWidget {
 var commentController = TextEditingController();
 final String? name;
 final String? text;
 final String? phone;
 final String? title;
 final String? firstImage;

 DetailsScreen({
   this.name,
   this.text,
   this.phone,
   this.title,
   this.firstImage,

});

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<ArgiServeCubit, ArgiServeStates>(
     listener: (context, state){},
     builder: (context, state){
       return Scaffold(
         backgroundColor: Colors.white,
         appBar: AppBar(
           centerTitle: true,
           elevation: 0,
           title: Text(
               'Post Details',
             style: TextStyle(
               color: mainColor,
             ),
           ),
           leading: IconButton(
             onPressed: (){
               Navigator.pop(context, HomeScreen());
             },
             icon:const Icon(
                 Icons.arrow_back
             ),
           ),
         ),
         body: SingleChildScrollView(

           physics:const BouncingScrollPhysics(),
           child: Column(
             crossAxisAlignment: CrossAxisAlignment.center,
             children: [
               const  SizedBox(
                 height: 15,
               ),
               Container(
                 padding:const EdgeInsetsDirectional.all(14),
                 width: double.infinity,
                 height: 100,
                 color: Colors.yellow[200],
                 child: Column(
                   crossAxisAlignment: CrossAxisAlignment.start,
                   children: [
                     Expanded(
                       child: Text(
                         '$text',
                         style:const TextStyle(
                           color: Colors.green,
                           fontSize: 18,
                         ),
                         maxLines: 2,
                         overflow: TextOverflow.ellipsis,
                       ),
                     ),
                     Row(
                       children: [
                         const  Icon(Icons.person),

                         const  SizedBox(
                           width: 5,
                         ),
                         Text(
                           '$name',
                           style:const TextStyle(
                             color: Colors.blue,

                           ),
                         ),

                       ],
                     ),
                   ],
                 ),
               ),
               const  SizedBox(
                 height: 10,
               ),
               Padding(
                 padding: const EdgeInsets.all(8.0),
                 child: Text(
                   '$title',

                 ),
               ),
               if(firstImage !='')
               Image(
                 height: 400,
                   image:
                   NetworkImage(
                     '$firstImage'
                   )

               ),

               const   SizedBox(
                 height:20,
               ),

               Padding(
                 padding: const EdgeInsets.only(right: 8),
                 child: Container(
                   width: 250,
                   height: 50,
                   decoration: BoxDecoration(
                     color: Colors.grey[300],
                     borderRadius: BorderRadius.circular(14),

                   ),
                   child: Row(
                     mainAxisAlignment: MainAxisAlignment.center,
                     children: [
                       const  Icon( Icons.phone),

                       const   SizedBox(
                         width: 10,
                       ),
                       TextButton(
                           onPressed: (){
                           },
                           child: Text(
                             '$phone',
                             style: const TextStyle(
                               color: Colors.blue,
                             ),
                           )
                       ),

                     ],
                   ),
                 ),
               ),
               const SizedBox(
                 height: 8,
               ),
             ],
           ),
         ),
       );
     },
    );
  }
}

Widget buildCommentItem() =>Padding(
  padding: const EdgeInsets.all(8.0),
  child: Container(
    padding:const EdgeInsetsDirectional.all(10),
    width: double.infinity,
    decoration: BoxDecoration(
        color: Colors.grey[300],
        borderRadius: BorderRadiusDirectional.circular(10)
    ),
    child:const Row(
      mainAxisAlignment: MainAxisAlignment.end,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Expanded(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.end,
            children: [
              Text(
                'خالد الروبي',
                style: TextStyle(
                    fontSize: 15,
                    fontWeight: FontWeight.bold
                ),
              ),
              SizedBox(
                height: 5,
              ),
              Text(
                'اي كلام اي كلام اي كلام اي كلام اي كلام اي كلام اي كلام اي كلام اي كلام اي كلام اي كلام اي كلام اي كلام اي كلام اي كلام اي كلام اي كلام اي كلام اي كلام اي كلاماي كلام اي كلام اي كلام اي كلام اي كلام اي كلام اي كلام اي كلام اي كلام اي كلام  ',
                textDirection: TextDirection.rtl,
              )
            ],
          ),
        ),
        SizedBox(
          width: 15,
        ),
        CircleAvatar(
          radius: 25,
          backgroundImage: AssetImage('assets/images/logo.jpg'),
        ),
      ],
    ),
  ),
);
Widget buildPostItem(context, PostModel model) =>Column(
  children: [
    Container(
      padding:const EdgeInsetsDirectional.all(8),
      width: double.infinity,
      height: 100,
      color: Colors.yellow[200],
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.end,
        children: [
          Expanded(
            child: Text(
              '${ArgiServeCubit.get(context).userModel?.name}',
              style:const TextStyle(
                color: Colors.green,
                fontSize: 18,
              ),
              maxLines: 2,
              overflow: TextOverflow.ellipsis,
            ),
          ),
          Row(
            children: [
              const    Row(
                children: [
                  Text(
                    'السعودية',
                    style: TextStyle(
                      color: Colors.blue,
                    ),
                  ),
                  SizedBox(
                    width: 5,
                  ),
                  Icon(Icons.location_on,
                  ),
                ],
              ),
              const  Spacer(),
              Row(
                children: [
                  Text(
                    '${ArgiServeCubit.get(context).userModel?.name}',
                    style: const TextStyle(
                      color: Colors.blue,

                    ),
                  ),
                  const  SizedBox(
                    width: 5,
                  ),
                  const Icon(Icons.person),
                ],
              ),

            ],
          ),
        ],
      ),
    ),
    const  SizedBox(
      height: 10,
    ),
    const Padding(
      padding:  EdgeInsets.all(8.0),
      child: Text(
        'نص الإعلان',
        textDirection: TextDirection.rtl,
      ),
    ),
    const  Image(
        image:
        NetworkImage(
            'https://cdn.britannica.com/94/152294-050-92FE0C83/Arabian-dromedary-camel.jpg?q=60')

    ),
    const   SizedBox(
      height: 5,
    ),
    const Image(
        image:
        NetworkImage(
            'https://cdn.britannica.com/94/152294-050-92FE0C83/Arabian-dromedary-camel.jpg?q=60')

    ),
    const  SizedBox(
      height: 5,
    ),
    const  Image(
        image:
        NetworkImage(
            'https://cdn.britannica.com/94/152294-050-92FE0C83/Arabian-dromedary-camel.jpg?q=60')

    ),
  ],
);
