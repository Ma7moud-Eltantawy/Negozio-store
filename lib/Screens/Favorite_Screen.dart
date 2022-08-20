import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:negozio_store/Providers/Shared_pref.dart';
import 'package:negozio_store/Screens/profile_screen.dart';
import 'package:negozio_store/network/Network/Product_data.dart';
import 'package:negozio_store/network/models/Fav_model.dart';
import 'package:negozio_store/styles/Local_Styles.dart';
import 'package:negozio_store/widgets/circular_progress.dart';
import 'package:provider/provider.dart';

import '../styles/icons.dart';

import 'package:flutter/material.dart';

class Favorite_Screen extends StatefulWidget {
  const Favorite_Screen({Key? key}) : super(key: key);
  static const scid="Fav_screen";
  @override
  _Favorite_Screen createState() => new _Favorite_Screen();
}

class _Favorite_Screen extends State<Favorite_Screen> {

  @override
  Widget build(BuildContext context) {
    return Consumer<shared_pref_prov>(
      builder:(context,prov,ch)=> new Scaffold(
        backgroundColor: Colors.white,
        appBar: AppBar(
          elevation: 0,
          centerTitle: true,
          title: Text(
            "Favourites",
            style: TextStyle(
                color: local_green
            ),
          ),
          backgroundColor: Colors.white,
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
                onTap: (){
                  Navigator.of(context).pushNamed(Myprofile_screen.scid);
                },
                child: CircleAvatar(
                  radius: 24,
                  backgroundColor: local_green,
                  child: CircleAvatar(
                    backgroundColor: Colors.white,
                    radius: 22.5,
                    child: CachedNetworkImage(
                      imageUrl:Provider.of<shared_pref_prov>(context,listen: false).user_data!.data!.image.toString(),
                      placeholder: (context, url) => Center(
                          child: CircularProgressIndicator(
                            color: local_green,
                            strokeWidth: 1.5,
                          )),
                      errorWidget: (context, url, error) => Icon(
                        Icons.error,
                        color: local_green,
                      ),
                      imageBuilder: (context, imageProvider) => CircleAvatar(
                        backgroundImage: imageProvider,
                        radius: 21,
                      ),
                    ),
                  ),
                ),
              ),
            ),
          ],
        ),
        body: LocalGalleryTab(),
      ),
    );
  }
}

class LocalGalleryTab extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    return _LocalGalleryState();
  }
}

class _LocalGalleryState extends State<LocalGalleryTab> {
  @override
  Widget build(BuildContext context) {
    return new Container(child: new Center(
      child: new RefreshIndicator(
        child: buildItem(),
        onRefresh: _refreshLocalGallery,
      ),
    ));
  }





  buildItem() {
    return StreamBuilder(
      stream: Provider.of<Products_prov>(context,listen: false).get_fav_products().asStream(),
      builder:(context,AsyncSnapshot<List<favorite_model>>snapshot)=> !snapshot.hasData?
          Center(child: progress_indicator(),)
          :ListView.builder(

        padding: const EdgeInsets.only(top: 15.0),
        physics: BouncingScrollPhysics(),
        itemCount: snapshot.data!.length,
        itemBuilder: (context, index) => Padding(
          padding: const EdgeInsets.only(left: 15.0, right: 15.0, bottom: 15.0),
          child: InkWell(
            onTap: () {

            },
            child: Container(
              width: double.infinity,
              height: 105,
              clipBehavior: Clip.antiAlias,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(8.0),
                color: Colors.grey[50],
              ),
              child: Padding(
                padding: const EdgeInsets.all(10.0),
                child: Row(
                  children: [
                    Container(
                      clipBehavior: Clip.antiAlias,
                      decoration: BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.circular(8.0),
                      ),
                      width: 90,
                      height: double.infinity,
                      child: CachedNetworkImage(
                        imageUrl:snapshot.data![index].product!.image.toString(),
                        fit: BoxFit.cover,
                        progressIndicatorBuilder:
                            (context, url, downloadProgress) => Center(
                          child: CircularProgressIndicator(
                            strokeWidth: 1.5,
                          ),
                        ),
                        errorWidget: (context, url, error) => Icon(
                          Icons.error,
                          color: local_green,
                        ),
                      ),
                    ),
                    SizedBox(
                      width: 10.0,
                    ),
                    Expanded(
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            snapshot.data![index].product!.name.toString(),
                            style: TextStyle(fontSize: 14),
                            overflow: TextOverflow.ellipsis,
                            maxLines: 2,
                          ),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Text(
                                '${snapshot.data![index].product!.price.toString()} EGP',
                                style: TextStyle(
                                  color: local_green,
                                  fontSize: 12,
                                ),
                              ),
                              InkWell(
                                onTap: () {

                                },
                                child: Icon(
                                  IconBroken.Heart,
                                  color: Colors.red,
                                ),
                              ),
                            ],
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }


  Future<Null> _refreshLocalGallery() async{
    return Future.delayed(
      Duration(seconds: 1),
          () {

        setState(() {
          print("refresh");

        });



        // showing snackbar

      },
    );

  }
}







