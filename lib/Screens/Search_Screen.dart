
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_staggered_animations/flutter_staggered_animations.dart';
import 'package:negozio_store/network/Network/Product_data.dart';
import 'package:negozio_store/styles/Local_Styles.dart';
import 'package:negozio_store/styles/icons.dart';
import 'package:provider/provider.dart';

import '../Providers/Shared_pref.dart';


class Search_screen extends StatefulWidget {
  static const String scid = '/material/search';

  @override
  _Search_screenState createState() => _Search_screenState();
}

class _Search_screenState extends State<Search_screen> {

  final GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey<ScaffoldState>();

  int ? _lastIntegerSelected;

  @override
  Widget build(BuildContext context) {
    var size=MediaQuery.of(context).size;
    var height=size.height;
    var width=size.width;
    return Consumer<shared_pref_prov>(
      builder:(context,prov,ch)=> Scaffold(
        backgroundColor: Colors.white,
        key: _scaffoldKey,
        appBar: AppBar(
          elevation: 0,
          backgroundColor: Colors.white,
          centerTitle: true,
          title: Text(

            'Search',
            style: TextStyle(
                color: local_green
            ),
          ),

          leading:Container(

            height: height/30,
            width: width/20,
            decoration: BoxDecoration(

              borderRadius: BorderRadius.circular(5),
            ),
            child: IconButton(
              icon: Icon(
                IconBroken.Search,
                color: local_green,
                size: 25,
              ),
              onPressed: () {
                showSearch(context: context, delegate: DataSearch());
              },
            ),
          ),
          leadingWidth: width/10,

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
        body: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              Row(
                textDirection: TextDirection.ltr,
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  const Text("Click on the icon",textAlign: TextAlign.center,),
                  Container(
                      margin: EdgeInsets.symmetric(horizontal: width/30),
                      child: const Icon( IconBroken.Search)),
                  const Text(" to be able to search",textAlign: TextAlign.center,),

                ],
              ),


            ],
          ),
        ),
        floatingActionButton: FloatingActionButton.extended(
          backgroundColor: local_green,
          tooltip: 'Back', // Tests depend on this label to exit the demo.
          onPressed: () {
            Navigator.of(context).pop();
          },
          label: const Text('Close'),
          icon: const Icon(Icons.close),
        ),

      ),
    );
  }
}






class DataSearch extends SearchDelegate<String> {


  @override
  List<Widget> buildActions(BuildContext context) {
    // action for app bar
    return [
      IconButton(
        onPressed: () {
          query = "";
        },
        icon: const Icon(Icons.clear),
      )
    ];
  }

  @override
  Widget buildLeading(BuildContext context) {
    // leading icon on the left of the app bar
    return IconButton(
      icon: AnimatedIcon(
        icon: AnimatedIcons.menu_arrow,
        progress: transitionAnimation,
      ),
      onPressed: () {
        close(context, "");
      },
    );
  }

  @override
  Widget buildResults(BuildContext context) {
    // TODO: implement buildResults
    return  SizedBox(
        height: 150.0,
        child: Card(
          color: Colors.red,
          shape: const StadiumBorder(),
          child: Text(query),
        ),
    );
  }

  @override
  Widget buildSuggestions(BuildContext context) {
    var size=MediaQuery.of(context).size;
    var height=size.height;
    var width=size.width;
    var scaffoldKey = GlobalKey<ScaffoldState>();
    void showsnackbar()
    {

      scaffoldKey.currentState!.showSnackBar(
          SnackBar(
              duration: const Duration(seconds: 3),
              backgroundColor: Theme.of(context).unselectedWidgetColor,
              content: const Text('تم ارسال الطلب',
                textAlign: TextAlign.center,
                style: TextStyle(
                    color: Colors.white,
                    fontFamily: 'cairo'
                ),)
          )
      );

    }

    // TODO: implement buildSuggestions
    final suggestionList = query.isEmpty
        ? Provider.of<Products_prov>(context).Serch_list
        : Provider.of<Products_prov>(context).Serch_list.where((element) => element.name!.contains(query)).toList();
    return Scaffold(
      key: scaffoldKey,
      body: ListView.builder(
        itemCount: suggestionList.length,
        itemBuilder: (BuildContext context, int index) {
          return AnimationConfiguration.staggeredList(
            position: index,
            duration: const Duration(milliseconds: 500),
            child: SlideAnimation(
              verticalOffset: 50.0,
              child: FadeInAnimation(
                  child: SizedBox(
                    height: height/5,

                    child: Stack(
                      children: [

                        Card(
                          shape: RoundedRectangleBorder(
                              borderRadius:BorderRadius.circular(10)
                          ),
                          elevation: 2,
                          child: Padding(
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
                                          imageUrl: suggestionList[index].image.toString(),
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
                                              suggestionList[index].name.toString(),
                                              style: TextStyle(fontSize: 14),
                                              overflow: TextOverflow.ellipsis,
                                              maxLines: 2,
                                            ),
                                            Row(
                                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                              children: [
                                                Text(
                                                  '${suggestionList[index].price} EGP',
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
                                                    color: suggestionList[index].inFavorites==true
                                                        ? Colors.red
                                                        : Colors.grey,
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
                      ],
                    ),
                  )
              ),
            ),
          );
        },
      ),
    );
  }
}