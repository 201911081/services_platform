import 'package:argiserve/Theme/colors.dart';
import 'package:argiserve/layout/cubit/cubit.dart';
import 'package:conditional_builder_null_safety/conditional_builder_null_safety.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../layout/home_layout_screen.dart';
import '../../shared/component/component.dart';
import '../../shared/component/contasnt.dart';
import '../../shared/network/local/cach_helper.dart';
import '../login/cubit/cubit.dart';
import '../login/login_screen.dart';
import 'cubit/cubit.dart';
import 'cubit/state.dart';


class RegisterScreen extends StatelessWidget {
  FocusNode myFocusNode =  FocusNode();
  final _formKey = GlobalKey<FormState>();
  var nameController = TextEditingController();
  var emailController = TextEditingController();
  var passwordController = TextEditingController();
  var phoneController = TextEditingController();

  @override
  Widget build(BuildContext context) {

    return BlocProvider(

      create: (BuildContext context)=> ArgiRegisterCubit(),
      child: BlocConsumer<ArgiRegisterCubit, ArgiRegisterStates>(
        listener: (context, state){
          if(state is ArgiCreateUserSuccessState){
            CacheHelper.saveData(
                key: 'uId',
                value: state.uId)
                .then((value) {
              uId= state.uId;
              ArgiServeCubit.get(context).getUserData();
              navigateAndFinish(context, HomeLayoutScreen());
            });

          }
          if(state is ArgiRegisterErrorState){
            showToast(text: 'Error!', state: ToastStates.error);
          }
        },
        builder: (context, state){
          return Scaffold(
            backgroundColor: Colors.white,
            appBar: AppBar(
              leading:IconButton(onPressed: (){
                Navigator.pop(context, LoginScreen());
              },
                icon: Icon(Icons.arrow_back_ios,
                  color: mainColor,
                ),
              ),
              elevation: 0,
            ),
            body: Center(
              child: SingleChildScrollView(
                physics:const BouncingScrollPhysics(),
                child: Form(
                  key: _formKey,
                  child: Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Column(
                      children: [
                        TextFormField(
                          textDirection: TextDirection.rtl,
                          cursorColor:const Color(0xfffbd7d7),
                          controller: nameController,
                          keyboardType: TextInputType.name,
                          // ignore: missing_return
                          validator: (String? value) {
                            if (value!.isEmpty) {
                              return 'Enter Your Name';
                            }
                            return null;
                          },
                          decoration: InputDecoration(
                            contentPadding:const EdgeInsets.symmetric(vertical: 12),
                            border: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(12),
                              borderSide:const BorderSide(width: 0.8),
                            ),
                            labelText: 'Enter Your Name',
                            prefixIcon:const Icon(Icons.drive_file_rename_outline,
                            ),
                          ),
                        ),
                        const SizedBox(
                          height: 15,
                        ),
                        TextFormField(
                          cursorColor:const Color(0xfffbd7d7),
                          controller: emailController,
                          keyboardType: TextInputType.emailAddress,
                          // ignore: missing_return
                          validator: (String? value) {
                            if (value!.isEmpty) {
                              return 'Enter Your Email Address';
                            }
                            return null;
                          },
                          decoration: InputDecoration(
                            contentPadding:const EdgeInsets.symmetric(vertical: 12),
                            border: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(12),
                              borderSide:const BorderSide(width: 0.8),
                            ),
                            labelText: 'Enter Your Email Address',
                            prefixIcon:const Icon(Icons.email_outlined,
                            ),
                          ),
                        ),
                        const  SizedBox(
                          height: 15,
                        ),
                        TextFormField(
                          textDirection: TextDirection.rtl,
                          cursorColor:const Color(0xfffbd7d7),
                          controller: phoneController,
                          keyboardType: TextInputType.name,
                          // ignore: missing_return
                          validator: (String? value) {
                            if (value!.isEmpty) {
                              return 'Enter Your Phone Number';
                            }
                            return null;
                          },
                          decoration: InputDecoration(
                            contentPadding:const EdgeInsets.symmetric(vertical: 12),
                            border: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(12),
                              borderSide:const BorderSide(width: 0.8),
                            ),
                            labelText: 'Your Phone Number',
                            prefixIcon:const Icon(Icons.phone,
                            ),
                          ),
                        ),
                        const  SizedBox(
                          height: 15,
                        ),
                        TextFormField(
                          cursorColor:const Color(0xfffbd7d7),
                          controller: passwordController,
                          keyboardType: TextInputType.visiblePassword,
                          // ignore: missing_return
                          validator: (value) {
                            if (value!.isEmpty) {
                              return 'Your Password';
                            }
                            return null;
                          },
                          onFieldSubmitted: (value) {
                            if(_formKey.currentState!.validate()){
                              ArgiLoginCubit.get(context).userLogin(
                                email: emailController.text,
                                password: passwordController.text,
                              );
                            }
                          },
                          obscureText:ArgiRegisterCubit.get(context).isPassword,

                          decoration: InputDecoration(
                            contentPadding:const EdgeInsets.symmetric(vertical: 12),
                            border: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(12),
                              borderSide:const BorderSide(width: 0.8),
                            ),
                            labelText: 'Password',

                            prefixIcon:const Icon(Icons.lock_outline,
                              // color: Color(0xff009E8F),
                            ),

                            suffixIcon: IconButton(
                              onPressed: (){
                                ArgiRegisterCubit.get(context).changePasswordRegisterVisibility();
                              },
                              icon: Icon(ArgiRegisterCubit.get(context).suffix),
                            ),
                          ),
                        ),

                        const  SizedBox(
                          height: 25,
                        ),
                        ConditionalBuilder(
                          condition: state is! ArgiRegisterLoadingState,
                          builder: (context) =>
                              SizedBox(
                                width: 130,
                                child: defaultButton(
                                  function: ()  async {
                                    if(_formKey.currentState!.validate() ){
                                      ArgiRegisterCubit.get(context).userStudentRegister(
                                        email: emailController.text,
                                        name: nameController.text,
                                        phone: phoneController.text,
                                        password: passwordController.text,
                                      );
                                    }
                                  },
                                  text: 'Login Now',
                                  isUppercase: true,
                                  backgroundColor: mainColor,
                                ),
                              ),
                          fallback: (context) =>
                          const  Center(child: CircularProgressIndicator()),
                        ),
                      ],
                    ),
                  ),
                ),
              ),
            ),
          );
        },
      ),
    );
  }
}
