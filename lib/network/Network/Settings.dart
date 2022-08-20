import 'dart:convert';

import 'package:flutter/material.dart';

import 'package:flutter/material.dart';
import 'dart:io';
import 'package:http/http.dart' as http;
import 'package:http/http.dart';
import 'package:negozio_store/network/models/faq_model.dart';
import 'package:negozio_store/network/models/product_model.dart';

import '../../main.dart';


class Settings_prov with ChangeNotifier{
  Map<int,dynamic> Faqs={

  };

  Future<List<Faq_model>> get_faqs()
  async {


    var headers = {
      'lang': 'en',
      'Content-Type': 'application/json',
      'Authorization': '$authkey',
    };
    var request = http.Request('GET', Uri.parse('https://student.valuxapps.com/api/faqs'));
    request.headers.addAll(headers);

    http.StreamedResponse response = await request.send();

    if (response.statusCode == 200) {
      var res=await http.Response.fromStream(response);
      // print(res.body);
      var js=json.decode(res.body)["data"]["data"];
      List<Faq_model> pr=[];
      for(var x in js)
      {

        try{
          Faq_model data =await Faq_model.fromJson(x);

          pr.add(data);

          Faqs.putIfAbsent(data.id!, (){
            return false;
          } );



        }
        catch(e)
        {
          print(e);
        }






      }
      print(Faqs.keys);



      return pr;


    }
    else {
      print(response.reasonPhrase);
      return [];
    }


  }

  void faqstate(int id,bool state)
  {


    Faqs.update(id, (value) => state);
    print(Faqs[id]);
    notifyListeners();
  }


}