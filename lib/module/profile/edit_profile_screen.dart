import 'package:argiserve/Theme/colors.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../layout/cubit/cubit.dart';
import '../../layout/cubit/state.dart';
import '../../shared/component/component.dart';


class EditProfileScreen extends StatelessWidget {
  var nameController = TextEditingController();
  var emailController = TextEditingController();
  var passwordController = TextEditingController();
  var phoneController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<ArgiServeCubit, ArgiServeStates>(
      listener: (context, state){
        if(state is UploadProfileImageSuccessState ){
          showToast(text: 'Done Successfully!', state: ToastStates.success);
        }
        if(state is UploadProfileImageErrorState){
          showToast(text: 'Oops! Try Again', state: ToastStates.error);
        }
        if(state is UserUpdateSuccessState ){
          showToast(text: 'Done Successfully!', state: ToastStates.success);
        }
        if(state is UserUpdateErrorState){
          showToast(text: 'Oops! Try Again', state: ToastStates.error);
        }
      },
      builder: (context, state){
        var userModel = ArgiServeCubit.get(context).userModel;
        var profileImage =  ArgiServeCubit.get(context).profileImage;
        nameController.text = userModel!.name!;
        emailController.text = userModel.email!;
        phoneController.text = userModel.phone!;
        return Scaffold(
          backgroundColor: Colors.white,
          appBar: AppBar(
            elevation: 0,
            centerTitle: true,
            title:  Text('Edit Profile',
            style: TextStyle(
              color: mainColor
            ),
            ),
          ),
          body: SingleChildScrollView(
            child: Center(
              child: Padding(
                padding: const EdgeInsets.all(20.0),
                child: Column(
                  children: [
                    if(
                    state is UserUpdateLoadingState
                    )
                  const  LinearProgressIndicator(),
                    if(profileImage !=null)
                    CircleAvatar(
                      radius: 76,
                      backgroundImage:FileImage(profileImage),
                    ),
                    if(profileImage ==null)
                      CircleAvatar(
                        radius: 76,
                        backgroundImage:NetworkImage('${userModel.image}'),
                      ),
                  const  SizedBox(
                      height: 10,
                    ),
                    InkWell(
                      onTap: (){
                         ArgiServeCubit.get(context).getProfileImage();
                      },
                      child: Text(
                        'Add Photo ',
                        style: TextStyle(
                            fontWeight: FontWeight.bold,
                            color: mainColor,
                            fontSize:25
                        ),
                      ),
                    ),
                    const SizedBox(
                      height: 10,
                    ),
                      const SizedBox(
                      height: 10,
                    ),
                    TextFormField(
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
                        labelText: 'Name',
                        prefixIcon:const Icon(Icons.drive_file_rename_outline,
                        ),
                      ),
                    ),
                    const SizedBox(
                      height: 15,
                    ),
                    TextFormField(
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
                        labelText: 'Email Address',
                        prefixIcon:const Icon(Icons.email_outlined,
                        ),
                      ),
                    ),
                    const SizedBox(
                      height: 15,
                    ),
                    TextFormField(
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
                        labelText: ' Phone Number',
                        prefixIcon:const Icon(Icons.phone,
                        ),
                      ),
                    ),

                    const  SizedBox(
                      height: 30,
                    ),
                    Container(
                      decoration: BoxDecoration(
                        color: Colors.blue,
                        borderRadius: BorderRadius.circular(14),

                      ),
                      child: MaterialButton(
                        onPressed: (){
                          if(profileImage !=null){
                            ArgiServeCubit.get(context).uploadProfileImage(
                                name: nameController.text,
                                email: emailController.text,
                                phone: phoneController.text
                            );
                          }else{
                            ArgiServeCubit.get(context).updateUserData(
                              name: nameController.text,
                              email: emailController.text,
                              phone: phoneController.text,
                            );
                          }

                        },
                        child:const Text(
                          'Confirm',
                          style: TextStyle(
                              color: Colors.white
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ),
        );
      },
    );
  }
}
