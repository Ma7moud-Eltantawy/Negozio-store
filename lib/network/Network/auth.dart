


import 'dart:convert';

import 'package:flutter/material.dart';
import 'dart:io';
import 'package:http/http.dart' as http;
import 'package:negozio_store/Screens/auth/Login.dart';
import 'package:negozio_store/network/models/usermodel.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../../main.dart';




class Auth_prov with ChangeNotifier {

  bool progress_state = false;
  usermodel ? User_data;
  var authjson;

  void changestate(bool state)
  {
    state==true?progress_state=false:progress_state=true;
    notifyListeners();
  }
  Future <void> Login(String user, int pass) async
  {

    var headers = {
      'lang': 'en',
      'Content-Type': 'application/json'
    };
    var request = http.Request(
        'POST', Uri.parse('https://student.valuxapps.com/api/login'));
    request.body = json.encode({
      "email": '$user',
      "password": '$pass'
    });
    request.headers.addAll(headers);
    http.StreamedResponse response = await request.send();

    if (response.statusCode == 200) {
      var res = await http.Response.fromStream(response);

      User_data = usermodel.fromJson(json.decode(res.body));
      print(User_data!.message);
      print("Uploaded! ");
      print('response.body ' + res.body);
      print(progress_state);
      progress_state = false;
      print(progress_state);
      authjson = json.decode(res.body);



      notifyListeners();
    }
    else {
      print(response.reasonPhrase);
    }
  }
  Future <void> Signup({required String name, required String email, required String password,required File imgfile,
   required String phone}) async
  {
    progress_state = true;
    File profileImage = File(imgfile.path);
    List<int> imageBytes = profileImage.readAsBytesSync();
    String base64Image = base64Encode(imageBytes);

    var headers = {
      'lang': 'en',
      'Content-Type': 'application/json'
    };
    var request = http.MultipartRequest(
        'POST', Uri.parse('https://student.valuxapps.com/api/register'));
    request.fields.addAll({
      "name": "$name",
      "phone": "$phone",
      "email": "$email",
      "password": "$email",
      'image':base64Image,
    });

    request.headers.addAll(headers);
    http.StreamedResponse response = await request.send();

    if (response.statusCode == 200) {
      var res = await http.Response.fromStream(response);

      User_data = usermodel.fromJson(json.decode(res.body));
      print(User_data!.message);
      print("Uploaded! ");
      print('response.body ' + res.body);
      print(progress_state);
      progress_state = false;
      print(progress_state);
      authjson = json.decode(res.body);


      notifyListeners();
    }
    else {
      print(response.reasonPhrase);
    }
  }
  String sunamemsg="";
  String suemailmsg="";
  String supassmsg="";
  String suphonemsg="";

  String suname="";
  String suemail="";
  String supass="";
  String  phone="";


  Future<void>validateuser(String name,String phone,String email,String pass) async
  {

    su_validatemail(email);
    su_validatepass(pass);
    su_validatephone(phone);
    su_validatename(name);
    notifyListeners();
  }
  Future<void>su_validatename(String name) async {
    if(name.isEmpty)
    {
      sunamemsg="Enter your full name..!";
    }
    else{
      sunamemsg="";
      suname=name;

    }
    notifyListeners();
  }
  Future<void>su_validatemail(String email) async {
    if(email.isEmpty)
    {
      suemailmsg="Enter your email..!";
    }
    else
    {
      suemailmsg="";
      suemail=email;
    }
    notifyListeners();
  }
  Future<void>su_validatepass(String pass) async {
    if ( pass.isEmpty) {

      supassmsg="Enter your password..!";
    }
    else
    {
      supassmsg="";
      supass=pass;
    }
    notifyListeners();
  }
  Future<void>su_validatephone(String Phone) async {
    if ( Phone.isEmpty) {

      suphonemsg="Enter your phone number..!";
    }
    else
    {
      suphonemsg="";
      phone=Phone;
    }
    notifyListeners();
  }
  Future<void> logout()async
  {
    final prefs = await SharedPreferences.getInstance();
    await prefs.remove('my_user');
    navigatorKey.currentState!.pushAndRemoveUntil(
        MaterialPageRoute(builder: (context) => Login_Screen()),
  (Route<dynamic> route) => false);




  }



}
