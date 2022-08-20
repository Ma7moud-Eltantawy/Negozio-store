import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:alan_voice/alan_voice.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/scheduler.dart';
import 'package:geolocator/geolocator.dart';
import 'package:just_audio/just_audio.dart';
import 'package:motion_toast/motion_toast.dart';
import 'package:motion_toast/resources/arrays.dart';
import 'package:negozio_store/Providers/prov_product_info.dart';
import 'package:negozio_store/Screens/Category.dart';
import 'package:negozio_store/Screens/Favorite_Screen.dart';
import 'package:negozio_store/Screens/Home_page.dart';
import 'package:negozio_store/Screens/auth/Login.dart';
import 'package:negozio_store/Screens/Map/map_location.dart';
import 'package:negozio_store/Screens/Settings.dart';
import 'package:negozio_store/Screens/auth/Verfication.dart';
import 'package:negozio_store/Screens/auth/more_information.dart';
import 'package:negozio_store/Screens/orders/Order_make.dart';
import 'package:negozio_store/Screens/orders/orders.dart';
import 'package:negozio_store/Screens/product_info.dart';
import 'package:negozio_store/Screens/profile_screen.dart';
import 'package:negozio_store/Screens/auth/signup.dart';
import 'package:negozio_store/Screens/splash_screen.dart';
import 'package:negozio_store/network/Network/Carts.dart';
import 'package:negozio_store/network/Network/Categories.dart';
import 'package:negozio_store/network/Network/Settings.dart';
import 'package:negozio_store/network/Network/Update_data.dart';
import 'package:negozio_store/network/Network/Verfication_prov.dart';
import 'package:negozio_store/network/Network/auth.dart';
import 'package:negozio_store/network/Network/orders_prov.dart';
import 'package:negozio_store/network/models/Categories.dart';
import 'package:negozio_store/widgets/Motion_toast.dart';
import 'package:negozio_store/widgets/drawer.dart';
import 'package:provider/provider.dart';
import 'package:path/path.dart';

import 'Providers/Change_data_prov.dart';
import 'Providers/Shared_pref.dart';
import 'Screens/All_products.dart';
import 'Screens/Map/Prov_location.dart';
import 'Screens/Search_Screen.dart';
import 'Screens/carts_screen.dart';
import 'network/Network/Product_data.dart';
import 'package:fluttertoast/fluttertoast.dart';
String ?authkey;
final GlobalKey<NavigatorState> navigatorKey = GlobalKey<NavigatorState>();
class NavigationService {
  static GlobalKey<NavigatorState> navigatorKey =
  GlobalKey<NavigatorState>();
}
final FlutterLocalNotificationsPlugin flutterLocalNotificationsPlugin =
FlutterLocalNotificationsPlugin();
const AndroidNotificationChannel channel = const AndroidNotificationChannel(
  //for notificaiton initialization
  'high_importance_channel', // id
  'High Importance Notifications', // title
  description: "this",
  importance: Importance.high,
  playSound: true,
);




void main()async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  await Geolocator.requestPermission();
  AlanVoice.deactivate();


  FirebaseMessaging messaging = await FirebaseMessaging.instance;
  //Local Notification implementation
  await flutterLocalNotificationsPlugin
      .resolvePlatformSpecificImplementation<
      AndroidFlutterLocalNotificationsPlugin>()
      ?.createNotificationChannel(channel);
  //for firebase  plugin and messaging required
  await FirebaseMessaging.instance.setForegroundNotificationPresentationOptions(
      alert: true, badge: true, sound: true);


  NotificationSettings settings = await messaging.requestPermission(
    alert: true,
    announcement: false,
    badge: true,
    carPlay: false,
    criticalAlert: false,
    provisional: false,
    sound: true,
  );
  FirebaseMessaging.onMessage.listen((RemoteMessage message) {
    print('Got a message whilst in the foreground!');
    RemoteNotification? notification = message
        .notification; //assign two variables for remotenotification and android notification
    AndroidNotification? android = message.notification?.android;
    if (notification != null && android != null) {
      print(message);


      flutterLocalNotificationsPlugin.show(
        notification.hashCode,
        notification.title,
        notification.body,
        NotificationDetails(
          android: AndroidNotificationDetails(
              channel.id, channel.name,
              color: Colors.blue,

              showWhen: true,
              playSound: true,
              showProgress: false,
              icon: '@drawable/ic_launcher'),
        ),
      );

    }

  });
  FirebaseMessaging.onMessageOpenedApp.listen((event) {
    final player = AudioPlayer();
    player.pause();
    print(event.data.toString());
  });
  FirebaseMessaging.onBackgroundMessage(_firebaseMessagingBackgroundHandler);

  print('User granted permission: ${settings.authorizationStatus}');
  var token=await FirebaseMessaging.instance.getToken();
  print("------------------------------------------");
  print(token);









  runApp(
      MultiProvider(
        providers: [
          ChangeNotifierProvider.value(value:Auth_prov() ),
          ChangeNotifierProvider.value(value:Products_prov() ),
          ChangeNotifierProvider.value(value:prov_product_info() ),
          ChangeNotifierProvider.value(value:Settings_prov() ),
          ChangeNotifierProvider.value(value:Carts_prov() ),
          ChangeNotifierProvider.value(value:Prov_loc() ),
          ChangeNotifierProvider.value(value:Orders_prov() ),
          ChangeNotifierProvider.value(value:Category_prov() ),
          ChangeNotifierProvider.value(value:Change_data_prov() ),
          ChangeNotifierProvider.value(value:shared_pref_prov() ),
          ChangeNotifierProvider.value(value:Verfication_prov() ),
          ChangeNotifierProvider.value(value:Update_data_prov() ),






        ],
        child: MaterialApp(
          debugShowCheckedModeBanner: false,
          navigatorKey: navigatorKey,
          theme: ThemeData(
            fontFamily: 'varela',
          ),
          home: Splash_screen(),
          title: "negozio",
          routes: {
            Settings.scid:(context)=>Settings(),
            Home_screen.scid:(context)=>Home_screen(),
            Login_Screen.scid:(context)=>Login_Screen(),
            Signup_Screen.scid:(context)=>Signup_Screen(),
            Product_info.scid:(context)=>Product_info(),
            carts_screen.scid:(context)=>carts_screen(),
            Loc_Screen.scid:(context)=>Loc_Screen(),
            Orders_screen.scid:(context)=>Orders_screen(),
            Make_order_screen.scid:(context)=>Make_order_screen(),
            Favorite_Screen.scid:(context)=>Favorite_Screen(),
            Search_screen.scid:(context)=>Search_screen(),
            Zoom.scid:(context)=>Zoom(),

            Myprofile_screen.scid:(context)=>Myprofile_screen(),
            Categories_Screen.scid:(context)=>Categories_Screen(),
            more_informtion_Screen.scid:(context)=>more_informtion_Screen(),
            Verfication.scid:(context)=>Verfication(),




          },
        ),
      ),
      );


}

void handleCommand(Map<String, dynamic> command) {



  debugPrint("New command: ${command}");
  switch (command["command"]) {
    case "go":

      navigatorKey.currentState!.pushNamed(Categories_Screen.scid);

      //Navigator.pushNamed(NavigationService.navigatorKey.currentContext!, Categories_Screen.scid);

      break;
    case "back":


      navigatorKey.currentState!.pop();
      //Navigator.pushNamed(NavigationService.navigatorKey.currentContext!, Categories_Screen.scid);

      break;
    case "open drawer":
      z.open!();
      //Navigator.pushNamed(NavigationService.navigatorKey.currentContext!, Categories_Screen.scid);
      break;
    case "end drawer":
      z.close!();
      //Navigator.pushNamed(NavigationService.navigatorKey.currentContext!, Categories_Screen.scid);

      break;
    case "end app":
      SystemChannels.platform.invokeMethod('SystemNavigator.pop');
      break;
    case "all products":
      navigatorKey.currentState!
          .push(MaterialPageRoute(
        builder: (context) => products_grid(getdatafunc:()=> Provider.of<Products_prov>(context,listen: false).get_products()),
      ))
          .then((value) {
        // you can do what you need here
        // setState etc.
      });

      break;

    case "likes":
      navigatorKey.currentState!.pushNamed(Favorite_Screen.scid);
      break;

    case "profile":
      navigatorKey.currentState!.pushNamed(Myprofile_screen.scid);
      break;
    case "settings":
      navigatorKey.currentState!.pushNamed(Settings.scid);
      break;
    case "cart":
      print("----------------------");
      print(navigatorKey.currentState!.context);
      navigatorKey.currentState!.pushNamed(carts_screen.scid);
      break;
    case "logout":
      //navigatorKey.currentState!.pushNamed(carts_screen.scid);
      break;


    default:
      debugPrint("Unknown command: ${command}");
  }
}
Future<void> _firebaseMessagingBackgroundHandler(RemoteMessage message) async {
  // If you're going to use other Firebase services in the background, such as Firestore,
  // make sure you call `initializeApp` before using other Firebase services.

  await Firebase.initializeApp();

  print("Handling a background message: ${message.messageId}");

    //Future.delayed(Duration(seconds: 2),()=>flutterLocalNotificationsPlugin.cancelAll() );


  }
 // final player = AudioPlayer();
  // Create a player
 /* final duration = await player.setUrl(           // Load a URL
      'https://cdn.islamic.network/quran/audio/128/ar.alafasy/262.mp3');*/

 // player.play();





