import 'package:alan_voice/alan_voice.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_staggered_grid_view/flutter_staggered_grid_view.dart';
import 'package:flutter_zoom_drawer/config.dart';
import 'package:negozio_store/Providers/Shared_pref.dart';
import 'package:negozio_store/Screens/All_products.dart';
import 'package:negozio_store/Screens/Search_Screen.dart';
import 'package:negozio_store/Screens/product_info.dart';
import 'package:negozio_store/Screens/profile_screen.dart';
import 'package:negozio_store/network/Network/Product_data.dart';
import 'package:negozio_store/styles/icons.dart';
import 'package:provider/provider.dart';

import '../main.dart';
import '../network/models/product_model.dart';
import '../referense.dart';
import '../styles/Local_Styles.dart';
import '../widgets/circular_progress.dart';
import '../widgets/drawer.dart';
import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter_custom_clippers/flutter_custom_clippers.dart';
class Home_screen extends StatefulWidget {
  const Home_screen({Key? key}) : super(key: key);
  static const scid="home_page";

  @override

  State<Home_screen> createState() => _Home_screenState();
}

class _Home_screenState extends State<Home_screen> {
  @override
  void initState() {
    try{
      FocusScopeNode currentFocus = FocusScope.of(context);
      currentFocus.dispose();
    }
    catch(e)
    {
      print(e);

    }

    AlanVoice.addButton(
        "e8655324bfc003d8959794f6683b755c2e956eca572e1d8b807a3e2338fdd0dc/stage",
        bottomMargin: 50,
        topMargin: 50,



        buttonAlign: AlanVoice.BUTTON_ALIGN_LEFT);
    AlanVoice.hideButton();


    AlanVoice.callbacks.add((command) => handleCommand(command.data));
    // TODO: implement initState
    super.initState();


  }
  @override
  void dispose() {
    try{
      FocusScopeNode currentFocus = FocusScope.of(context);
      currentFocus.dispose();
    }
    catch(e)
    {
      print(e);

    }

    super.dispose();

  }


  @override
  Widget build(BuildContext context) {


    return Consumer<shared_pref_prov>(
      builder:(context,prov,ch)=> Scaffold(

        backgroundColor: Colors.white,
        appBar: AppBar(
          elevation: 0,
          centerTitle: true,
          backgroundColor: Colors.white,
          leading: IconButton(
            icon:  Icon(
              IconBroken.Filter,
              size: 35,
              color: local_green,
            ),
            onPressed: () {
              z.open!();
            },
          ),
          actions: [
            InkWell(
              onTap: () {
                Navigator.of(context).pushNamed(Myprofile_screen.scid);

              },
              child: Padding(
                padding: const EdgeInsets.only(
                  right: 10,
                ),
                child: CircleAvatar(
                  radius: 24,
                  backgroundColor: local_green,
                  child: CircleAvatar(
                    backgroundColor: Colors.white,
                    radius: 22.5,
                    child: CachedNetworkImage(
                      imageUrl:
                      Provider.of<shared_pref_prov>(context,listen: false).user_data!.data!.image.toString(),
                      placeholder: (context, url) => Center(
                          child: CircularProgressIndicator(
                            strokeWidth: 1.5,
                          )),
                      errorWidget: (context, url, error) => Icon(
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
        ),
        body: SingleChildScrollView(
          child: Column(
            children: [

              Padding(
                padding: const EdgeInsets.only(
                    top: 10.0, left: 15.0, right: 15.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      'Hi, ${Provider.of<shared_pref_prov>(context,listen: false).user_data!.data!.name.toString()}!',
                      overflow: TextOverflow.ellipsis,
                      maxLines: 1,
                    ),
                    SizedBox(
                      height: 5.0,
                    ),
                    Text(
                      'Find Your Product',
                      style: TextStyle(fontSize: 20, color: local_green),
                    ),
                    SizedBox(
                      height: 15.0,
                    ),
                    InkWell(
                      onTap: (){
                        Navigator.of(context).pushNamed(Search_screen.scid);
                      },
                      child: Container(
                        height: 50,
                        width: MediaQuery.of(context).size.width,
                        decoration: BoxDecoration(
                          color: Colors.grey[50],
                          borderRadius: BorderRadius.circular(8.0),
                        ),
                        child: Padding(
                          padding:
                          const EdgeInsets.symmetric(horizontal: 8.0),
                          child: Row(
                            mainAxisAlignment:
                            MainAxisAlignment.spaceBetween,
                            children: [
                              Text(
                                'Search...',
                                style: TextStyle(color: Colors.grey),
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
                                  IconBroken.Search,
                                  color: local_green,
                                ),
                              )
                            ],
                          ),
                        ),
                      ),
                    ),
                    Padding(
                      padding:
                      const EdgeInsets.symmetric(vertical: 15.0),
                      child: Text(
                        'Offers',
                        style: TextStyle(fontWeight: FontWeight.bold),
                      ),
                    ),
                    Myslider(),

                    Padding(
                      padding:
                      const EdgeInsets.symmetric(vertical: 15.0),
                      child: Text(
                        'Categories',
                        style: TextStyle(fontWeight: FontWeight.bold),
                      ),
                    ),
                    Categories(),


                    Padding(
                      padding: const EdgeInsets.only(top: 15.0),
                      child: Row(
                        mainAxisAlignment:
                        MainAxisAlignment.spaceBetween,
                        children: [
                          Text(
                            'Most Popular',
                            style:
                            TextStyle(fontWeight: FontWeight.bold),
                          ),
                          GestureDetector(
                            onTap: (){
                              Navigator.of(context)
                                  .push(MaterialPageRoute(
                                builder: (context) => products_grid(getdatafunc:()=> Provider.of<Products_prov>(context,listen: false).get_products()),
                              ))
                                  .then((value) {
                                // you can do what you need here
                                // setState etc.
                              });

                            },
                            child: Text(
                              'See All',
                              style:
                              TextStyle(color: local_green, fontSize: 12),
                            ),
                          ),
                        ],
                      ),
                    ),


                    //BuildMostPopular(),
                  ],
                ),
              ),
              FutureBuilder(
                  future: Provider.of<Products_prov>(context,listen: false).get_products(),

                  builder:(BuildContext context, AsyncSnapshot<List<product_model>> snapshot)=>snapshot.connectionState==!snapshot.hasData?progress_indicator():snapshot.data==null? progress_indicator(): MostPopularwidget( snapshot.data! )),
            ],
          ),
        ),


      ),
    );

  }


  Widget MostPopularwidget(List<product_model>pr) {
    var size=MediaQuery.of(context).size;
    var height=size.height;
    var width=size.width;

    return StaggeredGridView.countBuilder(
      padding: const EdgeInsets.symmetric(vertical: 15.0),
      shrinkWrap: true,
      physics: NeverScrollableScrollPhysics(),
      crossAxisCount: 2,
      crossAxisSpacing: 10,
      mainAxisSpacing: 10,
      itemCount: pr.length,
      staggeredTileBuilder: (index) {
        return StaggeredTile.count(1, index.isEven ? 1.8 : 1.4);
      },
      itemBuilder: (context, index) {
        return InkWell(
          onTap: (){
            Navigator.of(context).pushNamed(Product_info.scid,arguments: pr[index].id);

          },
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
                        imageUrl: pr[index].image.toString(),

                        placeholder: (context, url) => Center(
                            child: CircularProgressIndicator(
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
                        pr[index].name.toString(),
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
                          if(pr[index].oldPrice!=pr[index].price)
                          Container(
                            alignment: Alignment.centerLeft,
                            width: width/6,
                            child: Text(
                              textAlign: TextAlign.left,
                              textDirection: TextDirection.ltr,

                              softWrap: true,
                              overflow: TextOverflow.ellipsis,

                              '${pr[index].oldPrice} EGP',
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

                              '${pr[index].price} EGP',
                              style: TextStyle(
                                color: local_green,
                                fontSize: width/32,
                              ),
                            ),
                          ),
                        ],
                      ),
                      pr[index].oldPrice!=pr[index].price?
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
                              "${(100-(pr[index].price/pr[index].oldPrice) * 100).toInt()} %",
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
                          Provider.of<Products_prov>(context,listen: false).Add_delete_fav(pr[index].id.toString());
                          setState(() {
                          });

                        },
                        child: Icon(
                          IconBroken.Heart,
                          color: pr[index].inFavorites!?Colors.red:Colors.grey,
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ),
          ),
        );
      },
    );
  }


  Widget Categories() {
    return Container(
      height: 80,
      child: ListView.separated(
          physics: BouncingScrollPhysics(),
          shrinkWrap: true,
          scrollDirection: Axis.horizontal,
          itemCount: list_of_categories.length,
          separatorBuilder: (context, index) {
            return SizedBox(
              width: 10.0,
            );
          },
          itemBuilder: (context, index) {
            return InkWell(
              onTap: (){
                Navigator.of(context).push(MaterialPageRoute(builder: (context){
                  return products_grid(getdatafunc:()=> Provider.of<Products_prov>(context,listen: false).get_category_product(int.parse(list_of_categories[index].id)));
                }));

              },
              child: Container(
                decoration: BoxDecoration(
                  color: Colors.grey[50],
                  borderRadius: BorderRadius.circular(8.0),
                ),
                child: Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 10.0),
                  child: Row(
                    children: [
                      Container(
                        width: 60,
                        height: 60,
                        clipBehavior: Clip.antiAlias,
                        decoration: BoxDecoration(
                          color: Colors.white,
                          borderRadius: BorderRadius.circular(8.0),
                        ),
                        child: CachedNetworkImage(
                          fit: BoxFit.cover,
                          imageUrl:  list_of_categories[index].img_link,

                          placeholder: (context, url) => Center(
                              child: CircularProgressIndicator(
                                strokeWidth: 1.5,
                                color: local_green,
                              )),
                          errorWidget: (context, url, error) => Icon(
                            Icons.error,
                            color: local_green,
                          ),
                        ),
                      ),
                      SizedBox(
                        width: 8.0,
                      ),
                      Container(
                        width: 150,

                        child: Text(
                          textAlign: TextAlign.center,
                          list_of_categories[index].category,
                          softWrap: true,
                          overflow: TextOverflow.ellipsis,


                        ),
                      ),
                    ],
                  ),
                ),
              ),
            );
          }),
    );
  }



}

class Myslider extends StatelessWidget {
  const Myslider({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return CarouselSlider(


      options: CarouselOptions(height: 120.0,
        aspectRatio: 16/9,
        viewportFraction: 0.8,
        initialPage: 0,
        enableInfiniteScroll: true,
        reverse: false,
        autoPlay: true,
        autoPlayInterval: Duration(seconds: 5),
        autoPlayAnimationDuration: Duration(seconds: 3),
        autoPlayCurve: Curves.fastOutSlowIn,
        enlargeCenterPage: true,
        scrollDirection: Axis.horizontal,


      ),
      items:Baners.map((i) {
        return Builder(
          builder: (BuildContext context) {
            return Card(
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.only(bottomRight: Radius.circular(15),topLeft: Radius.circular(15))
              ),

              child: Container(
                  width: MediaQuery.of(context).size.width,
                  margin: EdgeInsets.symmetric(horizontal: 5.0),
                  decoration: BoxDecoration(

                  ),
                  child: ClipRRect(borderRadius: BorderRadius.only(bottomRight: Radius.circular(15),topLeft: Radius.circular(15)),

              child: CachedNetworkImage(
              fit: BoxFit.cover,
              imageUrl: i,

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
              )),
            );
          },
        );
      }).toList(),
    );
  }






}










