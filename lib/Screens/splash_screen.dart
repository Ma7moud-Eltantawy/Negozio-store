import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:negozio_store/Providers/Shared_pref.dart';
import 'package:negozio_store/Screens/auth/Login.dart';
import 'package:negozio_store/Screens/tourorial.dart';
import 'package:loading_indicator/loading_indicator.dart';
import 'package:negozio_store/widgets/drawer.dart';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';
class Splash_screen extends StatefulWidget {
  const Splash_screen({Key? key}) : super(key: key);

  @override
  State<Splash_screen> createState() => _Splash_screenState();
}

class _Splash_screenState extends State<Splash_screen> with TickerProviderStateMixin {
  AnimationController? logocontrol,progresscontrol;
  Animation? Logo_animate,progress_animate;
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    logocontrol=AnimationController(vsync: this,duration: Duration(seconds: 5));
    Logo_animate=Tween<double>(begin: 0,end: 1).animate(CurvedAnimation(parent: logocontrol!, curve: Curves.easeInOutCubicEmphasized));
    Logo_animate!.addListener(()=>setState(() {}));
    progresscontrol=AnimationController(vsync: this,duration: Duration(seconds: 2));
    progress_animate=Tween<double>(begin: 0,end: 1).animate(CurvedAnimation(parent: logocontrol!, curve: Curves.easeInOutCubicEmphasized));
    progress_animate!.addListener(()=>setState(() {}));
    logocontrol!.forward().then((value){
      progresscontrol!.forward().then((value)async {
        final prefs = await SharedPreferences.getInstance();
        var jsonuserdata = await jsonDecode(prefs.getString('my_user').toString());
        print(jsonuserdata);
        var status=await prefs.getBool('status');

        Future.delayed(Duration(milliseconds: 500),() async {
          if(jsonuserdata!=null)
            {

              Provider.of<shared_pref_prov>(context,listen: false).get_db();
              Navigator.of(context).pushAndRemoveUntil(
                  MaterialPageRoute(builder: (context) => Zoom()),
                      (Route<dynamic> route) => false);
            }
          else{

            print(status.toString());
            status==null?
            Navigator.of(context).pushAndRemoveUntil(
                MaterialPageRoute(builder: (context) => OnBoardingScreen()),
                    (Route<dynamic> route) => false): Navigator.of(context).pushAndRemoveUntil(
                MaterialPageRoute(builder: (context) => Login_Screen()),
                    (Route<dynamic> route) => false);;
          }

        });
      });


    });
  }
  @override
  Widget build(BuildContext context) {
    var size=MediaQuery.of(context).size;
    var height=size.height;
    var width=size.width;
    return SafeArea(
      child: Scaffold(

        body: Stack(

          children: [
            Container(

              child: SvgPicture.asset("assets/img/background.svg",fit: BoxFit.cover,),

            ),
            Container(
              alignment: Alignment.center,
              color: Colors.transparent,
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Opacity(
                    opacity: Logo_animate!.value,
                    child: Center(
                      child: Image.asset(
                        'assets/img/logo.png',
                        height: height/2.5,
                        width: double.infinity,

                      ),
                    ),
                  ),
                  ShaderMask(


                    shaderCallback: (bounds) {
                      return RadialGradient(
                        center: Alignment.topLeft,
                        radius: 2,
                        colors: [Color.fromRGBO(24, 82, 66, 1),Color.fromRGBO(50, 130, 96, 1), Color.fromRGBO(70 ,167 ,119, 1),Color.fromRGBO(85 ,195 ,136, 1)],
                        tileMode: TileMode.repeated,
                      ).createShader(bounds);
                    },
                    child:   Container(
                      margin: EdgeInsets.all(width/20),
                      padding: EdgeInsets.all(width/20),

                      child: Opacity(
                        opacity:progress_animate!.value ,
                        child: Container(
                          height: height/8,
                          width: width/4,
                          child: Opacity(
                            opacity: .9,
                            child: LoadingIndicator(
                                indicatorType: Indicator.ballPulseSync, /// Required, The loading type of the widget
                                colors: const [Colors.white],       /// Optional, The color collections
                                strokeWidth: 1,

                                backgroundColor: Colors.transparent,      /// Optional, Background of the widget
                                pathBackgroundColor: Colors.transparent   /// Optional, the stroke backgroundColor
                            ),
                          ),
                        )
                      ),
                    ),
                  ),

                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
