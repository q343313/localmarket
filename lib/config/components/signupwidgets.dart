


import 'package:flutter/cupertino.dart';

import '../../allpaths.dart';

Widget buildsignupaction({
  required GlobalKey<FormState>formkey,
  required TextEditingController emailcontroller,
  required TextEditingController passwordcontroller,
  required TextEditingController usernamecontroller,
  required TextEditingController phonecontroller,
  required TextEditingController biocontroller,
  required TextEditingController addresscontroller,
  required BuildContext context,
  required WidgetRef ref
}){
  return SizedBox(
    width: double.infinity,
    child: ElevatedButton(onPressed: ()async{
      final checkbox = ref.watch(defaultprovidders.select((val)=>val.checkbox));
      // await FirebaseAuth.instance.createUserWithEmailAndPassword(email: "ptii05124@gmail.com", password: "lkpkkidf00");
      if(formkey.currentState!.validate()){
        if(!checkbox ){
          Get.snackbar("Warning","Please fill the check box",backgroundColor: Colors.orange);
        }else{
          ref.read(signupproviders.notifier).createUserProfile();
          passwordcontroller.clear();
          emailcontroller.clear();
          usernamecontroller.clear();
          phonecontroller.clear();
          addresscontroller.clear();
          biocontroller.clear();
        }
      }
    },
        child: Consumer(builder: (context,ref,child){
          final userdat = ref.watch(signupproviders.select((val)=>val.signupEnum));
          switch(userdat){
            case SignupEnum.loading:
              return CupertinoActivityIndicator(color: Colors.white,);
            case SignupEnum.exists:
            case SignupEnum.success:
            case SignupEnum.failures:
            case SignupEnum.initial:
              return AutoSizeText("Signup",style: TextStyle(fontSize: 20,fontFamily: "title",color: Colors.white),);
          }
        })),
  );
}

Widget buildphonewidget(WidgetRef ref,TextEditingController contoller,BuildContext context){
  return  Consumer(builder: (context,ref,child){
    final contrycode = ref.watch(signupproviders.select((val)=>val.country));
    return PhoneTextField(
        controller: contoller,
        countrycode: contrycode,
        onChanged: (valu)=>ref.read(signupproviders.notifier).addPhoneNumber(valu),
        callback: (){
          showCountryPicker(context: context, onSelect: (value){
            print("${value.flagEmoji} +${value.phoneCode}");
            ref.read(signupproviders.notifier).addCountryCode("${value.flagEmoji} +${value.phoneCode}");
          });
        });
  });
}

Widget builddateofbirth(WidgetRef ref,BuildContext context){
  return Consumer(builder: (context,ref,_){
    final dof = ref.watch(signupproviders.select((vl)=>vl.dof));
    return CustomTextfieldWidget(
      label: dof,
      hint: dof,
      preffixicon: Icons.biotech,
      lines: 3,
      onTap: ()async{
        DateTime ?datetime = await showDatePicker(context: context, firstDate: DateTime(1980), lastDate: DateTime(2010));
        if(datetime != null){
          ref.read(signupproviders.notifier).addUserDOF("${datetime.day}-${datetime.month}-${datetime.year}");
        }
      },
    );
  });
}

Widget builduserbiowidgt(WidgetRef ref,TextEditingController controller){
  return CustomTextfieldWidget(
    label: "Bio",
    hint: "About you...",
    minlines: 2,
    lines: 3,
    controller: controller,
    preffixicon: Icons.interpreter_mode_rounded,
    // validator: (value)=>AppValidations./(value.toString()),
    onChanged: (valu)=>ref.read(signupproviders.notifier).adduserBio(valu),
  );
}

Widget buildaddresswidgt(WidgetRef ref,TextEditingController controller){
  return CustomTextfieldWidget(
    label: "Address",
    hint: "location",
    minlines: 2,
    lines: 3,
    controller: controller,
    preffixicon: Icons.location_on,
    validator: (value)=>AppValidations.addressValidation(value.toString()),
    onChanged: (valu)=>ref.read(signupproviders.notifier).addUserAddress(valu),
  );
}

Widget buildemailwidgt(WidgetRef ref,TextEditingController controller){
  return CustomTextfieldWidget(
    label: "Email",
    hint: "Email",
    controller: controller,
    preffixicon: Icons.email,
    validator: (value)=>AppValidations.emailValidation(value.toString()),
    onChanged: (valu)=>ref.read(signupproviders.notifier).addUserEmail(valu),
  );
}

Widget buildpasswordwidgt(WidgetRef ref,TextEditingController controller){
  return passwordfield(ref,controller);
}

Widget buildusernamewidgt(WidgetRef ref,TextEditingController controller){
  return CustomTextfieldWidget(
    label: "Username",
    hint: "Username",
    controller: controller,
    preffixicon: Icons.account_circle,
    validator: (value)=>AppValidations.usernameValidation(value.toString()),
    onChanged: (valu)=>ref.read(signupproviders.notifier).addUserName(valu),
  );
}

Widget buildheadingwidget(String text,width,double size){
  return  AutoSizeText(text,maxFontSize: 26,minFontSize: size,
    style: TextStyle(fontSize:width* 0.025 ,fontFamily: "heading"),);
}

Widget buildsubtitlewidget(String text,width){
  return  AutoSizeText(text,maxFontSize: 26,minFontSize: 21,
    style: TextStyle(fontSize:width* 0.025 ,fontFamily: "body_p"),);
}

Widget buildsignupfooter(BuildContext context,String text,String buttonname,VoidCallback callback){
  return  Padding(
    padding: const EdgeInsets.symmetric(horizontal: 38.0),
    child: Text.rich(
        textAlign: TextAlign.center,
        TextSpan(children: [
          TextSpan(
              text: text,style: TextStyle(fontFamily: "body_c",fontSize: 12)
          ),
          TextSpan(
              text: buttonname,style: TextStyle(fontFamily: "body_c",fontSize: 14,
              color: Theme.of(context).brightness == Brightness.dark
                  ? AppColors.secondaryButtonDarkMode
                  : AppColors.secondaryButtonLightMode),
              recognizer: TapGestureRecognizer()
                ..onTap = callback

          ),
        ])
    ),
  );
}

Widget buildcheckboxwidget(BuildContext context,WidgetRef ref){
  return Consumer(builder: (context,ref,child){
    final check  = ref.watch(defaultprovidders.select((val)=>val.checkbox));
    return InkWell(
      onTap: (){
        ref.read(defaultprovidders.notifier).showcheckbox();
      },
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Checkbox(value: check, onChanged: (value){}),
          Column(
            children: [
              SizedBox(height: 5,),
              Text.rich(
                  textAlign: TextAlign.center,
                  TextSpan(children: [
                    TextSpan(text: "Are you agree to accept all the ",style: TextStyle(fontFamily: "body_p",fontSize: 20)),
                    TextSpan(
                      text: "Terms and\nservices",
                      style: TextStyle(fontFamily: "body_c",
                          fontSize: 12,color: Theme.of(context).brightness == Brightness.dark
                              ? AppColors.primaryButtonDarkMode
                              : AppColors.primaryButtonLightMode),
                      recognizer: TapGestureRecognizer()
                        ..onTap = () {
                          // 👉 Navigate to Terms & Conditions page
                          Navigator.pushNamed(context, RouteNames.termandconditions);
                        },
                    ),
                    TextSpan(text: " and",style: TextStyle(fontFamily: "body_p",fontSize: 20)),
                    TextSpan(
                      text: " Privacy policy",
                      style: TextStyle(fontFamily: "body_c",
                          fontSize: 12,color: Theme.of(context).brightness == Brightness.dark
                              ? AppColors.secondaryButtonDarkMode
                              : AppColors.secondaryButtonLightMode),
                      recognizer: TapGestureRecognizer()
                        ..onTap = () {
                          // 👉 Navigate to Terms & Conditions page
                          Navigator.pushNamed(context, RouteNames.termandconditions);
                        },
                    ),
                  ])),
            ],
          )
        ],
      ),
    );
  });
}

Widget passwordfield(WidgetRef ref,TextEditingController contoller){
  final showpassord = ref.watch(defaultprovidders.select((val)=>val.showpassord));
  return CustomTextfieldWidget(
    label: "Password",
    hint: "Password",
    controller: contoller,
    preffixicon: Icons.lock,
    validator: (value)=>AppValidations.passwordValidation(value.toString()),
    onChanged: (value)=>ref.read(signupproviders.notifier).addUserPassword(value),
    obstracttext: showpassord,
    suffixicon: IconButton(onPressed: (){
      ref.read(defaultprovidders.notifier).showpassword();
    }, icon: Icon(showpassord?Icons.visibility:Icons.visibility_off)),
  );
}