import 'dart:io';
import 'package:url_launcher/url_launcher.dart';

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
        onPressed: (){
          showCallOptions(context, user["userphone"]);
        },
      child: Icon(Icons.messenger,size: 40,color: Colors.white,),),
    );
  }
}

void launchPhoneCall(String phoneNumber) async {
  final Uri url = Uri(scheme: 'tel', path: phoneNumber);
  if (await canLaunchUrl(url)) {
    await launchUrl(url);
  } else {
    print('Could not launch $phoneNumber');
  }
}

Future<void> openWhatsApp(String phoneNumber, {String message = ''}) async {
  final cleanedNumber = phoneNumber.replaceAll('+', ''); // WhatsApp format
  final Uri url = Uri.parse('https://wa.me/$cleanedNumber?text=${Uri.encodeFull(message)}');
  try {
    await launchUrl(url, mode: LaunchMode.externalApplication);
  } catch (e) {
    print('Could not open WhatsApp: $e');
  }
}

void showCallOptions(BuildContext context, String phoneNumber) {
  showModalBottomSheet(
    backgroundColor: Theme.of(context).brightness == Brightness.dark
    ? AppColors.scaffoldDarkMode
    : AppColors.scaffoldLightMode,
    context: context,
    builder: (_) {
      return Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          ListTile(
            leading: Icon(Icons.call,color: Colors.blue,),
            title: Text('Call',style: TextStyle(fontFamily: "title"),),
            onTap: () {
              launchPhoneCall(phoneNumber);
              Navigator.pop(context);
            },
          ),
          ListTile(
            leading: Icon(Icons.chat,color: Colors.green,),
            title: Text('WhatsApp',style: TextStyle(fontFamily: "title"),),
            onTap: () {
              openWhatsApp(phoneNumber);
              Navigator.pop(context);
            },
          ),
          SizedBox(height: 10,)
        ],
      );
    },
  );
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
