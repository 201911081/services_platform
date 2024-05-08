import 'package:argiserve/module/register/cubit/state.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../../model/user_model.dart';


class ArgiRegisterCubit extends Cubit<ArgiRegisterStates>{
  ArgiRegisterCubit() : super(ArgiRegisterInitialState());
  static ArgiRegisterCubit get(context) =>BlocProvider.of(context);
  void userStudentRegister({
    required String email,
    required String name,
    required String phone,
    required String password,
  }) {
    emit(ArgiRegisterLoadingState());
    FirebaseAuth.instance.createUserWithEmailAndPassword(
        email: email,
        password: password,
    ).then((value) {

      userCreate(email: email,
          uId: value.user!.uid,
          name: name,
          phone: phone,
      );

    }).catchError((error){
      print(error.toString());
      emit(ArgiRegisterErrorState(error.toString()));
    });
  }

  void userCreate({
    required String email,
    required String name,
    required String phone,
    required String uId,
}){
    UserModel model = UserModel(
      name: name,
      email: email,
      phone: phone,
      image: 'https://as2.ftcdn.net/v2/jpg/00/64/67/27/1000_F_64672736_U5kpdGs9keUll8CRQ3p3YaEv2M6qkVY5.jpg ',
      uId: uId,
    );
    FirebaseFirestore.instance
        .collection('users')
        .doc(uId)
        .set(model.toMap()).then((value) {
          emit(ArgiCreateUserSuccessState(model.uId!));
    }).catchError((error){
      print(error.toString());
      emit(ArgiCreateUserErrorState(error));
    });
  }

  IconData suffix = Icons.visibility_outlined;
  bool isPassword = true;

  void changePasswordRegisterVisibility(){
    isPassword =!isPassword;
    suffix =isPassword? Icons.visibility_outlined: Icons.visibility_off_outlined;
    emit(ChangePasswordHaragRegisterVisibilityState());
  }


}
