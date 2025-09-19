


import 'package:google_mobile_ads/google_mobile_ads.dart';

import 'allpaths.dart';
final GlobalKey<NavigatorState> navigatorkey = GlobalKey<NavigatorState>();
GetIt getIt = GetIt.instance;

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  injctions();

  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );


  MobileAds.instance.initialize();
// apna test device id add karo (release ke liye safe hai)
  RequestConfiguration configuration = RequestConfiguration(
    testDeviceIds: ["A3CEDA64FFA02EC0B2E89E01E78EA123"],
  );
  MobileAds.instance.updateRequestConfiguration(configuration);

  FirebaseMessaging.onBackgroundMessage(backgroundmessage);

  FirebaseMessaging.onMessageOpenedApp.listen((message) {
    AddUserData().numberUnSeenNotification();
    AddUserData().addNotification(message);
  });

  final prefs = await SharedPreferences.getInstance();
  final isEnabled = prefs.getBool("notifications_enabled") ?? true;

  runApp(
    ProviderScope(
      overrides: [
        appNotificationController.overrideWith((ref) => isEnabled),
      ],
      child: MyApp(),
    ),
  );
}

@pragma('vm:entry-point')
Future<void> backgroundmessage(RemoteMessage message) async {
  AddUserData().numberUnSeenNotification();
  AddUserData().addNotification(message);
}

class MyApp extends ConsumerWidget {
  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final thememo = ref.watch(themeproviders);
    return GetMaterialApp(
      debugShowCheckedModeBanner: false,
      navigatorKey: navigatorkey,
      title: "Ecomerace App",
      theme: AppThemes.lightthemedata,
      darkTheme: AppThemes.darkthemedata,
      themeMode: thememo,
      initialRoute: RouteNames.splashscreen,
      onGenerateRoute: Routes.generateroute,
    );
  }
}

void injctions() {
  getIt.registerLazySingleton<ImplementAuthentication>(() => ImplementAuthentication());
  getIt.registerLazySingleton<ImageRepository>(() => ImageRepository());
  getIt.registerLazySingleton<AddUserData>(() => AddUserData());
  getIt.registerLazySingleton<FavoriteDatabase>(() => FavoriteDatabase());
}
