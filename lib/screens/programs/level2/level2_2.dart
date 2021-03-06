import 'package:flutter/material.dart';
import 'package:flutter_form_builder/flutter_form_builder.dart';
import 'package:flutter_redux/flutter_redux.dart';
import 'package:healthensuite/api/network.dart';
import 'package:healthensuite/api/networkmodels/interventionLevelsEntityPODO.dart';
import 'package:healthensuite/api/networkmodels/interventionlevels/levelonePODO.dart';
import 'package:healthensuite/api/networkmodels/interventionlevels/leveltwoPODO.dart';
import 'package:healthensuite/api/networkmodels/interventionlevels/leveltwoVariables.dart';
import 'package:healthensuite/api/networkmodels/patientProfilePodo.dart';
import 'package:healthensuite/api/statemanagement/actions.dart';
import 'package:healthensuite/api/statemanagement/app_state.dart';
import 'package:healthensuite/utilities/constants.dart';
import 'package:healthensuite/utilities/text_data.dart';
import 'package:healthensuite/screens/programs/level2/level2_3.dart';


class Level2_2of4 extends StatefulWidget {

  static final String title = 'Level 2';
  static final sidePad = EdgeInsets.symmetric(horizontal: 18);

 // final Future<PatientProfilePodo>? patientProfile;

  final LeveltwoVariables l2variables;


//  Level2_2of4(this.patientProfile, this.l2variables);
  Level2_2of4(this.l2variables);

  @override
  _Level2_2of4State createState() => _Level2_2of4State();
}

class _Level2_2of4State extends State<Level2_2of4> {
  String patientName = "Henry";
  TimeOfDay? time;
  final _formKey = GlobalKey<FormBuilderState>();

  @override
  Widget build(BuildContext context) {
  //  Future<PatientProfilePodo>? profile = widget.patientProfile;
    LeveltwoVariables variables = widget.l2variables;

    final Size size = MediaQuery.of(context).size;
    final ThemeData themeData = Theme.of(context);
    
    double pad = 18;

    return Scaffold(
      appBar: AppBar(
        title: Text(Level2_2of4.title),
        centerTitle: true,
      ),
      bottomNavigationBar: buttomBarWidget(context,variables),
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
                     sectionTitleWidget(themeData, text: "Your Next Step", textStyle: themeData.textTheme.headline4),
                     
                     bodyTextWidget(themeData, text: LEVEL1_DATA["bullet34"]!),

                     SizedBox(height: pad,),
                     sectionTitleWidget(themeData, text: LEVEL1_DATA["subHead7"]!, textStyle: themeData.textTheme.headline5),
                     bodyTextWidget(themeData, text: LEVEL1_DATA["bullet35"]!),

                     SizedBox(height: pad,),
                     timeQuestion(Level2_2of4.sidePad, themeData, context, question: "Choose Your Rise Time:", valName: "riseTime", l2variables: variables),

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
                padding: Level2_2of4.sidePad,
                child: Text('Page 2/4',
                textAlign: TextAlign.left,
                style: themeData.textTheme.bodyText2,),
              ),
              Padding(
                padding: Level2_2of4.sidePad,
                child: Text('Introduction to Sleep Restriction',
                textAlign: TextAlign.right,
                style: themeData.textTheme.bodyText2,),
              ),

              ],
            ),
          );
  }


  Padding timeQuestion(EdgeInsets sidePad, ThemeData themeData, BuildContext context, {required String question, required String valName, required LeveltwoVariables l2variables}) {
    return Padding(
              padding: sidePad,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(question,
                  style: themeData.textTheme.headline5,),
                  Row(
                    children: [
                      Expanded(
                        child: FormBuilderTextField(
                          name: valName,
                          initialValue: getText(_formKey, time, valName, l2variables),
                          readOnly: true,
                          style: themeData.textTheme.bodyText1,
                        ),
                      ),
                      IconButton(
                        onPressed: () => pickTime(context, _formKey, valName, time, l2variables),
                        icon: Icon(Icons.lock_clock),
                        color: appItemColorBlue,
                      ),
                    ],
                  ),
                  
                ],
              ),
            );
  }

  Future pickTime(BuildContext context, GlobalKey<FormBuilderState> key, String valName, TimeOfDay? time, LeveltwoVariables l2variables) async {
    final initialTime = TimeOfDay(hour: 5, minute: 0);
    final newTime = await showTimePicker(
      context: context,
      initialTime: time ?? initialTime,
    );

    if (newTime == null) return;

    time = newTime;
    print("New Time $time");
    String newRiseTime =  getText(key, time, valName, l2variables);
    l2variables.setNewriseTime(newRiseTime);
    l2variables.setCompleted(isCompleted: false);
  }

  String getText(GlobalKey<FormBuilderState> key, TimeOfDay? time, String valName, LeveltwoVariables l2variables) {
    String timeVal = "Click the left icon to select time";    
    if (time == null) {
      return timeVal;
    } else {
      final hours = time.hour.toString().padLeft(2, '0');
      final minutes = time.minute.toString().padLeft(2, '0');
      timeVal = '$hours:$minutes';
      print("The real time is $timeVal");
      l2variables.setNewriseTime(timeVal);
      l2variables.setCompleted(isCompleted: false);
      key.currentState!.fields[valName]!.didChange(timeVal);
      return timeVal;
    }
  }

  SafeArea buttomBarWidget(BuildContext context, LeveltwoVariables l2variables) {
    return SafeArea(
      child: BottomAppBar(
        color: Colors.transparent,
        child: Container(
          color: Colors.transparent,
          child: StoreConnector<AppState, PatientProfilePodo>(
            converter: (store) => store.state.patientProfilePodo,
            builder: (context, PatientProfilePodo profile) => Row(
              mainAxisSize: MainAxisSize.max,
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: <Widget>[
                navIconButton(context, buttonText: "Back", buttonActon: (){
                  Navigator.of(context).pop();
                }),
                navIconButton(context, buttonText: "Submit Rise Time", buttonActon: (){
                  print("Level 2 of 4 ${l2variables.averagenumberofbedhours}");
                  ApiAccess().submitLeveTwo(levelTwo: l2variables);
                  // Update State
                  InterventionLevelsEntity levelsentities = profile.interventionLevelsEntity ?? InterventionLevelsEntity();
                  levelsentities.setLevelTwoVariables(l2variables);
                  profile.setInterventionLevelsEntity(levelsentities);
                  StoreProvider.of<AppState>(context).dispatch(UpdatePatientProfileAction(profile));
                  // Update state end
                  Navigator.push(
                      context, new MaterialPageRoute(builder: (context) => Level2_3of4(l2variables))
                      );
                  }
                ),
              ],
            ),
          ),
        ),
        elevation: 100,
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
                padding: Level2_2of4.sidePad,
                child: Text(text,
                  style: textStyle,
                ),
              );
  }

  Padding bodyTextWidget(ThemeData themeData, {required String text}) {
    return Padding(
              padding: Level2_2of4.sidePad,
              child: Text(text, 
                style: themeData.textTheme.bodyText1,),
            );
  }
}