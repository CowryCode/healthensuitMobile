import 'package:cron/cron.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/material.dart';
import 'package:healthensuite/api/network.dart';
import 'package:healthensuite/screens/login/login_screen.dart';
import 'dart:ui';
import 'package:healthensuite/utilities/constants.dart';
import 'package:healthensuite/screens/programs/program_content.dart';

// void main() => runApp(new MyApp());

Future<void> main() async {
  await init(); // Added now
  runApp(MyApp());
}

Future init() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();

  FirebaseMessaging.instance.getToken().then((token){
    ApiAccess().saveDeviceIdentifier(code: token);
    print("token $token");
  });
}


class MyApp extends StatelessWidget {

  @override
  Widget build(BuildContext context) {

    double screenWidth = window.physicalSize.width;

    return new MaterialApp(
      theme: new ThemeData(primarySwatch: appBackgroundMaterialColor, textTheme: screenWidth < 500 ? TEXT_THEME_SMALL : TEXT_THEME_DEFAULT, fontFamily: "Montserrat"),
      home: LoginScreen(),
     // home: AppNotification(),
    );
  }
}

// class AppNotification extends StatefulWidget {
//
//   @override
//   _AppNotificationState createState() => _AppNotificationState();
// }


// class _AppNotificationState extends State<AppNotification> {
  // Add the local notification package
  // Add permission to android device
  // Create Notification system

  //  late FlutterLocalNotificationsPlugin _localNotification;
  //
  // FlutterLocalNotificationsPlugin get localNotification => _localNotification;
  //
  // final cron = Cron();
  // set localNotification(FlutterLocalNotificationsPlugin localNotification) {
  //   _localNotification = localNotification;
  // }

  // @override
  // void initState() {
  //   // TODO: implement initState
  //   super.initState();
  //   var androidInitialize = AndroidInitializationSettings("ic_launcher");
  //   var iosInitialize = IOSInitializationSettings();
  //   var initializeSetting = InitializationSettings(android: androidInitialize, iOS: iosInitialize);
  //
  //   localNotification = FlutterLocalNotificationsPlugin();
  //   localNotification.initialize(initializeSetting);
  //
  //   cron.schedule(Schedule.parse("1 5 8 * * *"), () async{
  //     print("Print this every 15th mintute of the hour ${DateTime.now()}");
  //     _showNotification();
  //   });
  // }

  // Future _showNotification() async{
  //   var androidDetails = AndroidNotificationDetails(
  //       "channelId",
  //       "Local Notification",
  //       "This is the description of the notifcation we created now",
  //     importance: Importance.high
  //   );
  //   var iosDetails = IOSNotificationDetails();
  //   var generalNotificationDetails = NotificationDetails(android: androidDetails, iOS: iosDetails);
  //   await localNotification.show(0, "Notify Title", "The body of the Notifcation", generalNotificationDetails);
  // }




  // @override
  // Widget build(BuildContext context) {
  //   return Scaffold(
  //     body: Center(
  //       child: Text("Click this button to recive notifcation"),
  //     ),
  //     floatingActionButton: FloatingActionButton(
  //       onPressed: _showNotification,
  //       child: Icon(Icons.notifications_active),
  //     ),
  //   );
  //   //return Container();
  // }
// }



