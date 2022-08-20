import 'package:flutter/material.dart';

Color local_green=Color.fromRGBO(24, 82, 66, 1);

OutlineInputBorder focusedBorder = OutlineInputBorder(
  borderRadius: BorderRadius.circular(8.0),
  borderSide: BorderSide(
    width: 1.3,
    color:  Color.fromRGBO(39, 140, 111, 1),
  ),
);

OutlineInputBorder enabledBorder =  OutlineInputBorder(
  borderRadius: BorderRadius.circular(8.0),
  borderSide: BorderSide(
    width: 1.3,
    color: local_green,
  ),
);

