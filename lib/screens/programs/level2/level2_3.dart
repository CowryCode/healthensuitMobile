import 'package:flutter/material.dart';
import 'package:healthensuite/api/networkmodels/interventionlevels/leveltwoVariables.dart';
import 'package:healthensuite/api/networkmodels/patientProfilePodo.dart';
import 'package:healthensuite/utilities/constants.dart';
import 'package:healthensuite/utilities/text_data.dart';
import 'package:healthensuite/screens/programs/level2/level2_4.dart';


class Level2_3of4 extends StatefulWidget {

  static final String title = 'Level 2';
  static final sidePad = EdgeInsets.symmetric(horizontal: 18);
  final Future<PatientProfilePodo>? patientProfile;
  final LeveltwoVariables? variables;


  Level2_3of4(this.patientProfile, this.variables);

  @override
  _Level2_3of4State createState() => _Level2_3of4State();
}

class _Level2_3of4State extends State<Level2_3of4> {
  String patientName = "Henry";
 // String sleepEfficiency = "86.9%";
  String yourBTime = "10:30";
  String yourRTime = "05:30";


  @override
  Widget build(BuildContext context) {
    Future<PatientProfilePodo>? profile = widget.patientProfile;
    LeveltwoVariables? l2variables = widget.variables;
    final Size size = MediaQuery.of(context).size;
    final ThemeData themeData = Theme.of(context);
    
    double pad = 18;

    l2variables!.setNewbedTime(yourBTime);
    l2variables.setNewriseTime(yourRTime);

    return Scaffold(
      appBar: AppBar(
        title: Text(Level2_3of4.title),
        centerTitle: true,
      ),
      bottomNavigationBar: buttomBarWidget(context, profile, l2variables),
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
                     sectionTitleWidget(themeData, text: "Set Your Sleep Window", textStyle: themeData.textTheme.headline4),
                     bodyTextWidget(themeData, text: "Based on your last 7 sleep diaries, you slept an average of ${l2variables.averagesleepefficiency} per night."),
                     bodyTextWidget(themeData, text: LEVEL1_DATA["bullet36"]!),
                     bodyTextWidget(themeData, text: LEVEL1_DATA["bullet37"]!),

                     SizedBox(height: pad,),
                     chosenTimeTable(themeData),
                     SizedBox(height: pad,),
                     bodyTextWidget(themeData, text: LEVEL1_DATA["bullet38"]!),

                     
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
                padding: Level2_3of4.sidePad,
                child: Text('Page 3/4',
                textAlign: TextAlign.left,
                style: themeData.textTheme.bodyText2,),
              ),
              Padding(
                padding: Level2_3of4.sidePad,
                child: Text('Introduction to Sleep Restriction',
                textAlign: TextAlign.right,
                style: themeData.textTheme.bodyText2,),
              ),

              ],
            ),
          );
  }


  SafeArea buttomBarWidget(BuildContext context, Future<PatientProfilePodo>? patientProfile, LeveltwoVariables l2vals) {
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
                print("Level 3 of 4 ${l2vals.averagenumberofbedhours}");
                Navigator.push(
                    context, new MaterialPageRoute(builder: (context) => Level2_4of4(patientProfile, l2vals))
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

  MaterialButton navIconButton(BuildContext context, {required String buttonText, Function? buttonActon}){
    return  MaterialButton(
              child: Text(buttonText, style: TextStyle(color: appItemColorBlue, fontWeight: FontWeight.w700),),
              onPressed: buttonActon as void Function()?,
            );
  }

   Padding sectionTitleWidget(ThemeData themeData, {required String text, TextStyle? textStyle} ) {
     return Padding(
                padding: Level2_3of4.sidePad,
                child: Text(text,
                  style: textStyle,
                ),
              );
  }

  Padding bodyTextWidget(ThemeData themeData, {required String text}) {
    return Padding(
              padding: Level2_3of4.sidePad,
              child: Text(text, 
                style: themeData.textTheme.bodyText1,),
            );
  }

  Padding chosenTimeTable(ThemeData themeData) {
    return Padding(
            padding: Level2_3of4.sidePad,
            child: DataTable(
              columns: tableHeaderWidget(themeData),
              rows: [
                rowWidget(themeData, desc: "Your Bed Time (In 24 Hours)", value: "$yourBTime"),
                rowWidget(themeData, desc: "Your Rise Time (In 24 Hours)", value: "$yourRTime"),
                
              ],
            )
          );
  }

  List<DataColumn> tableHeaderWidget(ThemeData themeData) {
    return [
              DataColumn(
                label: Text("SLEEP WINDOW", style: themeData.textTheme.headline5,),
                numeric: false
              ),
              DataColumn(
                label: Text("TIME", style: themeData.textTheme.headline5,),
                numeric: false
              )
            ];
  }

  DataRow rowWidget(ThemeData themeData, {required String desc, required String value}) {
    return DataRow(
            cells: [
              DataCell(
                Text(desc, style: themeData.textTheme.headline6,),
              ),
              DataCell(
                Text(value, style: themeData.textTheme.headline6,),
              ),
            ]
          );
  }


}