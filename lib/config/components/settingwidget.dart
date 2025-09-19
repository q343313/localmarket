

import 'package:flutter/cupertino.dart';
import '../../allpaths.dart';
import 'customStore.dart';

Widget buildnotificationtoggle(){
  return Consumer(builder: (context,ref,_){
    final notifi = ref.watch(appNotificationController);
    return SwitchListTile(
        value: notifi,
        activeColor: Colors.blue,
        title: const Text("Push Notifications",style: TextStyle(fontFamily: "title"),),
        subtitle: const Text("Get updates on new offers & products",style: TextStyle(fontFamily: "body_c"),),
        onChanged: (val) async {
          ref.read(appNotificationController.notifier).state = val;
          final prefs = await SharedPreferences.getInstance();
          await prefs.setBool("notifications_enabled", val);
          if (val) {
            await FirebaseMessaging.instance.subscribeToTopic("all_users");
          } else {
            await FirebaseMessaging.instance.unsubscribeFromTopic("all_users");
          }
        }

    );
  });
}

Widget buildemailnotificationtoggle(){
  return Consumer(builder: (context,ref,_){
    final notifi = ref.watch(emailNotificationController);
    return  SwitchListTile(
      value: notifi,
      activeColor: Colors.blue,
      title: const Text("Email Notifications",style: TextStyle(fontFamily: "title"),),
      subtitle: const Text("Receive updates via email",style: TextStyle(fontFamily: "body_c"),),
      onChanged: (val)=>ref.read(emailNotificationController.notifier).state= val,
    );
  });
}

Widget builduserprofile(){
  return Consumer(builder: (context,ref,_){
    final data = ref.watch(firebasedata);
    final profile  = ref.watch(profileproviders);
    return data.when(data: (value){
      final userdata = value.docs.where((e)=>e["useremail"] == profile.value).toList();
      final usernotif = userdata[0];
      return Card(
        color:  Theme.of(context).brightness ==Brightness.dark
            ? AppColors.containerDarkMode
            :Colors.grey.shade100,
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
        child: ListTile(
          contentPadding: const EdgeInsets.all(16),
          leading: buildprofileimagewidget(usernotif, context),
          title:  Text(usernotif["username"].toString(), style: TextStyle(fontSize: 15, fontWeight: FontWeight.bold,fontFamily: "body_c")),
          subtitle:  Text(usernotif["useremail"],style: TextStyle(fontFamily: "body_c"),),
          trailing: IconButton(
            icon: const Icon(Icons.edit, color: Colors.blue),
            onPressed: () {
              updateuserdialog(context, usernotif, ref);
            },
          ),
        ),
      );
    }, error: (err,val)=>Text(err.toString()), loading: ()=> CupertinoActivityIndicator(color: Colors.blue,));
  });
}

Future buildthemedialog(BuildContext context){
  return showDialog(context: context, builder: (context){
    return AlertDialog(
      backgroundColor:  Theme.of(context).brightness ==Brightness.dark
          ? AppColors.containerDarkMode
          :Colors.grey.shade100,
      title: Text("Change theme",style: TextStyle(fontFamily: "title",color: Theme.of(context).brightness ==Brightness.dark
          ? AppColors.scaffoldLightMode
          :Colors.black),),
      content: SingleChildScrollView(
        child: Consumer(builder: (context,ref,_){
          final theme = ref.watch(themeproviders);
          return Column(
            children: [
              RadioListTile(
                  value: ThemeMode.light,
                  groupValue: theme,
                  title: Text("Light theme",style: TextStyle(fontFamily: "title",color: Theme.of(context).brightness ==Brightness.dark
                      ? AppColors.scaffoldLightMode
                      :Colors.black),),
                  onChanged: (val){
                    Navigator.pop(context);
                    ref.read(themeproviders.notifier).state=ThemeMode.light;
                  }),
              RadioListTile(
                  value: ThemeMode.dark,
                  title:  Text("Dark theme",style: TextStyle(fontFamily: "title",color: Theme.of(context).brightness ==Brightness.dark
                      ? AppColors.scaffoldLightMode
                      :Colors.black),),
                  groupValue: theme, onChanged: (val){
                Navigator.pop(context);
                ref.read(themeproviders.notifier).state=ThemeMode.dark;
              }),
              RadioListTile(
                  value: ThemeMode.system,
                  title: Text("System theme",style: TextStyle(fontFamily: "title",color: Theme.of(context).brightness ==Brightness.dark
                      ? AppColors.scaffoldLightMode
                      :Colors.black),),
                  groupValue: theme, onChanged: (val){
                Navigator.pop(context);
                ref.read(themeproviders.notifier).state=ThemeMode.system;
              }),
            ],
          );
        }),
      ),
    );
  });
}

Future buildchangepassworddialog(BuildContext context){
  TextEditingController passwordcontroller = TextEditingController();
  final formkey = GlobalKey<FormState>();
  return showDialog(context: context, builder: (context){
    return AlertDialog(
      title: Text("Change Password",style: TextStyle(fontFamily: "title"),),
      content: Form(
          key: formkey,
          child:Consumer(builder: (context,ref,_){
            final showPassword = ref.watch(defaultprovidders.select((val)=>val.showpassord));
            return  CustomTextfieldWidget(
              label: "new Password",
              hint: "new Password",
              controller: passwordcontroller,
              preffixicon: Icons.lock,
              validator: (value)=>AppValidations.passwordValidation(value.toString()),
              obstracttext: showPassword,
              suffixicon: IconButton(onPressed: (){
                ref.read(defaultprovidders.notifier).showpassword();
              }, icon: Icon(showPassword?Icons.visibility:Icons.visibility_off)),
            );
          })),
      actions: [
        TextButton(onPressed: ()=>Navigator.pop(context), child: Text("Cancel",style: TextStyle(fontFamily: "title",color: Colors.blue),)),
        TextButton(onPressed: (){
          if(formkey.currentState!.validate()){
            Navigator.pop(context);
            AddUserData().changeUserPassword(passwordcontroller.text.toString());
          }
        }, child: Text("Change",style: TextStyle(fontFamily: "title",color: Colors.blue),))
      ],
    );
  });
}