abstract class ArgiServeStates{}
class ArgiInitialState extends ArgiServeStates{}

class ChangeBottomNavState extends ArgiServeStates{}

class GetUserLoadingState extends ArgiServeStates{}

class GetUserSuccessState extends ArgiServeStates{}

class GetUserErrorState extends ArgiServeStates{
  final String error;

  GetUserErrorState(this.error);
}

class ProfileImagePickedSuccessState extends ArgiServeStates{}

class ProfileImagePickedErrorState extends ArgiServeStates{}

class UploadProfileImageSuccessState extends ArgiServeStates{}

class UploadProfileImageErrorState extends ArgiServeStates{}

class UserUpdateLoadingState extends ArgiServeStates{}

class UserUpdateSuccessState extends ArgiServeStates{}

class UserUpdateErrorState extends ArgiServeStates{}

class PostImagePickedSuccessState extends ArgiServeStates{}

class PostImagePickedErrorState extends ArgiServeStates{}

class RemovePostImageState extends ArgiServeStates{}

class CreatePostLoadingState extends ArgiServeStates{}

class CreatePostSuccessState extends ArgiServeStates{}

class CreatePostErrorState extends ArgiServeStates{}

class GetPostsLoadingState extends ArgiServeStates{}

class GetPostsSuccessState extends ArgiServeStates{}

class CreateMyPostsLoadingState extends ArgiServeStates{}

class CreateMyPostsSuccessState extends ArgiServeStates{}

class CreateMyPostsErrorState extends ArgiServeStates{}

class GetMyPostsLoadingState extends ArgiServeStates{}

class GetMyPostsSuccessState extends ArgiServeStates{}

class SignOutLoadingState extends ArgiServeStates{}

class SignOutSuccessState extends ArgiServeStates{}

class SignOutErrorState extends ArgiServeStates{}