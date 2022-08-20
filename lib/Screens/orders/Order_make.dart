import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:negozio_store/Providers/Shared_pref.dart';
import 'package:negozio_store/Screens/Home_page.dart';
import 'package:negozio_store/Screens/Map/Prov_location.dart';
import 'package:negozio_store/Screens/Map/map_location.dart';
import 'package:negozio_store/Screens/orders/orders.dart';
import 'package:negozio_store/network/Network/Carts.dart';
import 'package:negozio_store/network/Network/orders_prov.dart';
import 'package:negozio_store/network/models/orders_model.dart';
import 'package:negozio_store/styles/Local_Styles.dart';
import 'package:negozio_store/widgets/Motion_toast.dart';
import 'package:negozio_store/widgets/material_button.dart';
import 'package:provider/provider.dart';

import '../../styles/icons.dart';
class Make_order_screen extends StatefulWidget {
  const Make_order_screen({Key? key}) : super(key: key);
  static const scid="make_order";

  @override
  State<Make_order_screen> createState() => _Make_order_screenState();
}

class _Make_order_screenState extends State<Make_order_screen> {
  TextEditingController nameController = TextEditingController();
  TextEditingController cityController = TextEditingController();
  TextEditingController regionController = TextEditingController();
  TextEditingController detailsController = TextEditingController();
  TextEditingController notesController = TextEditingController();
  var formState = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    var totalprice=ModalRoute.of(context)!.settings.arguments!.toString();
    var size=MediaQuery.of(context).size;
    var height=size.height;
    var width=size.width;
    return Consumer<shared_pref_prov>(
      builder:(context,prov,ch)=> Scaffold(
        backgroundColor: Colors.white,
        appBar: AppBar(
          centerTitle: true,
          title: Text(
            'Order Data',
            style: TextStyle(
              color: local_green
            ),
          ),
          backgroundColor: Colors.white,
          elevation: 0,
          leading: IconButton(
            icon: Icon(
              IconBroken.Arrow___Left_2,
              color:local_green,
              size: width/10,
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
        body: SingleChildScrollView(
          physics: BouncingScrollPhysics(),
          child: Padding(
            padding:  EdgeInsets.all(height/60),
            child: Form(
              key: formState,
              child: Container(
                height: height/1.5,
                child: Consumer<Prov_loc>(

                  builder:(context,prov,ch)=> Column(
                    mainAxisAlignment: MainAxisAlignment.spaceAround,
                    children: [
                      Row(
                        children: [
                          Expanded(
                            child: Divider(
                              color: local_green,
                              thickness: 1.2,
                              indent: 10.0,
                              endIndent: 10.0,
                            ),
                          ),
                          Text(
                            'Enter Your Address',
                            style: TextStyle(
                              fontSize: 15,
                            ),
                          ),
                          Expanded(
                            child: Divider(
                              color: local_green,
                              thickness: 1.2,
                              indent: 10.0,
                              endIndent: 10.0,
                            ),
                          ),
                        ],
                      ),
                      SizedBox(
                        height:  height/20,
                      ),
                      TextFormField(


                        controller: nameController,
                        cursorColor: local_green,
                        keyboardType: TextInputType.emailAddress,
                        validator: ( value) {
                          if (value!.isEmpty) {
                            return 'Please enter your name';
                          }
                          return null;
                        },
                        decoration: InputDecoration(
                          filled: true,
                          fillColor: Colors.white,
                          labelText: 'Name',
                          labelStyle: TextStyle(
                            color: local_green
                          ),
                          prefixIcon: Icon(IconBroken.User,color: Colors.grey,),
                          enabledBorder: enabledBorder,
                          focusedBorder: focusedBorder,
                          errorBorder: enabledBorder,
                          focusedErrorBorder: focusedBorder,
                        ),
                      ),
                      Padding(
                        padding:  EdgeInsets.only(
                          top: height/120,
                        ),
                        child: Container(
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(8.0),
                            color: Colors.grey[50],
                          ),
                          width: MediaQuery.of(context).size.width,
                          height: height/15,
                          child: InkWell(
                            onTap: (){
                              Navigator.of(context).pushNamed(Loc_Screen.scid);
                            },
                            child: Padding(
                              padding: const EdgeInsets.symmetric(horizontal: 10),
                              child: Row(
                                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                children: [
                                  Expanded(
                                    child: Text(
                                      "Change location data by map",
                                      style: TextStyle(
                                        color: local_green,
                                        overflow: TextOverflow.ellipsis,
                                      ),
                                    ),
                                  ),
                                  InkWell(
                                    onTap: (){
                                      Navigator.of(context).pushNamed(Loc_Screen.scid);

                                    },
                                    child: Container(
                                      decoration: BoxDecoration(
                                        borderRadius: BorderRadius.circular(6.0),
                                        color: Colors.white,
                                      ),
                                      width: 35,
                                      height: 35,
                                      child: Icon(
                                        IconBroken.Location,
                                        color: local_green,
                                      ),
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          ),
                        ),
                      ),
          Padding(
            padding: const EdgeInsets.only(
                  top: 15.0,
            ),
            child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        "City",
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
                        height:  height/15,
                        child: Padding(
                          padding:  EdgeInsets.symmetric(horizontal:  height/60),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Expanded(
                                child: Text(
                                  prov.placemarks==null?"change city from map":prov.cityname.toString(),
                                  style: TextStyle(
                                    color: Colors.grey,
                                    overflow: TextOverflow.ellipsis,
                                  ),
                                ),
                              ),
                            ],
                          ),
                        ),
                      ),
                    ],
              ),

          ),
                      Padding(
                        padding:  EdgeInsets.only(
                          top:  height/120,
                        ),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              "Region",
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
                              height:  height/15,
                              child: Padding(
                                padding: const EdgeInsets.symmetric(horizontal: 10),
                                child: Row(
                                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                  children: [
                                    Expanded(
                                      child: Text(
                                        prov.placemarks==null?"change region from map":prov.countryname.toString(),
                                        style: TextStyle(
                                          color: Colors.grey,
                                          overflow: TextOverflow.ellipsis,
                                        ),
                                      ),
                                    ),

                                  ],
                                ),
                              ),
                            ),
                          ],
                        ),
                      ),
                      Padding(
                        padding:  EdgeInsets.only(
                          top: height/120,
                        ),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              "Details",
                              style: TextStyle(color: local_green, fontSize: 16),
                            ),
                            SizedBox(
                              height:  height/60,
                            ),
                            Container(
                              decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(8.0),
                                color: Colors.grey[50],
                              ),
                              width: MediaQuery.of(context).size.width,
                              height:  height/15,
                              child: Padding(
                                padding: const EdgeInsets.symmetric(horizontal: 10),
                                child: Row(
                                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                  children: [
                                    Expanded(
                                      child: Text(
                                        prov.placemarks==null?"change address details from map":prov.address.toString(),
                                        style: TextStyle(
                                          color: Colors.grey,
                                          overflow: TextOverflow.ellipsis,
                                        ),
                                      ),
                                    ),

                                  ],
                                ),
                              ),
                            ),
                          ],
                        ),
                      ),

                      TextFormField(
                        controller: notesController,
                        cursorColor: local_green,
                        validator: ( value) {
                          if (value!.isEmpty) {
                            return 'Please enter your notes';
                          }
                          return null;
                        },
                        decoration: InputDecoration(
                          filled: true,
                          fillColor: Colors.white,
                          labelText: 'notes',
                          labelStyle: TextStyle(
                            color: local_green
                          ),
                          prefixIcon: Icon(IconBroken.Document,color: Colors.grey,),
                          enabledBorder: enabledBorder,
                          focusedBorder: focusedBorder,
                          errorBorder: enabledBorder,
                          focusedErrorBorder: focusedBorder,
                        ),
                      ),
                      SizedBox(
                        height:  height/60,
                      ),

                    ],
                  ),
                ),
              ),
            ),
          ),
        ),
        bottomNavigationBar: BottomAppBar(
          child: Container(
            height: 135,
            child: Padding(
              padding: const EdgeInsets.all(15.0),
              child: Column(
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        'Total Price:',
                        style: TextStyle(fontSize: 16,color: Colors.black54),
                      ),
                      Text(
                        '${totalprice} EGP',
                        style: TextStyle(
                          color: local_green,
                          fontSize: 16,
                        ),
                      ),
                    ],
                  ),
                  SizedBox(
                    height: 20,
                  ),
                  Mbutton(width: width, height: height, colors: [
                    Color.fromRGBO(59, 221, 175, 1.0),
                    Color.fromRGBO(39, 140, 111, 1),
                    Color.fromRGBO(39, 140, 111, 1),
                    local_green,
                  ], txt: "Confirm", wid: Icon(IconBroken.Buy,color: Colors.white,), func: ()=>()async{
                    if(nameController.text.isNotEmpty && notesController.text.isNotEmpty &&Provider.of<Prov_loc>(context,listen: false).address!=null)
                      {

                        var pr=Provider.of<Prov_loc>(context,listen: false);
                        await Provider.of<Prov_loc>(context,listen: false).AddnewAddress(name: nameController.text,
                            city: pr.cityname.toString(), region: pr.countryname.toString(), details: pr.address.toString(),
                            long: pr.currentLatLng.longitude, lat: pr.currentLatLng.latitude, notes: notesController.toString());
                        await Provider.of<Orders_prov>(context,listen: false).Add_order(Provider.of<Prov_loc>(context,listen: false).Location_id!.toInt());
                        await Provider.of<Carts_prov>(context,listen: false).get_Carts().then((value) =>
                            MY_toast(ctx: context, height: height, width: width, desc: "The order has been successfully added")
                        );
                        Navigator.of(context).pushNamed(Orders_screen.scid);




                      }
                    else{
                      Fail_toast(ctx: context, height: height, width: width, desc: "The order has been successfully added", title: 'failed');

                    }



                  })
                ],
              ),
            ),
          ),
          elevation: 10,
          color: Colors.white,
        ),
      ),
    );
  }
}
