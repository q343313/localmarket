

import 'package:flutter_riverpod/legacy.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:localmarket/data/userdata/adduserdatainfirebase.dart';
import 'package:localmarket/main.dart';
import 'package:localmarket/models/updateprofilemodels.dart';
import 'package:localmarket/utils/enum.dart';

final updateproviders = StateNotifierProvider<UpdateNotifiers,UpdateStates>((ref)=>UpdateNotifiers(getIt()));

class UpdateNotifiers extends StateNotifier<UpdateStates>{
  final AddUserData addUserData;
  UpdateNotifiers(this.addUserData):super(UpdateStates());

  void addusername(String username)=>state = state.copyWith(username: username);
  void addaddress(String address)=>state = state.copyWith(address: address);
  void adduserbio(String bio)=>state = state.copyWith(userbio: bio);
  void adduserphone(String phone)=>state = state.copyWith(phone: phone);
  void addcountry(String country)=>state = state.copyWith(country: country);

  void updateuseraccont(user)async{
    state = state.copyWith(updateEnum: UpdateEnum.loading);
    try {

      final username = state.username.isEmpty?user["username"]:state.username;
      final userbio = state.address.isEmpty?user["useraddress"]:state.address;
      final address = state.userbio.isEmpty?user["userbio"]:state.userbio;
      final country = state.country.isEmpty?user["country"]:state.country;
      final phone = state.phone.isEmpty?user["userphone"]:state.phone;
      UpdateModels updateModels = UpdateModels(
          country: country,
          userbio: userbio,
          userphone:phone,
          username: username,
          useraddress: address
      );
      await addUserData.updateUserProfile(updateModels);
      state =state.copyWith(updateEnum: UpdateEnum.success,message: "User profile updated succesfully");
     Get.back();
      resetstates();
    }catch(e){
      state = state.copyWith(updateEnum: UpdateEnum.failure,message: e.toString());
      Get.snackbar("Update Failed","User profile updated failed");
      Get.back();
      resetstates();
    }
  }

  resetstates(){
    state = state.copyWith(updateEnum: UpdateEnum.initlal,userbio: "",username: "",address: "",country: "",phone: "");
  }


}

class UpdateStates {
  final String username;
  final String userbio;
  final String address;
  final String country;
  final String phone;
  final String message;
  final UpdateEnum updateEnum;
  UpdateStates({
    this.country = "",
    this.phone = "",
    this.address  ="",
    this.username = "",
    this.userbio ="",
    this.updateEnum = UpdateEnum.initlal,
  this.message = ""});

  UpdateStates copyWith({
    String?username,
     String? userbio,
     String ?address,
     String ?country,
     String? phone,
     String ?message,
    UpdateEnum?updateEnum
}){
    return UpdateStates(
      username: username??this.username,
      userbio: userbio??this.userbio,
      address: address??this.address,
      country: country??this.country,
      message: message??this.message,
      phone: phone??this.phone,
      updateEnum: updateEnum??this.updateEnum
    );
  }
}