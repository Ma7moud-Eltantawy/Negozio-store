import 'dart:convert';

import 'package:flutter/material.dart';

import 'package:flutter/material.dart';
import 'dart:io';
import 'package:http/http.dart' as http;
import 'package:http/http.dart';
import 'package:negozio_store/main.dart';
import 'package:negozio_store/network/models/Carts_model.dart';
import 'package:negozio_store/network/models/cart_model.dart';
import 'package:negozio_store/network/models/ordermodel.dart';
import 'package:negozio_store/network/models/orders_model.dart';
import 'package:negozio_store/network/models/product_model.dart';


class Orders_prov with ChangeNotifier{
  Future<void> Add_order(int adderess_id)
  async {

    var headers = {
      'lang': 'en',
      'Content-Type': 'application/json',
      'Authorization': '$authkey'
    };

    var request = http.Request('POST', Uri.parse('https://student.valuxapps.com/api/orders'));
    request.body = json.encode({
      "address_id": adderess_id,
      "payment_method": 1,
      "use_points": false,
      "promo_code_id": null
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

  Future<orders_model> get_orders()
  async {

    var headers = {
      'lang': 'en',
      'Content-Type': 'application/json',
      'Authorization': '$authkey'
    };
    print("a7aaaa");

    var request = http.Request('GET', Uri.parse('https://student.valuxapps.com/api/orders'));
    request.headers.addAll(headers);
    http.StreamedResponse response = await request.send();
    print("a7aaaa");

    if (response.statusCode == 200) {
      var res=await http.Response.fromStream(response);
      // print(res.body);
      print(res.body);
      var js=json.decode(res.body);
      orders_model data = orders_model.fromJson(js);
      print(data.data!.total);




      notifyListeners();
      print(data.data!.data!.length);

      return data;


    }
    else {
      print(response.reasonPhrase);
      return orders_model();
    }


  }


  Future<void> cancel_order(int id)
  async {

    var headers = {
      'lang': 'en',
      'Content-Type': 'application/json',
      'Authorization': '$authkey'
    };

    var request = http.Request('GET', Uri.parse('https://student.valuxapps.com/api/orders/$id/cancel'));
    request.headers.addAll(headers);
    http.StreamedResponse response = await request.send();

    if (response.statusCode == 200) {
      var res=await http.Response.fromStream(response);
       print(res.body);
      notifyListeners();

    }
    else {
      print(response.reasonPhrase);

    }


  }







}