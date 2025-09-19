


import '../../allpaths.dart';

Widget buildprofilebuttons(user,WidgetRef ref,BuildContext context){
  return  Row(
    children: [
      actionButton(
        context,
        color: Colors.red,
        icon: Icons.delete,
        label: "Delete",
        onTap: (){
          showprofiledeletedialog("Delete", "If you want to delete your account you will delete your all data and all product detail",
                  (){
                    ref.read(loginprovider.notifier).deleteaccount();
                    AddUserData().deleteProfileImage();
                  }, context);
          ref.read(imageproviders.notifier).deleteimage();
        },
      ),
      const SizedBox(width: 12),
      actionButton(
        context,
        color: Colors.grey,
        icon: Icons.logout,
        label: "Logout",
        onTap: (){
          showprofiledeletedialog("Logout", "If you want to logout your account you will delete your all data and all product detail",
                  (){
                    ref.read(loginprovider.notifier).logoutuser();
                    AddUserData().deleteProfileImage();
                  }, context);
          ref.read(imageproviders.notifier).deleteimage();
        },
      ),
      const SizedBox(width: 12),
      actionButton(
          context,
          color: Colors.blue,
          icon: Icons.edit,
          label: "Edit",
          onTap: ()=>updateuserdialog(context, user, ref)
      ),

    ],
  );
}

Widget buildprofileimage(userimage,WidgetRef ref){
  return Consumer(builder: (context,ref,_){
    final image = ref.watch(imageproviders.select((val)=>val.imagepath));
    if(image != null && image.path.isNotEmpty){
      AddUserData().addProfileImage(image.path.toString());
    }
    return InkWell(
      onTap: ()=>imagepickerwidget(context, ref),
      child: image !=null && image.path.isNotEmpty?
      CustomImageWidget(image: image.path.toString(),)
          :userimage != null && userimage.isNotEmpty
          ? CustomImageWidget(image: userimage,):CustomImageWidget(),
    );
  });
}

Widget infoCard(IconData icon, String title, String value,BuildContext context) {
  return Expanded(
    child: Card(
      color: Theme.of(context).brightness== Brightness.dark
          ? AppColors.containerDarkMode
          : AppColors.containerLightMode,
      elevation: 2,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
      child: Padding(
        padding: const EdgeInsets.symmetric(vertical: 16, horizontal: 8),
        child: Column(
          children: [
            Icon(icon, color: Colors.blue, size: 28),
            const SizedBox(height: 8),
            Text(title,
                style: const TextStyle(fontSize: 14, fontWeight: FontWeight.w500,fontFamily: "title")),
            const SizedBox(height: 4),
            Text(
              value,
              style: const TextStyle(fontSize: 13, color: Colors.grey,fontFamily: "body_c"),
              textAlign: TextAlign.center,
            ),
          ],
        ),
      ),
    ),
  );
}

Widget sectionTitle(String text) {
  return Align(
    alignment: Alignment.centerLeft,
    child: Text(
      text,
      style: const TextStyle(
        fontSize: 18,
        fontWeight: FontWeight.bold,
        fontFamily: "title",
      ),
    ),
  );
}

Widget sectionBox(String text,BuildContext context,double fontsize) {
  return Container(
    margin: const EdgeInsets.only(top: 8),
    padding: const EdgeInsets.all(12),
    decoration: BoxDecoration(
      color: Theme.of(context).brightness== Brightness.dark
          ? AppColors.containerDarkMode
          : Colors.grey.shade200,
      borderRadius: BorderRadius.circular(12),
    ),
    child: Text(
      text,
      style:  TextStyle(fontSize: fontsize, fontFamily: "body_p"),
    ),
  );
}

Widget actionButton(BuildContext context,
    {required Color color,
      required IconData icon,
      required String label,
      required VoidCallback onTap}) {
  return Expanded(
    child: ElevatedButton.icon(
      style: ElevatedButton.styleFrom(
        backgroundColor: color,
        padding: const EdgeInsets.symmetric(vertical: 14),
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
      ),
      onPressed: onTap,
      icon: Icon(icon, color: Colors.white),
      label: Text(label,
          style: const TextStyle(color: Colors.white, fontWeight: FontWeight.bold)),
    ),
  );
}


Future<void>showprofiledeletedialog(String buttonname,String text,VoidCallback callback,BuildContext context){
  return showDialog(context: context, builder: (context){
    return AlertDialog(
      title: Text(buttonname,style: TextStyle(fontSize: 22,fontFamily: "title"),),
      content: Text(text,style: TextStyle(fontFamily: "body_p",fontSize: 20),),
      actions: [
        TextButton(onPressed: ()=>Navigator.pop(context), child: Text("Cancel",style: TextStyle(
            fontSize: 16,fontFamily: "title",color: AppColors.secondaryButtonLightMode
        ),)),
        TextButton(onPressed: callback, child: Text(buttonname,style: TextStyle(fontFamily: "title",fontSize: 16,color: AppColors.secondaryButtonLightMode),))
      ],
    );
  });
}

