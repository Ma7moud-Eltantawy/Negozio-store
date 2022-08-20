import 'dart:convert';
import 'dart:io';
import 'dart:typed_data';

import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:image_picker/image_picker.dart';
import 'package:modal_bottom_sheet/modal_bottom_sheet.dart';
import 'package:negozio_store/Screens/Search_Screen.dart';
import 'package:negozio_store/network/Network/Update_data.dart';
import 'package:negozio_store/network/Network/auth.dart';
import 'package:negozio_store/styles/Local_Styles.dart';
import 'package:negozio_store/widgets/Motion_toast.dart';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';
import '../Providers/Change_data_prov.dart';
import '../Providers/Shared_pref.dart';
import '../network/Network/Product_data.dart';
import '../styles/icons.dart';
import 'material_button.dart';

TextEditingController emailController = TextEditingController();

TextEditingController fullNameController = TextEditingController();

TextEditingController phoneController = TextEditingController();


var formState = GlobalKey<FormState>();

void Filter_bottom_sheet(@required BuildContext context,@required double height,@required double width)
{
  showBarModalBottomSheet(
    shape: RoundedRectangleBorder(
      borderRadius: BorderRadius.only(
        topLeft: Radius.circular(20.0),
        topRight: Radius.circular(20.0),

      ),
    ), builder: (BuildContext context) =>
      Container(
        child: Padding(
          padding: const EdgeInsets.all(15.0),
          child: SingleChildScrollView(
            physics: BouncingScrollPhysics(),
            child: Column(
              children: [
                Text(
                  'Filter',
                  style: TextStyle(
                    color: local_green,
                    fontSize: 16,
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.only(
                    top: 25,
                    bottom: 25,
                  ),
                  child: Form(
                    key: formState,
                    child: Column(
                      children: [
                        Container(
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



                                Expanded(
                                  child: SliderTheme(
                                    data: SliderTheme.of(context).copyWith(
                                      activeTrackColor: Colors.white,
                                      thumbShape: RoundSliderThumbShape(enabledThumbRadius: 10.0,),
                                      overlayShape: RoundSliderOverlayShape(overlayRadius: 10.0),
                                      thumbColor: Colors.white,

                                    ),
                                    child: ShaderMask(

                                      shaderCallback: (Rect bounds) {
                                        return RadialGradient(
                                          center: Alignment.topLeft,
                                          radius: 10,
                                          colors: [Color.fromRGBO(24, 82, 66, 1),Color.fromRGBO(50, 130, 96, 1), Color.fromRGBO(70 ,167 ,119, 1),Color.fromRGBO(85 ,195 ,136, 1)],
                                          tileMode: TileMode.repeated,
                                        ).createShader(bounds);
                                      },
                                      child: Consumer<Products_prov>(

                                        builder: (context,prov,ch)=>RangeSlider(

                                            values: RangeValues(prov.filter_min.toDouble(),prov.filter_max.toDouble()),
                                            min: 0,
                                            max: 150000,
                                            divisions: 2500,
                                            activeColor: Colors.white,
                                            inactiveColor: Colors.white38,
                                            labels: RangeLabels(prov.filter_min.round().toString(),prov.filter_max.round().toString()),
                                            onChanged: (RangeValues val){
                                              prov.change_min_max(val.start.toInt(),val.end.toInt());
                                              print(prov.filter_min);

                                            }
                                        ),
                                      ),
                                    ),
                                  ),
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
                                    IconBroken.Filter,
                                    color: local_green,
                                  ),
                                )
                              ],
                            ),
                          ),
                        ),

                        SizedBox(
                          height: 20,
                        ),
                        InkWell(
                          onTap: (){
                            Navigator.of(context).pushNamed(Search_screen.scid);
                            Navigator.of(context).pop();


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
                                    'Search...',
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
                                      IconBroken.Search,
                                      color: local_green,
                                    ),
                                  )
                                ],
                              ),
                            ),
                          ),
                        ),


                        SizedBox(
                          height: 20,
                        ),
                        Mbutton(width: width, height: height, colors:[ Color.fromRGBO(59, 221, 175, 1.0),

                          local_green,], txt: "Confirm", wid: Icon(IconBroken.Shield_Done,color: Colors.white,), func: ()=>(){
                          var pr=Provider.of<Products_prov>(context,listen:false);
                         pr.confirm_slider(pr.filter_min, pr.filter_max);
                         Navigator.of(context).pop();
                        })

                      ],
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      )
      , context: context
  );
}


void Profile_bottom_sheet(@required BuildContext context,@required double height,@required double width)
{
  showBarModalBottomSheet(
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.only(
          topLeft: Radius.circular(20.0),
          topRight: Radius.circular(20.0),

        ),
      ), builder: (BuildContext context) =>
      Container(
        child: Padding(
          padding: const EdgeInsets.all(15.0),
          child: SingleChildScrollView(
            physics: BouncingScrollPhysics(),
            child: Column(
              children: [
                Text(
                  'Update Data',
                  style: TextStyle(
                    color: local_green,
                    fontSize: 16,
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.only(
                    top: 25,
                    bottom: 35,
                  ),
                  child: Form(
                    key: formState,
                    child: Column(
                      children: [
                        Stack(
                          alignment: Alignment.bottomRight,
                          children: [
                            Consumer<Change_data_prov>(
                              builder:(context,prov,ch)=> CircleAvatar(
                                radius: 88,
                                backgroundColor: local_green,
                                child: CircleAvatar(
                                  radius: 84,
                                  backgroundColor: Colors.white,
                                  child:

                                  prov.imgfile2 !=null ?
                                  CircleAvatar(
                                    backgroundColor: Colors.white,
                                      radius: 84,
                                      backgroundImage: FileImage(File( prov.imgfile2!.path)),)
                                      :
                                  CachedNetworkImage(
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
                                          radius: 84,
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
                                  onPressed: () => showDialog(
                                    context: context,
                                    builder: (BuildContext context) =>
                                        AlertDialog(
                                          actions: <Widget>[
                                            Center(
                                              child: Column(
                                                children: [
                                                  TextButton(
                                                    onPressed: () async{
                                                      await Provider.of<Change_data_prov>(context,listen: false).Pickimagefromsource2(ImageSource.camera);
                                                    },
                                                    style: ButtonStyle(
                                                      overlayColor:  MaterialStateProperty.all<Color>(Color.fromRGBO(85 ,195 ,136, 1).withOpacity(.2)),
                                                    ),
                                                    child: ShaderMask(
                                                      shaderCallback: (bounds) {
                                                        return RadialGradient(
                                                          center: Alignment.topLeft,
                                                          radius: 3,
                                                          colors: [Color.fromRGBO(24, 82, 66, 1),Color.fromRGBO(50, 130, 96, 1), Color.fromRGBO(70 ,167 ,119, 1),Color.fromRGBO(85 ,195 ,136, 1)],
                                                          tileMode: TileMode.repeated,
                                                        ).createShader(bounds);
                                                      },
                                                      child: Row(
                                                        mainAxisAlignment:
                                                        MainAxisAlignment.center,
                                                        children: [
                                                          Icon(IconBroken.Camera),
                                                          SizedBox(
                                                            width: 10.0,
                                                          ),
                                                          Text('Camera'),
                                                        ],
                                                      ),
                                                    ),
                                                  ),
                                                  TextButton(

                                                    style: ButtonStyle(
                                                        
                                                      overlayColor:  MaterialStateProperty.all<Color>(Color.fromRGBO(85 ,195 ,136, 1).withOpacity(.2)),
                                                    ),



                                                    onPressed: ()async {
                                                      await Provider.of<Change_data_prov>(context,listen: false).Pickimagefromsource2(ImageSource.gallery);

                                                    },
                                                    child: ShaderMask(
                                                      shaderCallback: (bounds) {
                                                        return RadialGradient(
                                                          center: Alignment.topLeft,
                                                          radius: 3,
                                                          colors: [Color.fromRGBO(24, 82, 66, 1),Color.fromRGBO(50, 130, 96, 1), Color.fromRGBO(70 ,167 ,119, 1),Color.fromRGBO(85 ,195 ,136, 1)],
                                                          tileMode: TileMode.repeated,
                                                        ).createShader(bounds);
                                                      },
                                                      child: Row(
                                                        mainAxisAlignment:
                                                        MainAxisAlignment.center,
                                                        children: [
                                                          Icon(IconBroken.Image_2),
                                                          SizedBox(
                                                            width: 10.0,
                                                          ),
                                                          Text('Gallery'),
                                                        ],
                                                      ),
                                                    ),
                                                  ),
                                                ],
                                              ),
                                            )
                                          ],
                                        ),
                                  ),
                                  icon: Icon(IconBroken.Camera,color: local_green,),
                                ),
                                radius: 22,
                                backgroundColor: Colors.grey[50],
                              ),
                            ),
                          ],
                        ),
                        SizedBox(
                          height: 30,
                        ),
                        TextFormField(
                          controller: fullNameController,
                          cursorColor: local_green,
                          keyboardType: TextInputType.text,
                          validator: ( value) {
                            if (value!.isEmpty) {
                              return 'Please enter your name';
                            }
                            return null;
                          },
                          decoration: InputDecoration(
                            filled: true,
                            fillColor: Colors.white,
                            labelText: 'Full Name',
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
                        SizedBox(
                          height: 20,
                        ),
                        TextFormField(
                          controller: emailController,
                          cursorColor: local_green,
                          keyboardType: TextInputType.emailAddress,
                          validator: ( value) {
                            if (value!.isEmpty) {
                              return 'Please enter your email';
                            }
                            return null;
                          },
                          decoration: InputDecoration(
                            filled: true,
                            fillColor: Colors.white,
                            labelText: 'Email',
                            labelStyle: TextStyle(
                              color: local_green
                            ),
                            prefixIcon: Icon(IconBroken.Message,color: Colors.grey,),
                            enabledBorder: enabledBorder,
                            focusedBorder: focusedBorder,
                            errorBorder: enabledBorder,
                            focusedErrorBorder: focusedBorder,
                          ),
                        ),
                        SizedBox(
                          height: 20,
                        ),
                        TextFormField(
                          controller: phoneController,
                          cursorColor: local_green,
                          keyboardType: TextInputType.phone,
                          maxLength: 11,
                          validator: ( value) {
                            if (value!.isEmpty) {
                              return 'Please enter your phone number';
                            }
                            return null;
                          },
                          decoration: InputDecoration(
                            filled: true,
                            fillColor: Colors.white,
                            labelText: 'Phone',
                            labelStyle: TextStyle(
                                color: local_green
                            ),
                            prefixIcon: Icon(IconBroken.Call,color: Colors.grey,),
                            enabledBorder: enabledBorder,
                            focusedBorder: focusedBorder,
                            errorBorder: enabledBorder,
                            focusedErrorBorder: focusedBorder,
                          ),
                        ),
                        SizedBox(
                          height: 20,
                        ),
                        Mbutton(width: width, height: height, colors: [ Color.fromRGBO(59, 221, 175, 1.0),
                          Color.fromRGBO(39, 140, 111, 1),
                          Color.fromRGBO(39, 140, 111, 1),
                          local_green,], txt: "Confirm Data", wid: Icon(IconBroken.Shield_Done,color: Colors.white,), func: ()=>()async{
                         if(Provider.of<Change_data_prov>(context,listen: false).imgfile2 !=null)
                         {
                           Provider.of<Update_data_prov>(context,listen: false).Update_data(
                               name: fullNameController.text, email:emailController.text, imgfile:File(Provider.of<Change_data_prov>(context,listen: false).imgfile2!.path) , phone: phoneController.text).then((val) async {
                                 if(val.status==true)
                                   {
                                     await Provider.of<shared_pref_prov>(context,listen: false).user_db(Provider.of<Update_data_prov>(context,listen: false).authjson);
                                     await Provider.of<shared_pref_prov>(context,listen: false).get_db();
                                     Navigator.of(context).pop();
                                     MY_toast(ctx: context, height: height, width: width, desc: val.message.toString());
                                   }
                                 else{

                             Fail_toast(ctx: context, title: "Failed", height: height, width: width, desc:val.message.toString() );

                           }






                           });
                         }
                         else
                           {
                             Fail_toast(ctx: context, title: "Failed", height: height, width: width, desc: "Check your data entered");
                           }
                       
                        })
                            
                      ],
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
      context: context
  );
}


