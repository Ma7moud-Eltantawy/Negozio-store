
import 'package:flutter/material.dart';

import '../styles/Local_Styles.dart';
class txtformfield extends StatelessWidget {
  const txtformfield(
      {

        required this.controller,
        required this.width,
        required this.height,
        required this.hinttext,
        required this.icondata,
        required this.inputtype,
        required this.errortext,
        this.fieldname,
      }
      );
  final TextEditingController? controller;
  final double? width;
  final double? height;
  final String? hinttext;
  final String? errortext;
  final IconData? icondata;
  final TextInputType?inputtype;
  final String? fieldname;




  @override
  Widget build(BuildContext context) {
    return TextFormField(
      cursorColor: local_green,

      textDirection: TextDirection.ltr,
      textAlign: TextAlign.left,
      validator: (val)=>val!.isEmpty?"user cant be blank":null,
      controller: controller,
      keyboardType: inputtype,
      textAlignVertical: TextAlignVertical.center,
      obscureText: false,
      style: TextStyle(
        fontFamily:'varela' ,
          color: Theme.of(context).unselectedWidgetColor,
      ),
      decoration: InputDecoration(
        errorText: errortext,
        enabledBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(8.0),
        ),
        focusedBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(8.0),
          borderSide: BorderSide(
            width: 1.3,
            color: local_green,
          ),
        ),
        errorBorder:OutlineInputBorder(
          borderRadius: BorderRadius.circular(8.0),
          borderSide: BorderSide(
            color: Colors.grey,
          ),
        ),
        focusedErrorBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(8.0),
          borderSide: BorderSide(
            width: 1.3,
            color: local_green,
          ),
        ),



        prefixIcon: Icon(icondata,color: local_green,),
        prefixIconColor: Colors.orange,
        suffixIconColor: Colors.orangeAccent,
        labelText: fieldname,
        labelStyle: TextStyle(
          color: local_green
        ),
        filled: false,
        hintText: hinttext,
        hintStyle: TextStyle(
            fontSize: 12,
            color: local_green,

        ),

        contentPadding: EdgeInsets.only(
            right: width!/60

        ),
      ),



    );
  }
}