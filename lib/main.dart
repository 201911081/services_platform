import 'package:argiserve/shared/bloc_observer.dart';
import 'package:argiserve/shared/component/contasnt.dart';
import 'package:argiserve/shared/network/local/cach_helper.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'Theme/colors.dart';
import 'layout/cubit/cubit.dart';
import 'layout/cubit/state.dart';
import 'layout/home_layout_screen.dart';
import 'module/login/login_screen.dart';

void main()async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  await CacheHelper.init();
  Bloc.observer = MyBlocObserver();
  Widget widget;
  uId = CacheHelper.getData(key: 'uId');

  if(uId != null){
    widget = HomeLayoutScreen();
  }else{
    widget = LoginScreen();
  }
  runApp(MyApp(
    startWidget: widget,
  ));
}

class MyApp extends StatelessWidget {
  final Widget startWidget;

  const MyApp({super.key, required this.startWidget});
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return BlocProvider(
        create: (BuildContext context) => ArgiServeCubit()..getUserData()..getPosts()..getMyPosts(),
        child: BlocConsumer<ArgiServeCubit, ArgiServeStates>(
            listener: (context, state) {},
            builder: (context, state) {
              return MaterialApp(
                debugShowCheckedModeBanner: false,
                theme: ThemeData(
                  appBarTheme:  AppBarTheme(
                    iconTheme: IconThemeData(
                        color:mainColor
                    ),
                    color: Colors.white,
                    systemOverlayStyle:const SystemUiOverlayStyle(
                      statusBarIconBrightness: Brightness.dark,
                      statusBarColor: Colors.white,
                    ),
                  ),
                  primarySwatch: Colors.green,
                ),
                home: startWidget,
              );
            }));
  }
}

