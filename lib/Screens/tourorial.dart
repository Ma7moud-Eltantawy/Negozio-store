import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_svg/svg.dart';
import 'package:negozio_store/Screens/auth/Login.dart';
import 'package:shared_preferences/shared_preferences.dart';

import 'package:smooth_page_indicator/smooth_page_indicator.dart';

class BoardingModel {
  final String image;
  final String title;
  final String body;

  BoardingModel(
      {required this.image, required this.title, required this.body});
}

List<BoardingModel> boarding = [
  BoardingModel(
      image: 'assets/img/Online shopping-pana.png',
      title: 'Welcome to Negozio app',
      body:
      'this app allows consumers to directly buy goods or services from a seller over the Internet using app.'),
  BoardingModel(
      image: 'assets/img/Questions-pana.png',
      title: 'What are you thinking?',
      body:
      'The application provides all the products you are considering, for example (electronic, sports, ...., etc.)'),
  BoardingModel(
      image: 'assets/img/Online Groceries-pana.png',
      title: 'select products',
      body:
      'Select all the required products and add them to the shopping cart.'),


  BoardingModel(
      image: 'assets/img/Online Groceries-rafiki.png',
      title: 'make an order',
      body:
      'You can make an order by adding your personal information (name, location) and then confirming this order'),
  BoardingModel(
      image: 'assets/img/Take Away-pana.png',

      title: 'Wait for the order to be delivered',
      body:
      'Your order will reach you within a maximum of two days, we wish you a special service and happy days.'),

];

class OnBoardingScreen extends StatefulWidget {
  @override
  _OnBoardingScreenState createState() => _OnBoardingScreenState();
}

class _OnBoardingScreenState extends State<OnBoardingScreen> {
  PageController boardController = PageController();

  bool isLast = false;

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        Container(
          width: MediaQuery.of(context).size.width,
          height: MediaQuery.of(context).size.height,
          child: SvgPicture.asset(
            'assets/img/totback.svg',
            fit: BoxFit.cover,
          ),
        ),
        Scaffold(
          backgroundColor: Colors.transparent,
          body: AnnotatedRegion<SystemUiOverlayStyle>(
            value: SystemUiOverlayStyle(
                statusBarColor: Colors.transparent,
                statusBarIconBrightness: Brightness.dark
            ),
            child: SafeArea(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Align(
                    alignment: Alignment.topRight,
                    child: TextButton(
                      style: ButtonStyle(
                        overlayColor:  MaterialStateProperty.all<Color>(Color.fromRGBO(85 ,195 ,136, 1).withOpacity(.2)),
                      ),
                        onPressed: submit,

                        child: Text(
                          'Skip',
                          style: TextStyle(

                            color: Color.fromRGBO(24, 82, 66, .5),
                            fontSize: 20,
                          ),
                        )),
                  ),
                  Expanded(
                    child: PageView.builder(
                      onPageChanged: (int index) {
                        if (index == boarding.length - 1) {
                          setState(() {
                            isLast = true;
                          });
                        } else {
                          setState(() {
                            isLast = false;
                          });
                        }
                      },
                      controller: boardController,
                      physics: BouncingScrollPhysics(),
                      itemBuilder: (context, index) {
                        return buildBoardingItem(boarding[index]);
                      },
                      itemCount: boarding.length,
                    ),
                  ),
                  Center(
                    child: Padding(
                      padding: const EdgeInsets.only(bottom: 70),
                      child: SmoothPageIndicator(
                        controller: boardController,
                        count: boarding.length,
                        effect: ExpandingDotsEffect(
                          dotColor: Colors.grey,
                          dotHeight: 10,
                          dotWidth: 10,
                          expansionFactor: 4,
                          spacing: 5,
                          activeDotColor: Color.fromRGBO(24, 82, 66, 1),
                        ),
                      ),
                    ),
                  ),
                  !isLast
                      ? Align(
                    alignment: Alignment.bottomRight,
                    child: Padding(
                      padding: const EdgeInsets.only(bottom: 50.0),
                      child: TextButton(
                          onPressed: () {
                            boardController.nextPage(
                                duration: Duration(milliseconds: 750),
                                curve: Curves.fastLinearToSlowEaseIn);
                          },
                          child: Row(
                            mainAxisSize: MainAxisSize.min,
                            children: [
                              Text(
                                'Next',
                                style: TextStyle(
                                    color: Colors.grey, fontSize: 22),
                              ),
                              Baseline(
                                  baseline: 33,
                                  baselineType: TextBaseline.alphabetic,
                                  child: Icon(
                                    Icons.arrow_forward,
                                    color: Colors.grey,
                                    size: 30,
                                  ))
                            ],
                          )),
                    ),
                  )
                      : Align(
                    alignment: Alignment.bottomRight,
                    child: Padding(
                      padding: const EdgeInsets.only(bottom: 50.0),
                      child: TextButton(
                        style: ButtonStyle(
                          overlayColor:  MaterialStateProperty.all<Color>(Color.fromRGBO(85 ,195 ,136, 1).withOpacity(.2)),
                        ),
                          onPressed: submit,
                          child: Row(
                            mainAxisSize: MainAxisSize.min,
                            children: [
                              Text(
                                'Get Started',
                                style: TextStyle(
                                    color: Color.fromRGBO(24, 82, 66, 1), fontSize: 22),
                              ),
                              Baseline(
                                  baseline: 33,
                                  baselineType: TextBaseline.alphabetic,
                                  child: Icon(
                                    Icons.arrow_forward,
                                    color: Color.fromRGBO(24, 82, 66, 1),
                                    size: 30,
                                  ))
                            ],
                          )),
                    ),
                  ),
                ],
              ),
            ),
          ),
        )
      ],
    );
  }

  Widget buildBoardingItem(BoardingModel model) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 20.0, horizontal: 15.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Center(
              child: Image.asset(
                '${model.image}',
                width: 280,
                height: 280,
              )),
          SizedBox(
            height: 30,
          ),
          Text(
            '${model.title}',
            textDirection: TextDirection.ltr,
            textAlign: TextAlign.center,
            style: TextStyle(
                fontFamily: 'CMSansSerif', fontSize: 22, color: Colors.grey),
          ),
          SizedBox(
            height: 10,
          ),
          Text(
            '${model.body}',
            textDirection: TextDirection.ltr,
            textAlign: TextAlign.center,
            style: TextStyle(
              color: Colors.grey,
            ),
          ),
        ],
      ),
    );
  }

  void submit()async{
    final prefs = await SharedPreferences.getInstance();
    await prefs.setBool('status', false);
    Navigator.of(context).pushAndRemoveUntil(
        MaterialPageRoute(builder: (context) => Login_Screen()),
            (Route<dynamic> route) => false);


  }
}
