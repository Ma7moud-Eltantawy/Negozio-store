import 'package:flutter/material.dart';

class prov_product_info with ChangeNotifier{

  int active_point=0;
  void change_active(int num)
  {
    active_point=num;
    notifyListeners();
  }
}