

import '../../allpaths.dart';

class Routes {

  static Route<dynamic>generateroute(RouteSettings setting){
    switch(setting.name){
      case RouteNames.splashscreen:
        return MaterialPageRoute(builder: (_)=>Splashscreens());
      case RouteNames.signupscreen:
        return MaterialPageRoute(builder: (_)=>Signupscreens());
      case RouteNames.loginscreen:
        return MaterialPageRoute(builder: (_)=>LoginScreen());
      case RouteNames.resetscreen:
        return MaterialPageRoute(builder: (_)=>Resetscreens());
      case RouteNames.termandconditions:
        return MaterialPageRoute(builder: (_)=>TermsAndConditionsPage());
      case RouteNames.introcreen:
        return MaterialPageRoute(builder: (_)=>IntroScreens());
      case RouteNames.helpcenter:
        return MaterialPageRoute(builder: (_)=>HelpCenterScreen());
      case RouteNames.security:
        return MaterialPageRoute(builder: (_)=>SecurityScreen());
      case RouteNames.privacyscreen:
        return MaterialPageRoute(builder: (_)=>PrivacyPolicyScreen());
      case RouteNames.aboutapp:
        return MaterialPageRoute(builder: (_)=>AboutAppScreen());
      case RouteNames.aboutme:
        return MaterialPageRoute(builder: (_)=>AboutDeveloperScreen());


      case RouteNames.homescreen:
        return MaterialPageRoute(builder: (_)=>Homescreens());
      case _:
        return MaterialPageRoute(builder: (_){
          return Scaffold(
            body: Center(
              child: Column(
                children: [
                  Text("No Route Found",style: TextStyle(fontFamily: "title"),)
                ],
              ),
            ),
          );
        });
    }
  }
}