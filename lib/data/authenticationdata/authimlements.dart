


import 'package:firebase_auth/firebase_auth.dart';

import '../../models/profilemodels.dart';
import '../userdata/adduserdatainfirebase.dart';
import 'authservices.dart';


class ImplementAuthentication extends AuthenicaionServices{

  final auth = FirebaseAuth.instance;
  @override
  logoutuser()async {
    await auth.signOut();
  }

  @override
  resetpassword(String email) {
    // TODO: implement resetpassword
    throw UnimplementedError();
  }

  @override
  signupuser(ProfileModels profilemodel)async{
    print(profilemodel.useremail);
    print(profilemodel.userpassword);
   UserCredential credential =  await auth.createUserWithEmailAndPassword(email: profilemodel.useremail, password: profilemodel.userpassword);
    AddUserData().createUserProfile(profilemodel);
  }

  @override
  loginuser(String email, password)async{
    print(email);
    print(password);
    await auth.signInWithEmailAndPassword(email: email, password: password);
  }

}