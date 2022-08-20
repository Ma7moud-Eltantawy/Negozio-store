import 'package:flutter/material.dart';

class progress_indicator extends StatelessWidget {
  const progress_indicator({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    var size=MediaQuery.of(context).size;
    var height=size.height;
    var width=size.width;
    return ShaderMask(


      shaderCallback: (bounds) {
        return RadialGradient(
          center: Alignment.topLeft,
          radius: 1,
          colors: [Color.fromRGBO(24, 82, 66, 1),Color.fromRGBO(50, 130, 96, 1), Color.fromRGBO(70 ,167 ,119, 1),Color.fromRGBO(85 ,195 ,136, 1)],
          tileMode: TileMode.repeated,
        ).createShader(bounds);
      },
      child:   Container(
        margin: EdgeInsets.all(width/20),
        padding: EdgeInsets.all(width/20),

        child: Opacity(
          opacity:1 ,
          child: CircularProgressIndicator(
            color: Colors.white,
          ),
        ),
      ),
    );
  }
}
