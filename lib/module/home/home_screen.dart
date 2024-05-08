import 'package:argiserve/Theme/colors.dart';
import 'package:argiserve/module/home/search_screen.dart';
import 'package:argiserve/module/myposts/add_post_screen.dart';
import 'package:conditional_builder_null_safety/conditional_builder_null_safety.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../layout/cubit/cubit.dart';
import '../../layout/cubit/state.dart';
import '../../model/post_model.dart';
import '../../shared/component/component.dart';
import '../details/details_screen.dart';

class HomeScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return BlocConsumer<ArgiServeCubit, ArgiServeStates>(
      listener: (context, state) {},
      builder: (context, state) {
        var model = ArgiServeCubit.get(context).userModel;
        return Column(
          children: [
            Stack(
              alignment: Alignment.bottomCenter,
              children: [
                const Image(image: AssetImage('assets/images/home2.jpeg')),
                Column(
                  crossAxisAlignment: CrossAxisAlignment.end,
                  children: [
                    Padding(
                      padding: const EdgeInsets.only(right: 12, bottom: 50),
                      child: IconButton(
                        onPressed: () {
                          navigateTo(context, AddpostScreen());
                        },
                        icon: const Icon(
                          Icons.post_add,
                          size: 60,
                          color: Colors.green,
                        ),
                      ),
                    ),
                    InkWell(
                      onTap: (){
                        navigateTo(context, SearchScreen());
                      },
                      child: Padding(
                        padding: const EdgeInsets.only(
                            left: 15, right: 15, bottom: 15),
                        child: Container(
                          padding: const EdgeInsetsDirectional.only(
                              top: 15, start: 15, bottom: 15),
                          height: 50,
                          width: double.infinity,
                          decoration: BoxDecoration(
                            color: Colors.grey[100],
                            borderRadius: BorderRadius.circular(12),
                          ),
                          child: const Row(
                            children: [
                              Icon(Icons.search_rounded),
                              SizedBox(
                                width: 8,
                              ),
                              Text(
                                'Search...',
                                style: TextStyle(fontSize: 18),
                              ),
                            ],
                          ),
                        ),
                      ),
                    ),

                  ],
                )
              ],
            ),
            Row(
              crossAxisAlignment: CrossAxisAlignment.center,
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
              const  Text('Welcome,',
                  style: TextStyle(
                      color: Colors.black,
                      fontSize: 30,
                      fontWeight: FontWeight.w900),
                ),
                Text(' ${model?.name}',
                  style:const  TextStyle(
                      color: Colors.black,
                      fontSize: 30,
                      fontWeight: FontWeight.w900),
                ),
              ],
            ),
            ListView.separated(
                physics: const BouncingScrollPhysics(),
                shrinkWrap: true,
                itemBuilder: (context, index) => buildPostItem(
                    ArgiServeCubit.get(context).posts[index], context),
                separatorBuilder: (context, index) => myDivider(),
                itemCount: ArgiServeCubit.get(context).posts.length),
          ],
        );
      },
    );
  }
}

Widget buildPostItem(PostModel model, context) => Padding(
      padding: const EdgeInsets.all(8.0),
      child: InkWell(
        onTap: () {
          navigateTo(
              context,
              DetailsScreen(
                name: model.name,
                text: model.text,
                title: model.title,
                phone: model.phone,
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
          child: Padding(
            padding: const EdgeInsets.only(top: 15, left: 7, bottom: 15),
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                if (model.firstPostImage != '')
                  Image(
                    image: NetworkImage(
                      '${model.firstPostImage}',
                    ),
                    height: 120,
                    width: 120,
                  ),
                const SizedBox(
                  width: 15,
                ),
                Expanded(
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.start,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Expanded(
                        child: Text(
                          '${model.text}',
                          maxLines: 2,
                          overflow: TextOverflow.ellipsis,
                          style: const TextStyle(
                              color: Colors.blue, fontWeight: FontWeight.bold),
                        ),
                      ),
                      Expanded(
                        child: Text(
                          '${model.dateTime}',
                          maxLines: 2,
                          overflow: TextOverflow.ellipsis,
                          style: TextStyle(
                            color: mainColor,
                          ),
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


