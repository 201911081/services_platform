import 'dart:io';
import 'package:argiserve/layout/cubit/state.dart';
import 'package:argiserve/module/myposts/my_posts.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:image_picker/image_picker.dart';
import 'package:firebase_storage/firebase_storage.dart' as firebase_storage;
import '../../model/post_model.dart';
import '../../model/user_model.dart';
import '../../module/home/home_screen.dart';
import '../../module/login/login_screen.dart';
import '../../module/profile/profile_screen.dart';
import '../../shared/component/component.dart';
import '../../shared/component/contasnt.dart';
import '../../shared/network/local/cach_helper.dart';



class ArgiServeCubit extends Cubit<ArgiServeStates> {
  ArgiServeCubit() : super(ArgiInitialState());

  static ArgiServeCubit get(context) => BlocProvider.of(context);
  int currentIndex = 0;
  List<Widget>screens = [
    HomeScreen(),
    MyPosts(),
    const ProfileScreen(),
  ];

  void changeBottomNav(int index) {
    currentIndex = index;
    print(index);

    emit(ChangeBottomNavState());
  }


  UserModel? userModel;
  PostModel? postModel;
  void getUserData(){
    emit(GetUserLoadingState());

    FirebaseFirestore.instance
        .collection('users')
        .doc(uId)
        .get()
        .then((value) {
          userModel = UserModel.fromJson(value.data());
          print(userModel?.name);
          print(userModel?.uId);
          emit(GetUserSuccessState());
    })
        .catchError((error){
          print(error.toString());
          emit(GetUserErrorState(error.toString()));
    }
        );
  }

  File? profileImage;
  final picker = ImagePicker();

  Future getProfileImage() async {
    final pickedFile = await picker.pickImage(source: ImageSource.gallery);

    if (pickedFile != null) {
      profileImage = File(pickedFile.path);
      emit(ProfileImagePickedSuccessState());
    } else {
      emit(ProfileImagePickedErrorState());
    }
  }


  void uploadProfileImage({
    required String name,
    required String email,
    required String phone,
}){
    emit(UserUpdateLoadingState());
    firebase_storage.FirebaseStorage.instance
        .ref()
        .child('users/${Uri.file(profileImage!.path).pathSegments.last}')
        .putFile(profileImage!)
        .then((value) {
          value.ref.getDownloadURL().then((value) {
             emit(UploadProfileImageSuccessState());
            updateUserData(name: name, email: email, phone: phone,
            image: value
            );

          }).catchError((error){
            emit(UploadProfileImageErrorState());
          });
    })
        .catchError((error){
      emit(UploadProfileImageErrorState());
    });
  }

  void updateUserData({
    required String name,
    required String email,
    required String phone,
    String? image,
}){
    UserModel model = UserModel(
      name: name,
      email: email,
      phone: phone,
      uId: userModel!.uId,
      image:image?? userModel!.image,
    );
    FirebaseFirestore.instance
        .collection('users')
        .doc(userModel?.uId)
        .update(model.toMap())
        .then((value) {
      getUserData();
      emit(UserUpdateSuccessState());
    })
        .catchError((error){
      print(error.toString());
      emit(UserUpdateErrorState());
    });
  }

  File? firstPostImage;

  Future getFirstPostImage() async {
    final pickedFile = await picker.pickImage(source: ImageSource.gallery);

    if (pickedFile != null) {
      firstPostImage = File(pickedFile.path);
      emit(PostImagePickedSuccessState());
    } else {
      emit(PostImagePickedErrorState());
    }
  }


  void removePostImage(){
    firstPostImage = null;
    emit(RemovePostImageState());
  }


  void uploadPostImage({
    required String text,
    required String title,
    required String dateTime,
  }){
    emit(CreatePostLoadingState());
    firebase_storage.FirebaseStorage.instance
        .ref()
        .child('posts/${Uri.file(firstPostImage!.path).pathSegments.last}')
        .putFile(firstPostImage!)
        .then((value) {
      value.ref.getDownloadURL().then((value) {
        createPost(
          title: title,
          text: text,
          dateTime: dateTime,
          firstPostImage: value
        );
      }).catchError((error){
        emit(CreatePostErrorState());
      });
    })
        .catchError((error){
      emit(CreatePostErrorState());
    });
  }


  void createPost({
    required String text,
    required String title,
    required String dateTime,
    String? firstPostImage,
  }){
    emit(CreatePostLoadingState());
    PostModel model = PostModel(
      name: userModel!.name,
      uId: userModel!.uId,
      phone: userModel!.phone,
      image:userModel!.image,
      text: text,
      title: title,
      dateTime: dateTime,
     firstPostImage: firstPostImage??'',

    );
    FirebaseFirestore.instance
        .collection('posts')
        .add(model.toMap())
        .then((value) {
          emit(CreatePostSuccessState());
    })
        .catchError((error){

      emit(CreatePostErrorState());
    });
  }


  List<PostModel> posts =[];

  void getPosts(){
    emit(GetPostsLoadingState());
    FirebaseFirestore.instance
        .collection('posts')
        .orderBy('dateTime')
        .snapshots()
        .listen((event) {
    posts =[];
    event.docs.forEach((element) {
    posts.add(PostModel.fromJson(element.data()));
    });
    emit(GetPostsSuccessState());
    });
  }


  void createMyPost({
    required String text,
    required String title,
    required String dateTime,
    String? firstPostImage,
  }){
    emit(CreateMyPostsLoadingState());
    PostModel model = PostModel(
      name: userModel!.name,
      uId: userModel!.uId,
      phone: userModel!.phone,
      image:userModel!.image,
      text: text,
      title: title,
      dateTime: dateTime,
      firstPostImage: firstPostImage??'',

    );
    FirebaseFirestore.instance
        .collection('users')
        .doc(uId)
        .collection('myPosts')
        .add(model.toMap())
        .then((value) {
      emit(CreateMyPostsSuccessState());
    })
        .catchError((error){

      emit(CreateMyPostsErrorState());
    });
  }


  List<PostModel> myPosts =[];

  void getMyPosts(){
    emit(GetMyPostsLoadingState());
    FirebaseFirestore.instance
        .collection('users')
        .doc(uId)
        .collection('myPosts')
        .orderBy('dateTime')
        .snapshots()
        .listen((event) {
      myPosts =[];
      event.docs.forEach((element) {
        print(myPosts.length);
        myPosts.add(PostModel.fromJson(element.data()));
        print(myPosts.length);
        print('gggggggggggggggggggggggg');
      });
      emit(GetMyPostsSuccessState());
    });
  }

  void uploadMyPostImage({
    required String text,
    required String title,
    required String dateTime,
  }){
    emit(CreateMyPostsLoadingState());
    firebase_storage.FirebaseStorage.instance
        .ref()
        .child('posts/${Uri.file(firstPostImage!.path).pathSegments.last}')
        .putFile(firstPostImage!)
        .then((value) {
      value.ref.getDownloadURL().then((value) {
        createMyPost(
            title: title,
            text: text,
            dateTime: dateTime,
            firstPostImage: value
        );
      }).catchError((error){
        emit(CreateMyPostsErrorState());
      });
    })
        .catchError((error){
      emit(CreateMyPostsErrorState());
    });
  }

  void signOut(context) {
    emit(SignOutLoadingState());
    FirebaseAuth.instance.signOut().then((value) async {
      CacheHelper.removeData('uId');
      await FirebaseFirestore.instance.collection('users').get().then((value) {
        value.docs.forEach((element) async {
          if (element.id == userModel!.uId) {
            element.reference.update({'token': null});
          }
        });
      });
      navigateAndFinish(context, LoginScreen());
      emit(SignOutSuccessState());
    }).catchError((error) {
      print(error.toString());
      emit(SignOutErrorState());
    });
  }


}