// import 'dart:ffi';

import 'package:flutter/material.dart';
import 'package:flutter_redux/flutter_redux.dart';
import 'package:healthensuite/api/network.dart';
import 'package:healthensuite/api/networkmodels/interventionlevels/levelonePODO.dart';
import 'package:healthensuite/api/networkmodels/interventionlevels/leveltwoPODO.dart';
import 'package:healthensuite/api/networkmodels/interventionlevels/leveltwoVariables.dart';
import 'package:healthensuite/api/networkmodels/patientProfilePodo.dart';
import 'package:healthensuite/api/networkmodels/statusEntityPODO.dart';
import 'package:healthensuite/api/statemanagement/app_state.dart';
import 'package:healthensuite/screens/programs/level1/level1_2.dart';
import 'package:healthensuite/screens/programs/level1/level1_3.dart';
import 'package:healthensuite/screens/programs/level1/level1_4.dart';
import 'package:healthensuite/screens/programs/level1/level1_5.dart';
import 'package:healthensuite/screens/programs/level1/level1_6.dart';
import 'package:healthensuite/screens/programs/level1/level1_7.dart';
import 'package:healthensuite/screens/programs/level2/level2_2.dart';
import 'package:healthensuite/screens/programs/level2/level2_3.dart';
import 'package:healthensuite/screens/programs/level2/level2_4.dart';
import 'package:healthensuite/screens/programs/level4/level4_2.dart';
import 'package:healthensuite/screens/programs/level4/level4_3.dart';
import 'package:healthensuite/screens/programs/level4/level4_4.dart';
import 'package:healthensuite/screens/programs/level5/level5_2.dart';
import 'package:healthensuite/screens/programs/level5/level5_3.dart';
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
 // final Future<PatientProfilePodo>? patientProfile;
  int levelVal;

 // ProgramContent({Key? key, this.onMenuTap, required this.patientProfile, this.levelVal: 0}) : super(key: key);
  ProgramContent({Key? key, this.onMenuTap, this.levelVal: 0}) : super(key: key);

  @override
  _ProgramContentState createState() => _ProgramContentState();
}

class _ProgramContentState extends State<ProgramContent> {
  double progress = .15;

   @override
  Widget build(BuildContext context) {
    // Future<PatientProfilePodo>? profile = widget.patientProfile;
     final Size size = MediaQuery.of(context).size;
    final ThemeData themeData = Theme.of(context);
    double pad = 18;

    return Scaffold(
      drawer: NavigationDrawerWidget(indexNum: 4,),
      appBar: AppBar(
        title: Text(ProgramContent.title),
        centerTitle: true,
      ),
      body: Container(
        width: size.width,
        height: size.height,
        child: StoreConnector<AppState, PatientProfilePodo>(
          converter: (store) => store.state.patientProfilePodo,
          builder: (context, PatientProfilePodo patientprofile) => Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              SizedBox(height: pad,),
              Center(
                child: getInterventionLevel(
                    themeData,
                    size,
                    pad,
                    context,
                    patientprofile,
                    patientprofile.statusEntity!.getInterventionLevel() ?? -1
                ),
              ),
              // Center(
              //    child: FutureBuilder<PatientProfilePodo>(
              //       future: profile,
              //       builder: (BuildContext context, AsyncSnapshot<PatientProfilePodo> snapshot){
              //         if(snapshot.hasData){
              //           PatientProfilePodo profileData = snapshot.data!;
              //           int interventionLevel = profileData.statusEntity!.getInterventionLevel() ?? - 1;
              //           return  getInterventionLevel(themeData, size, pad, context, profile, interventionLevel);
              //         }else{
              //           return Container(
              //             child: Center(child: CircularProgressIndicator(),),
              //           );
              //         }
              //       },
              //     )
              // ),
            ],
          ),
        ),
      ),
    );
  }

  Widget getInterventionLevel(ThemeData themeData, Size size, double pad, BuildContext context, PatientProfilePodo patientProfile, int interventionLevel){
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


   Card sectionTwoCard(ThemeData themeData, double pad, BuildContext context, PatientProfilePodo patientProfile, int interventionLevel) {
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
                    if(interventionLevel >= -1 ){
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
                      return getLevelfour();
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
                      return getLevelsix();
                    }else{
                      SizedBox(height: 2.0,);
                    }
                  }()) ,
                ),

              ],
            ),
          );
   }

  Widget getLevelOne(PatientProfilePodo patientProfile ){
   return  levelButtonWidget(topic: "Level 1: Introduction to Health enSuite Insomnia",
        action: (){
          int? nextLevel = patientProfile.statusEntity!.nextPage;
          bool? isCompleted = patientProfile.statusEntity?.readInterventionGroupleveloneArticle;
          InterventionlevelOne levelOne = patientProfile.interventionLevelsEntity?.levelOneEntity ?? InterventionlevelOne();
          if(levelOne == null){
            levelOne = new InterventionlevelOne();
          }

          if(isCompleted!){
            Navigator.push(
                context, new MaterialPageRoute(builder: (context) => Level1of7(6))
            );
          }else if(nextLevel == 2){
            Navigator.push(
                context, new MaterialPageRoute(builder: (context) => Level1of2(1))
            );
          }else if(nextLevel == 3){
            Navigator.push(
                context, new MaterialPageRoute(builder: (context) => Level1of3(2))
            );
          }else if(nextLevel == 4){
            Navigator.push(
                context, new MaterialPageRoute(builder: (context) => Level1of4(3))
            );
          }else if(nextLevel == 5){
            Navigator.push(
                context, new MaterialPageRoute(builder: (context) => Level1of5(4))
            );
          }else if(nextLevel == 6){
            Navigator.push(
                context, new MaterialPageRoute(builder: (context) => Level1of6(5))
            );
          }else if(nextLevel == 7){
            Navigator.push(
                context, new MaterialPageRoute(builder: (context) => Level1of7(6))
            );
          }else {
          Navigator.push(
              context, new MaterialPageRoute(builder: (context) => Level1(previousPage: 1,))
          );
          }
          // Navigator.push(
          //     context, new MaterialPageRoute(builder: (context) => Level1(previousPage: 1,))
          // );
        });
  }

  Widget getLeveltwo(PatientProfilePodo patientProfile ){
    return  levelButtonWidget(topic: "Level 2: Introduction to Sleep Restriction",
        action: (){
          // New Variabless
          Future<LeveltwoVariables> l2variables = ApiAccess().getLeveltwoVariables();
          LeveltwoVariables l2VExracted = new LeveltwoVariables();
          l2variables.then((value) => {
          l2VExracted = value
          });
          StatusEntity? status = patientProfile.statusEntity;
          InterventionlevelTwo? levelTwo = patientProfile.interventionLevelsEntity!.levelTwoEntity;
          int? nextLevel =  patientProfile.statusEntity!.nextPage;
          bool? isCompleted = patientProfile.statusEntity!.readInterventionGroupleveltwoArticle;

          if(isCompleted!){
          Navigator.push(
          context, new MaterialPageRoute(builder: (context) => Level2_4of4( l2VExracted))
          );
          }else if(nextLevel == 2){
          Navigator.push(
          context, new MaterialPageRoute(builder: (context) => Level2_2of4(l2VExracted))
          );
          }else if(nextLevel == 3){
          Navigator.push(
          context, new MaterialPageRoute(builder: (context) => Level2_3of4(l2VExracted))
          );
          }else if(nextLevel == 4){
          Navigator.push(
          context, new MaterialPageRoute(builder: (context) => Level2_4of4(l2VExracted))
          );
          }else {
            Navigator.push(
                context, new MaterialPageRoute(builder: (context) => Level2())
            );
          }
          // Navigator.push(
          //     context, new MaterialPageRoute(builder: (context) => Level2())
          // );
        });
  }

  Widget getLevelthree(PatientProfilePodo patientProfile ){
    return   levelButtonWidget(topic: "Level 3: Sleep Hygiene",
        action: (){
          // StatusEntity? status;
          // await profile!.then((value) => {
          // status = value.statusEntity,
          // patientName = value.firstName!
          // });

          // int? nextLevel = status!.nextPage;
          // bool? isCompleted = status!.readInterventionGrouplevelfourArticle;

          // New Variables
          int? nextLevel = patientProfile.statusEntity!.nextPage;
          bool? isCompleted = patientProfile.statusEntity!.readInterventionGrouplevelfourArticle;

          if(isCompleted!){
          Navigator.push(
          context, new MaterialPageRoute(builder: (context) => Level4_4of4())
          );
          }else if(nextLevel == 2){
          Navigator.push(
          context, new MaterialPageRoute(builder: (context) => Level4_2of4())
          );
          }else if(nextLevel == 3){
          Navigator.push(
          context, new MaterialPageRoute(builder: (context) => Level4_3of4())
          );
          }else if(nextLevel == 4){
          Navigator.push(
          context, new MaterialPageRoute(builder: (context) => Level4_4of4())
          );
          } else {
            Navigator.push(
                context, new MaterialPageRoute(builder: (context) => Level3())
            );
          }

          // Navigator.push(
          //     context, new MaterialPageRoute(builder: (context) => Level3())
          // );
        });
  }

  Widget getLevelfour(){
    return  levelButtonWidget(topic: "Level 4: Relaxation techniques",
        action: (){
          Navigator.push(
              context, new MaterialPageRoute(builder: (context) => Level4())
          );
        });
  }

  Widget getLevelfive(PatientProfilePodo patientProfile ){
    return levelButtonWidget(topic: "Level 5: Changing Thoughts",
        action: (){
          // StatusEntity? status;
          // await profile!.then((value) => {
          // status = value.statusEntity,
          // });
         // int? nextLevel = status!.nextPage;
         //  bool? isCompleted = status!.readInterventionGrouplevelfiveArticle;

          int? nextLevel = patientProfile.statusEntity!.nextPage;
          bool? isCompleted = patientProfile.statusEntity!.readInterventionGrouplevelfiveArticle;

          if(isCompleted!){
          Navigator.push(
          context, new MaterialPageRoute(builder: (context) => Level5_3of3())
          );
          }else if(nextLevel == 2){
          Navigator.push(
          context, new MaterialPageRoute(builder: (context) => Level5_2of3())
          );
          }else if(nextLevel == 3){
          Navigator.push(
          context, new MaterialPageRoute(builder: (context) => Level5_3of3())
          );
          } else {
          Navigator.push(
              context, new MaterialPageRoute(builder: (context) => Level5_1of3())
          );
          }
          // Navigator.push(
          //     context, new MaterialPageRoute(builder: (context) => Level5_1of3(patientProfile))
          // );
        });
  }

  Widget getLevelsix(){
    return levelButtonWidget(topic: "Level 6: Maintaining Your Progress",
        action: (){
          Navigator.push(
              context, new MaterialPageRoute(builder: (context) => Level6())
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