import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:negozio_store/Screens/auth/Login.dart';
import 'package:negozio_store/Screens/auth/more_information.dart';
import 'package:negozio_store/network/Network/Verfication_prov.dart';
import 'package:negozio_store/network/Network/auth.dart';
import 'package:negozio_store/styles/icons.dart';
import 'package:negozio_store/widgets/material_button.dart';
import 'package:provider/provider.dart';

import '../../styles/Local_Styles.dart';
import '../../widgets/Motion_toast.dart';
class Verfication extends StatefulWidget {
  const Verfication({Key? key}) : super(key: key);
  static const scid="verfiy";


  @override
  State<Verfication> createState() => _Verfication();
}

class _Verfication extends State<Verfication> {
  final  TextEditingController ? n1=TextEditingController();
  final  TextEditingController ? n2=TextEditingController();
  final  TextEditingController ? n3=TextEditingController();
  final  TextEditingController ? n4=TextEditingController();
  final  TextEditingController ? n5=TextEditingController();
  final  TextEditingController ? n6=TextEditingController();
  String txt="";

  @override
  Widget build(BuildContext context) {
    var size=MediaQuery.of(context).size;
    var height=size.height;
    var width=size.width;
    return SafeArea(
      child: Scaffold(

        body: Stack(
          children: [
            SvgPicture.asset(
              'assets/img/back2.svg',
              fit: BoxFit.cover,
            ),
            Padding(
              padding: EdgeInsets.symmetric(horizontal: width/13),
              child:  Center(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text("check box in gmail account..",style: TextStyle(
                      color: local_green,

                    ),),
                    SizedBox(
                      height: height/15,
                    ),
                    Wrap(
                      alignment: WrapAlignment.start,
                      spacing: 4,
                      direction: Axis.horizontal,
                      runSpacing: 10,
                      children: [
                        _otpTextField(context, false,1,n1!),
                        _otpTextField(context, false,2,n2!),
                        _otpTextField(context, false,3,n3!),
                        _otpTextField(context, false,4,n4!),
                        _otpTextField(context, false,5,n5!),
                        _otpTextField(context, false,6,n6!),

                      ],
                    ),
                    SizedBox(
                      height: height/15,
                    ),
                    Mbutton(width: width, height: height, colors: [
                      Color.fromRGBO(59, 221, 175, 1.0),
                      Color.fromRGBO(39, 140, 111, 1),
                      Color.fromRGBO(39, 140, 111, 1),
                      local_green,
                    ], txt: "Verify Account", wid: Icon(IconBroken.Shield_Done,color: Colors.white,), func: ()=>(){

                      Provider.of<Verfication_prov>(context,listen:false ).Verifyotp(Provider.of<Auth_prov>(context,listen: false).suemail,txt).then((val) async {
                       if(val.toString()=="true")
                         {
                           try
                           {
                             FocusScopeNode currentFocus = FocusScope.of(context);
                             currentFocus.unfocus();
                           }
                           catch(e)
                           {

                           }
                           Navigator.of(context).pushNamed(more_informtion_Screen.scid);
                           MY_toast(ctx: context, height: height, width: width, desc: "Validation success ✅");
                           try
                           {
                             FocusScopeNode currentFocus = FocusScope.of(context);
                             currentFocus.dispose();
                           }
                           catch(e)
                           {

                           }


                         }
                       else
                         {
                           try
                           {
                             FocusScope.of(context).dispose();
                           }
                           catch(e)
                           {

                           }

                           Fail_toast(ctx: context, height: height, width: width, desc: "Validation failure ❌", title: 'Failed');

                         }
                      });
                    

                    })
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );


  }
  Widget _otpTextField(BuildContext context, bool autoFocus,int num,TextEditingController con) {
    return  Container(
      height: MediaQuery.of(context).size.shortestSide * 0.13,
      decoration: BoxDecoration(
        border: Border.all(color: Colors.grey),
        borderRadius: BorderRadius.circular(5),
        color: Colors.white,
        shape: BoxShape.rectangle,
      ),
      child: AspectRatio(
        aspectRatio: 1,
        child: TextField(
          controller: con,
          autofocus: autoFocus,
          decoration: InputDecoration(
            border: InputBorder.none,
          ),
          textAlign: TextAlign.center,
          keyboardType: TextInputType.number,
          style: TextStyle(),
          cursorColor: local_green,
          maxLines: 1,
          onTap: (){

          },
          onChanged: (value) {
            setState(() {
              txt=n1!.text+n2!.text+n3!.text+n4!.text+n5!.text+n6!.text;
              print(txt);
            });

            print(value);
            if(value.length == 1 && num!=6) {


              FocusScope.of(context).nextFocus();
            }
          },
        ),
      ),
    );
  }
}
