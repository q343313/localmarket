import '../../allpaths.dart';


class LoginScreen extends ConsumerWidget {
   LoginScreen({super.key});

  TextEditingController emailController = TextEditingController();
  TextEditingController passwordController = TextEditingController();
  final formKey = GlobalKey<FormState>();
  @override
  Widget build(BuildContext context,WidgetRef ref) {
    final width  = MediaQuery.of(context).size.width;
    return Scaffold(
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 38.0),
        child: Form(
          key: formKey,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              buildheadingwidget("Welcome Back", width,21),
              buildsubtitlewidget("login your account in snapsell app", width),
              SizedBox(height: 20,),
              buildloginemailwidget(ref, emailController),
              SizedBox(height: 10,),
              buildpassordwidget(ref, passwordController),
              buildforgetpassword(context),
              SizedBox(height: 50,),
              buildloginaction(
                  formkey: formKey,
                  emailcontroller: emailController,
                  passwordcontroller: passwordController,
                  context: context, ref: ref).animate().fade(duration: 900.ms).scale(delay: 1100.ms),
            ],
          ),
        ),
      ).animate().fade(duration: 500.ms).scale(delay: 500.ms),
      persistentFooterButtons: [buildsignupfooter(context, "Don't have account? ", "Signup         ", ()=>Navigator.pushReplacementNamed(context, RouteNames.signupscreen))],
    );
  }
}

