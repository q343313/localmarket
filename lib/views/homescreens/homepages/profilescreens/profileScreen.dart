

import 'package:flutter/cupertino.dart';
import 'package:localmarket/riverpad/firebaseriverpad/profileproviders.dart';
import '../../../../allpaths.dart';
import '../../../../config/components/customcchemanager.dart';



class Profilescreens extends ConsumerStatefulWidget {
  const Profilescreens({super.key});

  @override
  ConsumerState<Profilescreens> createState() => _ProfilescreensState();
}

class _ProfilescreensState extends ConsumerState<Profilescreens> {
  String email = "";
  final collection = AddUserData().collection2.snapshots();

  @override
  Widget build(BuildContext context) {
    final profile = ref.watch(profileproviders);
    email = profile.value.toString();
    return Scaffold(
      appBar: AppBar(
        automaticallyImplyLeading: false,
        elevation: 0,
        centerTitle: true,
        title: Text("My Profile",),
      ),
      body:Consumer(builder: (context,ref,_){
        final firebasedat= ref.watch(firebasedata);
       return firebasedat.when(data: (value){
           final data = value.docs;
          final userprofile = data
              .where((e) => e["useremail"] == email)
              .toList();
          if (userprofile.isEmpty) {
            return const Center(child: Text("User not found"));
          }
          final user = userprofile[0];
          return SingleChildScrollView(
            padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 16),
            child: Column(
              children: [
                buildprofileimage(user["userimage"], ref),
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
                sectionTitle("Actions"),
                const SizedBox(height: 12),
                buildprofilebuttons(user, ref, context),
                SizedBox(height: 25,),
                sectionTitle("Your Cart"),
                SizedBox(height: 30,),
                SizedBox(height: 250,
                  child: ListView.builder(
                    scrollDirection: Axis.horizontal,
                    itemCount: user["craft"].length,
                    itemBuilder: (context,index){
                      final product = user["craft"][index]["product"];
                      final emailss = user["craft"][index]["useremail"];
                      final newuserr = data.where((e)=>e["useremail"] == emailss).toList();
                      return buildProductCardCraft(context, product, newuserr[0]);
                    },),)
              ],
            ),
          );
        }, error: (eeir,staa)=>Text(eeir.toString()), loading: ()=>Center(child:CupertinoActivityIndicator(color: Colors.blue,),));
      }),
    );
  }

}


Widget buildProductCardCraft(BuildContext context, dynamic product,user) {
  return SizedBox(
    width: 200,
    child: InkWell(
      onTap: (){
        Navigator.push(context, MaterialPageRoute(builder: (context)=>ProductDetails(product: product,user: user,)));
      },
      child: Card(
        elevation: 4,
        margin: const EdgeInsets.symmetric(horizontal: 8),
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(16),
        ),
        color: Theme.of(context).brightness == Brightness.dark
            ? Colors.grey.shade900
            : Colors.white,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Stack(
              children: [
                ClipRRect(
                    borderRadius: const BorderRadius.vertical(
                      top: Radius.circular(16),
                    ),
                    child: ProductImage(url: product["image"][0])
                ),
                Positioned(
                  top: 10,
                  right: 10,
                  child: CircleAvatar(
                    radius: 18,
                    backgroundColor: Colors.black45,
                    child: Consumer(builder: (context, ref, _) {
                      final craftState = ref.watch(craftProvider); // 👈 ab yeh state watch kar raha hai
                      final userMap = (user is Map<String, dynamic>)
                          ? user
                          : Map<String, dynamic>.from(user.data() as Map);
                      final productMap = (product is Map<String, dynamic>)
                          ? product
                          : Map<String, dynamic>.from(product.data() as Map);

                      final isAdd = craftState.any((e) =>
                      e is Map<String, dynamic> &&
                          e["product"]?["name"] == productMap["name"]);

                      return IconButton(onPressed: (){
                        // ref.read(craftProvider.notifier).toggleFavorite(productMap, userMap);
                        final data = userMap;
                        data["product"] = productMap;
                        AddUserData().deleteValueCraft(product["name"]);
                      }, icon: Icon(Icons.delete,color: Colors.red,));
                    }),
                  ),
                ),
              ],
            ),
            Padding(
              padding: const EdgeInsets.all(10.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    product["name"],
                    style: const TextStyle(
                      fontFamily: "title",
                      fontSize: 16,
                      fontWeight: FontWeight.bold,
                    ),
                    maxLines: 1,
                    overflow: TextOverflow.ellipsis,
                  ),
                  const SizedBox(height: 4),
                  Text(
                    "${product["price"]} PKR",
                    style: TextStyle(
                      fontFamily: "body_c",
                      fontSize: 14,
                      color: Theme.of(context).colorScheme.secondary,
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    ),
  );
}







//






// import 'package:auto_size_text/auto_size_text.dart';
// import 'package:country_picker/country_picker.dart';
// import 'package:flutter/material.dart';
// import 'package:flutter/cupertino.dart';
// import 'package:flutter_riverpod/flutter_riverpod.dart';
// import 'package:localmarket/config/components/cutomtextfieldwidget.dart';
// import 'package:localmarket/config/components/imagewidgets.dart';
// import 'package:localmarket/config/domians/appcolors.dart';
// import 'package:localmarket/data/userdata/adduserdatainfirebase.dart';
// import 'package:localmarket/riverpad/imageproviders/imageproviders.dart';
// import 'package:localmarket/riverpad/loginproviders/loginproviders.dart';
// import 'package:localmarket/riverpad/updateproviders/updateproviders.dart';
// import 'package:localmarket/utils/enum.dart';
// import 'package:localmarket/views/authscreens/signupscreens.dart';
// import 'package:shared_preferences/shared_preferences.dart';
//
// class Profilescreens extends ConsumerStatefulWidget {
//   const Profilescreens({super.key});
//
//   @override
//   ConsumerState<Profilescreens> createState() => _ProfilescreensState();
// }
//
// class _ProfilescreensState extends ConsumerState<Profilescreens> {
//   String email = "";
//   @override
//   void initState() {
//     // TODO: implement initState
//     super.initState();
//     getuseremail();
//   }
//
//   getuseremail()async{
//     var pref =await SharedPreferences.getInstance();
//     email = pref.getString("email").toString();
//     return email;
//  }
//  final collection = AddUserData().collection2.snapshots();
//   @override
//   Widget build(BuildContext context) {
//     final width = MediaQuery.of(context).size.width;
//     return Scaffold(
//       appBar: AppBar(
//         title: Text("Profile Screens"),
//       ),
//       body: Padding(
//         padding: const EdgeInsets.symmetric(horizontal: 38.0),
//         child: Center(
//           child: SingleChildScrollView(
//             child: Column(
//               mainAxisAlignment: MainAxisAlignment.center,
//               children: [
//                 StreamBuilder(stream: collection,
//                     builder: (context,snapshot){
//                     if(snapshot.connectionState == ConnectionState.waiting){
//                       return CircularProgressIndicator();
//                     } else if(snapshot.hasError){
//                       return Text("${snapshot.error}");
//                     }else if(!snapshot.hasData){
//                       return Text("No Data Exists");
//                     }else{
//                       final data = snapshot.data!.docs;
//                       final userprofile = data.where((e)=>e["useremail"] == email).toList();
//                       if (userprofile.isEmpty) {
//                         return const Text("User not found");
//                       }
//
//                       final user = userprofile[0];
//                       return Column(
//                         children: [
//                           Consumer(builder: (context,ref,_){
//                             final image = ref.watch(imageproviders.select((val)=>val.imagepath));
//                             if(image != null && image.path.isNotEmpty){
//                               AddUserData().adduserimage(image.path.toString());
//                             }
//                             return InkWell(
//                               onTap: ()=>imagepickerwidget(context, ref),
//                               child: image !=null && image.path.isNotEmpty?
//                               CustomImageWidget(image: image.path.toString(),)
//                               : CustomImageWidget(image: user["userimage"],),
//                             );
//                           }),
//                         buildheadingwidget(user["username"], width, 18),
//                           buildsubtitlewidget(user["useremail"], width),
//                           SizedBox(height: 20,),
//                           buildprofilebutton(context,ref,user),
//                           SizedBox(height: 30,),
//                           buildrowusablewidget("Dote Of Birth",user["userdeof"] , context),
//                           builddividerwidget(context),
//                           buildrowusablewidget("Contact",user["country"]+user["userphone"] , context),
//                           builddividerwidget(context),
//                           buildtitlewidgt("About User:", width, context),
//                           builddetailwidget(user["userbio"], "body_p", width,20),
//                           builddividerwidget(context),
//                           SizedBox(height: 10,),
//                           buildtitlewidgt("User Address:", width, context),
//                           builddetailwidget(user["useraddress"], "body_p", width,20),
//                           builddividerwidget(context),
//                         ],
//                       );
//
//                     }
//                     })
//               ],
//             ),
//           ),
//         ),
//       ),
//     );
//   }
// }
//
//

//
//
// Widget buildrowusablewidget(String title,String text,BuildContext context){
//   final width = MediaQuery.of(context).size.width;
//   return Row(
//     mainAxisAlignment: MainAxisAlignment.spaceBetween,
//     children: [
//       buildtitlewidgt(title, width, context),
//       builddetailwidget(text, "body_c", width, 16)
//     ],
//   );
// }
//
//  Widget buildtitlewidgt(String text,width,BuildContext context){
//   return Align(alignment: Alignment.centerLeft,
//   child: AutoSizeText(text,minFontSize: 18,maxFontSize: 22,style: TextStyle(
//    fontSize:  width * 0.025,fontFamily: "title",
//     color: Theme.of(context).brightness == Brightness.dark
//       ? AppColors.secondaryTextDarkMode
//         : AppColors.secondaryTextLightMode
//   ),),) ;
// }
//
// Widget builddetailwidget(String text,String fontfamily,width,double size){
//   return Align(
//     alignment: Alignment.centerLeft,
//     child: AutoSizeText(text,maxFontSize: 20,minFontSize:size,style: TextStyle(
//       fontFamily: fontfamily,
//       fontSize: width * 0.025
//     ),),
//   );
// }
//
// Widget buildprofilebutton(BuildContext context,WidgetRef ref,user)
// {
//   return Row(
//     mainAxisAlignment: MainAxisAlignment.spaceBetween,
//     children: [
//       FloatingActionButton(
//         backgroundColor: Theme.of(context).brightness == Brightness.dark
//         ? AppColors.secondaryButtonDarkMode
//         : AppColors.secondaryButtonLightMode,
//         onPressed: (){
//           showprofiledeletedialog("Logout", "If you want to logout your account you will delete your all data and all product detail",
//                   ()=> ref.read(loginprovider.notifier).logoutuser(), context);
//
//         },
//       child: Icon(Icons.logout,color: Colors.white,),),
//       FloatingActionButton(
//         backgroundColor: Theme.of(context).brightness == Brightness.dark
//             ? AppColors.secondaryButtonDarkMode
//             : AppColors.secondaryButtonLightMode,
//         onPressed: (){
//          showprofiledeletedialog("Delete", "If you want to delete your account you will delete your all data and all product detail",
//              ()=> ref.read(loginprovider.notifier).deleteaccount(), context);
//         },
//         child: Icon(Icons.delete,color: Colors.red,),),
//       FloatingActionButton(
//         backgroundColor: Theme.of(context).brightness == Brightness.dark
//             ? AppColors.secondaryButtonDarkMode
//             : AppColors.secondaryButtonLightMode,
//         onPressed: (){
//           updateuserdialog(context,user,ref);
//         },
//         child: Icon(Icons.edit,color: Colors.white,),)
//     ],
//   );
// }
//
// Widget builddividerwidget(BuildContext context){
//   return Divider(color: Colors.black12);
// }
//
// Future<void>showprofiledeletedialog(String buttonname,String text,VoidCallback callback,BuildContext context){
//   return showDialog(context: context, builder: (context){
//     return AlertDialog(
//       title: Text(buttonname,style: TextStyle(fontSize: 22,fontFamily: "title"),),
//       content: Text(text,style: TextStyle(fontFamily: "body_p",fontSize: 20),),
//       actions: [
//         TextButton(onPressed: ()=>Navigator.pop(context), child: Text("Cancel",style: TextStyle(
//           fontSize: 16,fontFamily: "title",color: AppColors.secondaryButtonLightMode
//         ),)),
//         TextButton(onPressed: callback, child: Text(buttonname,style: TextStyle(fontFamily: "title",fontSize: 16,color: AppColors.secondaryButtonLightMode),))
//       ],
//     );
//   });
// }