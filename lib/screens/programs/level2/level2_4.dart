import 'package:flutter/material.dart';
import 'package:healthensuite/api/network.dart';
import 'package:healthensuite/api/networkmodels/interventionlevels/leveltwoVariables.dart';
import 'package:healthensuite/api/networkmodels/patientProfilePodo.dart';
import 'package:healthensuite/screens/home/home_screen.dart';
import 'package:healthensuite/utilities/constants.dart';
import 'package:healthensuite/utilities/text_data.dart';
import 'package:healthensuite/screens/sleepClock/sleep_clock.dart';


class Level2_4of4 extends StatefulWidget {

  static final String title = 'Level 2';
  static final sidePad = EdgeInsets.symmetric(horizontal: 18);
  final Future<PatientProfilePodo>? patientProfile;
  final LeveltwoVariables l2variables;
  final int currentPage = 4;

  Level2_4of4(this.patientProfile, this.l2variables);

  @override
  _Level2_4of4State createState() => _Level2_4of4State();
}

class _Level2_4of4State extends State<Level2_4of4> {
  String patientName = "Henry";
//  String sleepEfficiency = "86.9%";
 // String yourBTime = "10:30";
 // String yourRTime = "05:30";

  @override
  Widget build(BuildContext context) {
    final Size size = MediaQuery.of(context).size;
    final ThemeData themeData = Theme.of(context);

    Future<PatientProfilePodo>? profile = widget.patientProfile;
    LeveltwoVariables? l2variable = widget.l2variables;


    double pad = 18;

    return Scaffold(
      appBar: AppBar(
        title: Text(Level2_4of4.title),
        centerTitle: true,
      ),
      bottomNavigationBar: buttomBarWidget(context, l2variable, profile),
      body: Container(
        width: size.width,
        height: size.height,
        child: Column(
          children: [
            SizedBox(height: pad,),
            headerWidget(themeData),
            
            Expanded(
              flex: 1,
              child: SingleChildScrollView(
                scrollDirection: Axis.vertical,
                physics: ClampingScrollPhysics(),
                child: Column(
                   crossAxisAlignment: CrossAxisAlignment.start,
                   children: [
                     SizedBox(height: pad,),
                     sectionTitleWidget(themeData, text: "Improving Sleep Efficiency", textStyle: themeData.textTheme.headline4),
                     bodyTextWidget(themeData, text: LEVEL1_DATA["bullet39"]!),
                     bodyTextWidget(themeData, text: LEVEL1_DATA["bullet40"]!),
                     bodyTextWidget(themeData, text: LEVEL1_DATA["bullet41"]!),
                     bodyTextWidget(themeData, text: LEVEL1_DATA["bullet42"]!),
                     
                     bodyTextWidget(themeData, text: "Based on the sleep diaries you completed over the past week, your average sleep efficiency is ${l2variable.averagesleepefficiency}. Ideally, sleep efficiency should be around 85-90%."),
                     SizedBox(height: pad,),

                             sleepReportButtonWidget(topic: "Sleep efficiency report for the last week", action: (){gotoSleepReport(context, profile);}),
                             bodyTextWidget(themeData,
                                 text: "${l2variable.message ?? " No Sleep Report for Last Week, this may be because you didn't fill all required sleep diary"}"),
                    // bodyTextWidget(themeData, text: LEVEL1_DATA["bullet43"]!),
                    // bodyTextWidget(themeData, text: LEVEL1_DATA["bullet44"]!),
                    // bodyTextWidget(themeData, text: LEVEL1_DATA["bullet45"]!),
                    // bodyTextWidget(themeData, text: LEVEL1_DATA["bullet46"]!),
                    // bodyTextWidget(themeData, text: LEVEL1_DATA["bullet47"]!),

                     SizedBox(height: pad,),
                     sectionTitleWidget(themeData, text: LEVEL1_DATA["subHead8"]!, textStyle: themeData.textTheme.headline5),
                     bodyTextWidget(themeData, text: LEVEL1_DATA["bullet48"]!),
                     bodyTextWidget(themeData, text: LEVEL1_DATA["bullet49"]!),
                     bodyTextWidget(themeData, text: LEVEL1_DATA["bullet50"]!),
                     
                   ],
                ),
              ),
            ),
          ],
        ),
      ),
    );

  }

  SingleChildScrollView headerWidget(ThemeData themeData) {
    return SingleChildScrollView(
            scrollDirection: Axis.horizontal,
            child: Row(
              mainAxisSize: MainAxisSize.max,
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Padding(
                padding: Level2_4of4.sidePad,
                child: Text('Page 4/4',
                textAlign: TextAlign.left,
                style: themeData.textTheme.bodyText2,),
              ),
              Padding(
                padding: Level2_4of4.sidePad,
                child: Text('Introduction to Sleep Restriction',
                textAlign: TextAlign.right,
                style: themeData.textTheme.bodyText2,),
              ),

              ],
            ),
          );
  }


  SafeArea buttomBarWidget(BuildContext context, LeveltwoVariables variables, Future<PatientProfilePodo>? futureProfile) {
    return SafeArea(
      child: BottomAppBar(
        color: Colors.transparent,
        child: Container(
          color: Colors.transparent,
          child: Row(
            mainAxisSize: MainAxisSize.max,
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: <Widget>[
              navIconButton(context, buttonText: "Back", buttonActon: (){
                Navigator.of(context).pop();
              }),
              navIconButton(context, buttonText: "Conclude Level 2", buttonActon: (){
                createAlertDialog(
                    context: context,
                    title: "",
                    message: "Congratulations! You have finished level 2!",
                    variables: variables,
                    futureProfile: futureProfile);

                // ApiAccess().submitLeveTwo(levelTwo: variables);
                // Navigator.of(context).push(MaterialPageRoute(
                //     builder: (context) => HomeScreen(futureProfile: futureProfile)));
              }
              ),
            ],
          ),
        ),
        elevation: 100,
      ),
    );
  }

  MaterialButton navIconButton(BuildContext context, {required String buttonText, Function? buttonActon}){
    return  MaterialButton(
              child: Text(buttonText, style: TextStyle(color: appItemColorBlue, fontWeight: FontWeight.w700),),
              onPressed: buttonActon as void Function()?,
            );
  }

   Padding sectionTitleWidget(ThemeData themeData, {required String text, TextStyle? textStyle} ) {
     return Padding(
                padding: Level2_4of4.sidePad,
                child: Text(text,
                  style: textStyle,
                ),
              );
  }

  Padding bodyTextWidget(ThemeData themeData, {required String text}) {
    return Padding(
              padding: Level2_4of4.sidePad,
              child: Text(text, 
                style: themeData.textTheme.bodyText1,),
            );
  }

  MaterialButton sleepReportButtonWidget({required String topic, Function? action}) {
     return MaterialButton(
                  child: Text(topic, 
                    style: TextStyle(color: appBackgroundColor, fontWeight: FontWeight.w700),
                  ),
                  onPressed: action as void Function()?
                );
   }

   void gotoSleepReport(BuildContext context, Future<PatientProfilePodo>? patientProfile){
     Navigator.push(
      context, new MaterialPageRoute(builder: (context) => SleepClock(patientProfile: patientProfile,))
    );
   }


  createAlertDialog({required BuildContext context, required String title, required String message,required LeveltwoVariables variables, required Future<PatientProfilePodo>? futureProfile}){
    final ThemeData themeData = Theme.of(context);
    return showDialog(
        context: context,
        barrierDismissible: false,
        builder: (context){
          return AlertDialog(
            title: Text(title,
              style: themeData.textTheme.headline5,),
            content: Text(message,
              style: themeData.textTheme.bodyText2,),
            actions: [
              MaterialButton(
                  child: Text("Go Back", style: TextStyle(color: appItemColorBlue, fontWeight: FontWeight.w700),),
                  onPressed: (){
                    Navigator.of(context).pop();
                  }
              ),
              MaterialButton(
                  child: Text("Submit Anyway", style: TextStyle(color: appItemColorBlue, fontWeight: FontWeight.w700),),
                  onPressed: (){
                    variables.setCompleted(isCompleted: true);
                    ApiAccess().submitLeveTwo(levelTwo: variables);
                    Navigator.of(context).push(MaterialPageRoute(
                        builder: (context) => HomeScreen(futureProfile: futureProfile, justLoggedIn: false)));
                  }
              ),
            ],
          );
        });
  }
}