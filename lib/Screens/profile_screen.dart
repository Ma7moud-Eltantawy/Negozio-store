import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:negozio_store/Providers/Shared_pref.dart';
import 'package:negozio_store/Screens/Settings.dart';
import 'package:negozio_store/network/Network/Update_data.dart';
import 'package:negozio_store/widgets/material_button.dart';
import 'package:provider/provider.dart';

import '../network/Network/auth.dart';
import '../styles/Local_Styles.dart';
import '../styles/icons.dart';
import '../widgets/bottom_sheet.dart';
class Myprofile_screen extends StatefulWidget {
  const Myprofile_screen({Key? key}) : super(key: key);
  static const scid ="my_prof";

  @override
  State<Myprofile_screen> createState() => _Myprofile_screenState();

}

class _Myprofile_screenState extends State<Myprofile_screen> {
  final formKey = GlobalKey<FormState>();
  @override
  void initState() {

    // TODO: implement initState
    super.initState();

  }

  @override
  Widget build(BuildContext context) {
    var size=MediaQuery.of(context).size;
    var height=size.height;
    var width=size.width;
    return   Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        elevation: 0,
        backgroundColor: Colors.white,
        systemOverlayStyle: SystemUiOverlayStyle(
          statusBarColor: Colors.white,
          statusBarIconBrightness: Brightness.dark,
        ),
        centerTitle: true,
        title: Text(
          'My Profile',
          style: TextStyle(color:local_green),
        ),
        leading: IconButton(
          onPressed: () {
            Navigator.pop(context);
          },
          icon: Icon(
            IconBroken.Arrow___Left_2,
            color: local_green,
            size: 35,
          ),
        ),
        actions: [
          IconButton(
            onPressed: () {
            Navigator.of(context).pushNamed(Settings.scid);

            },
            icon: Icon(
              IconBroken.Setting,
              color: local_green,
              size: 35,
            ),
          ),
        ],
      ),
      body: Padding(
        padding: const EdgeInsets.all(15.0),
        child: SingleChildScrollView(
          keyboardDismissBehavior: ScrollViewKeyboardDismissBehavior.onDrag,
          physics: BouncingScrollPhysics(),
          child: Consumer<shared_pref_prov>(
            builder:(context,prov,ch)=> Column(
              children: [
                Stack(
                  alignment: Alignment.bottomRight,
                  children: [
                    CircleAvatar(
                      radius: 88,
                      backgroundColor: local_green,
                      child: CircleAvatar(
                        radius: 84,
                        backgroundColor: Colors.white,
                        child: CircleAvatar(
                          backgroundColor: Colors.white,
                          radius: 80,
                          child:  Consumer<shared_pref_prov>(
                            builder:(context,pro,ch)=> CachedNetworkImage(
                              imageUrl: Provider.of<shared_pref_prov>(context,listen: false).user_data!.data!.image.toString(),
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
                                    radius: 80,
                                  ),
                            ),
                          ),
                        ),
                      ),
                    ),
                    CircleAvatar(
                      radius: 25,
                      backgroundColor: Colors.white,
                      child: CircleAvatar(
                        child: IconButton(
                          splashRadius: 22,
                          onPressed: () {
                            Profile_bottom_sheet(context, height, width);
                          },
                          icon: Icon(IconBroken.Camera,color: local_green,),
                        ),
                        radius: 22,
                        backgroundColor: Colors.grey[50],
                      ),
                    ),
                  ],
                ),
                Padding(
                  padding: const EdgeInsets.only(top: 20.0),
                  child: Text(
                    Provider.of<shared_pref_prov>(context,listen: false).user_data!.data!.name.toString(),
                    style: TextStyle(fontSize: 18),
                  ),
                ),
                Text(
                    Provider.of<shared_pref_prov>(context,listen: false).user_data!.data!.email.toString(),
                  style: TextStyle(fontSize: 15, color: Colors.grey),
                ),
                profileItem(
                    context: context,
                    title: 'Full Name',
                    content:  Provider.of<shared_pref_prov>(context,listen: false).user_data!.data!.name.toString(),
                    onTap: () {
                      Profile_bottom_sheet(context, height, width);
                     // Profile_bottom_sheet(context, height, width);
                    }),
                profileItem(
                    context: context,
                    title: 'Email',
                    content:  Provider.of<shared_pref_prov>(context,listen: false).user_data!.data!.email.toString(),
                    onTap: () {
                      Profile_bottom_sheet(context, height, width);

                      //bottomSheetUpdateUserData(context: context, cubit: cubit);
                    }),
                profileItem(
                    context: context,
                    title: 'phone',
                    content:  Provider.of<shared_pref_prov>(context,listen: false).user_data!.data!.phone.toString(),
                    onTap: () {
                     // bottomSheetUpdateUserData(context: context, cubit: cubit);
                    }),
                SizedBox(
                  height: 40,
                ),
                Mbutton(width: width, height: height, colors: [ Color.fromRGBO(59, 221, 175, 1.0),
                  Color.fromRGBO(39, 140, 111, 1),
                  Color.fromRGBO(39, 140, 111, 1),
                  local_green,], txt: "Logout", wid: Icon(IconBroken.Logout,color: Colors.white,), func: ()=>(){

                  Provider.of<Auth_prov>(context,listen: false).logout();
                })
              ],
            ),
          ),
        ),
      ),
    );
  }




  Widget profileItem({
    required BuildContext context,
    required String title,
    required String content,
    required Function onTap,
  }) {
    return Padding(
      padding: const EdgeInsets.only(
        top: 15.0,
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            title,
            style: TextStyle(color: local_green, fontSize: 16),
          ),
          SizedBox(
            height: 5,
          ),
          Container(
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(8.0),
              color: Colors.grey[50],
            ),
            width: MediaQuery.of(context).size.width,
            height: 50,
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 10),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Expanded(
                    child: Text(
                      content,
                      style: TextStyle(
                        color: Colors.grey,
                        overflow: TextOverflow.ellipsis,
                      ),
                    ),
                  ),
                  InkWell(
                    onTap: (){
                      onTap();
                    },
                    child: Container(
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(6.0),
                        color: Colors.white,
                      ),
                      width: 35,
                      height: 35,
                      child: Icon(
                        IconBroken.Edit,
                        color: local_green,
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}


