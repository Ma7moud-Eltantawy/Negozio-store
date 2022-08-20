import 'dart:convert';

import 'package:flutter/material.dart';

import 'package:flutter/material.dart';
import 'dart:io';
import 'package:http/http.dart' as http;
import 'package:http/http.dart';
import 'package:negozio_store/main.dart';
import 'package:negozio_store/network/models/Categories.dart';
import 'package:negozio_store/network/models/Fav_model.dart';
import 'package:negozio_store/network/models/product_model.dart';


class Category_prov with ChangeNotifier{


  Future<Categories_model> get_categories()
  async {

    var headers = {
      'lang': 'en',

    };
    var request = http.Request('GET', Uri.parse('https://student.valuxapps.com/api/categories'));
    request.headers.addAll(headers);

    http.StreamedResponse response = await request.send();

    if (response.statusCode == 200) {
      var res=await http.Response.fromStream(response);
      // print(res.body);
      var js=json.decode(res.body);
      Categories_model data =await Categories_model.fromJson(js);
      notifyListeners();
      return data;
    }
    else {
      print(response.reasonPhrase);
      return Categories_model();
    }


  }

}