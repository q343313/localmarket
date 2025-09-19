import 'package:localmarket/allpaths.dart';

class NotificationServices{

  final FirebaseMessaging firebaseMessaging = FirebaseMessaging.instance;
  final FlutterLocalNotificationsPlugin flutterLocalNotificationsPlugin = FlutterLocalNotificationsPlugin();

  void init(){
    AndroidInitializationSettings androidInitializationSettings  = AndroidInitializationSettings("mipmap/ic_launcher");
    DarwinInitializationSettings darwinInitializationSettings = DarwinInitializationSettings();
    InitializationSettings initializationSettings =  InitializationSettings(
      android: androidInitializationSettings,
      iOS: darwinInitializationSettings
    );
    flutterLocalNotificationsPlugin.initialize(
      initializationSettings,
      onDidReceiveNotificationResponse: (NotificationResponse respone){
      if(respone.payload != null && respone.payload!.isNotEmpty){
        final Map<String,dynamic>mappayload = jsonDecode(respone.payload!);
        handleMessage(mappayload);
      }
      }
    );
  }

  Future<void>getNotificationPermission()async{
    NotificationSettings _ = await firebaseMessaging.requestPermission(
       alert: true,
      announcement: true,
      badge: true,
      carPlay: true,
      criticalAlert: true,
      providesAppNotificationSettings: true,
      provisional: true,
      sound: true
    );
  }

  Future<String>getFCMToken()async{
    String?token  = await firebaseMessaging.getToken();
    return token!;
  }

  void firebaseInit()async{
    FirebaseMessaging.onMessage.listen((message){
      AddUserData().numberUnSeenNotification();
      AddUserData().addNotification(message);
      showNotification(message);

    });
  }

  Future<void>showNotification(RemoteMessage mesage)async{
    AndroidNotificationChannel androidNotificationChannel  =AndroidNotificationChannel(
        "my_channel_id", "MHy channel id",
        importance: Importance.max);
    AndroidNotificationDetails androidNotificationDetails = AndroidNotificationDetails(
        androidNotificationChannel.id.toString()
        ,  androidNotificationChannel.name.toString(),importance: Importance.high,
    icon: "mipmap/ic_launcher"
    );
    DarwinNotificationDetails darwinNotificationDetails = DarwinNotificationDetails(presentAlert: true,);

    NotificationDetails notificationDetails = NotificationDetails(
      android: androidNotificationDetails,
      iOS: darwinNotificationDetails
    );

    int id = Random().nextInt(1000);
    String payload= jsonEncode(mesage.data);
    flutterLocalNotificationsPlugin.show(
        id, mesage.notification!.title, mesage.notification!.body, notificationDetails,payload: payload);

  }


  Future<void>handleMessage(Map<String,dynamic>payloaf)async{
    if(payloaf["next"] == "message"){}
  }

  Future<void>backGroundMessage()async{
    RemoteMessage ? message  = await firebaseMessaging.getInitialMessage();
    if(message!=null){
      AddUserData().numberUnSeenNotification();
      AddUserData().addNotification(message);
      handleMessage(message.data);
    }
  }


  Future<void>simpleNotification({
    required String title,
    required String body,
    String?payload,

})async{
    AndroidNotificationChannel androidNotificationChannel  =AndroidNotificationChannel(
        "my_channel_id", "MHy channel id",
        importance: Importance.max);
    AndroidNotificationDetails androidNotificationDetails = AndroidNotificationDetails(
        androidNotificationChannel.id.toString()
        ,  androidNotificationChannel.name.toString(),importance: Importance.high,
        icon: "mipmap/ic_launcher"
    );
    DarwinNotificationDetails darwinNotificationDetails = DarwinNotificationDetails(presentAlert: true,);

    NotificationDetails notificationDetails = NotificationDetails(
        android: androidNotificationDetails,
        iOS: darwinNotificationDetails
    );

    int id = Random().nextInt(1000);
    flutterLocalNotificationsPlugin.show(
        id, title,
        body,
        notificationDetails,payload: jsonDecode(payload!));

  }


}