




import '../../utils/enum.dart';

class Loginstates {

  final String useremail;
  final String passord;
  final LoginEnum loginEnum;
  final String message;

  Loginstates({
    this.loginEnum = LoginEnum.initial,
    this.useremail = "",
    this.passord = "",
    this.message = ""
  });

  Loginstates copyWith({
    String? useremail,
    String ?passord,
    LoginEnum ?loginEnum,
    String?message
  }){
    return Loginstates(
        useremail: useremail??this.useremail,
        passord: passord??this.passord,
        loginEnum: loginEnum??this.loginEnum,
        message: message??this.message

    );
  }
}