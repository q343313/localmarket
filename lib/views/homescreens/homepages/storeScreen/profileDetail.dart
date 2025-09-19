import 'dart:io';
import '../../../../allpaths.dart';

class ProfileDetail extends ConsumerWidget {
   ProfileDetail({super.key,required this.user});
  dynamic user;

  @override
  Widget build(BuildContext context,WidgetRef ref) {
    final profile = ref.watch(profileproviders);
    return Scaffold(
      appBar: AppBar(
        title: Text(user["username"]),
      ),
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 18.0),
        child: Center(
          child: Column(
            children: [
            SizedBox(height: 30,),
              buildyourownwidget(context, user, profile),
              const SizedBox(height: 12),
              Text(user["username"],
                style: TextStyle(fontFamily: "title", fontSize: 20,),),
              Text(user["useremail"], style: TextStyle(
                  color: Colors.grey, fontSize: 20, fontFamily: "body_p"),),
              const SizedBox(height: 14),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  infoCard(Icons.cake, "Birthdate", user["userdeof"],context),
                  infoCard(Icons.phone, "Contact",
                      "${user["country"]}${user["userphone"]}",context),
                ],),
              const SizedBox(height: 24),
              sectionTitle("About"),
              sectionBox(user["userbio"], context,17),
              const SizedBox(height: 16),
              sectionTitle("Address"),
              sectionBox(user["useraddress"], context,17),
              const SizedBox(height: 10),
            ],
          ),
        ),
      ),
      floatingActionButton: FloatingActionButton(
        backgroundColor: Colors.blue,
        onPressed: (){},
      child: Icon(Icons.messenger,size: 40,color: Colors.white,),),
    );
  }
}

Widget buildyourownwidget(BuildContext context,user,profile){
  return user["useremail"] == profile.value
      ? Stack(
    children: [
      _buildprofilewidget(context,user),
      Positioned(
          top: 0,
          right: 0,
          child: CircleAvatar(
            radius: 20,
            backgroundColor: Colors.blue,
            child: const Center(
                child: Icon(Icons.person,
                    size: 30, color: Colors.white)),
          ))
    ],
  )
      : _buildprofilewidget(context,user);
}

Widget _buildprofilewidget(BuildContext context,user){
  return CircleAvatar(
    radius: 80,
    backgroundColor: Theme.of(context).brightness == Brightness.dark
        ? Colors.white10
        : Colors.grey.shade200,
    backgroundImage: user["userimage"].isNotEmpty
        ? FileImage(File(user["userimage"]))
        : null,
    child: user["userimage"] == null || user["userimage"].isEmpty
        ? Text(
      user["username"].toString().substring(0, 1).toUpperCase(),
      style: TextStyle(
        fontFamily: "heading",
        fontSize: 48,
        fontWeight: FontWeight.bold,
        color: Theme.of(context).colorScheme.primary,
      ),
    )
        : null,
  );
}
