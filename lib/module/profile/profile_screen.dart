
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../layout/cubit/cubit.dart';
import '../../layout/cubit/state.dart';
import '../../shared/component/component.dart';
import 'edit_profile_screen.dart';


class ProfileScreen extends StatelessWidget {
  const ProfileScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<ArgiServeCubit, ArgiServeStates>(
      listener: (context, state){},
      builder: (context, state){
        var userModel = ArgiServeCubit.get(context).userModel;
        return SingleChildScrollView(
          child: Column(
            children: [
              const SizedBox(
                height:60,
              ),

              if(userModel!.image !=null)
              Center(
                child: CircleAvatar(
                  radius: 80,
                  backgroundImage: NetworkImage(
                    '${userModel.image}',
                  ),
                )
              ),
              Padding(
                padding: const EdgeInsets.all(20.0),
                child: Column(
                  children: [
                    Container(
                      padding:const EdgeInsetsDirectional.only(start: 10),
                      width: double.infinity,
                      height: 100,
                      decoration: BoxDecoration(
                        color: Colors.grey[300],
                        borderRadius: BorderRadius.circular(14),

                      ),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          const   Text(
                            'Name',
                            style: TextStyle(
                                fontSize: 25,
                                fontWeight: FontWeight.bold
                            ),
                          ),
                          const  SizedBox(
                            height: 4,
                          ),
                          myDivider(),
                          const  SizedBox(
                            height: 10,
                          ),
                          Expanded(
                            child: Text(
                              '${userModel.name}',
                              style:const TextStyle(
                                  fontSize: 25,
                                  fontWeight: FontWeight.bold
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                    const   SizedBox(
                      height: 10,
                    ),
                    Container(
                      padding:const EdgeInsetsDirectional.only(start: 10),
                      width: double.infinity,
                      height: 100,
                      decoration: BoxDecoration(
                        color: Colors.grey[300],
                        borderRadius: BorderRadius.circular(14),

                      ),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          const Text(
                            'Email Address ',
                            style: TextStyle(
                                fontSize: 25,
                                fontWeight: FontWeight.bold
                            ),
                          ),
                          const  SizedBox(
                            height: 4,
                          ),
                          myDivider(),
                          const  SizedBox(
                            height: 4,
                          ),
                          Expanded(
                            child: Text(
                              '${userModel.email}',
                              style:const TextStyle(
                                  fontSize: 25,
                                  fontWeight: FontWeight.bold
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                    const  SizedBox(
                      height: 10,
                    ),
                    Container(
                      width: double.infinity,
                      height: 100,
                      decoration: BoxDecoration(
                        color: Colors.grey[300],
                        borderRadius: BorderRadius.circular(14),

                      ),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          const  SizedBox(
                            height: 4,
                          ),
                          const  Text(
                            'Phone Number',
                            style: TextStyle(
                                fontSize: 25,
                                fontWeight: FontWeight.bold
                            ),
                          ),
                          const  SizedBox(
                            height: 4,
                          ),
                          myDivider(),
                          const  SizedBox(
                            height: 4,
                          ),
                          Expanded(
                            child: Text(
                              '${userModel.phone}',
                              style:const TextStyle(
                                  fontSize: 25,
                                  fontWeight: FontWeight.bold
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                    const SizedBox(
                      height: 20,
                    ),
                    Row(
                      children: [
                        Expanded(
                          child: Container(
                            decoration: BoxDecoration(
                              color: Colors.blue,
                              borderRadius: BorderRadius.circular(14),
                            ),
                            child: MaterialButton(
                              onPressed: (){
                               navigateTo(context, EditProfileScreen());
                              },
                              child:const Text(
                                'Edit Profile',
                                style: TextStyle(
                                  color: Colors.white
                                ),
                              ),
                            ),
                          ),
                        ),
                        const SizedBox(
                          width: 10,
                        ),
                        Expanded(
                          child: Container(
                            decoration: BoxDecoration(
                              color: Colors.red,
                              borderRadius: BorderRadius.circular(14),
                            ),
                            child: MaterialButton(
                              onPressed: (){
                                showDialog(context: context, builder: (context){
                                  return   AlertDialog(
                                    title:const  Text("Warning!"
                                      //      "${HabitsCubit.get(context).habits[HabitsCubit.get(context).habitId].name}"
                                      // "${HabitsCubit.get(context).habits[HabitsCubit.get(context).habitId].days}"
                                    ),
                                    titleTextStyle:const TextStyle(
                                      color: Colors.red,
                                    ),
                                    content:const Text('Are Your Sure To Logout ?'),
                                    contentTextStyle:const TextStyle(
                                      color: Colors.black,
                                    ),
                                    actions: [
                                      TextButton(onPressed: (){
                                        ArgiServeCubit.get(context).signOut(context);
                                      }, child:const Text('Log Out',style: TextStyle(
                                          color: Colors.red
                                      ),),

                                      ),
                                      TextButton(onPressed: (){Navigator.pop(context);}, child:const Text('No')),

                                    ],

                                  );
                                });

                              },
                              child:const Text(
                                'Logout',
                                style: TextStyle(
                                  color: Colors.white
                                ),
                              ),
                            ),
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
            ],
          ),
        );
      },
    );
  }
}
