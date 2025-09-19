




import 'dart:io';

import 'package:auto_size_text/auto_size_text.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:localmarket/riverpad/imageproviders/imageproviders.dart';

import '../domians/appcolors.dart';


class CustomImageWidget extends StatelessWidget {
  final String image;
  const CustomImageWidget({super.key,this.image = ""});

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        CircleAvatar(
          radius: 70,
          backgroundColor: Colors.black12,
          backgroundImage: image != "" && image.isNotEmpty?FileImage(File(image)):null,
          child: image == "" || image.isEmpty?
          Center(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Icon(Icons.camera_alt),
                Text("Upload image",style: TextStyle(fontFamily: "body_p",fontSize: 17),)
              ],
            ),
          ):null,
        ),
        Positioned(
            bottom: 0,
            right: 0,
            child: CircleAvatar(
              backgroundColor: Theme.of(context).brightness == Brightness.dark
                  ? AppColors.scaffoldLightMode
                  : AppColors.scaffoldDarkMode,
              child: Icon(Icons.camera_alt,color:  Theme.of(context).brightness == Brightness.dark
                  ? AppColors.scaffoldDarkMode
                  : AppColors.scaffoldLightMode,),
            ))
      ],
    );
  }
}


Future<void>imagepickerwidget(BuildContext context,WidgetRef ref){
  return showModalBottomSheet(context: context,
      builder: (context){
        return Container(
          width: double.infinity,
          height: 179,
          child: Column(
            children: [
              customlisttile(context, (){
                Navigator.pop(context);
                ref.read(imageproviders.notifier).galleyimage();
              }, "Gallery", Icon(Icons.library_add)),
              customlisttile(context, (){
                Navigator.pop(context);
                ref.read(imageproviders.notifier).cameraimage();
              }, "Camera", Icon(Icons.camera)),
              customlisttile(context, (){
                Navigator.pop(context);
                ref.read(imageproviders.notifier).deleteimage();

              }, "Delete", Icon(Icons.delete,color: Colors.red,)),
            ],
          ),
        );
      });
}

Widget customlisttile(BuildContext context,VoidCallback callback,String title,Icon icon){
  return ListTile(
    title: AutoSizeText(title,style: TextStyle(fontFamily: "heading_c",fontSize: 17),),
    leading: icon,
    onTap: callback,
  );
}