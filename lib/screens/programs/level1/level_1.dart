import 'package:flutter/material.dart';
import 'package:healthensuite/api/networkmodels/patientProfilePodo.dart';
import 'package:healthensuite/utilities/constants.dart';
import 'package:healthensuite/utilities/text_data.dart';
import 'package:healthensuite/screens/programs/level1/level1_2.dart';


class Level1 extends StatefulWidget {

  static final String title = 'Level 1';
  static final sidePad = EdgeInsets.symmetric(horizontal: 18);
  final Future<PatientProfilePodo>? patientProfile;


  Level1(this.patientProfile);

  @override
  _Level1State createState() => _Level1State();
}

class _Level1State extends State<Level1> {
  String patientName = "Henry";

  @override
  Widget build(BuildContext context) {
    Future<PatientProfilePodo>? futureprofile = widget.patientProfile;
    final Size size = MediaQuery.of(context).size;
    final ThemeData themeData = Theme.of(context);
    double pad = 18;
    //Future.delayed(Duration.zero, () => createAlertDialog(context, themeData));
    return Scaffold(
      appBar: AppBar(
        title: Text(Level1.title),
        centerTitle: true,
      ),
      bottomNavigationBar: buttomBarWidget(context, futureprofile),
      body: Container(
        width: size.width,
        height: size.height,
        child: Column(
          children: [
            SizedBox(height: pad,),
            
            Align(
              alignment: Alignment.centerRight,
              child: Padding(
                padding: Level1.sidePad,
                child: Text('Page 1/7',
                textAlign: TextAlign.right,
                style: themeData.textTheme.bodyText2,),
              ),
            ),
            SingleChildScrollView(
              scrollDirection: Axis.vertical,
              physics: ClampingScrollPhysics(),
              child: Column(
                 crossAxisAlignment: CrossAxisAlignment.start,
                 children: [
                   SizedBox(height: pad,),
                   sectionTitleWidget(themeData, text: "Introduction to Health enSuite Insomnia", textStyle: themeData.textTheme.headline4),
                   bodyTextWidget(themeData, text: LEVEL1_DATA["bullet1"]!),
                   bodyTextWidget(themeData, text: LEVEL1_DATA["bullet2"]!),
                   bodyTextWidget(themeData, text: LEVEL1_DATA["bullet3"]!),
                   SizedBox(height: pad,),
                   sectionTitleWidget(themeData, text: LEVEL1_DATA["subHead1"]!, textStyle: themeData.textTheme.headline5),
                   bodyTextWidget(themeData, text: LEVEL1_DATA["bullet4"]!),
                   bodyTextWidget(themeData, text: LEVEL1_DATA["bullet5"]!),

                 ],
              ),
            ),
          ],
        ),
      ),
    );

  }

  SafeArea buttomBarWidget(BuildContext context, Future<PatientProfilePodo>? futureProfile) {
    return SafeArea(
      child: BottomAppBar(
        color: Colors.transparent,
        child: Container(
          color: Colors.transparent,
          child: Row(
            mainAxisSize: MainAxisSize.max,
            mainAxisAlignment: MainAxisAlignment.end,
            children: <Widget>[
              MaterialButton(
                child: Text("Next", style: TextStyle(color: appItemColorBlue, fontWeight: FontWeight.w700),),
                onPressed: (){
                  Navigator.push(
                  context, new MaterialPageRoute(builder: (context) => Level1of2(futureProfile))
                  );
                }
              ),
              
            ],
          ),
        ),
        elevation: 100,
      ),
    );
  }

   Padding sectionTitleWidget(ThemeData themeData, {required String text, TextStyle? textStyle} ) {
     return Padding(
                padding: Level1.sidePad,
                child: Text(text,
                  style: textStyle,
                ),
              );
  }

  createAlertDialog(BuildContext context, ThemeData themeData) async{
    return showDialog(
      context: context, 
      barrierDismissible: false,
      builder: (context){
        return AlertDialog(
          title: Text("Welcome To Level 1", style: themeData.textTheme.headline5,),
          content: SingleChildScrollView(
            scrollDirection: Axis.vertical,
                physics: ClampingScrollPhysics(),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                splashTextWidget(themeData, text: "Welcome $patientName,"),
                splashTextWidget(themeData, text: LEVEL1_DATA["splashBullet1"]!),
                splashTextWidget(themeData, text: LEVEL1_DATA["splashBullet2"]!),
              ],
            ),
          ),
          actions: [
            MaterialButton(
              child: Text("OK", style: TextStyle(color: appItemColorBlue, fontWeight: FontWeight.w700),),
              onPressed: (){
                Navigator.of(context).pop();
              }
            ),
          ],
        );
      });
  }

  Text splashTextWidget(ThemeData themeData, {required String text}) {
    return Text(text, 
                style: themeData.textTheme.bodyText1,);
  }

  Padding bodyTextWidget(ThemeData themeData, {required String text}) {
    return Padding(
              padding: Level1.sidePad,
              child: Text(text, 
                style: themeData.textTheme.bodyText1,),
            );
  }
}