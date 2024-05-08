import 'package:argiserve/Theme/colors.dart';
import 'package:argiserve/shared/component/component.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:intl/intl.dart';

import '../../layout/cubit/cubit.dart';
import '../../layout/cubit/state.dart';

class AddpostScreen extends StatelessWidget {
  var textController = TextEditingController();
  var titleController = TextEditingController();
  String now = DateFormat('dd/MM/yyyy').format(DateTime.now());
  @override
  Widget build(BuildContext context) {
    return BlocConsumer<ArgiServeCubit, ArgiServeStates>(
      listener: (context, state) {
        if(state is CreateMyPostsSuccessState){
          showToast(text: 'Done Successfully!', state: ToastStates.success);
          Navigator.pop(context);
        }
        if(state is CreateMyPostsErrorState){
          showToast(text: 'Oops! Try Again', state: ToastStates.error);
        }
      },
      builder: (context, state) {
        var userModel = ArgiServeCubit.get(context).userModel;
        return Scaffold(
            backgroundColor: Colors.white,
            appBar: AppBar(
              elevation: 0,
              actions: [
                TextButton(
                    onPressed: () {

                      if (ArgiServeCubit.get(context).firstPostImage == null) {
                        ArgiServeCubit.get(context).createPost(
                            text: textController.text,
                            title: titleController.text,
                            dateTime: now
                        );
                        ArgiServeCubit.get(context).createMyPost(
                            text: textController.text,
                            title: titleController.text,
                            dateTime: now);
                      }
                      if (ArgiServeCubit.get(context).firstPostImage != null) {
                        ArgiServeCubit.get(context).uploadPostImage(
                            text: textController.text,
                            title: titleController.text,
                            dateTime: now);
                        ArgiServeCubit.get(context).uploadMyPostImage(
                            text: textController.text,
                            title: titleController.text,
                            dateTime: now);

                      }
                    },
                    child: Text(
                      'Post',
                      style: TextStyle(fontSize: 20, color: mainColor),
                    )),
              ],
            ),
            body: Padding(
              padding: const EdgeInsets.all(20.0),
              child: Column(
                children: [
                  if (state is CreatePostLoadingState)
                    const LinearProgressIndicator(),
                  if (state is CreatePostLoadingState)
                    const SizedBox(
                      height: 5,
                    ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.end,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      Expanded(
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.start,
                          crossAxisAlignment: CrossAxisAlignment.end,
                          children: [
                            Text(
                              '${userModel?.name}',
                              style: const TextStyle(
                                  fontSize: 15, fontWeight: FontWeight.bold),
                            ),
                          ],
                        ),
                      ),
                      const SizedBox(
                        width: 15,
                      ),
                      CircleAvatar(
                        radius: 25,
                        backgroundImage: NetworkImage('${userModel?.image}'),
                      ),
                    ],
                  ),
                  Expanded(
                    child: TextFormField(
                      controller: textController,
                      decoration: const InputDecoration(
                        hintText: 'Post Title...',
                        border: InputBorder.none,
                      ),
                    ),
                  ),
                  Expanded(
                    child: TextFormField(
                      controller: titleController,
                      decoration: const InputDecoration(
                        hintText: 'Post Description',
                        border: InputBorder.none,
                      ),
                    ),
                  ),
                  Row(
                    children: [
                      if (ArgiServeCubit.get(context).firstPostImage != null)
                        Stack(
                          alignment: AlignmentDirectional.topEnd,
                          children: [
                            Container(
                              height: 100,
                              width: 100,
                              decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(4),
                                  image: DecorationImage(
                                      image: FileImage(
                                          ArgiServeCubit.get(context)
                                              .firstPostImage!),
                                      fit: BoxFit.cover)),
                            ),
                            IconButton(
                              onPressed: () {
                                ArgiServeCubit.get(context).removePostImage();
                              },
                              icon: const Icon(
                                Icons.close,
                                color: Colors.blue,
                              ),
                            ),
                          ],
                        ),
                    ],
                  ),
                  Column(
                    children: [
                      if (ArgiServeCubit.get(context).firstPostImage == null)
                        TextButton(
                            onPressed: () {
                              ArgiServeCubit.get(context).getFirstPostImage();
                            },
                            child: const Row(
                              children: [
                                Icon(Icons.image),
                                SizedBox(
                                  width: 5,
                                ),
                                Text('Add Photo')
                              ],
                            )),
                    ],
                  ),
                ],
              ),
            ));
      },
    );
  }
}
