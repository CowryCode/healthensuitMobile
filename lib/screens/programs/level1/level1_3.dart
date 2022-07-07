import 'package:flutter/material.dart';
import 'package:healthensuite/api/network.dart';
import 'package:healthensuite/api/networkmodels/interventionlevels/levelonePODO.dart';
import 'package:healthensuite/api/networkmodels/patientProfilePodo.dart';
import 'package:healthensuite/utilities/constants.dart';
import 'package:healthensuite/utilities/text_data.dart';
import 'package:healthensuite/screens/programs/level1/level1_4.dart';


class Level1of3 extends StatefulWidget {

  static final String title = 'Level 1';
  static final sidePad = EdgeInsets.symmetric(horizontal: 18);
  final InterventionlevelOne levelone;

  final Future<PatientProfilePodo>? patientProfile;
  final int currentPage = 3;
  final int previousPage;
  Level1of3(this.levelone, this.patientProfile, this.previousPage);

  @override
  _Level1of3State createState() => _Level1of3State();
}

class _Level1of3State extends State<Level1of3> {
  String patientName = "Henry";

  @override
  Widget build(BuildContext context) {
    int currentPage = widget.currentPage;
    Future<PatientProfilePodo>? futureprofile = widget.patientProfile;
    InterventionlevelOne level1 = widget.levelone;
    final Size size = MediaQuery.of(context).size;
    final ThemeData themeData = Theme.of(context);
    double pad = 18;
    double paraHeight = 3;

    return Scaffold(
      appBar: AppBar(
        title: Text(Level1of3.title),
        centerTitle: true,
      ),
      bottomNavigationBar: buttomBarWidget(context, level1, futureprofile,currentPage),
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
                     sectionTitleWidget(themeData, text: "What causes insomnia?", textStyle: themeData.textTheme.headline4),
                     Padding(
                       padding: Level1of3.sidePad,
                       child: Image.asset('assets/images/causesInsomnia-img.jpg'),
                     ),
                     SizedBox(height: paraHeight,),
                     bodyTextWidget(themeData, text: LEVEL1_DATA["bullet8"]!),
                     SizedBox(height: paraHeight,),
                     bodyTextWidget(themeData, text: LEVEL1_DATA["bullet9"]!),
                   ],
                ),
              ),
            ),
          ],
        ),
      ),
    );

  }

  SafeArea buttomBarWidget(BuildContext context, InterventionlevelOne levelone, Future<PatientProfilePodo>? futureProfile, int currentPage) {
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

              navIconButton(context, buttonText: "Next", buttonActon: (){
                ApiAccess().savePage(currentPage: currentPage, interventionLevel: 1);
                 Navigator.push(
                    context, new MaterialPageRoute(builder: (context) => Level1of4(levelone, futureProfile, currentPage))
                    );
              }),
            ],
          ),
        ),
        elevation: 100,
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
                padding: Level1of3.sidePad,
                child: Text('Page 3/7',
                textAlign: TextAlign.left,
                style: themeData.textTheme.bodyText2,),
              ),
              Padding(
                padding: Level1of3.sidePad,
                child: Text('Intro. to Health enSuite Insomnia',
                textAlign: TextAlign.right,
                style: themeData.textTheme.bodyText2,),
              ),

              ],
            ),
          );
  }

  // IconButton navIconButton(BuildContext context, {IconData buttonIcon, Function buttonActon}) {
  //   return IconButton(
  //               onPressed: buttonActon,
  //               color: appItemColorBlue,
  //               icon: Icon(buttonIcon),
  //             );
  // }

  MaterialButton navIconButton(BuildContext context, {required String buttonText, Function? buttonActon}){
    return  MaterialButton(
              child: Text(buttonText, style: TextStyle(color: appItemColorBlue, fontWeight: FontWeight.w700),),
              onPressed: buttonActon as void Function()?,
            );
  }

   Padding sectionTitleWidget(ThemeData themeData, {required String text, TextStyle? textStyle} ) {
     return Padding(
                padding: Level1of3.sidePad,
                child: Text(text,
                  style: textStyle,
                ),
              );
  }

  Padding bodyTextWidget(ThemeData themeData, {required String text}) {
    return Padding(
              padding: Level1of3.sidePad,
              child: Text(text, 
                style: themeData.textTheme.bodyText1,),
            );
  }
}