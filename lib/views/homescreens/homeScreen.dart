
import '../../allpaths.dart';
import 'homepages/FavoriteproductScreen/favoriteScreen.dart';

class Homescreens extends ConsumerStatefulWidget {
  const Homescreens({super.key});

  @override
  ConsumerState<ConsumerStatefulWidget> createState() {
    return _Homescreens();
  }

}

class _Homescreens extends ConsumerState<Homescreens>{
  List<Widget>screens = [
    SettingsScreen(),
    NotificationScreen(),
    ShopingCartScreen(),
    FavoriteScreen(),
    Profilescreens()
  ];

  @override
  void initState() {
    super.initState();
    Future((){
      ref.watch(profileproviders);
    });

    Future((){
      ref.read(favoriteProvider.notifier).refreshFavorites();
    });
  }
  @override
  Widget build(BuildContext context) {
    final index = ref.watch(navigtionprovider);
    final data = ref.watch(firebasedata);
    final email = ref.watch(profileproviders);
    return Scaffold(
      bottomNavigationBar: NavigationBarTheme(
        data: NavigationBarThemeData(
            labelTextStyle: WidgetStateProperty.all(TextStyle(fontSize: 10,fontFamily: "body_c"))
        ),
        child: NavigationBar(
          destinations: [
            NavigationDestination(icon: Icon(Icons.settings), label: "setting",selectedIcon: Icon(Icons.settings),),
            data.when(data: (value){
              final userdata = value.docs.where((e)=>e["useremail"] == email.value).toList();
              final usernotif = userdata[0]["nocount"];
              if(usernotif == 0){
                return NavigationDestination(icon: Icon(Icons.notifications), label: "updates",selectedIcon: Icon(Icons.notifications),);
              }else{
                return Stack(
                  children: [
                    NavigationDestination(icon: Icon(Icons.notifications), label: "updates",selectedIcon: Icon(Icons.notifications),),
                    Positioned(
                      top:0,
                        right:10,
                        child: CircleAvatar(
                      radius: 10,
                      backgroundColor: Colors.green,
                      child: Text(usernotif.toString(),style: TextStyle(fontFamily: "body_c",fontSize: 14,color: Colors.white),),
                    ))
                  ],
                );
              }
            }, error: (err,val)=>Text(err.toString()), loading: ()=> NavigationDestination(icon: Icon(Icons.notifications), label: "update",selectedIcon: Icon(Icons.notifications)),),
            NavigationDestination(icon: Icon(Icons.shopping_cart), label: "product",selectedIcon: Icon(Icons.shopping_cart),),
            NavigationDestination(icon: Icon(Icons.favorite), label: "favorite",selectedIcon: Icon(Icons.favorite),),
            NavigationDestination(icon: Icon(Icons.person), label: "profile",)
          ],
          backgroundColor: Theme.of(context).brightness == Brightness.dark
              ? AppColors.scaffoldDarkMode
              : AppColors.scaffoldLightMode,
          height: 60,
          indicatorColor: Theme.of(context).brightness == Brightness.dark
              ? AppColors.secondaryButtonDarkMode
              : Colors.lightBlueAccent.shade100,
          shadowColor:Theme.of(context).brightness == Brightness.dark
              ? AppColors.scaffoldLightMode
              : AppColors.scaffoldDarkMode,
          selectedIndex: index,
          onDestinationSelected:(value){
            ref.read(navigtionprovider.notifier).state = value;
          },
        ),
      ),
      body: screens[index]
    );
  }

}
