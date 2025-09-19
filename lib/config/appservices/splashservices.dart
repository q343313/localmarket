


import 'package:flutter/cupertino.dart';
import 'package:localmarket/data/authenticationdata/authimlements.dart';

import '../route/routenames.dart';

class SplashServices {
  static signupscreen(BuildContext context)async{
    final user = ImplementAuthentication().auth.currentUser;
   await Future.delayed(Duration(seconds: 4),(){
    if(user != null){
      Navigator.pushReplacementNamed(context, RouteNames.homescreen);
    }else{
      Navigator.pushReplacementNamed(context, RouteNames.introcreen);
    }
    });
  }
}