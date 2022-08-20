import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:modal_progress_hud_nsn/modal_progress_hud_nsn.dart';
import 'package:negozio_store/Screens/orders/orders.dart';
import 'package:negozio_store/Screens/profile_screen.dart';
import 'package:negozio_store/network/Network/Settings.dart';
import 'package:negozio_store/network/Network/auth.dart';
import 'package:negozio_store/network/models/faq_model.dart';
import 'package:negozio_store/styles/Local_Styles.dart';
import 'package:negozio_store/styles/icons.dart';
import 'package:negozio_store/widgets/Change_password_sheet.dart';
import 'package:negozio_store/widgets/Conatctme_bouttomsheet.dart';
import 'package:negozio_store/widgets/material_button.dart';
import 'package:provider/provider.dart';
import 'package:rflutter_alert/rflutter_alert.dart';

import '../Providers/Shared_pref.dart';
import '../widgets/circular_progress.dart';
class Settings extends StatefulWidget {
  const Settings({Key? key}) : super(key: key);
  static const scid="setting_screen";

  @override
  State<Settings> createState() => _SettingsState();
}

class _SettingsState extends State<Settings> {
  @override
  Widget build(BuildContext context) {
    var size=MediaQuery.of(context).size;
    var height=size.height;
    var width=size.width;
    return Consumer<shared_pref_prov>(
      builder:(context,prov,ch)=> Scaffold(
        backgroundColor: Colors.white,
        appBar: AppBar(
          centerTitle: true,
          title: Text(

            'Settings',
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
                      imageUrl: Provider.of<shared_pref_prov>(context,listen: false).user_data!.data!.image.toString(),
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
        ),
        body: FutureBuilder(
          future:   Provider.of<Settings_prov>(context,listen: false).get_faqs(),

          builder:(context,AsyncSnapshot <List<Faq_model>>snapshot)=>!snapshot.hasData?Center(child: progress_indicator(),): SingleChildScrollView(
            physics: BouncingScrollPhysics(),
            child: Padding(
              padding: const EdgeInsets.all(15.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Padding(
                    padding: const EdgeInsets.only(bottom: 12.0),
                    child: Text(
                      'Account',
                      style: TextStyle(
                        color: local_green,
                        fontSize: 16,
                      ),
                    ),
                  ),
                  ListTile(
                    onTap: () {
                      Navigator.of(context).pushNamed(Myprofile_screen.scid);

                    },
                    dense: true,
                    horizontalTitleGap: -4,
                    //minLeadingWidth: 0,
                    minVerticalPadding: 15.0,
                    contentPadding: EdgeInsets.symmetric(horizontal: 10),
                    shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(8.0)),
                    tileColor: Colors.grey[50],
                    leading: Icon(
                      IconBroken.Profile,
                      color: local_green,
                      size: 26,
                    ),
                    title: Text(
                      'Edit Profile',
                      style: TextStyle(
                        fontSize: 14,
                        overflow: TextOverflow.ellipsis,
                      ),
                    ),
                    trailing: Icon(
                      IconBroken.Arrow___Right_2,
                      color: local_green,
                      size: 26,
                    ),
                  ),
                  SizedBox(
                    height: 10.0,
                  ),
                  ListTile(
                    onTap: () {

                      Changepassword_bottom_sheet(context, height, width);

                    },
                    dense: true,
                    horizontalTitleGap: -4,
                    //minLeadingWidth: 0,
                    minVerticalPadding: 15.0,
                    contentPadding: EdgeInsets.symmetric(horizontal: 10),
                    shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(8.0)),
                    tileColor: Colors.grey[50],
                    leading: Icon(
                      IconBroken.Password,
                      color: local_green,
                      size: 26,
                    ),
                    title: Text(
                      'Change Password',
                      style: TextStyle(
                        fontSize: 14,
                        overflow: TextOverflow.ellipsis,
                      ),
                    ),
                    trailing: Icon(
                      IconBroken.Arrow___Right_2,
                      color: local_green,
                      size: 26,
                    ),
                  ),
                  SizedBox(
                    height: 10.0,
                  ),
                  ListTile(
                    onTap: () {
                      Navigator.of(context).pushNamed(Orders_screen.scid);
                    },
                    dense: true,
                    horizontalTitleGap: -4,
                    //minLeadingWidth: 0,
                    minVerticalPadding: 15.0,
                    contentPadding: EdgeInsets.symmetric(horizontal: 10),
                    shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(8.0)),
                    tileColor: Colors.grey[50],
                    leading: Icon(
                      IconBroken.Buy,
                      color: local_green,
                      size: 26,
                    ),
                    title: Text(
                      'Orders',
                      style: TextStyle(
                        fontSize: 14,
                        overflow: TextOverflow.ellipsis,
                      ),
                    ),
                    trailing: Icon(
                      IconBroken.Arrow___Right_2,
                      color: local_green,
                      size: 26,
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.symmetric(vertical: 12.0),
                    child: Text(
                      'Legal',
                      style: TextStyle(
                        color: local_green,
                        fontSize: 16,
                      ),
                    ),
                  ),
                  ListTile(
                    onTap: () {},
                    dense: true,
                    horizontalTitleGap: -4,
                    //minLeadingWidth: 0,
                    minVerticalPadding: 15.0,
                    contentPadding: EdgeInsets.symmetric(horizontal: 10),
                    shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(8.0)),
                    tileColor: Colors.grey[50],
                    leading: Icon(
                      IconBroken.Shield_Done,
                      color: local_green,
                      size: 26,
                    ),
                    title: Text(
                      'Privacy Policy',
                      style: TextStyle(
                        fontSize: 14,
                        overflow: TextOverflow.ellipsis,
                      ),
                    ),
                    trailing: Icon(
                      IconBroken.Arrow___Right_2,
                      color: local_green,
                      size: 26,
                    ),
                  ),
                  SizedBox(
                    height: 10.0,
                  ),
                  ListTile(
                    onTap: () {
                      Contactme_bottom_sheet(context, height, width);

                    },
                    dense: true,
                    horizontalTitleGap: -4,
                    //minLeadingWidth: 0,
                    minVerticalPadding: 15.0,
                    contentPadding: EdgeInsets.symmetric(horizontal: 10),
                    shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(8.0)),
                    tileColor: Colors.grey[50],
                    leading: Icon(
                      IconBroken.Activity,
                      color: local_green,
                      size: 26,
                    ),
                    title: Text(
                      'Contact Me',
                      style: TextStyle(
                        fontSize: 14,
                        overflow: TextOverflow.ellipsis,
                      ),
                    ),
                    trailing: Icon(
                      IconBroken.Arrow___Right_2,
                      color: local_green,
                      size: 26,
                    ),
                  ),
                  // SizedBox(height: 10.0,),
                  Padding(
                    padding: const EdgeInsets.symmetric(vertical: 12.0),
                    child: Text(
                      'FAQ',
                      style: TextStyle(
                        color: local_green,
                        fontSize: 16,
                      ),
                    ),
                  ),
                  ListView.separated(
                    physics: NeverScrollableScrollPhysics(),
                    shrinkWrap: true,
                    itemCount: snapshot.data!.length,
                    itemBuilder: (context, index) {
                      return ClipRRect(
                        borderRadius: BorderRadius.circular(8.0),
                        child: Consumer<Settings_prov>(
                          builder:(context,prov,ch)=> ExpansionTile(
                            backgroundColor: Colors.grey[50],
                            collapsedBackgroundColor: Colors.grey[50],
                            iconColor: local_green,
                            childrenPadding: EdgeInsets.only(
                                left: 15.0, right: 15.0, bottom: 15.0),
                            collapsedIconColor: local_green,
                            tilePadding: EdgeInsets.symmetric(horizontal: 10.0),
                            controlAffinity: ListTileControlAffinity.trailing,
                            trailing: prov.Faqs[snapshot.data![index].id]==false?Icon(IconBroken.Arrow___Down_2):Icon(IconBroken.Arrow___Up_2),
                            title: Row(
                              children: [
                                Icon(IconBroken.Info_Circle, color: local_green,
                                  size: 26,),
                                SizedBox(width: 10.0,),
                                Text(
                                  snapshot.data![index].question.toString(),
                                  overflow: TextOverflow.ellipsis,
                                  maxLines: 1,
                                  style: TextStyle(fontSize: 14,color: local_green),
                                ),
                              ],
                            ),
                            children: [
                              Text(
                                  snapshot.data![index].answer!
                              ),
                            ],
                            onExpansionChanged: (value) {
                              Provider.of<Settings_prov>(context,listen: false).faqstate(snapshot.data![index].id!, value);


                            },
                          ),
                        ),
                      );
                    },
                    separatorBuilder: (context, index) {
                      return SizedBox(height: 10.0,);
                    },
                  ),
                ],
              ),
            ),
          ),
        ) ,
        bottomNavigationBar: BottomAppBar(
          elevation: 0,
          color: Colors.white38,
          child: Padding(
            padding:
            const EdgeInsets.symmetric(horizontal: 15.0, vertical: 20.0),
            child: Mbutton(width: width, height: height, colors: [
              Color.fromRGBO(59, 221, 175, 1.0),
              Color.fromRGBO(39, 140, 111, 1),
              Color.fromRGBO(39, 140, 111, 1),
              local_green,
            ], txt: "Logout", wid: Icon(IconBroken.Logout,color: Colors.white,), func: ()=>(){

              Provider.of<Auth_prov>(context,listen: false).logout();
            })
          ),
        ),
      ),
    );
  }
}



