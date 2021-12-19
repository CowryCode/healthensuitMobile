import 'dart:ffi';

import 'package:flutter/material.dart';
import 'package:healthensuite/api/networkmodels/interventionlevels/leveltwoVariables.dart';
import 'package:healthensuite/api/networkmodels/patientProfilePodo.dart';
import 'package:healthensuite/utilities/drawer_navigation.dart';
import 'package:healthensuite/utilities/constants.dart';
import 'package:healthensuite/screens/programs/level1/level_1.dart';
import 'package:healthensuite/screens/programs/level2/level_2.dart';
import 'package:healthensuite/screens/programs/level3/level_3.dart';
import 'package:healthensuite/screens/programs/level4/level_4.dart';
import 'package:healthensuite/screens/programs/level5/level_5.dart';
import 'package:healthensuite/screens/programs/level6/level_6.dart';


class ProgramContent extends StatefulWidget{

  final Function? onMenuTap;
   static final String title = 'Program Content';
   static final sidePad = EdgeInsets.symmetric(horizontal: 18);
  final Future<PatientProfilePodo>? patientProfile;
  int levelVal;


 // const ProgramContent({Key? key, this.onMenuTap, required this.patientProfile}) : super(key: key);
  ProgramContent({Key? key, this.onMenuTap, required this.patientProfile, this.levelVal: 0}) : super(key: key);

  @override
  _ProgramContentState createState() => _ProgramContentState();
}

class _ProgramContentState extends State<ProgramContent> {
  double progress = .15;

   @override
  Widget build(BuildContext context) {
     Future<PatientProfilePodo>? profile = widget.patientProfile;
     final Size size = MediaQuery.of(context).size;
    final ThemeData themeData = Theme.of(context);
    double pad = 18;

    return Scaffold(
      drawer: NavigationDrawerWidget(indexNum: 4,patientprofile: profile,),
      appBar: AppBar(
        title: Text(ProgramContent.title),
        centerTitle: true,
      ),
      body: Container(
        width: size.width,
        height: size.height,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            SizedBox(height: pad,),
           // sectionOneCard(pad, themeData, size, widget.levelVal),
            //  sectionTwoCard(themeData, pad, context, profile),
            Center(
             // child: sectionTwoCard(themeData, pad, context, profile, 1)
               child: FutureBuilder<PatientProfilePodo>(
                  future: profile,
                  builder: (BuildContext context, AsyncSnapshot<PatientProfilePodo> snapshot){
                    if(snapshot.hasData){
                      PatientProfilePodo profileData = snapshot.data!;
                      int interventionLevel = profileData.statusEntity!.getInterventionLevel() ?? - 1;
                      return  getInterventionLevel(themeData, size, pad, context, profile, interventionLevel);
                    }else{
                      return Container(
                        child: Center(child: CircularProgressIndicator(),),
                      );
                    }
                  },
                )
            ),
          ],
        ),
      ),
    );
  }

  Widget getInterventionLevel(ThemeData themeData, Size size, double pad, BuildContext context, Future<PatientProfilePodo>? patientProfile, int interventionLevel){
   return   Container(
       child: Column(
         crossAxisAlignment: CrossAxisAlignment.start,
         children: [
            SizedBox(height: pad,),
            sectionOneCard(pad, themeData, size, interventionLevel),
         sectionTwoCard(themeData, pad, context, patientProfile, interventionLevel)
         ]
     ));
  //  return  sectionTwoCard(themeData, pad, context, patientProfile, interventionLevel);
  }


   Card sectionTwoCard(ThemeData themeData, double pad, BuildContext context, Future<PatientProfilePodo>? patientProfile, int interventionLevel) {
     return Card(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                sectionTitleWidget(themeData, text: "Intervention Group Content"),

                Container(
                  child:((){
                    if(interventionLevel < 0 ){
                      return  Padding(
                        padding: ProgramContent.sidePad,
                        child: Text("You will have to complete 5 sleep diaries during the last 7 days to be able to see the Intervention content.",
                          style: themeData.textTheme.bodyText2,
                        )
                      );
                    }else{
                      return  Padding(
                        padding: ProgramContent.sidePad,
                        child: Text("Only current or previous levels are available to access",
                          style: themeData.textTheme.bodyText2,
                        ),
                      );
                    }
                  }()) ,
                ),
                // Padding(
                //   padding: ProgramContent.sidePad,
                //   child: Text("Only current or previous levels are available to access",
                //     style: themeData.textTheme.bodyText2,
                //   ),
                // ),
                SizedBox(height: pad,),
                Container(
                  child:((){
                    if(interventionLevel >= 0 ){
                      return Padding(
                        padding: ProgramContent.sidePad,
                        child: Text("Table of Content",
                          style: themeData.textTheme.headline5,
                        ),
                      );
                    }else{
                      return  Padding(
                        padding: ProgramContent.sidePad,
                        child: Text("",
                          style: themeData.textTheme.bodyText2,
                        ),
                      );
                    }
                  }()) ,
                ),

                Container(
                  child:((){
                    if(interventionLevel >= 0 ){
                      return getLevelOne(patientProfile);
                    }else{
                      SizedBox(height: 2.0,);
                    }
                  }()) ,
                ),

                Container(
                  child:((){
                    if(interventionLevel >= 1){
                      return getLeveltwo(patientProfile);
                    }else{
                      SizedBox(height: 2.0,);
                    }
                  }()) ,
                ),
                Container(
                  child:((){
                    if(interventionLevel >= 2){
                      return getLevelthree(patientProfile);
                    }else{
                      SizedBox(height: 2.0,);
                    }
                  }()) ,
                ),
                Container(
                  child:((){
                    if(interventionLevel >= 3){
                      return getLevelfour(patientProfile);
                    }else{
                      SizedBox(height: 2.0,);
                    }
                  }()) ,
                ),
                Container(
                  child:((){
                    if(interventionLevel >= 4){
                      return getLevelfive(patientProfile);
                    }else{
                      SizedBox(height: 2.0,);
                    }
                  }()) ,
                ),

                Container(
                  child:((){
                    if(interventionLevel >= 5){
                      return getLevelsix(patientProfile);
                    }else{
                      SizedBox(height: 2.0,);
                    }
                  }()) ,
                ),

              ],
            ),
          );
   }

  Widget getLevelOne(Future<PatientProfilePodo>? patientProfile ){
   return  levelButtonWidget(topic: "Level 1: Introduction to Health enSuite Insomnia",
        action: (){
          Navigator.push(
              context, new MaterialPageRoute(builder: (context) => Level1(patientProfile, 1))
          );
        });
  }

  Widget getLeveltwo(Future<PatientProfilePodo>? patientProfile ){
    return  levelButtonWidget(topic: "Level 2: Introduction to Sleep Restriction",
        action: (){
          Navigator.push(
              context, new MaterialPageRoute(builder: (context) => Level2(patientProfile:patientProfile))
          );
        });
  }

  Widget getLevelthree(Future<PatientProfilePodo>? patientProfile ){
    return   levelButtonWidget(topic: "Level 3: Sleep Hygiene",
        action: (){
          Navigator.push(
              context, new MaterialPageRoute(builder: (context) => Level3(patientProfile))
          );
        });
  }

  Widget getLevelfour(Future<PatientProfilePodo>? patientProfile ){
    return  levelButtonWidget(topic: "Level 4: Relaxation techniques",
        action: (){
          Navigator.push(
              context, new MaterialPageRoute(builder: (context) => Level4(patientProfile))
          );
        });
  }

  Widget getLevelfive(Future<PatientProfilePodo>? patientProfile ){
    return levelButtonWidget(topic: "Level 5: Changing Thoughts",
        action: (){
          Navigator.push(
              context, new MaterialPageRoute(builder: (context) => Level5(patientProfile))
          );
        });
  }

  Widget getLevelsix(Future<PatientProfilePodo>? patientProfile ){
    return levelButtonWidget(topic: "Level 6: Maintaining Your Progress",
        action: (){
          Navigator.push(
              context, new MaterialPageRoute(builder: (context) => Level6(patientProfile))
          );
        });
  }

   MaterialButton levelButtonWidget({required String topic, Function? action}) {
     return MaterialButton(
                  child: Text(topic, 
                    style: TextStyle(color: appBackgroundColor, fontWeight: FontWeight.w700),
                  ),
                  onPressed: action as void Function()?
                );
   }

   Card sectionOneCard(double pad, ThemeData themeData, Size size, int interventionlevel) {
     int lev = interventionlevel >= 0 ? interventionlevel : 0;
     return Card(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                SizedBox(height: pad,),
                sectionTitleWidget(themeData, text: "My Progress"),
                Padding(
                  padding: ProgramContent.sidePad,
                  child: SizedBox(
                    width: size.width,
                    height: size.height/30,
                    child: Stack(
                      fit: StackFit.expand,
                      children: [
                        LinearProgressIndicator(
                         // value: progress,
                          value: getProgval(interventionlevel),
                          valueColor: AlwaysStoppedAnimation(appBackgroundColor),
                          backgroundColor: appItemColorLightGrey,
                        ),
                        Center(child: buildProgress(themeData, size.height/30, interventionlevel)),
                      ],
                    ),
                  ),
                ),
                Padding(
                  padding: ProgramContent.sidePad,
                  child: Text("Status: Level ${lev} of 6",
                    style: themeData.textTheme.headline6,
                  ),
                ),
                SizedBox(height: pad,),
              ],
            ),
          );
   }

   Padding sectionTitleWidget(ThemeData themeData, {required String text}) {
     return Padding(
                  padding: ProgramContent.sidePad,
                  child: Text(text,
                    style: themeData.textTheme.headline4,
                  ),
                );
   }

  Widget buildProgress(ThemeData themeData, double barSize, int interventionlevel) {
     progress = getProgval(interventionlevel);
    if (progress == 1) {
      print("Height: $barSize");
      return Icon(
          Icons.done,
          color: appItemColorWhite,
          size: barSize,
        );
    } else {
      return Text(
        myPercentage(),
        style: themeData.textTheme.headline4,
      );
    }
  }

  String myPercentage(){
    int perc = (progress * 100).toInt();
    String val = perc.toString() + '%';
    return val;
  }

  double getProgval(int x){
     switch(x){
       case 0:
         return 0.05;
       case 1:
         return 0.20;
       case 2:
         return 0.35;
       case 3:
         return 0.55;
       case 4:
         return 0.70;
       case 5:
         return 0.85;
       case 6:
         return 1;
       default:
         return 0.0;
     }
  }

}