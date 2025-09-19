


import '../../utils/enum.dart';

class SignupStates {

  final noww = DateTime.now();

  final String username;
  final String useremail;
  final String passord;
  final String userimage;
  final String country;
  final String phone;
  final String addres;
  final String userbio;
  final String dof;
  final SignupEnum signupEnum;
  final String message;

  SignupStates({
    this.signupEnum = SignupEnum.initial,
    this.useremail = "",
    this.country= "🇵🇰 +92",
    this.userbio = "",
    this.userimage = "",
    this.username = "",
    this.phone = "",
    this.dof= "00:00:0000",
    this.addres= "",
    this.passord = "",
    this.message = ""
});

  SignupStates copyWith({
    String?username,
     String? useremail,
     String ?passord,
     String ?userimage,
     String ?country,
     String? phone,
     String ?addres,
     String ?userbio,
     String ?dof,
     SignupEnum ?signupEnum,
    String?message
}){
    return SignupStates(
      username: username??this.username,
      userbio: userbio??this.userbio,
      useremail: useremail??this.useremail,
      userimage: userimage??this.userimage,
      country: country??this.country,
      phone:  phone??this.phone,
      passord: passord??this.passord,
      addres: addres??this.addres,
      signupEnum: signupEnum??this.signupEnum,
      dof: dof??this.dof,
      message: message??this.message

    );
  }
}