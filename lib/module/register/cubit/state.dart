abstract class ArgiRegisterStates{}

class ArgiRegisterInitialState extends ArgiRegisterStates{}

class ArgiRegisterLoadingState extends ArgiRegisterStates{}

class ArgiRegisterSuccessState extends ArgiRegisterStates{}

class ArgiRegisterErrorState extends ArgiRegisterStates{
  final  error;
 ArgiRegisterErrorState(this.error);
}

class ArgiCreateUserSuccessState extends ArgiRegisterStates{
  final String uId;

  ArgiCreateUserSuccessState(this.uId);
}

class ArgiCreateUserErrorState extends ArgiRegisterStates{
  final  error;
  ArgiCreateUserErrorState(this.error);
}

class ChangePasswordHaragRegisterVisibilityState extends ArgiRegisterStates{}

class ConfirmPasswordHaragRegisterVisibilityState extends ArgiRegisterStates{}
