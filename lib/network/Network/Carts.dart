import 'dart:convert';

import 'package:flutter/material.dart';

import 'package:flutter/material.dart';
import 'dart:io';
import 'package:http/http.dart' as http;
import 'package:http/http.dart';
import 'package:negozio_store/main.dart';
import 'package:negozio_store/network/models/Carts_model.dart';
import 'package:negozio_store/network/models/cart_model.dart';
import 'package:negozio_store/network/models/product_model.dart';


class Carts_prov with ChangeNotifier{


  Future<carts_model> get_Carts()
  async {


    var headers = {
      'lang': 'en',
      'Content-Type': 'application/json',
      'Authorization': '$authkey'
    };

    var request = http.Request('GET', Uri.parse('https://student.valuxapps.com/api/carts'));
    request.headers.addAll(headers);
    http.StreamedResponse response = await request.send();

    if (response.statusCode == 200) {
      var res=await http.Response.fromStream(response);
      // print(res.body);
      var js=json.decode(res.body);
      carts_model data = carts_model.fromJson(js);




      notifyListeners();

      return data;


    }
    else {
      print(response.reasonPhrase);
      return carts_model();
    }


  }



  Future<void> update_cart(int id,int quantity)
  async {

    var headers = {
      'lang': 'en',
      'Content-Type': 'application/json',
      'Authorization': '$authkey'
    };
    var request = http.Request('PUT', Uri.parse('https://student.valuxapps.com/api/carts/$id'));
    request.body = json.encode({
      "quantity": quantity
    });
    request.headers.addAll(headers);

    http.StreamedResponse response = await request.send();

    if (response.statusCode == 200) {
      print(await response.stream.bytesToString());
    }
    else {
      print(response.reasonPhrase);
    }

  }


  Future<void> add_delete_cart(String id,int quant)
  async {

    var headers = {
      'lang': 'ar',
      'Content-Type': 'application/json',
      'Authorization': '$authkey',
    };
    var request = http.Request('POST', Uri.parse('https://student.valuxapps.com/api/carts'));
    request.body = json.encode({
      "quantity": quant,
      "product_id": id
    });
    request.headers.addAll(headers);

    http.StreamedResponse response = await request.send();

    if (response.statusCode == 200) {
      print(await response.stream.bytesToString());
    }
    else {
      print(response.reasonPhrase);
    }


  }
}