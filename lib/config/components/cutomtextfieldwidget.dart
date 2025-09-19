

import 'package:auto_size_text/auto_size_text.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import '../domians/appcolors.dart';

class PhoneTextField extends StatelessWidget {
  final String countrycode;
  final TextEditingController controller;
  final VoidCallback callback;
  final Function(String)? onChanged;
  const PhoneTextField({super.key,required this.controller,required this.countrycode,required this.callback,this.onChanged});

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Expanded(
            flex: 3,
            child: InkWell(
              onTap: callback,
              child: Container(
                height: 50,
                decoration: BoxDecoration(
                  // border: Border.all(color: Colors.blue,),
                    border: Border(top: BorderSide(color: Colors.blue),left:  BorderSide(color: Colors.blue),bottom:  BorderSide(color: Colors.blue),right: BorderSide.none),
                    borderRadius: BorderRadius.circular(10)
                ),
                child: Center(child: Text(countrycode,style: TextStyle(fontFamily: "body_c",fontSize: 15),),),
              ),
            )),
        Expanded(
            flex: 7,
            child: CustomTextfieldWidget(
              label: "Phone",
              hint: "3************",
              controller: controller,
              onChanged:onChanged ,
              // validator: (value)=>AppVallidations.phonevalidation(value.toString()),
            ))
      ],
    );
  }
}


class CustomTextfieldWidget extends StatelessWidget {
  final TextEditingController?controller;
  final String?label;
  final String?hint;
  final TextInputType textInputType;
  final IconData?preffixicon;
  final IconButton?suffixicon;
  final bool?obstracttext;
  final String? Function(String?)? validator;
  final Function(String)? onChanged;
  final Function()? onTap;
  final int lines;
  final int minlines;
  const CustomTextfieldWidget({
    super.key,
    this.textInputType = TextInputType.text,
    this.controller ,
    this.label ,
    this.suffixicon,
    this.preffixicon,
    this.hint,
    this.obstracttext,
    this.validator,
    this.onChanged,
    this.onTap,
    this.lines = 1,
    this.minlines = 1
  });

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      controller: controller,
      style: TextStyle(fontFamily: "body_c",fontSize: 13),
      validator:validator ,autofocus: false,
      onChanged:onChanged ,
      onTap:onTap ,
      minLines: minlines,
      keyboardType: textInputType,
      maxLines: lines,
      obscureText: obstracttext??false,
      obscuringCharacter: "*",
      decoration: InputDecoration(
          border: OutlineInputBorder(
              borderRadius: BorderRadius.circular(13),
              borderSide: BorderSide(color: Colors.blue)
          ),
          enabledBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(13),
              borderSide: BorderSide(color: Colors.blue)
          ),
          prefixIcon: Icon(preffixicon,),
          suffixIcon: suffixicon,
          label: AutoSizeText(label??"",style: TextStyle(fontFamily: "body_p",fontSize: 20),),
          hintText: hint,
          hintStyle:  TextStyle(fontFamily: "body_c",fontSize: 13,)
      ),
    );
  }
}