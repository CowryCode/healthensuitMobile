import 'dart:async';

import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:healthensuite/api/network.dart';
import 'package:healthensuite/api/networkUtilities.dart';
import 'package:healthensuite/api/networkmodels/interventionlevels/leveltwoPODO.dart';
import 'package:healthensuite/api/networkmodels/interventionlevels/leveltwoVariables.dart';
import 'package:healthensuite/api/networkmodels/patientProfilePodo.dart';
import 'package:healthensuite/api/networkmodels/statusEntityPODO.dart';
import 'package:healthensuite/screens/programs/level2/level2_3.dart';
import 'package:healthensuite/screens/programs/level2/level2_4.dart';
import 'package:healthensuite/screens/programs/program_content.dart';
import 'package:healthensuite/utilities/constants.dart';
import 'package:healthensuite/utilities/text_data.dart';
import 'package:healthensuite/screens/programs/level2/level2_2.dart';


class Level2 extends StatefulWidget {
   bool timedout;
  static final String title = 'Level 2';
  static final sidePad = EdgeInsets.symmetric(horizontal: 18);

  final Future<PatientProfilePodo>? patientProfile;

  Level2({ required this.patientProfile, this.timedout: false});

  @override
  _Level2State createState() => _Level2State();
}

class _Level2State extends State<Level2> {
  String patientName = "Henry";
  String sleepEfficiency = "86.9%";

  Future<LeveltwoVariables>? l2Vairiables;

  LeveltwoVariables? variables;

  @override
  void initState() {
    super.initState();
    l2Vairiables = ApiAccess().getLeveltwoVariables();
    Future<PatientProfilePodo>? profile = widget.patientProfile;
    WidgetsBinding.instance!.addPostFrameCallback((_) async {
      StatusEntity? status;
      InterventionlevelTwo? levelTwo;
      await profile!.then((value) => {
        status = value.statusEntity,
        levelTwo = value.interventionLevelsEntity!.levelTwoEntity
      });

      LeveltwoVariables? l2VExracted;
      await l2Vairiables!.then((value) => {
        l2VExracted = value
      });

      int? nextLevel = status!.nextPage;
      bool? isCompleted = status!.readInterventionGroupleveltwoArticle;
      if(isCompleted!){
        Navigator.push(
            context, new MaterialPageRoute(builder: (context) => Level2_4of4(profile, l2VExracted))
        );
      }else if(nextLevel == 2){
        Navigator.push(
            context, new MaterialPageRoute(builder: (context) => Level2_2of4(profile, l2VExracted))
        );
      }else if(nextLevel == 3){
        Navigator.push(
            context, new MaterialPageRoute(builder: (context) => Level2_3of4(profile,l2VExracted))
        );
      }else if(nextLevel == 4){
        Navigator.push(
            context, new MaterialPageRoute(builder: (context) => Level2_4of4(profile, l2VExracted))
        );
      }
    });
  }


  @override
  Widget build(BuildContext context) {
    Future<PatientProfilePodo>? profile = widget.patientProfile;

    final Size size = MediaQuery.of(context).size;
    final ThemeData themeData = Theme.of(context);
    double pad = 18;

    //Future.delayed(Duration.zero, () => createAlertDialog(context, themeData));

    return Scaffold(
      appBar: AppBar(
        title: Text(Level2.title),
        centerTitle: true,
      ),
      bottomNavigationBar: buttomBarWidget(context, profile),
      body: Container(
        width: size.width,
        height: size.height,
        child: Column(
          children: [
            SizedBox(height: pad,),

            Align(
              alignment: Alignment.centerRight,
              child: Padding(
                padding: Level2.sidePad,
                child: Text('Page 1/4',
                textAlign: TextAlign.right,
                style: themeData.textTheme.bodyText2,),
              ),
            ),
         Expanded(
              flex: 1,
              child: SingleChildScrollView(
                scrollDirection: Axis.vertical,
                physics: ClampingScrollPhysics(),
                child: FutureBuilder<LeveltwoVariables>(
                  future: l2Vairiables,
                  builder: (BuildContext context, AsyncSnapshot<LeveltwoVariables> snapshot){
                    if(snapshot.hasData){
                      widget.timedout = true;
                      LeveltwoVariables l2V = snapshot.data!;
                      return getcontent(themeData, size, pad, l2V);
                    }else{
                      if(widget.timedout == false){
                        Timer.periodic(Duration(seconds: timeout_duration), (timer){
                          print("Timer PRE CHECK ran . . . . . . ${timer.tick}");
                          if(widget.timedout == false){
                            if(timer.tick == 1){
                              // setState(() {
                              widget.timedout = true;
                              print("The state chnaged to  ${widget.timedout}");
                              // });
                              timer.cancel();
                              print("Timer cancled ");
                              showAlertDialog(
                                  context: context, title: "",
                                  message: "It' seems you have network issues or have not filled any sleep Diary for the past 4 days please do so",
                                  patientprofile: profile
                              );
                            }
                          }else{
                            timer.cancel();
                          }
                        });
                      }
                      return Container(
                        child: Center(child: CircularProgressIndicator(),),
                      );
                    }
                  },
                )
              ),
            ),
          ],
        ),
      ),
    );

  }
  
  Widget getcontent(ThemeData themeData, Size size, double pad, LeveltwoVariables l2var){
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        SizedBox(height: pad,),
        sectionTitleWidget(themeData, text: "Introduction to Sleep Restriction", textStyle: themeData.textTheme.headline4),
        bodyTextWidget(themeData, text: LEVEL1_DATA["bullet23"]!),
        bodyTextWidget(themeData, text: LEVEL1_DATA["bullet24"]!),
        bodyTextWidget(themeData, text: LEVEL1_DATA["bullet25"]!),
        SizedBox(height: pad,),
        sectionTitleWidget(themeData, text: LEVEL1_DATA["subHead5"]!, textStyle: themeData.textTheme.headline5),
        bodyTextWidget(themeData, text: LEVEL1_DATA["bullet26"]!),
        bodyTextWidget(themeData, text: LEVEL1_DATA["bullet27"]!),
        bodyTextWidget(themeData, text: LEVEL1_DATA["bullet28"]!),

        SizedBox(height: pad,),
        sectionTitleWidget(themeData, text: LEVEL1_DATA["subHead6"]!, textStyle: themeData.textTheme.headline5),
        bodyTextWidget(themeData, text: "• You spent an average of ${l2var.averagenumberofbedhours} in bed per night."),
        bodyTextWidget(themeData, text: "• You were asleep for an average of ${l2var.averagenumberofsleephours} per night."),

        SizedBox(height: pad,),
        bodyTextWidget(themeData, text: "This means that your average sleep efficiency was ${l2var.averagesleepefficiency}"),
        bodyTextWidget(themeData, text: LEVEL1_DATA["bullet31"]!),
        bodyTextWidget(themeData, text: LEVEL1_DATA["bullet32"]!),
        bodyTextWidget(themeData, text: LEVEL1_DATA["bullet33"]!),
      ],
    );
  }

  SafeArea buttomBarWidget(BuildContext context, Future<PatientProfilePodo>? patientProfile) {
    return SafeArea(
      child: BottomAppBar(
        color: Colors.transparent,
        child: Container(
          color: Colors.transparent,
          child: Row(
            mainAxisSize: MainAxisSize.max,
            mainAxisAlignment: MainAxisAlignment.end,
            children: <Widget>[
              FutureBuilder<LeveltwoVariables>(
                future: l2Vairiables,
                builder: (context, AsyncSnapshot<LeveltwoVariables> snapshot) {
                  if(snapshot.hasData){
                    LeveltwoVariables l2V = snapshot.data!;
                    return MaterialButton(
                        child: Text("Next", style: TextStyle(color: appItemColorBlue, fontWeight: FontWeight.w700),),
                        onPressed: (){
                          print("Level 1 of 4 ${l2V.averagesleepefficiency}");
                          Navigator.push(
                              context, new MaterialPageRoute(builder: (context) => Level2_2of4(patientProfile, l2V))
                          );
                        }
                    );
                  }else{
                    return Container(
                      child: Center(child: CircularProgressIndicator(),),
                    );
                  }

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
                padding: Level2.sidePad,
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
          title: Text("Welcome To Level 2", style: themeData.textTheme.headline5,),
          content: SingleChildScrollView(
            scrollDirection: Axis.vertical,
                physics: ClampingScrollPhysics(),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                splashTextWidget(themeData, text: "Welcome $patientName,"),
                splashTextWidget(themeData, text: LEVEL1_DATA["splashBullet3"]!),
                splashTextWidget(themeData, text: LEVEL1_DATA["splashBullet4"]!),
                splashTextWidget(themeData, text: LEVEL1_DATA["splashBullet5"]!),
                splashTextWidget(themeData, text: LEVEL1_DATA["splashBullet6"]!),
                splashTextWidget(themeData, text: LEVEL1_DATA["splashBullet7"]!),
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
              padding: Level2.sidePad,
              child: Text(text, 
                style: themeData.textTheme.bodyText1,),
            );
  }



  showAlertDialog({required BuildContext context, required String title, required String message, required Future<PatientProfilePodo>? patientprofile}) {

    // set up the button
    Widget okButton = TextButton(
      child: Text("OK"),
      onPressed: () {
        Navigator.of(context).push(MaterialPageRoute(
          builder: (context) => ProgramContent(patientProfile: patientprofile,),
        ));
      },
    );

    // set up the AlertDialog
    AlertDialog alert = AlertDialog(
      // title: Text("My title"),
      title: Text(title),
      content: Text(message),
      actions: [
        okButton,
      ],
    );

    // show the dialog
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return alert;
      },
    );
  }
}