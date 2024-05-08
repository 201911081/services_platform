import 'package:argiserve/module/myposts/add_post_screen.dart';
import 'package:argiserve/shared/component/component.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../module/home/search_screen.dart';
import 'cubit/cubit.dart';
import 'cubit/state.dart';



class HomeLayoutScreen extends StatelessWidget {
  int currentState =0;
  @override
  Widget build(BuildContext context) {
    return BlocConsumer<ArgiServeCubit,ArgiServeStates>(
      listener: (context, state){},
      builder: (context, state){
        var cubit =ArgiServeCubit.get(context);
        return  Scaffold(
           backgroundColor: Colors.white,
          body:SingleChildScrollView(
            physics:const BouncingScrollPhysics(),
              child: Column(
                children: [
                  cubit.screens[cubit.currentIndex],
                ],
              ),
          ),
          bottomNavigationBar: BottomNavigationBar(
            type: BottomNavigationBarType.fixed,

            elevation: 0,
            currentIndex: cubit.currentIndex,
            onTap: (index){
              cubit.changeBottomNav(index);
            },
            items:const [
                BottomNavigationBarItem(icon: Icon(Icons.home_outlined),
                label: 'Home',
              ),
               BottomNavigationBarItem(icon: Icon(Icons.apps_outlined),
                label: 'My Posts',
              ),
               BottomNavigationBarItem(icon: Icon(Icons.person_pin),
                label: 'Profile',
              ),
            ],
          ),
        );
      },
    );
  }
}
