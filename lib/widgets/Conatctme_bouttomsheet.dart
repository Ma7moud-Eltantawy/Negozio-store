import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:modal_bottom_sheet/modal_bottom_sheet.dart';
import 'package:negozio_store/styles/Local_Styles.dart';
import 'package:negozio_store/widgets/Motion_toast.dart';
import 'package:provider/provider.dart';
import '../Providers/Change_data_prov.dart';
import '../Providers/Shared_pref.dart';
import '../network/Network/Product_data.dart';
import '../referense.dart';
import '../styles/icons.dart';
import 'material_button.dart';

TextEditingController emailController = TextEditingController();

TextEditingController fullNameController = TextEditingController();

TextEditingController phoneController = TextEditingController();


var formState = GlobalKey<FormState>();

void Contactme_bottom_sheet(@required BuildContext context,@required double height,@required double width)
{
  showBarModalBottomSheet(
    shape: RoundedRectangleBorder(
      borderRadius: BorderRadius.only(
        topLeft: Radius.circular(20.0),
        topRight: Radius.circular(20.0),
      ),
    ),
    context: context,
    builder: (context) => Container(
      child: Padding(
        padding: const EdgeInsets.all(15.0),
        child: SingleChildScrollView(
          physics: BouncingScrollPhysics(),
          child: Column(
            children: [
              Text(
                'Contact Me',
                style: TextStyle(
                  color: local_green,
                  fontSize: width/20,
                ),
              ),
              Padding(
                padding: const EdgeInsets.only(
                  top: 25,
                  bottom: 25,
                ),
                child: Column(
                  children: [
                    Container(
                      width: MediaQuery.of(context).size.width,
                      height: height/7,
                      child: Row(
                        children: [
                          Expanded(
                            flex: 1,
                            child: Container(
                              clipBehavior: Clip.antiAlias,
                              decoration: BoxDecoration(
                                color: Colors.grey[50],
                                borderRadius: BorderRadius.circular(8.0),
                              ),
                              child: Image.asset(
                                'assets/img/tantawy.jpg',
                                fit: BoxFit.cover,
                              ),
                            ),
                          ),
                          SizedBox(
                            width: 10.0,
                          ),
                          Expanded(
                            flex: 2,
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              mainAxisSize: MainAxisSize.max,
                              children: [
                                Text('Mahmoud Moustafa Eltantawy',style: TextStyle(fontSize: width/30),),
                                Text('Aga,Dk,Egypt',style: TextStyle(fontSize: width/30),),
                                Row(
                                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                  children: [
                                    InkWell(
                                      onTap:(){
                                        final url = 'https://www.facebook.com/mahmoud.eltantawy.3990';
                                        Launch_link(url);
                                      },
                                      child: Container(
                                        height: height/15,
                                        width: width/7,
                                        child: Image.asset(
                                          'assets/img/facebook.png',
                                          fit: BoxFit.cover,
                                        ),
                                      ),
                                    ),
                                    InkWell(
                                      onTap:(){
                                        final url = 'https://www.linkedin.com/in/mahmoud-eltantawy-7b26321b1';
                                        Launch_link(url);
                                      },
                                      child: Container(
                                        height: height/15,
                                        width: width/7,
                                        child: Image.asset(
                                          'assets/img/linkedIn_PNG9.png',
                                          fit: BoxFit.cover,
                                        ),
                                      ),
                                    ),
                                    InkWell(
                                      onTap:(){
                                        final url = 'https://wa.me/+2001015876911';
                                        Launch_link(url);
                                      },
                                      child: Container(
                                        height: height/15,
                                        width: width/7,
                                        child: Image.asset(
                                          'assets/img/whatsapp.png',
                                          fit: BoxFit.cover,
                                        ),
                                      ),
                                    ),
                                    InkWell(
                                      onTap: (){
                                        final url = 'https://www.instagram.com/ma7moud_eltantawy_/?igshid=YmMyMTA2M2Y=';
                                        Launch_link(url);
                                      },
                                      child: Container(
                                        height: height/15,
                                        width: width/7,
                                        child: Image.asset(
                                          'assets/img/instagram.png',
                                          fit: BoxFit.cover,
                                        ),
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
                    SizedBox(
                      height: 20,
                    ),
                    Mbutton(width: width, height: height, colors: [
                      Color.fromRGBO(59, 221, 175, 1.0),
                      Color.fromRGBO(39, 140, 111, 1),
                      Color.fromRGBO(39, 140, 111, 1),
                      local_green,
                    ], txt: "Back", wid: Icon(IconBroken.Arrow___Left_2,color: Colors.white,), func: ()=>(){
                      Navigator.pop(context);
                    })

                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    ),
  );

}