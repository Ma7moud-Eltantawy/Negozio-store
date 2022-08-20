import 'package:alan_voice/alan_voice.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:negozio_store/network/Network/auth.dart';
import 'package:negozio_store/styles/Local_Styles.dart';
import 'package:negozio_store/widgets/Motion_toast.dart';
import 'package:negozio_store/widgets/drawer.dart';
import 'package:provider/provider.dart';
import 'package:rflutter_alert/rflutter_alert.dart';

import '../../Providers/Change_data_prov.dart';
import '../../Providers/Shared_pref.dart';
import '../../styles/icons.dart';
import '../../widgets/material_button.dart';
class more_informtion_Screen extends StatefulWidget {
  static const scid="more_informtion";
  const more_informtion_Screen({Key? key}) : super(key: key);

  @override
  _more_informtion_ScreenState createState() => _more_informtion_ScreenState();
}

class _more_informtion_ScreenState extends State<more_informtion_Screen> {
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



    return SafeArea(
      child: Scaffold(

        body: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children:[

              Container(
                  alignment: Alignment.centerRight,
                  decoration: const BoxDecoration(
                    image: DecorationImage(
                        image: AssetImage('assets/img/back.png'),
                        opacity: 0.3,
                        fit:BoxFit.cover
                    ),
                  ),
                  height: height/3.5,
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Image.asset('assets/img/logopic.png',height: height/12,),
                      ShaderMask(


                        shaderCallback: (bounds) {
                          return RadialGradient(
                            center: Alignment.topLeft,
                            radius: 10,
                            colors: [Color.fromRGBO(24, 82, 66, 1),Color.fromRGBO(85 ,195 ,136, 1)],
                            tileMode: TileMode.repeated,
                          ).createShader(bounds);
                        },
                        child:   Container(

                            child: Text("N E G O Z I O",style: TextStyle(
                                fontSize: height/22,
                                fontFamily: 'CMSansSerif',
                                fontWeight: FontWeight.w900,
                                color: Colors.white
                            ),)
                        ),
                      ),


                    ],
                  )
              ),
              Container(

                height: height/2.5,
                alignment: Alignment.centerRight,
                width: width,
                margin: EdgeInsets.symmetric(horizontal: width/25,vertical: height/60),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Stack(
                      children: [
                        SizedBox(
                          height: height/3,
                          width: width,
                          child: Card(
                            shape: const CircleBorder(),
                            color: local_green.withOpacity(.2),
                            child: Consumer<Change_data_prov>(
                              builder:(context,prov,ch)=> Container(
                                decoration: BoxDecoration(
                                  image:prov.imgfile==null?const DecorationImage(
                                      image: AssetImage('assets/img/def_img.png'),
                                      fit: BoxFit.cover
                                  ): DecorationImage(
                                      image: FileImage(prov.imgfile!),
                                      fit: BoxFit.cover
                                  ),
                                  shape: BoxShape.circle,
                                  border: Border.all(color:local_green.withOpacity(.3),width: width/200),
                                ),
                              ),
                            ),
                          ),
                        ),
                        Positioned(
                          bottom: height/20,
                          right: width/8,
                          child: GestureDetector(
                            onTap: () => showDialog(
                              context: context,
                              builder: (BuildContext context) =>
                                  AlertDialog(
                                    actions: <Widget>[
                                      Center(
                                        child: Column(
                                          children: [
                                            TextButton(
                                              onPressed: () async{
                                                await Provider.of<Change_data_prov>(context,listen: false).Pickimagefromsource(ImageSource.camera);
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

                                              onPressed: ()async {
                                                await Provider.of<Change_data_prov>(context,listen: false).Pickimagefromsource(ImageSource.gallery);

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
                            child: SizedBox(

                              height: height/20,
                              width: width/10,
                              child: Card(
                                shape: const CircleBorder(),
                                color: Theme.of(context).unselectedWidgetColor,
                                child: Container(

                                  child: Center(
                                    child: Icon(Icons.add,color: Colors.white,size: width/22,),
                                  ),
                                  decoration: BoxDecoration(
                                    color: local_green.withOpacity(.6),

                                    shape: BoxShape.circle,
                                    border: Border.all(color: local_green.withOpacity(.3),width: width/200),
                                  ),
                                ),
                              ),
                            ),
                          ),),

                      ],
                    ),





                  ],
                ),
              ),



              /*-----------------------------------------------------------------*/


              Padding(
                padding: EdgeInsets.symmetric(horizontal: width/28),
                child: Mbutton(width: width, height: height,

                    func: ()=>()async{

                      var pr=Provider.of<Auth_prov>(context,listen: false);

                      try{
                        await  Provider.of<Auth_prov>(context,listen: false).Signup(name:pr.suname , email: pr.suemail, password: pr.supass, imgfile: Provider.of<Change_data_prov>(context,listen: false).imgfile!, phone: pr.phone);
                        if(pr.User_data!.status==true)
                        {
                          await Provider.of<shared_pref_prov>(context,listen: false).user_db( pr.authjson);
                          await Provider.of<shared_pref_prov>(context,listen: false).get_db();
                          Navigator.of(context).pushAndRemoveUntil(
                              MaterialPageRoute(builder: (context) => Zoom()),
                                  (Route<dynamic> route) => false);
                          MY_toast(ctx: context, height: height, width: width, desc: pr.User_data!.message.toString());

                        }
                        else
                        {
                          Fail_toast(title:"fail",ctx: context, height: height, width: width, desc: pr.User_data!.message.toString());
                        }
                      }
                      catch(e)
                      {
                        Fail_toast(title:"failed",ctx: context, height: height, width: width, desc: "Check that the information entered is correct..!");
                      }



                    },colors:  [
                      Color.fromRGBO(59, 221, 175, 1.0),
                      Color.fromRGBO(39, 140, 111, 1),
                      Color.fromRGBO(39, 140, 111, 1),
                      local_green,
                    ], txt: "Save data & Go to home page",
                    wid: Icon(Icons.arrow_forward,color: Colors.white,size: height/30,)
                ),
              ),
              SizedBox(height: height/80),

              SizedBox(height: height/320,),
              Container(

                  child:Row(mainAxisAlignment: MainAxisAlignment.center,
                    textDirection: TextDirection.ltr,
                    children: [
                      Text("do you wouldn't add your photo ?",style: Theme.of(context).textTheme.bodyText1!.copyWith(
                          fontSize: width/30,
                          color: Colors.black26,

                          fontWeight: FontWeight.w600
                      )
                      ),
                      SizedBox(width: width/35,),
                      GestureDetector(
                        onTap: (){
                          //Navigator.of(context).pushNamed(Login_Screen.scid);
                        },
                        child: Text("Skip",style: Theme.of(context).textTheme.bodyText1!.copyWith(
                            fontSize: width/28,
                            color:  local_green,

                            fontWeight: FontWeight.w600
                        )
                        ),
                      ),
                    ],
                  )
              ),


            ],

          ),
        ),
      ),
    );
  }
}

class txt extends StatelessWidget {
  const txt({
    required this.text
  });
  final String? text;
  @override
  Widget build(BuildContext context) {
    return Container(
      alignment: Alignment.centerRight,
      child: Text(text!,style: Theme.of(context).textTheme.bodyText1!.copyWith(
          fontSize: 14,
          color: Colors.black38,
          fontFamily: 'cairo',
          fontWeight: FontWeight.w600
      )
      ),
    );
  }
}
