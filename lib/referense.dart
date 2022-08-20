import 'package:flutter/material.dart';
import 'package:url_launcher/url_launcher.dart';


class Category_data{
  Category_data(@required this.img_link,@required this.category,@required this.id);
  final String img_link;
  final String category;
  final  String id;
}

List<Category_data>list_of_categories=[
  Category_data("https://student.valuxapps.com/storage/uploads/categories/16445230161CiW8.Light%20bulb-amico.png","Lighting tools", "40"),
  Category_data("https://student.valuxapps.com/storage/uploads/categories/16445270619najK.6242655.jpg","Sport", "42"),
  Category_data("https://student.valuxapps.com/storage/uploads/categories/1630142480dvQxx.3658058.jpg","Corona fight", "43"),

  Category_data("https://student.valuxapps.com/storage/uploads/categories/16301438353uCFh.29118.jpg","Electronic Devices", "44"),
  Category_data( "https://student.valuxapps.com/storage/uploads/categories/1644527120pTGA7.clothes.png","Clothes", "46"),

];


List<String>Baners=[
  "https://student.valuxapps.com/storage/uploads/banners/1619472351ITAM5.3bb51c97376281.5ec3ca8c1e8c5.jpg",
  "https://student.valuxapps.com/storage/uploads/banners/1619472116OYHxC.45b7de97376281.5ec3ca8c1d324.jpg",
  "https://student.valuxapps.com/storage/uploads/banners/1626544896muQ0Q.best-deal-promotional-ribbon-style-green-banner-design_1017-27469.jpg",
  "https://student.valuxapps.com/storage/uploads/banners/1626545208UfigP.golden-coin-money-cashback-promotion-ecommerce-poster-banner-template-blue-background-216757528.jpg",
  "https://student.valuxapps.com/storage/uploads/banners/16283378549Vinn.banner foods@2x.png",
  "https://student.valuxapps.com/storage/uploads/banners/1641000123OrbOP.BALCK-White-FRIDAY-AR21112019.jpg",
  "https://student.valuxapps.com/storage/uploads/banners/1641000140NnSq9.black-friday-cyber-monday-sales.jpg",
  "https://student.valuxapps.com/storage/uploads/banners/1641000163w2k1O.انطلاق-عروض-الجمعة-السوداء-Black-Friday-على-متجر-TomTop.jpg",
  "https://student.valuxapps.com/storage/uploads/banners/1648845777FC4nO.IMG-20220324-WA0010.jpg",


];
Future<void>Launch_link(String link)async{
  var urlink=link;
  if(await canLaunch((urlink))){
    await launch (urlink);
  }
  else{
    await launch (urlink);
  }
}

