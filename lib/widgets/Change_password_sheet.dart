import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:modal_bottom_sheet/modal_bottom_sheet.dart';
import 'package:negozio_store/network/Network/Update_data.dart';
import 'package:negozio_store/styles/Local_Styles.dart';
import 'package:negozio_store/widgets/Motion_toast.dart';
import 'package:provider/provider.dart';
import '../Providers/Change_data_prov.dart';
import '../Providers/Shared_pref.dart';
import '../network/Network/Product_data.dart';
import '../referense.dart';
import '../styles/icons.dart';
import 'material_button.dart';

TextEditingController currentPasswordController = TextEditingController();
TextEditingController newPasswordController = TextEditingController();


var formState = GlobalKey<FormState>();

void Changepassword_bottom_sheet(@required BuildContext context,@required double height,@required double width)
{
  showBarModalBottomSheet(
    shape: RoundedRectangleBorder(
      borderRadius: BorderRadius.only(
        topLeft: Radius.circular(20.0),
        topRight: Radius.circular(20.0),
      ),
    ),
    context: context,
    builder: (context) =>
        Container(
          child: Padding(
            padding: const EdgeInsets.all(15.0),
            child: SingleChildScrollView(
              physics: BouncingScrollPhysics(),
              child: Column(
                children: [
                  Text(
                    'Change Password',
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
                    child: Consumer<Change_data_prov>(
                      builder:(context,pr,ch)=> Form(
                        key: formState,
                        child: Column(
                          children: [
                            Consumer<Change_data_prov>(
                              builder:(context,pr,ch)=>TextFormField(
                                controller: currentPasswordController,
                                cursorColor: local_green,
                                keyboardType: TextInputType.visiblePassword,
                                obscureText:pr.showdata2,
                                decoration: InputDecoration(
                                  filled: true,
                                  fillColor: Colors.white,
                                  labelText: 'Current Password',
                                  labelStyle: TextStyle(
                                      color: local_green
                                  ),
                                  prefixIcon: Icon(IconBroken.Unlock,color: local_green,),
                                  suffixIcon:
                                  IconButton(onPressed: () {
                                    pr.change2show(pr.showdata2);

                                  }, icon:pr.showdata2? Icon(IconBroken.Show,color: local_green,): Icon(IconBroken.Hide,color: Colors.grey,),



                                  ),
                                  enabledBorder: enabledBorder,
                                  focusedBorder: focusedBorder,
                                  errorBorder: enabledBorder,
                                  focusedErrorBorder: focusedBorder,
                                ),
                              ),
                            ),
                            SizedBox(
                              height: 20,
                            ),
                            Consumer<Change_data_prov>(
                              builder:(context,pr,ch)=>TextFormField(
                                controller: newPasswordController,
                                cursorColor: local_green,
                                keyboardType: TextInputType.visiblePassword,
                                obscureText:pr.showdata3,
                                decoration: InputDecoration(
                                  filled: true,
                                  fillColor: Colors.white,
                                  labelText: 'Current Password',
                                  labelStyle: TextStyle(
                                      color: local_green
                                  ),
                                  prefixIcon: Icon(IconBroken.Unlock,color: local_green,),
                                  suffixIcon:
                                  IconButton(onPressed: () {
                                    pr.change2show(pr.showdata3);

                                  }, icon:pr.showdata3? Icon(IconBroken.Show,color: local_green,): Icon(IconBroken.Hide,color: Colors.grey,),



                                  ),
                                  enabledBorder: enabledBorder,
                                  focusedBorder: focusedBorder,
                                  errorBorder: enabledBorder,
                                  focusedErrorBorder: focusedBorder,
                                ),
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
                            ], txt: 'Change Password', wid: Icon(IconBroken.Edit,color: Colors.white,), func: ()=>(){

                              Provider.of<Update_data_prov>(context,listen:false).Changepassword(currentPasswordController.text, newPasswordController.text).then((Val){
                                Navigator.of(context).pop();
                                Val['status'].toString()=="true"?
                                MY_toast(ctx: context, height: height, width: width, desc:Val['message'] ): Fail_toast(ctx: context, height: height, width: width, desc:Val['message'], title: 'failed');
                              });

                            })

                          ],
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
  );

}



