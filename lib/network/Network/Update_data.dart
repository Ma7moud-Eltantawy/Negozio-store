import 'dart:convert';
import 'dart:io';

import 'package:email_auth/email_auth.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:image_picker/image_picker.dart';
import 'package:negozio_store/main.dart';
import 'package:negozio_store/network/models/usermodel.dart';

class Update_data_prov with ChangeNotifier{

  var authjson;
  Future <usermodel> Update_data({required String name, required String email,required File imgfile,
    required String phone}) async
  {
    File profileImage = File(imgfile.path);
    List<int> imageBytes = profileImage.readAsBytesSync();
    String base64Image = base64Encode(imageBytes);
    print(imgfile.path);
    var headers = {
      'lang': 'en',
      'Content-Type': 'application/json',
      'Authorization': '$authkey'
    };
    var request = http.Request('PUT', Uri.parse('https://student.valuxapps.com/api/update-profile'));
    request.body = json.encode({
      "name": name,
      "phone": phone,
      "email": email,
      "image":  base64Image,
    });
/*

    var headers = {
      'lang': 'en',
      'Content-Type': 'application/json',
      'Authorization': '$authkey'
    };

    var request = http.MultipartRequest(
        'PUT', Uri.parse('https://student.valuxapps.com/api/update-profile'));
    request.fields.addAll({
      "name": "tantawy2",
      "phone": "1234567812011",
      "email": "tantawy@gmail.com",
      "password": "123123",
      "image": null
    });
    //request.files.add(await http.MultipartFile.fromPath('image', imgfile.path));*/
    request.headers.addAll(headers);
    http.StreamedResponse response = await request.send();

    if (response.statusCode == 200) {
      var res = await http.Response.fromStream(response);
      usermodel user=usermodel.fromJson(json.decode(res.body));
      print(res.body);
      authjson = json.decode(res.body);
      notifyListeners();
      return user;
    }
    else {
      print(response.reasonPhrase);
      return usermodel();
    }
  }
  Future<Map<String,dynamic>> Changepassword(var current_pass,var new_pass)async
  {
    var headers = {
      'lang': 'en',
      'Content-Type': 'application/json',
      'Authorization': '$authkey'
    };
    var request = http.Request('POST', Uri.parse('https://student.valuxapps.com/api/change-password'));
    request.body = json.encode({
      "current_password": current_pass,
      "new_password": new_pass
    });
    request.headers.addAll(headers);

    http.StreamedResponse response = await request.send();

    if (response.statusCode == 200) {
      var res = await http.Response.fromStream(response);
      var js=json.decode(res.body);
      print(res.body);
      return {"status":js["status"], "message":js["message"]};
    }
    else {
      print(response.reasonPhrase);
      return{};
    }

  }

}