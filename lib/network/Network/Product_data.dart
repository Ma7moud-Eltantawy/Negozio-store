import 'dart:convert';

import 'package:flutter/material.dart';

import 'package:flutter/material.dart';
import 'dart:io';
import 'package:http/http.dart' as http;
import 'package:http/http.dart';
import 'package:negozio_store/main.dart';
import 'package:negozio_store/network/models/Fav_model.dart';
import 'package:negozio_store/network/models/product_model.dart';


class Products_prov with ChangeNotifier{
  var filter_min=0;
  var filter_max=1000;
  var slidermin=0;
  var slider_max=1000000;
  var filtering_min=0;
  var filtering_max=0;
  List<product_model> Serch_list=[];
  void change_min_max(int start,int end)
  {
    filter_min=start;
    filter_max=end;
    notifyListeners();
  }
  void confirm_slider(int start,int end)
  {
    filtering_min=start;
    filtering_max=end;
    notifyListeners();
  }


Future<List<product_model>> get_products()
async {

  var headers = {
    'lang': 'en',
    'Content-Type': 'application/json',
    'Authorization': '$authkey'
  };
  var request = http.Request('GET', Uri.parse('https://student.valuxapps.com/api/products'));
  request.headers.addAll(headers);

  http.StreamedResponse response = await request.send();

  if (response.statusCode == 200) {
    var res=await http.Response.fromStream(response);
   // print(res.body);
   var js=json.decode(res.body)["data"]["data"];
   List<product_model> pr=[];
   for(var x in js)
   {

     try{
       product_model data =await product_model.fromJson(x);
       pr.add(data);
     }
     catch(e)
        {
          print(e);
        }

    // print(pr.length);
     Serch_list=pr;

   }
   filter_min=pr[0].price;
   filter_max=pr[0].price;
   for(var y in pr)
     {
      if(y.price>filter_max)
        {
          filter_max=y.price;
          filtering_max=y.price;
        }
      if(y.price<filter_min)
      {
        filter_min=y.price;
        filtering_min=y.price;
      }

     }
   print(filter_min);




   notifyListeners();

    return pr;


  }
  else {
    print(response.reasonPhrase);
    return [];
  }


}



Future<product_model> get_product_details(int id)
async {

  var headers = {
    'lang': 'en',
    'Content-Type': 'application/json',
    'Authorization': '$authkey'
  };
  var request = http.Request('GET', Uri.parse('https://student.valuxapps.com/api/products/$id'));
  request.headers.addAll(headers);

  http.StreamedResponse response = await request.send();

  if (response.statusCode == 200) {
    var res=await http.Response.fromStream(response);
    // print(res.body);
    var js=json.decode(res.body)["data"];
    product_model data =await product_model.fromJson(js);
    return data;

  }
  else {
    print(response.reasonPhrase);
    return product_model();
  }


}

  Future<List<favorite_model>> get_fav_products()
  async {

    var headers = {
      'lang': 'en',
      'Content-Type': 'application/json',
      'Authorization': '$authkey'
    };
    var request = http.Request('GET', Uri.parse('https://student.valuxapps.com/api/favorites'));
    request.headers.addAll(headers);
    http.StreamedResponse response = await request.send();

    if (response.statusCode == 200) {
      var res=await http.Response.fromStream(response);
      // print(res.body);
      var js=json.decode(res.body)["data"]["data"];
      List<favorite_model> pr=[];
      for(var x in js)
      {

        try{
          favorite_model data =await favorite_model.fromJson(x);
          pr.add(data);
        }
        catch(e)
        {
          print(e);
        }

      }

      notifyListeners();

      return pr;


    }
    else {
      print(response.reasonPhrase);
      return [];
    }


  }


  Future<List<product_model>> get_category_product(int Cat_id)
  async {

    var headers = {
      'lang': 'en',
      'Content-Type': 'application/json',
      'Authorization': '$authkey'
    };
    var request = http.Request('GET', Uri.parse('https://student.valuxapps.com/api/categories/$Cat_id'));
    request.headers.addAll(headers);

    http.StreamedResponse response = await request.send();

    if (response.statusCode == 200) {

      var res=await http.Response.fromStream(response);
      print(res.body);
      var js=json.decode(res.body)["data"]["data"];
      List<product_model> pr=[];
      for(var x in js)
      {

        try{
          product_model data =await product_model.fromJson(x);
          pr.add(data);
        }
        catch(e)
        {
          print(e);
        }

        print(pr[0].name);

      }

      var num=pr[0].price;

      filter_min=num.toInt();
      filter_max=num.toInt();

      for(var y in pr)
      {
        if(y.price>filter_max)
        {
          var x=y.price;
          filter_max=x.toInt();
        }
        if(y.price<filter_min)
        {
          var x=y.price;
          filter_min=x.toInt();
        }

      }
      print(filter_min);
      print(filter_max);



      notifyListeners();

      return pr;


    }
    else {
      print(response.reasonPhrase);
      return [];
    }


  }


  Future<void> Add_delete_fav(String prouct_id)
  async {

    var headers = {
      'lang': 'en',
      'Content-Type': 'application/json',
      'Authorization': '$authkey'
    };

    var request = http.Request('POST', Uri.parse('https://student.valuxapps.com/api/favorites'));
    request.body = json.encode({
      "product_id": prouct_id
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