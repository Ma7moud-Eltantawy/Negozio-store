import 'dart:io';

import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';

class Change_data_prov with ChangeNotifier{
  bool  showdata=true;
  bool  su_showdata=true;
  bool  showdata2=true;
  bool  showdata3=true;
  File? imgfile;
  File? imgfile2;
  Pickimagefromsource(ImageSource source) async
  {
    final ImagePicker _picker = ImagePicker();
    final pickedFile = await _picker.pickImage(source: source);
    imgfile=File(pickedFile!.path);
    print(imgfile!.path);

    notifyListeners();

  }
  Pickimagefromsource2(ImageSource source) async
  {
    final ImagePicker _picker = ImagePicker();
    final pickedFile = await _picker.pickImage(source: source);
    imgfile2=File(pickedFile!.path);


    notifyListeners();

  }
  void changeshow(bool data)
  {
    showdata=!data;
    notifyListeners();
  }
  void change2show(bool data)
  {
    showdata2=!data;
    notifyListeners();
  }
  void change3show(bool data)
  {
    showdata3=!data;
    notifyListeners();
  }
  void changesignupshow(bool data)
  {
    su_showdata=!data;
    notifyListeners();
  }
}