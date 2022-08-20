



import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:negozio_store/main.dart';
import 'package:negozio_store/network/models/usermodel.dart';
import 'package:shared_preferences/shared_preferences.dart';


class shared_pref_prov with ChangeNotifier
{
  usermodel?user_data;
  Future <void >user_db(dynamic jsonuserdata)async{

    final prefs = await SharedPreferences.getInstance();
    await prefs.clear();
    String user = await jsonEncode(jsonuserdata);
    print(user);
    print("---------------------------------");
    await prefs.setString('my_user',json.encode(user));



    notifyListeners();
  }
  Future<void> get_db()async{

    final prefs = await SharedPreferences.getInstance();
    var jsonuserdata = await jsonDecode(prefs.getString('my_user').toString());

    print(jsonuserdata);
    var user =await usermodel.fromJson(json.decode(jsonuserdata));
    user_data=user;
    authkey=user.data!.token;

    print("-------------------------------------");
    print(user_data!.data!.phone);


    notifyListeners();
  }

}







