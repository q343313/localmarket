

import 'package:flutter/cupertino.dart';

import '../../allpaths.dart';

Widget buildloginaction({
  required GlobalKey<FormState>formkey,
  required TextEditingController emailcontroller,
  required TextEditingController passwordcontroller,
  required BuildContext context,
  required WidgetRef ref
}){
  return SizedBox(
    width: double.infinity,
    child: ElevatedButton(onPressed: ()async{
      final checkbox = ref.watch(defaultprovidders.select((val)=>val.checkbox));
      if(formkey.currentState!.validate()){
        ref.read(loginprovider.notifier).login_user_account();
        passwordcontroller.clear();
        emailcontroller.clear();
      }
    },
        child: Consumer(builder: (context,ref,child){
          final userdat = ref.watch(loginprovider.select((val)=>val.loginEnum));
          switch(userdat){

            case LoginEnum.loading:
              return CupertinoActivityIndicator(color: Colors.white,);
            case LoginEnum.notexits:
            case LoginEnum.failure:
            case LoginEnum.initial:
            case LoginEnum.success:
              return AutoSizeText("Login",style: TextStyle(fontSize: 20,fontFamily: "title",color: Colors.white),);
          }
        })),
  );
}

Widget buildloginemailwidget(WidgetRef ref,TextEditingController controller){
  return CustomTextfieldWidget(label: "Email",hint: "email",controller: controller,
    onChanged: (value)=>ref.read(loginprovider.notifier).adduseremail(value),
    validator: (value)=>AppValidations.emailValidation(value.toString()),
    preffixicon: Icons.email,);
}

Widget buildpassordwidget(WidgetRef ref,TextEditingController contoller){
  final showpassord = ref.watch(defaultprovidders.select((val)=>val.showpassord));
  return CustomTextfieldWidget(
    label: "Password",
    hint: "Password",
    controller: contoller,
    preffixicon: Icons.lock,
    validator: (value)=>AppValidations.passwordValidation(value.toString()),
    onChanged: (value)=>ref.read(loginprovider.notifier).adduserpassword(value),
    obstracttext: showpassord,
    suffixicon: IconButton(onPressed: (){
      ref.read(defaultprovidders.notifier).showpassword();
    }, icon: Icon(showpassord?Icons.visibility:Icons.visibility_off)),
  );
}

Widget buildforgetpassword(BuildContext context){
  return Align(
    alignment: Alignment.topRight,
    child: InkWell(
      onTap: (){},
      child: AutoSizeText("Forget password?",style: TextStyle(fontFamily: "body_c",fontSize: 18,color: Theme.of(context).brightness ==Brightness.dark
          ? AppColors.secondaryButtonDarkMode
          : AppColors.secondaryButtonDarkMode),),
    ),
  );
}