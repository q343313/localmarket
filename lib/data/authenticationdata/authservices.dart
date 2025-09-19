



import '../../models/profilemodels.dart';

abstract class AuthenicaionServices{

  signupuser(ProfileModels profilemodel);
  loginuser(String email,password);
  logoutuser();
  resetpassword(String email);
}