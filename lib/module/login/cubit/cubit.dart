
import 'package:argiserve/module/login/cubit/state.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../shared/component/contasnt.dart';


class ArgiLoginCubit extends Cubit<ArgiLoginStates>{
  ArgiLoginCubit() : super(ArgiLoginInitialState());
  static ArgiLoginCubit get(context) =>BlocProvider.of(context);
  void userLogin({
    required String email,
    required String password,
  }) {
    emit(ArgiLoginLoadingState());
  FirebaseAuth.instance.signInWithEmailAndPassword(
      email: email,
      password: password,
  ).then((value) {
    // print(value.user.email);
    // print(value.user.uid);
    uId = value.user!.uid;
    emit(ArgiLoginSuccessState(value.user!.uid));
  }).catchError((error){
    emit(ArgiLoginErrorState(error.toString()));
  });
  }

  IconData suffix = Icons.visibility_outlined;
  bool isPassword = true;

  void changePasswordVisibility(){
    isPassword =!isPassword;
    suffix =isPassword? Icons.visibility_outlined: Icons.visibility_off_outlined;
    emit(ChangePasswordVisibilityState());
  }
}
