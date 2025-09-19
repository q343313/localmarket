import '../../allpaths.dart';

class Signupscreens extends ConsumerWidget {
   Signupscreens({super.key});

  final emailController = TextEditingController();
  final passwordController = TextEditingController();
  final usernameController = TextEditingController();
  final bioController = TextEditingController();
  final addressController = TextEditingController();
  final phoneController = TextEditingController();
  final formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context,WidgetRef ref) {
    final width = MediaQuery.of(context).size.width;
    return Scaffold(
    body:  SingleChildScrollView(
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 38.0),
        child: Form(
          key: formKey,
          child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                SizedBox(height: 90,),
               buildheadingwidget("Create Account", width,21),
                buildsubtitlewidget("Signup your account in local market app", width),
                SizedBox(height: 20,),
                SizedBox(
                  width: double.infinity,
                  height: 400,
                  child: Card(
                    color: Theme.of(context).brightness == Brightness.dark
                    ? AppColors.scaffoldDarkMode
                    : AppColors.scaffoldLightMode,
                    child: SingleChildScrollView(
                      child: Padding(
                        padding: const EdgeInsets.symmetric(vertical: 12.0),
                        child: Column(
                          children: [
                            buildusernamewidgt(ref, usernameController),
                            SizedBox(height: 10,),
                            buildemailwidgt(ref, emailController),
                            SizedBox(height: 10,),
                            buildpasswordwidgt(ref, passwordController),
                            SizedBox(height: 10,),
                            buildphonewidget(ref, phoneController, context),
                            SizedBox(height: 10,),
                            builddateofbirth(ref, context,),
                            SizedBox(height: 10,),
                            builduserbiowidgt(ref, bioController),
                            SizedBox(height: 10,),
                            buildaddresswidgt(ref, addressController)
                          ],
                        ),
                      ),
                    ),
                  ),
                ),
                buildcheckboxwidget(context,ref),
                SizedBox(height: 40,),
                buildsignupaction(
                    formkey: formKey,
                    emailcontroller: emailController,
                    passwordcontroller: passwordController,
                    usernamecontroller: usernameController,
                    phonecontroller: phoneController,
                    biocontroller: bioController,
                    addresscontroller: addressController,
                    context: context,
                    ref: ref).animate().fade(duration: 900.ms).scale(delay: 1100.ms),
              ],
            ).animate().fade(duration: 500.ms).scale(delay: 500.ms),
        ),
      ),
    ),
    persistentFooterButtons: [buildsignupfooter(context,"Already have account? ","Login             ", ()=>Navigator.pushReplacementNamed(context, RouteNames.loginscreen))],
    );
  }
}

