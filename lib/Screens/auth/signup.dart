import 'package:flutter/material.dart';
import 'package:negozio_store/Screens/auth/Login.dart';
import 'package:negozio_store/Screens/auth/Verfication.dart';
import 'package:negozio_store/Screens/auth/more_information.dart';
import 'package:negozio_store/network/Network/Verfication_prov.dart';
import 'package:provider/provider.dart';
import '../../Providers/Change_data_prov.dart';
import '../../network/Network/auth.dart';
import '../../styles/Local_Styles.dart';
import '../../styles/icons.dart';
import '../../widgets/Motion_toast.dart';
import '../../widgets/Textformfield.dart';
import '../../widgets/material_button.dart';
import '../../widgets/myalert.dart';
class Signup_Screen extends StatefulWidget {
  static const scid="signup";
  const Signup_Screen({Key? key}) : super(key: key);

  @override
  _Signup_ScreenState createState() => _Signup_ScreenState();
}

class _Signup_ScreenState extends State<Signup_Screen> {
  final  TextEditingController ? _user=TextEditingController();
  final  TextEditingController ? _name=TextEditingController();
  final  TextEditingController ? _phone=TextEditingController();
  final  TextEditingController ? _pass=TextEditingController();
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
              Consumer<Auth_prov>(
                builder:(context,prov,ch)=> Container(
                  alignment: Alignment.centerRight,
                  width: width,
                  margin: EdgeInsets.symmetric(horizontal: width/25),
                  child: Column(
                    children: [

                      Opacity(
                        opacity: .8,

                        child: txtformfield(controller: _name, width: width, height: height, hinttext: 'Enter Full Name',
                          icondata:IconBroken.User ,inputtype: TextInputType.name,
                          errortext: prov.sunamemsg,
                          fieldname: 'Name',

                        ),


                      ),
                      SizedBox(height: height/60,),
                      Opacity(
                        opacity: .8,

                        child: txtformfield(controller: _user, width: width, height: height, hinttext: 'Enter user Email or Phone number',
                          icondata:IconBroken.Message ,inputtype: TextInputType.name,
                          errortext: prov.suemailmsg,
                          fieldname: 'Email',

                        ),


                      ),
                      SizedBox(height: height/60,),
                      Opacity(
                        opacity: .8,

                        child: txtformfield(controller: _phone, width: width, height: height, hinttext: 'Enter user Email or Phone number',
                          icondata:IconBroken.Call ,inputtype: TextInputType.phone,
                          errortext:prov.suphonemsg,
                          fieldname: 'Phone',

                        ),


                      ),
                      SizedBox(height: height/60,),

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

                                }, icon:pr.showdata? Icon(IconBroken.Hide,color: Colors.grey,): Icon(IconBroken.Show,color: local_green,)



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

                    ],
                  ),
                ),
              ),

              SizedBox(height: height/60,),



              /*-----------------------------------------------------------------*/

              Consumer<Auth_prov>(
                builder:(context,pro,ch)=> Container(
                  margin: EdgeInsets.symmetric(horizontal: width/28,vertical: height/60),
                  child: Mbutton(width: width, height: height,
                      func: ()=>()async{
                    pro.validateuser(_name!.text, _phone!.text, _user!.text, _pass!.text);
                    if(pro.suemailmsg.isEmpty&&pro.sunamemsg.isEmpty&&pro.supassmsg.isEmpty &&pro.suphonemsg.isEmpty)
                      {
                        Navigator.of(context).pushNamed(Verfication.scid);
                        Provider.of<Verfication_prov>(context,listen: false).sendOtp(_user!.text);
                      }


                      },

                      colors:  [
                        Color.fromRGBO(59, 221, 175, 1.0),
                        Color.fromRGBO(39, 140, 111, 1),
                        Color.fromRGBO(39, 140, 111, 1),
                        local_green,
                      ], txt: "Signup",
                      wid: Icon(IconBroken.Add_User,color: Colors.white,size: height/30,)
                  ),
                ),
              ),
              SizedBox(height: height/80,),

              SizedBox(height: height/50,),
              Container(

                  child:Row(mainAxisAlignment: MainAxisAlignment.center,
                    textDirection: TextDirection.ltr,
                    children: [
                      Text("Already have an account ?",style: Theme.of(context).textTheme.bodyText1!.copyWith(
                          fontSize: width/30,
                          color: Colors.black26,
                          fontFamily: 'varela',
                          fontWeight: FontWeight.w600
                      )
                      ),
                      SizedBox(width: width/35,),
                      GestureDetector(
                        onTap: (){
                          Navigator.of(context).pushNamed(Login_Screen.scid);
                        },
                        child: Text("Login",style: Theme.of(context).textTheme.bodyText1!.copyWith(
                            fontSize:width/30,
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
