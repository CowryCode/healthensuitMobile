import 'dart:async';
import 'dart:io';

import 'package:cron/cron.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/material.dart';
import 'package:flutter_redux/flutter_redux.dart';
import 'package:healthensuite/api/network.dart';
import 'package:healthensuite/api/networkUtilities.dart';
import 'package:healthensuite/api/networkmodels/interventionlevels/leveltwoVariables.dart';
import 'package:healthensuite/api/networkmodels/loginPodo.dart';
import 'package:healthensuite/api/networkmodels/patientProfilePodo.dart';
import 'package:healthensuite/api/networkmodels/sleepDiaryPODO.dart';
import 'package:healthensuite/api/statemanagement/actions.dart';
import 'package:healthensuite/api/statemanagement/app_state.dart';
import 'package:healthensuite/api/statemanagement/diskstorage.dart';
import 'package:healthensuite/api/statemanagement/reducer.dart';
import 'package:healthensuite/screens/home/home_screen.dart';
import 'package:healthensuite/screens/login/login_screen.dart';
import 'dart:ui';
import 'package:healthensuite/utilities/constants.dart';
import 'package:redux/redux.dart';
// void main() => runApp(new MyApp());
//bool? loginStatus;
Future<bool>? loginStatus;
// Future<void> main() async{
//   WidgetsFlutterBinding.ensureInitialized();
//   await Firebase.initializeApp();
//   await init();
//   // *************** Update ************
//   loginStatus = await Localstorage().getBoolean(key_Login_Status);
//   ((){
//     print("LOGIN STATUS IS ${loginStatus}");
//     if(loginStatus == true){
//       runApp(MyAppLoginScreen(loginStatus: true,));
//     }else{
//       runApp(MyAppLoginScreen(loginStatus: false,));
//     }
//   }());
// }

void main() async{
  //Firebase.initializeApp();
  await WidgetsFlutterBinding.ensureInitialized();
  await init();


  // *************** Update ************
  loginStatus =  Localstorage().getBooleanNotNullable(key_Login_Status);

  ((){
    if(loginStatus != null) {
      loginStatus!.then((value) =>
      {
        print("LOGIN STATUS IS ${value}"),
        if(loginStatus == true){
          runApp(MyAppLoginScreen(loginStatus: true,)),
        } else
          {
            runApp(MyAppLoginScreen(loginStatus: false,)),
          }
      });
    }else{
      runApp(MyAppLoginScreen(loginStatus: false,));
    }
  }());
}


// Future init() async {
//   WidgetsFlutterBinding.ensureInitialized();
//   await Firebase.initializeApp();
//
//   //This is a sample comment
//
//   FirebaseMessaging.instance   // This is to enable the notification run while app is in terminated mode
//       .getInitialMessage()
//       .then((RemoteMessage? message) {
//     if (message != null) {
//     }
//   });
// //TODO: INTEGRATE NOTIFICATION FOR iOS
//   FirebaseMessaging.instance.getToken().then((token){
//     ApiAccess().saveDeviceIdentifier(code: token);
//     print("token $token");
//   });
//
// }

Future init() async{
 // Firebase.initializeApp();
   if (Platform.isIOS) {
     await Firebase.initializeApp(
         options: FirebaseOptions(
             apiKey: "your api key Found in GoogleService-info.plist",
             appId: "Your app id found in Firebase",
             messagingSenderId: "Your Sender id found in Firebase",
             projectId: "Your Project id found in Firebase"));

   } else {
     await Firebase.initializeApp();
   }

//    FirebaseMessaging.instance   // This is to enable the notification run while app is in terminated mode
//        .getInitialMessage()
//        .then((RemoteMessage? message) {
//      if (message != null) {
//      }
//    });
// //TODO: INTEGRATE NOTIFICATION FOR iOS
//   FirebaseMessaging.instance.getToken().then((token){
//   ApiAccess().saveDeviceIdentifier(code: token);
//   print("token $token");
//   });

 await WidgetsFlutterBinding.ensureInitialized();


//   FirebaseMessaging.instance   // This is to enable the notification run while app is in terminated mode
//       .getInitialMessage()
//       .then((RemoteMessage? message) {
//     if (message != null) {
//     }
//   });
// //TODO: INTEGRATE NOTIFICATION FOR iOS
//   FirebaseMessaging.instance.getToken().then((token){
//     ApiAccess().saveDeviceIdentifier(code: token);
//     print("token $token");
//   });

}

class MyAppLoginScreen extends StatelessWidget {
  bool loginStatus;  // 2022-07-15
  MyAppLoginScreen({required this.loginStatus});  // 2022-07-15

  final Store<AppState> _store = Store<AppState>(
    appStateReducer,
    initialState: AppState(
      sleepDiariesPODO: SleepDiariesPODO(),
      patientProfilePodo: PatientProfilePodo(),
      loginPodo: LoginPodo().getInitializedLoginPodo(),
      leveltwoVariables: LeveltwoVariables()
    )
  );


  @override
  Widget build(BuildContext context) {

    double screenWidth = window.physicalSize.width;

    return StoreProvider<AppState>(
      store: _store,
      child: MaterialApp(
        theme: new ThemeData(primarySwatch: appBackgroundMaterialColor, textTheme: screenWidth < 500 ? TEXT_THEME_SMALL : TEXT_THEME_DEFAULT, fontFamily: "Montserrat"),
         home: LoginScreen(loginStatus: loginStatus,),
        //home: HomeScreen(futureProfile: null, timedout: true,),
      ),
    );
  }
}

class MyAppHomeScreen extends StatelessWidget {

  final Store<AppState> _store = Store<AppState>(
      appStateReducer,
      initialState: AppState(
          sleepDiariesPODO: SleepDiariesPODO(),
          patientProfilePodo: PatientProfilePodo(),
          loginPodo: LoginPodo().getInitializedLoginPodo(),
          leveltwoVariables: LeveltwoVariables()
      )
  );


  @override
  Widget build(BuildContext context) {
    double screenWidth = window.physicalSize.width;

    Future<PatientProfilePodo>? patientprofile =  ApiAccess().getPatientProfile(null);
      patientprofile.then((value) => {
      if (value != null && value.firstName != null) {
          StoreProvider.of<AppState>(context).dispatch(UpdatePatientProfileAction(value)),
      Navigator.push(context, new MaterialPageRoute(
          builder: (context) => HomeScreen(timedout: true)))
      }
      });

    return StoreProvider<AppState>(
      store: _store,
      child: MaterialApp(
        theme: new ThemeData(primarySwatch: appBackgroundMaterialColor, textTheme: screenWidth < 500 ? TEXT_THEME_SMALL : TEXT_THEME_DEFAULT, fontFamily: "Montserrat"),
        home: HomeScreen(timedout: true,),
      ),
    );
  }
}


// class MyApp extends StatelessWidget {
//
//   @override
//   Widget build(BuildContext context) {
//
//     double screenWidth = window.physicalSize.width;
//
//     return new MaterialApp(
//       theme: new ThemeData(primarySwatch: appBackgroundMaterialColor, textTheme: screenWidth < 500 ? TEXT_THEME_SMALL : TEXT_THEME_DEFAULT, fontFamily: "Montserrat"),
//       // home: LoginScreen(),
//       home: HomeScreen(futureProfile: null, timedout: true,),
//     );
//   }
// }
