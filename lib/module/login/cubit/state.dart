abstract class ArgiLoginStates{}

class ArgiLoginInitialState extends ArgiLoginStates{}

class ArgiLoginLoadingState extends ArgiLoginStates{}

class ArgiLoginSuccessState extends ArgiLoginStates{
  final String uId;

  ArgiLoginSuccessState(this.uId);
}

class ArgiLoginErrorState extends ArgiLoginStates{
  final  error;
 ArgiLoginErrorState(this.error);
}

class ChangePasswordVisibilityState extends ArgiLoginStates{}
