import 'package:conditional_builder_null_safety/conditional_builder_null_safety.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../Theme/colors.dart';
import '../../layout/cubit/cubit.dart';
import '../../layout/cubit/state.dart';
import '../../model/post_model.dart';
import '../../shared/component/component.dart';
import '../details/details_screen.dart';
import 'add_post_screen.dart';

class MyPosts extends StatelessWidget {
  const MyPosts({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<ArgiServeCubit, ArgiServeStates>(
      listener: (context, state) {},
      builder: (context, state) {
        return ConditionalBuilder(
            condition: ArgiServeCubit.get(context).posts.isNotEmpty,
            builder: (context) => Padding(
              padding: const EdgeInsets.only(top: 8, left: 8,right: 8),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.end,
                children: [
                  const SizedBox(
                    height:40,
                  ),
                  Padding(
                    padding: const EdgeInsets.only(right: 8),
                    child: IconButton(
                      onPressed: () {
                        navigateTo(context, AddpostScreen());
                      },
                      icon: const Icon(
                        Icons.post_add,
                        size: 50,
                      ),
                    ),
                  ),
                  const SizedBox(
                    height:20,
                  ),
                  ListView.separated(
                      physics:const BouncingScrollPhysics(),
                      shrinkWrap: true,
                      itemBuilder: (context, index) => buildBannerItem(
                          ArgiServeCubit.get(context).myPosts[index], context),
                      separatorBuilder: (context, index) => myDivider(),
                      itemCount: ArgiServeCubit.get(context).myPosts.length),
                ],
              ),
            ),
            fallback: (context) =>
             Center(child: SafeArea(
               child: Column(
                 children: [
                   const SizedBox(height: 40,),
                   Text('No Posts Yet!',style: TextStyle(
                    color: mainColor,
                     fontSize: 40
                               ),),
                   Padding(
                     padding: const EdgeInsets.all(60.0),
                     child: defaultButton(function: (){
                       navigateTo(context, AddpostScreen());
                     }, text: 'Add Post'),
                   )
                 ],
               ),
             ))

        );
      },
    );
  }
}

Widget buildBannerItem(PostModel model, context) => Padding(
  padding: const EdgeInsets.all(8.0),
  child: InkWell(
    onTap: (){
      navigateTo(context, DetailsScreen(
        name: model.name,
        text: model.text,
        title : model.title,
        phone : model.phone,
        firstImage: model.firstPostImage,

      ));
    },

    child: Container(
      width: double.infinity,
      height: 160,
      decoration: BoxDecoration(
        color: Colors.grey[200],
        borderRadius: BorderRadius.circular(14),

      ),
      child:  Padding(
        padding:const EdgeInsets.only(
            top: 15,
            left: 7,
            bottom: 15
        ),
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            if(model.firstPostImage !='')
              Image(image: NetworkImage('${model.firstPostImage}',
              ),
                height: 120,
                width: 120,
              ),
            const SizedBox(width: 15,),
            Expanded(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.start,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Expanded(
                    child: Text('${model.text}',
                      maxLines: 2,
                      overflow: TextOverflow.ellipsis,
                      style: const TextStyle(
                          color: Colors.blue, fontWeight: FontWeight.bold),
                    ),
                  ),
                  Expanded(
                    child: Text('${model.dateTime}',
                      maxLines: 2,
                      overflow: TextOverflow.ellipsis,
                      style: TextStyle(
                        color:mainColor,),
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    ),
  ),
);

