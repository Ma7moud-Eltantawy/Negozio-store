import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:negozio_store/styles/icons.dart';
import 'package:provider/provider.dart';

import 'Prov_location.dart';

class Loc_Screen extends StatefulWidget {

  static const scid="loc";

  Loc_Screen({Key? key}) : super(key: key);

  @override
  _Loc_ScreenState createState() => _Loc_ScreenState();
}

class _Loc_ScreenState extends State<Loc_Screen> {
  late String searchAdd;
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
  }
  @override
  Widget build(BuildContext context) {

    var size=MediaQuery.of(context).size;
    var height=size.height;
    var width =size.width;
    return SafeArea(
      child: Scaffold(

        body: Stack(
          children: [
            FutureBuilder(
              future: Provider.of<Prov_loc>(context,listen: false). getCurrentLocation(),
              builder:(context,snapshot)=>snapshot.hasData?
              Consumer<Prov_loc>(
                builder:(ctx,pr,ch)=> GoogleMap(
                  markers:pr.markers.values.toSet(),
                  onMapCreated: Provider.of<Prov_loc>(context,listen: false).onMapCreated,
                  initialCameraPosition:
                  CameraPosition(target:Provider.of<Prov_loc>(context,listen: false).currentLatLng, zoom: 15.0),
                  mapType: pr.type,
                  onTap: (val){
                    print(val);
                    pr.change_currentlocation(val);
                  },
                  onLongPress:(val) => showDialog(
                    context: context,
                    builder: (BuildContext context) =>
                        AlertDialog(
                          actions: <Widget>[
                            Center(
                              child: Column(
                                children: [
                                  Text(
                                      'Change Map type !',
                                    style: TextStyle(
                                      color: Colors.red,
                                      fontSize: width/22,
                                      fontFamily: 'varela'
                                    ),

                                  ),

                                  TextButton(
                                    onPressed: () {
                                      pr.change_maptype(MapType.normal);
                                      Navigator.pop(context);

                                    },
                                    child: Row(
                                      mainAxisAlignment:
                                      MainAxisAlignment.center,
                                      children: [
                                        Image.asset(
                                          "assets/img/map3.png",
                                          height: height/15,
                                          width: width/12,
                                        ),
                                        SizedBox(
                                          width: 10.0,
                                        ),
                                        Text('Normal'),
                                      ],
                                    ),
                                  ),
                                  TextButton(
                                    onPressed: () {
                                      pr.change_maptype(MapType.hybrid);
                                      Navigator.pop(context);

                                    },
                                    child: Row(
                                      mainAxisAlignment:
                                      MainAxisAlignment.center,
                                      children: [
                                        Image.asset(
                                          "assets/img/map1.png",
                                          height: height/15,
                                          width: width/12,
                                        ),
                                        SizedBox(
                                          width: 10.0,
                                        ),
                                        Text('Satellite'),
                                      ],
                                    ),
                                  ),
                                  TextButton(
                                    onPressed: () {
                                      pr.change_maptype(MapType.terrain);
                                      Navigator.pop(context);
                                    },
                                    child: Row(
                                      mainAxisAlignment:
                                      MainAxisAlignment.center,
                                      children: [
                                        Image.asset(
                                          "assets/img/map2.png",
                                          height: height/15,
                                          width: width/12,
                                        ),
                                        SizedBox(
                                          width: 10.0,
                                        ),
                                        Text('Terrain'),
                                      ],
                                    ),
                                  ),
                                ],
                              ),
                            )
                          ],
                        ),
                  ),
                ),
              ):Container(
                  height: height,
                  width: width,
                  color: Colors.white,
                  child: const Center(child: CircularProgressIndicator())),
            ),
            Positioned(
              top: height/2200,
              left: width/800,
              child: GestureDetector(
                onTap: ()async{
                  Navigator.of(context).pop();
                },
                child: Card(
                  shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(100.0)),
                  elevation: 5,

                  child: const CircleAvatar(
                    backgroundColor: Colors.white,
                    child: Icon(Icons.navigate_before,size: 20,),
                  ),
                ),
              ),
            ),
            Positioned(
                bottom: height/5.5,
                right: width/60,



                child: GestureDetector(
                  onTap: (){
                    Provider.of<Prov_loc>(context,listen: false).mylocationnavigate();
                  },
                  child: Card(
                    color: Colors.red,
                    child: Container(

                        height: height/20,
                        width: width/8.8,
                        child:
                        Icon(Icons.my_location_outlined, size: 16,color: Colors.white,)

                    ),
                  ),
                )
            ),



            Consumer<Prov_loc>(
              builder:(context,pr,ch)=> Positioned(
                  bottom: height/8,
                  right: width/60,



                  child: GestureDetector(
                    onTap: () => showDialog(
                          context: context,
                          builder: (BuildContext context) =>
                          AlertDialog(
                            actions: <Widget>[
                              Center(
                                child: Column(
                                  children: [
                                    Text(
                                      'Change Map type !',
                                      style: TextStyle(
                                          color: Colors.red,
                                          fontSize: width/22,
                                          fontFamily: 'varela'
                                      ),

                                    ),

                                    TextButton(
                                      onPressed: () {
                                        pr.change_maptype(MapType.normal);
                                        Navigator.pop(context);

                                      },
                                      child: Row(
                                        mainAxisAlignment:
                                        MainAxisAlignment.center,
                                        children: [
                                          Image.asset(
                                            "assets/img/map3.png",
                                            height: height/15,
                                            width: width/12,
                                          ),
                                          SizedBox(
                                            width: 10.0,
                                          ),
                                          Text('Normal'),
                                        ],
                                      ),
                                    ),
                                    TextButton(
                                      onPressed: () {
                                        pr.change_maptype(MapType.hybrid);
                                        Navigator.pop(context);

                                      },
                                      child: Row(
                                        mainAxisAlignment:
                                        MainAxisAlignment.center,
                                        children: [
                                          Image.asset(
                                            "assets/img/map1.png",
                                            height: height/15,
                                            width: width/12,
                                          ),
                                          SizedBox(
                                            width: 10.0,
                                          ),
                                          Text('Satellite'),
                                        ],
                                      ),
                                    ),
                                    TextButton(
                                      onPressed: () {
                                        pr.change_maptype(MapType.terrain);
                                        Navigator.pop(context);
                                      },
                                      child: Row(
                                        mainAxisAlignment:
                                        MainAxisAlignment.center,
                                        children: [
                                          Image.asset(
                                            "assets/img/map2.png",
                                            height: height/15,
                                            width: width/12,
                                          ),
                                          SizedBox(
                                            width: 10.0,
                                          ),
                                          Text('Terrain'),
                                        ],
                                      ),
                                    ),
                                  ],
                                ),
                              )
                            ],
                          ),),
                    child: Card(
                      color: Colors.white,
                      child: Container(

                          height: height/20,
                          width: width/8.8,
                          child:
                          Icon(Icons.map_outlined, size: 18,color: Colors.black,)

                      ),
                    ),
                  )
              ),
            ),





            Positioned(

              top: height/12,
              right: width/18,
              left: width/18,
              child: Opacity(
                opacity: .8,
                child: Container(
                  height: 50,
                  width: double.infinity,
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(10),
                    color: Colors.white,
                  ),
                  child: TextField(
                    textAlignVertical: TextAlignVertical.center,
                    textAlign: TextAlign.left,
                    decoration: InputDecoration(
                      suffixIcon:IconButton(
                        icon: const Icon(Icons.search),
                        onPressed: (){
                          Provider.of<Prov_loc>(context,listen: false).searchnavigate(searchAdd);
                        },
                        iconSize: width/15,
                      ),
                      hintText: 'Enter place name',

                      border: InputBorder.none,
                      contentPadding: EdgeInsets.only(
                        left: width/50,

                      ),
                    ),
                    onChanged: (val) {
                      setState(() {
                        searchAdd = val;
                      });
                    },
                  ),
                ),
              ),
            ),
          ],
        ),

      ),
    );
  }





}

