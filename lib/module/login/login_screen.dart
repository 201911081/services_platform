import 'package:argiserve/Theme/colors.dart';
import 'package:argiserve/layout/cubit/cubit.dart';
import 'package:conditional_builder_null_safety/conditional_builder_null_safety.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../layout/home_layout_screen.dart';
import '../../shared/component/component.dart';
import '../../shared/component/contasnt.dart';
import '../../shared/network/local/cach_helper.dart';
import '../register/register_screen.dart';
import 'cubit/cubit.dart';
import 'cubit/state.dart';


class LoginScreen extends StatelessWidget {
  FocusNode myFocusNode = FocusNode();
  final _formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    var emailController = TextEditingController();
    var passwordController = TextEditingController();

    return  BlocProvider(
      create: (BuildContext context)=> ArgiLoginCubit(),
      child: BlocConsumer<ArgiLoginCubit, ArgiLoginStates>(
        listener: (context, state){
          if(state is ArgiLoginErrorState){
            showToast(text: state.error, state: ToastStates.error);
          }
          if(state is ArgiLoginSuccessState){
            CacheHelper.saveData(
                key: 'uId',
                value: state.uId)
                .then((value) {
                  uId= state.uId;
                  ArgiServeCubit.get(context).getUserData();
              navigateAndFinish(context, HomeLayoutScreen());
            });
            ArgiServeCubit.get(context).getMyPosts();
            ArgiServeCubit.get(context).getPosts();
          }
          },
        builder: (context, state){
          return  Scaffold(
            backgroundColor:Colors.white,
            appBar: AppBar(
              elevation: 0,
            ),
            body: SingleChildScrollView(
              child: Form(
                key: _formKey,
                child: Column(
                  children: [
                     Text(
                      'Welcome To Services Platform',
                      style: TextStyle(
                          fontWeight:FontWeight.bold,
                          fontSize: 20,
                        color: mainColor,
                      ),
                    ),
                    const  SizedBox(
                      height: 15,
                    ),
                    const  Center(
                      child: SizedBox(
                        height: 200,
                        width: 400,
                        child:
                        Image(
                          image: AssetImage('assets/images/icon.png',),),
                      ),
                    ),
                    const   SizedBox(
                      height: 20,
                    ),
                    Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: TextFormField(
                        cursorColor: Colors.white,
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
                    ),
                    const  SizedBox(
                      height: 20,
                    ),
                    Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: TextFormField(

                        cursorColor:const Color(0xfffbd7d7),
                        controller: passwordController,
                        keyboardType: TextInputType.visiblePassword,
                        // ignore: missing_return
                        validator: (value) {
                          if (value!.isEmpty) {
                            return 'Enter Your Password';
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
                        obscureText:ArgiLoginCubit.get(context).isPassword,

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
                              ArgiLoginCubit.get(context).changePasswordVisibility();
                            },
                            icon: Icon(ArgiLoginCubit.get(context).suffix),
                          ),
                        ),
                      ),
                    ),
                    const   SizedBox(
                      height: 20,
                    ),
                    Padding(
                      padding: const EdgeInsets.only(right: 50,
                          left: 50
                      ),
                      child:  ConditionalBuilder(
                        condition: state is! ArgiLoginLoadingState,
                        builder: (context) =>
                            defaultButton(
                              function: ()  async {
                                if(_formKey.currentState!.validate() ){
                                  ArgiLoginCubit.get(context).userLogin(
                                    email: emailController.text,
                                    password: passwordController.text,
                                  );
                                }
                              },
                              text: 'Login',
                              isUppercase: true,
                            ),
                        fallback: (context) =>
                        const   Center(child: CircularProgressIndicator()),
                      ),
                    ),
                    const SizedBox(
                      height: 20,
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        const    Text(
                          'Don\'t Have An Account ?',

                        ),
                        MaterialButton(onPressed: (){
                          navigateTo(context, RegisterScreen());
                        },
                          child:const Text(
                            'Register Now',
                            style: TextStyle(
                                color: Colors.blue
                            ),
                          ),
                        ),
                      ],
                    )
                  ],
                ),
              ),
            ),
          );
        },
      ),
    );
  }
}
