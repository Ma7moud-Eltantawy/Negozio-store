import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:negozio_store/Screens/product_info.dart';
import 'package:negozio_store/network/Network/Product_data.dart';
import 'package:negozio_store/network/models/product_model.dart';
import 'package:negozio_store/styles/icons.dart';
import 'package:negozio_store/widgets/bottom_sheet.dart';
import 'package:negozio_store/widgets/circular_progress.dart';
import 'package:provider/provider.dart';

import '../Providers/Shared_pref.dart';
import '../styles/Local_Styles.dart';

class products_grid extends StatefulWidget {
  const products_grid({Key? key, required this.getdatafunc}) : super(key: key);

  final Function getdatafunc;

  @override
  State<products_grid> createState() => _products_gridState();
}

class _products_gridState extends State<products_grid> {

  @override
  Widget build(BuildContext context) {

    var size=MediaQuery.of(context).size;
    var height=size.height;
    var width=size.width;
    return Consumer<shared_pref_prov>(
      builder:(context,prov,ch)=>Scaffold(
        appBar: AppBar(
          centerTitle: true,
          title: Text(

            'Products',
            style: TextStyle(
                color: local_green
            ),
          ),
          backgroundColor: Colors.white,
          elevation: 0,
          leading: IconButton(
            icon: Icon(
              IconBroken.Arrow___Left_2,
              color: local_green,
              size: 35,
            ),
            onPressed: () {
              Navigator.pop(context);
            },
          ),
          actions: [
            Padding(
              padding: const EdgeInsets.only(
                right: 10,
              ),
              child: InkWell(
                onTap: () {

                },
                child: CircleAvatar(
                  radius: 24,
                  backgroundColor: local_green,
                  child: CircleAvatar(
                    backgroundColor: Colors.white,
                    radius: 22.5,
                    child: CachedNetworkImage(
                      imageUrl: prov.user_data!.data!.image.toString(),
                      placeholder: (context, url) =>
                          Center(
                              child: CircularProgressIndicator(
                                color: local_green,
                                strokeWidth: 1.5,
                              )),
                      errorWidget: (context, url, error) =>
                          Icon(
                            Icons.error,
                            color: local_green,
                          ),
                      imageBuilder: (context, imageProvider) =>
                          CircleAvatar(
                            backgroundImage: imageProvider,
                            radius: 21,
                          ),
                    ),
                  ),
                ),
              ),
            ),
          ],
          bottom:PreferredSize(
              preferredSize: Size.fromHeight(height/12), // here the desired height
              child: InkWell(
                onTap: (){
                  //Profile_bottom_sheet(context, height, width);
                  Filter_bottom_sheet(context, height, width);

                },
                child: Container(
                  margin: EdgeInsets.symmetric(horizontal: width/90,vertical: height/90) ,

                  height: height/16,
                  width: MediaQuery.of(context).size.width,
                  decoration: BoxDecoration(
                    color: Colors.grey[100],
                    borderRadius: BorderRadius.circular(8.0),
                  ),
                  child: Padding(
                    padding:
                     EdgeInsets.symmetric(horizontal: width/120,vertical: height/120),
                    child: Row(
                      mainAxisAlignment:
                      MainAxisAlignment.spaceBetween,
                      children: [



                        Text(
                          'feltering...',
                          style: TextStyle(color: local_green),
                        ),

                        Container(
                          width: 35,
                          height: 35,
                          decoration: BoxDecoration(
                            color: Colors.white,
                            borderRadius:
                            BorderRadius.circular(6.0),
                          ),
                          child: Icon(
                            IconBroken.Filter_2,
                            color: local_green,
                          ),
                        )
                      ],
                    ),
                  ),
                ),
              ),
          ),
        ),


        body: FutureBuilder(

          future: widget.getdatafunc(),
          builder: (context,AsyncSnapshot<List<product_model>>snapshot)=>!snapshot.hasData?Center(child: progress_indicator(),):Consumer<Products_prov>(
            builder:(context,prov,ch)=> GridView.builder(
                itemCount: snapshot.data!.where((element) => element.price<prov.filtering_max && element.price>prov.filtering_min ).length,
                gridDelegate:SliverGridDelegateWithMaxCrossAxisExtent(
                maxCrossAxisExtent: 200,
                childAspectRatio: 6 / 10,
                crossAxisSpacing: 10,
                mainAxisSpacing: 10
            ),
                itemBuilder:(context,index)=>
                    InkWell(
                            onTap: (){


                              Navigator.of(context).pushNamed(Product_info.scid,arguments:snapshot.data!.where((element) => element.price<prov.filtering_max && element.price>prov.filtering_min).toList()[index].id);

                            },
                            child:  Card(
                                child: Container(
                                      decoration: BoxDecoration(
                                      borderRadius: BorderRadius.circular(8.0),
                                      color: Colors.grey[50],
                                      ),
                                      child: Padding(
                                            padding: const EdgeInsets.all(8.0),
                                            child: Column(
                                            children: [
                                            Expanded(
                                            child: Container(
                                            width: MediaQuery.of(context).size.width,
                                            clipBehavior: Clip.antiAlias,
                                            decoration: BoxDecoration(
                                            borderRadius: BorderRadius.circular(8.0),
                                            ),
                                            child: CachedNetworkImage(
                                            fit: BoxFit.cover,
                                            imageUrl: snapshot.data!.where((element) => element.price<prov.filtering_max && element.price>prov.filtering_min ).toList()[index].image.toString(),

                                            placeholder: (context, url) => Center(
                                            child: CircularProgressIndicator(
                                              color: local_green,
                                            strokeWidth: 1.5,
                                            )),
                                            errorWidget: (context, url, error) => Icon(
                                            Icons.error,
                                            color: local_green,
                                            ),
                                            ),
                                            ),
                                            ),
                                            Padding(
                                            padding:  EdgeInsets.symmetric(vertical: width *0.1),
                                            child: Container(
                                            width: width/2.5,
                                            child: Text(
                                            softWrap: true,
                                            overflow: TextOverflow.ellipsis,
                                                snapshot.data!.where((element) => element.price<prov.filtering_max && element.price>prov.filtering_min ).toList()[index].name.toString(),
                                            maxLines: 2,
                                            style: TextStyle(
                                            //overflow: TextOverflow.ellipsis,
                                            ),
                                            ),
                                            ),
                                            ),
                                            Row(
                                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                            children: [
                                            Column(
                                            crossAxisAlignment: CrossAxisAlignment.start,
                                            children: [
                                            if(snapshot.data!.where((element) => element.price<prov.filtering_max && element.price>prov.filtering_min ).toList()[index].oldPrice!=snapshot.data!.where((element) => element.price<prov.filtering_max && element.price>prov.filtering_min ).toList()[index].price)
                                            Container(
                                            alignment: Alignment.centerLeft,
                                            width: width/6,
                                            child: Text(
                                            textAlign: TextAlign.left,
                                            textDirection: TextDirection.ltr,

                                            softWrap: true,
                                            overflow: TextOverflow.ellipsis,

                                            '${snapshot.data!.where((element) => element.price<prov.filtering_max && element.price>prov.filtering_min ).toList()[index].oldPrice} EGP',
                                            style: TextStyle(
                                            decoration: TextDecoration.lineThrough,
                                            color: local_green,
                                            fontSize: width/35,
                                            ),
                                            ),
                                            ),
                                            Container(
                                            width: width/5,
                                            child: Text(

                                            softWrap: true,
                                            overflow: TextOverflow.ellipsis,

                                            '${snapshot.data!.where((element) => element.price<prov.filtering_max && element.price>prov.filtering_min ).toList()[index].price} EGP',
                                            style: TextStyle(
                                            color: local_green,
                                            fontSize: width/32,
                                            ),
                                            ),
                                            ),
                                            ],
                                            ),
                                snapshot.data!.where((element) => element.price<prov.filtering_max && element.price>prov.filtering_min ).toList()[index].oldPrice!=snapshot.data!.where((element) => element.price<prov.filtering_max && element.price>prov.filtering_min ).toList()[index].price?
                                            Container(
                                            alignment: Alignment.center,
                                            height: height/25,
                                            width: width/11,
                                            decoration: BoxDecoration(
                                            image: DecorationImage(
                                            image: AssetImage("assets/img/dis.png"),
                                            fit: BoxFit.cover
                                            ),
                                            ),
                                            child: Column(
                                            mainAxisAlignment: MainAxisAlignment.center,
                                            children: [
                                            Text(
                                            "${100-(snapshot.data!.where((element) => element.price<prov.filtering_max && element.price>prov.filtering_min ).toList()[index].price/(snapshot.data!.where((element) => element.price<prov.filtering_max && element.price>prov.filtering_min ).toList()[index].oldPrice) * 100).toInt()} %",
                                            style: TextStyle(
                                            fontFamily: 'varela',
                                            fontSize: height/100,
                                            color: Colors.white
                                            ),
                                            ),
                                            Text(
                                            "OFF",
                                            style: TextStyle(
                                            fontFamily: 'varela',
                                            fontSize: height/100,
                                            color: Colors.white
                                            ),
                                            ),
                                            ],
                                            ),
                                            ):Container(),
                                            InkWell(
                                            onTap: (){
                                             prov.Add_delete_fav(snapshot.data!.where((element) => element.price<prov.filtering_max && element.price>prov.filtering_min).toList()[index].id.toString());
                                             setState(() {

                                             });

                                            },
                                            child: Icon(
                                            IconBroken.Heart,
                                            color:snapshot.data!.where((element) => element.price<prov.filtering_max && element.price>prov.filtering_min).toList()[index].inFavorites!?Colors.red: Colors.grey,
                                            ),
                                            ),
                                            ],
                                            ),
                                            ],
                                            ),
                                      ),
                                ),
                              ),

                            ),
        ),
          ),
      ),
      ),
    );
  }
}
