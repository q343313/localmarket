import '../../allpaths.dart';

class SignupNotifier extends StateNotifier<SignupStates>{
  final ImplementAuthentication implementAuthentication;
  SignupNotifier(this.implementAuthentication):super(SignupStates());

  void addUserEmail(String email)=>state = state.copyWith(useremail: email);
  void addUserName(String name)=>state = state.copyWith(username: name);
  void addUserPassword(String password)=>state = state.copyWith(passord: password);
  void addUserImage(String image)=>state = state.copyWith(userimage: image);
  void addUserAddress(String address)=>state = state.copyWith(addres: address);
  void adduserBio(String bio)=>state = state.copyWith(userbio: bio);
  void addUserDOF(String dof)=>state = state.copyWith(dof: dof);
  void addCountryCode(String country)=>state = state.copyWith(country: country);
  void addPhoneNumber(String phone)=>state = state.copyWith(phone: phone);
  void createUserProfile()async{

    state = state.copyWith(signupEnum: SignupEnum.loading);
    try {
      final userid  = Random().nextInt(10000);
      var pref =await SharedPreferences.getInstance();
      pref.setInt("userid", userid);
      pref.setString("email", state.useremail);

      ProfileModels profileModels  = ProfileModels(
          username: state.username,
          useraddress: state.addres,
          userid: userid,
          userimage: state.userimage,
          userphone: state.phone,
          userbio: state.userbio,
          userdeof: state.dof,
          useremail: state.useremail,
          userpassword: state.passord,
          product: [],
          country: state.country
      );
      await implementAuthentication.signupuser(profileModels);
      state = state.copyWith(signupEnum: SignupEnum.success,message: "User Account Created Successfully");
      resetStates();
      Get.snackbar("Successfully", "User Account created successfully",backgroundColor: Colors.green);
      navigatorkey.currentState!.pushReplacementNamed(RouteNames.homescreen);
      NotificationServices().simpleNotification(title:"Welcome local market", body:  "Welcome to LocalMarket!!❤️‍🩹🥽");

    }on FirebaseAuthException catch(e){
      if(e.code == "email-already-in-use"){
        state = state.copyWith(signupEnum: SignupEnum.exists,message: e.code.toString());
        Get.snackbar("Exists", e.code.toString(),backgroundColor: Colors.orange);
        resetStates();
        navigatorkey.currentState!.pushReplacementNamed(RouteNames.loginscreen);
      }else{
        state = state.copyWith(signupEnum: SignupEnum.failures,message: e.code.toString());
        Get.snackbar("Failed", e.code.toString(),backgroundColor: Colors.red);
        print(e.toString());
        resetStates();
      }
    }
    }
    void resetStates(){
    state = state.copyWith(signupEnum: SignupEnum.initial,useremail: "",userimage: "",passord: "",phone: "",country: "🇵🇰 +92",userbio: "",username: "",addres: "",dof: "00:00:0000",);
    }

}