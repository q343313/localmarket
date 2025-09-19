





import '../../allpaths.dart';
import 'loginstates.dart';

class Loginnotifier extends StateNotifier<Loginstates>{
  final ImplementAuthentication implementAuthentication;
  Loginnotifier(this.implementAuthentication):super(Loginstates());

  void adduseremail(String email)=>state = state.copyWith(useremail: email);
  void adduserpassword(String password)=>state = state.copyWith(passord: password);

  void login_user_account()async{

    state = state.copyWith(loginEnum: LoginEnum.loading);
    print(state.useremail);
    try {

      await implementAuthentication.loginuser(state.useremail,state.passord);
      var pref =await SharedPreferences.getInstance();
      pref.setString("email", state.useremail);
      state = state.copyWith(loginEnum: LoginEnum.success,message: "User Account login Succesfully");
      resetstates();
      Get.snackbar("Succesfully", "User Accont login succesfully",backgroundColor: Colors.green);
      navigatorkey.currentState!.pushReplacementNamed(RouteNames.homescreen);

    }on FirebaseAuthException catch(e){
      if(e.code == "invalid-credential"){
        state = state.copyWith(loginEnum: LoginEnum.notexits,message: e.code.toString());
        Get.snackbar("Not exists", e.code.toString(),backgroundColor: Colors.orange);
        resetstates();
        navigatorkey.currentState!.pushReplacementNamed(RouteNames.signupscreen);
      }else{
        state = state.copyWith(loginEnum: LoginEnum.failure,message: e.code.toString());
        Get.snackbar("Failed", e.code.toString(),backgroundColor: Colors.red);
        print(e.toString());
        resetstates();
      }
    }
  }

  resetstates(){
    state = state.copyWith(loginEnum: LoginEnum.initial,);
  }

  void logoutuser()async{
    await implementAuthentication.logoutuser();
    navigatorkey.currentState!.pushReplacementNamed(RouteNames.signupscreen);
    Get.snackbar("Logout", "User logout succesfully");
  }

  void deleteaccount()async{
    await implementAuthentication.logoutuser();
    navigatorkey.currentState!.pushReplacementNamed(RouteNames.signupscreen);
    Get.snackbar("Delete", "User Deleted succesfully");
    AddUserData().deleteUserProfile();
  }

}