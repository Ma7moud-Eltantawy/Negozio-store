import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:negozio_store/Providers/Shared_pref.dart';
import 'package:negozio_store/Screens/auth/signup.dart';
import 'package:negozio_store/network/Network/auth.dart';
import 'package:negozio_store/widgets/Motion_toast.dart';
import 'package:provider/provider.dart';
import 'package:modal_progress_hud_nsn/modal_progress_hud_nsn.dart';


import '../../Providers/Change_data_prov.dart';
import '../../main.dart';
import '../../styles/Local_Styles.dart';
import '../../styles/icons.dart';
import '../../widgets/Textformfield.dart';
import '../../widgets/circular_progress.dart';
import '../../widgets/drawer.dart';
import '../../widgets/material_button.dart';
import '../../widgets/myalert.dart';

class Login_Screen extends StatefulWidget {

  static const scid="Login";
  const Login_Screen({Key? key}) : super(key: key);

  @override
  _Login_ScreenState createState() => _Login_ScreenState();
}

class _Login_ScreenState extends State<Login_Screen> {
  late FocusNode _cvcFocusNode;
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    try{
      FocusScopeNode currentFocus = FocusScope.of(context);
      currentFocus.requestFocus();
    }
    catch(e)
    {
      print(e);

    }


  }
  @override
  void dispose() {


    // TODO: implement dispose
    super.dispose();
  }
  var formState = GlobalKey<FormState>();
  final  TextEditingController ? _user=TextEditingController();
  final  TextEditingController ? _pass=TextEditingController();
  @override
  Widget build(BuildContext context) {
    var size=MediaQuery.of(context).size;
    var height=size.height;
    var width=size.width;
    return AnnotatedRegion<SystemUiOverlayStyle>(
      value: SystemUiOverlayStyle(
        statusBarColor: Colors.white.withOpacity(.7),
          statusBarIconBrightness: Brightness.light
      ),
      child: SafeArea(

        child: Scaffold(
          backgroundColor: Colors.white,


          body: Consumer<Auth_prov>(
            builder:(context,prov,ch)=> ModalProgressHUD(
              progressIndicator: progress_indicator(),
              color: Colors.black54,
              inAsyncCall: prov.progress_state,
              child: SingleChildScrollView(
                child: Form(
                  key: formState,
                  child: Column(
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
                      height: height/3,
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
                        margin: EdgeInsets.symmetric(horizontal: width/28,vertical: height/60),
                        child: Column(
                          children: [


                            Opacity(
                              opacity: .8,

                              child: txtformfield(controller: _user, width: width, height: height, hinttext: 'Enter user Email or Phone number',
                                icondata:IconBroken.Message ,inputtype: TextInputType.name,
                                errortext: "",
                                fieldname: 'Email',

                              ),


                            ),



                            Opacity(
                              opacity: .8,

                              child: Center(
                                  child: Consumer<Change_data_prov>(
                                    builder:(context,pr,ch)=> TextFormField(
                                      cursorColor:local_green,
                                      textDirection: TextDirection.ltr,
                                      textAlign: TextAlign.left,
                                      textAlignVertical: TextAlignVertical.center,
                                      validator: (val)=>val!.isEmpty?"user cant be blank":null,
                                      controller: _pass,

                                      keyboardType: TextInputType.visiblePassword,
                                      obscureText: pr.showdata,
                                      style: const TextStyle(
                                        color: Colors.grey
                                      ),
                                      decoration: InputDecoration(
                                        labelText: 'Password',
                                        labelStyle: TextStyle(
                                            color:local_green
                                        ),
                                        enabledBorder: OutlineInputBorder(
                                          borderRadius: BorderRadius.circular(8.0),
                                          borderSide: BorderSide(
                                            width: 1.3,
                                            color: Colors.grey,
                                          ),
                                        ),
                                        focusedBorder: OutlineInputBorder(
                                          borderRadius: BorderRadius.circular(8.0),
                                          borderSide: BorderSide(
                                            width: 1.3,
                                            color: local_green,
                                          ),
                                        ),
                                        errorBorder:OutlineInputBorder(
                                          borderRadius: BorderRadius.circular(8.0),
                                          borderSide: BorderSide(
                                            color: Colors.grey,
                                          ),
                                        ),
                                        focusedErrorBorder: OutlineInputBorder(
                                          borderRadius: BorderRadius.circular(8.0),
                                          borderSide: BorderSide(
                                            width: 1.3,
                                            color: local_green,
                                          ),
                                        ),


                                        suffixIcon:
                                           IconButton(onPressed: () {
                                            pr.changeshow(pr.showdata);

                                          }, icon:pr.showdata? Icon(IconBroken.Hide,color: Colors.grey,): Icon(IconBroken.Show,color: local_green,),



                                          ),

                                        prefixIcon: Icon(IconBroken.Unlock,color: local_green,),


                                        hintText: 'Enter your password',
                                        hintStyle: const TextStyle(
                                            fontSize: 12,
                                            color: Colors.grey

                                        ),

                                        errorStyle: const TextStyle(

                                        ),

                                        contentPadding: EdgeInsets.only(
                                            right: width/60

                                        ),



                                    ),
                                ),
                                  ),
                              ),

                            ),
                            SizedBox(height: height/50,),

                            GestureDetector(
                              onTap: (){


                              },
                              child: Container(
                                alignment: Alignment.center,
                                child: Text("Forget Password ?",style: Theme.of(context).textTheme.bodyText1!.copyWith(
                                    fontSize: 14,
                                    color: Colors.black38,
                                    fontFamily: 'varela',
                                    fontWeight: FontWeight.w600
                                )
                                ),
                              ),
                            ),
                            SizedBox(height: height/50,),

                            Consumer<Auth_prov>(


                              builder:(context,pro,ch)=> Mbutton(width: width, height: height,
                                  func: ()=>() async {


                                    if(_user!.text.isNotEmpty&&_pass!.text.isNotEmpty)
                                  {



                                    Future vaidate()
                                    async {
                                      try{


                                        if(pro.User_data!.status.toString()=="true")

                                        {
                                          try{
                                            FocusScopeNode currentFocus = FocusScope.of(context);
                                            currentFocus.dispose();
                                          }
                                          catch(e)
                                          {
                                            print(e);

                                          }
                                          Navigator.of(context).pushAndRemoveUntil(
                                              MaterialPageRoute(builder: (context) => Zoom()),
                                                  (Route<dynamic> route) => false);
                                          MY_toast(ctx: context, height: height, width: width, desc:pro.User_data!.message.toString());


                                        }
                                        else{
                                          alertfunc(ctx: context, height: height, width: width, desc: "user name or password hass error", buttxt2: "Create account",
                                              but2:(){
                                                Navigator.pop(context);
                                              }, but1: (){
                                                Navigator.of(context).pushNamed(Signup_Screen.scid);

                                              });
                                        }
                                      }
                                      catch(e)
                                      {
                                        print("xx");



                                        alertfunc(ctx: context, height: height, width: width, desc: "user name or password hass error", buttxt2: "Create account",
                                            but2:(){
                                              Navigator.pop(context);
                                            }, but1: (){
                                              Navigator.of(context).pushNamed(Signup_Screen.scid);
                                            });

                                      }

                                    }

                                    Future<void> execute()async
                                    {

                                      prov.changestate(false);
                                      await prov.Login(_user!.text,int.parse(_pass!.text));
                                      prov.changestate(true);
                                      try{
                                        await Provider.of<shared_pref_prov>(context,listen: false).user_db( pro.authjson);
                                        await Provider.of<shared_pref_prov>(context,listen: false).get_db();
                                      }
                                      catch(e)
                                      {}


                                      await vaidate();


                                      authkey=pro.User_data!.data!.token.toString();
                                    }
                                    await execute();






                                    //await Provider.of<shared_pref_prov>(context,listen: false).user_db( pro.authjson);
                                    //Future.delayed(const Duration(seconds: 0), () async => await Provider.of<shared_pref_prov>(context,listen: false).user_db( pro.authjson));

                                    //Future.delayed(const Duration(seconds: 3), () async =>  await Provider.of<shared_pref_prov>(context,listen: false).get_db());
                                    //Future.delayed(const Duration(seconds: 1), () async =>  await vaidate());





                                  }
                                else{

                                  alertfunc(ctx: context, height: height, width: width, desc: "There is an error in the data entered", buttxt2: "Create account",
                                      but2:(){
                                        Navigator.pop(context);
                                      }, but1: (){
                                        Navigator.pop(context);
                                        Navigator.of(context).pushNamed(Signup_Screen.scid);
                                      });

                                }

                                    // Future.delayed(Duration(seconds: 0),()=> .then((json) => Provider.of<shared_pref_prov>(context,listen: false).user_db( pro.authjson)));





                                  },

                                  colors:  [
                                    Color.fromRGBO(59, 221, 175, 1.0),
                                    Color.fromRGBO(39, 140, 111, 1),
                                    Color.fromRGBO(39, 140, 111, 1),
                                    local_green,
                                  ], txt: "Login",
                                  wid: Icon(IconBroken.Login,color: Colors.white,size: height/30,)
                              ),
                            ),


                            SizedBox(height: height/30,),
                            Container(

                                child:Row(mainAxisAlignment: MainAxisAlignment.center,
                                  textDirection: TextDirection.ltr,
                                  children: [
                                    Text("You don't have any account ?",style: Theme.of(context).textTheme.bodyText1!.copyWith(
                                        fontSize: width/30,
                                        color: Colors.grey,
                                        fontFamily: 'varela',
                                        fontWeight: FontWeight.w600
                                    )
                                    ),
                                    SizedBox(width: width/35,),
                                    InkWell(
                                      onTap: (){
                                        Navigator.of(context).pushNamed(Signup_Screen.scid);
                                      },
                                      child: Text("Create account",style: Theme.of(context).textTheme.bodyText1!.copyWith(
                                          fontSize: width/30,
                                          color:  local_green,
                                          fontFamily: 'varela',
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
