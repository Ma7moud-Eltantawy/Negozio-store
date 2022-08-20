import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_zoom_drawer/config.dart';
import 'package:flutter_zoom_drawer/flutter_zoom_drawer.dart';
import 'package:negozio_store/Screens/Category.dart';
import 'package:negozio_store/Screens/Favorite_Screen.dart';
import 'package:negozio_store/Screens/Home_page.dart';
import 'package:negozio_store/Screens/Search_Screen.dart';
import 'package:negozio_store/Screens/Settings.dart';
import 'package:negozio_store/Screens/carts_screen.dart';
import 'package:negozio_store/Screens/profile_screen.dart';
import 'package:negozio_store/network/Network/auth.dart';
import 'package:negozio_store/styles/Local_Styles.dart';
import 'package:negozio_store/widgets/Motion_toast.dart';
import 'package:provider/provider.dart';

import '../Providers/Shared_pref.dart';
import '../styles/icons.dart';
final ZoomDrawerController z = ZoomDrawerController();






class Zoom extends StatefulWidget {


  const Zoom({Key? key}) : super(key: key);
  static const scid="zoom_drawer";

  @override
  _ZoomState createState() => _ZoomState();
}

class _ZoomState extends State<Zoom> {



  @override
  void initState() {

    // TODO: implement initState
    super.initState();

    //SystemChannels.textInput.invokeMethod('TextInput.hide');

  }
  @override
  void dispose() {

    // TODO: implement dispose
    super.dispose();

  }
  @override
  Widget build(BuildContext context) {

    var size=MediaQuery.of(context).size;
    var height=size.height;
    var width=size.width;

    return Consumer<shared_pref_prov>(
      builder:(context,prov,ch)=> ZoomDrawer(
        controller: z,
        borderRadius: 24,
        style: DrawerStyle.defaultStyle,
        // showShadow: true,
        openCurve: Curves.fastOutSlowIn,
        slideWidth: MediaQuery.of(context).size.width * 0.65,
        duration: const Duration(milliseconds: 500),
        // angle: 0.0,
        menuBackgroundColor: local_green,
        mainScreen:RefreshIndicator(
          color: local_green,
          child: Home_screen(),
          onRefresh: () {
            return Future.delayed(
              Duration(seconds: 1),
                  () {

                setState(() {
                  print("refresh");

                });



                    // showing snackbar

              },
            );
          },
        ),
        menuScreen: Theme(
          data: ThemeData.dark(),
          child:  Scaffold(
            backgroundColor: local_green,
            body: Padding(
              padding: EdgeInsets.only(left: 25),
              child: Padding(
                padding: const EdgeInsets.only(bottom: 40.0),
                child: Container(
                  height: height,
                  width: width/2.5,
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.spaceAround,
                    children: [
                      InkWell(
                        onTap: () {

                        },
                        child: Row(
                          children: [
                            CircleAvatar(
                              radius: width/18,
                              backgroundColor: Colors.white,
                              child: CircleAvatar(
                                backgroundColor: local_green,
                                radius:width/19,
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
                                        radius: width/20,
                                      ),
                                ),
                              ),
                            ),
                            SizedBox(
                              width: width/60,
                            ),
                            Container(
                              width: width/3.8,
                              child: Column(
                                children: [

                                  Text(

                              Provider.of<shared_pref_prov>(context,listen: false).user_data!.data!.name.toString(),
                                    softWrap: true,
                                    overflow: TextOverflow.ellipsis,


                                    style: TextStyle(
                                      fontSize: width/40,
                                        color: Colors.white, fontWeight: FontWeight.bold),
                                  ),
                                  Text(

                                      Provider.of<shared_pref_prov>(context,listen: false).user_data!.data!.email.toString(),
                                    softWrap: true,
                                    overflow: TextOverflow.ellipsis,
                                    maxLines: 2,


                                    style: TextStyle(
                                        fontSize: width/40,
                                        color: Colors.white, fontWeight: FontWeight.bold),
                                  ),
                                ],
                              ),
                            ),


                          ],
                        ),
                      ),

                      /*----------------*/

                      Column(
                        children: [
                          InkWell(
                            onTap: () {
                              z.close!();
                            },
                            child: Row(
                              children: [
                                Icon(
                                  IconBroken.Home,
                                  size: 25,
                                  color: Colors.white,
                                ),
                                SizedBox(
                                  width: 10.0,
                                ),
                                Text(
                                  'Home',
                                  style: TextStyle(
                                      color: Colors.white, fontWeight: FontWeight.bold),
                                ),
                              ],
                            ),
                          ),
                          SizedBox(
                            height: 20.0,
                          ),
                          InkWell(
                            onTap: () {
                              Navigator.of(context).pushNamed(Categories_Screen.scid);
                              z.close!();
                            },
                            child: Row(
                              children: [
                                Icon(
                                  IconBroken.Category,
                                  size: 25,
                                  color: Colors.white,
                                ),
                                SizedBox(
                                  width: 10.0,
                                ),
                                Text(
                                  'Categories',
                                  style: TextStyle(
                                      color: Colors.white, fontWeight: FontWeight.bold),
                                ),
                              ],
                            ),
                          ),
                          SizedBox(
                            height: 20.0,
                          ),
                          InkWell(
                            onTap: () {
                              Navigator.of(context).pushNamed(Favorite_Screen.scid);
                              z.close!();
                            },
                            child: Row(
                              children: [
                                Icon(
                                  IconBroken.Heart,
                                  size: 25,
                                  color: Colors.white,
                                ),
                                SizedBox(
                                  width: 10.0,
                                ),
                                Text(
                                  'Favorites',
                                  style: TextStyle(
                                      color: Colors.white, fontWeight: FontWeight.bold),
                                ),
                              ],
                            ),
                          ),
                          SizedBox(
                            height: 20.0,
                          ),
                          InkWell(
                            onTap: () {
                              Navigator.of(context).pushNamed(Search_screen.scid);
                              z.close!();
                            },
                            child: Row(
                              children: [
                                Icon(
                                  IconBroken.Search,
                                  size: 25,
                                  color: Colors.white,
                                ),
                                SizedBox(
                                  width: 10.0,
                                ),
                                Text(
                                  'Search',
                                  style: TextStyle(
                                      color: Colors.white, fontWeight: FontWeight.bold),
                                ),
                              ],
                            ),
                          ),
                          SizedBox(
                            height: 20.0,
                          ),
                          InkWell(
                            onTap: () {
                              Navigator.of(context).pushNamed(carts_screen.scid);
                              z.close!();
                            },
                            child: Row(
                              children: [
                                Icon(
                                  IconBroken.Buy,
                                  size: 25,
                                  color: Colors.white,
                                ),
                                SizedBox(
                                  width: 10.0,
                                ),
                                Text(
                                  'Cart',
                                  style: TextStyle(
                                      color: Colors.white, fontWeight: FontWeight.bold),
                                ),
                              ],
                            ),
                          ),
                          SizedBox(
                            height: 20.0,
                          ),
                          InkWell(
                            onTap: () {
                              Navigator.of(context).pushNamed(Myprofile_screen.scid);
                              z.close!();

                            },
                            child: Row(
                              children: [
                                Icon(
                                  IconBroken.Profile,
                                  size: 25,
                                  color: Colors.white,
                                ),
                                SizedBox(
                                  width: 10.0,
                                ),
                                Text(
                                  'Profile',
                                  style: TextStyle(
                                      color: Colors.white, fontWeight: FontWeight.bold),
                                ),
                              ],
                            ),
                          ),
                          SizedBox(
                            height: 20.0,
                          ),
                          InkWell(
                            onTap: () {
                              Navigator.of(context).pushNamed(Settings.scid);
                              z.close!();

                            },
                            child: Row(
                              children: [
                                Icon(
                                  IconBroken.Setting,
                                  size: 25,
                                  color: Colors.white,
                                ),
                                SizedBox(
                                  width: 10.0,
                                ),
                                Text(
                                  'Settings',
                                  style: TextStyle(
                                      color: Colors.white, fontWeight: FontWeight.bold),
                                ),
                              ],
                            ),
                          ),
                        ],
                      ),

                      /*-------------------------*/


                      Row(
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          Icon(
                            IconBroken.Logout,
                            color: Colors.white,
                            size: width/15,
                          ),
                          SizedBox(
                            width: width/40,
                          ),
                          InkWell(
                            onTap: () async{
                              print("010");
                              await Provider.of<Auth_prov>(context,listen: false).logout();

                            },
                            child: Text(
                              'Logout',
                              style: TextStyle(
                                  color: Colors.white, fontWeight: FontWeight.bold),
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
    );
  }
}


