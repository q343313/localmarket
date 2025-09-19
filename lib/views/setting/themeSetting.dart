


import '../../allpaths.dart';

class Themesetting extends ConsumerWidget {
  const Themesetting({super.key});

  @override
  Widget build(BuildContext context,WidgetRef ref) {
    final thememoe = ref.watch(themeproviders);
    return Scaffold(
      appBar: AppBar(
        title:Text("Theme Setting",style: TextStyle(fontFamily: "title",fontSize: 20),) ,
      ),
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 8.0),
        child: Center(
          child: Column(
            children: [
              SizedBox(height: 20,),
              RadioListTile(
                title: Text("Light Theme",style: TextStyle(fontSize: 16,fontFamily: "title"),),
                  value: ThemeMode.light,
                  groupValue: thememoe,
                  onChanged: (vl){
                    ref.read(themeproviders.notifier).state= ThemeMode.light;
                  }),
              RadioListTile(
                  title: Text("Dark Theme",style: TextStyle(fontSize: 16,fontFamily: "title"),),
                  value: ThemeMode.dark,
                  groupValue: thememoe,
                  onChanged: (vl){
                    ref.read(themeproviders.notifier).state= ThemeMode.dark;
                  }),
              RadioListTile(
                  title: Text("System Theme",style: TextStyle(fontSize: 16,fontFamily: "title"),),
                  value: ThemeMode.system,
                  groupValue: thememoe,
                  onChanged: (vl){
                    ref.read(themeproviders.notifier).state= ThemeMode.system;
                  })
            ],
          ),
        ),
      ),
    );
  }
}
