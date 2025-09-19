



import '../../allpaths.dart';

class Splashscreens extends StatefulWidget {
  const Splashscreens({super.key});

  @override
  State<Splashscreens> createState() => _SplashscreensState();
}

class _SplashscreensState extends State<Splashscreens> {
  final NotificationServices notificationServices = NotificationServices();
  @override
  void initState() {
    super.initState();
    notificationServices.init();
    notificationServices.getNotificationPermission();
    background();
    notificationServices.firebaseInit();
    notificationServices.getFCMToken().then((val)=>print(val));

    SplashServices.signupscreen(context);
  }

  background()async{
    await notificationServices.backGroundMessage();
  }
  @override
  Widget build(BuildContext context) {
    final width  = MediaQuery.of(context).size.width;
    return Scaffold(
     body: Center(
       child: Column(
         mainAxisAlignment: MainAxisAlignment.center,
         children: [
           Image(image: AssetImage("assets/images/pngegg (9).png"),width: 250,height: 200,).animate().fade(duration: 500.ms).scale(delay: 500.ms),
         ],
       ),
     ),
      floatingActionButton: AutoSizeText("SnapSell",minFontSize: 24,maxFontSize: 32,
        style: TextStyle(
        fontFamily: "heading",fontSize: width * 0.025
      ),).animate().fade(duration: 500.ms).scale(delay: 500.ms),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerFloat,
    );
  }
}
