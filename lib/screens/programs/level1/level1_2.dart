import 'package:flutter/material.dart';
import 'package:flutter_form_builder/flutter_form_builder.dart';
import 'package:flutter_redux/flutter_redux.dart';
import 'package:healthensuite/api/network.dart';
import 'package:healthensuite/api/networkmodels/interventionlevels/levelonePODO.dart';
import 'package:healthensuite/api/networkmodels/patientProfilePodo.dart';
import 'package:healthensuite/api/statemanagement/app_state.dart';
import 'package:healthensuite/utilities/constants.dart';
import 'package:healthensuite/utilities/text_data.dart';
import 'package:healthensuite/screens/programs/level1/level1_3.dart';


class Level1of2 extends StatefulWidget {

  static final String title = 'Level 1';
  static final sidePad = EdgeInsets.symmetric(horizontal: 18);
  static final optionPad = EdgeInsets.only(bottom: 10.0);
 // final Future<PatientProfilePodo>? patientProfile;
 //  final InterventionlevelOne levelOneEntity;

  final int currentPage = 2;
  final int previousPage;

//  Level1of2(this.levelOneEntity,  this.previousPage);
  Level1of2( this.previousPage);

  @override
  _Level1of2State createState() => _Level1of2State();
}

class _Level1of2State extends State<Level1of2> {
  String patientName = "Henry";

  @override
  Widget build(BuildContext context) {
    int currentPage = widget.currentPage;
  //  Future<PatientProfilePodo>? futureprofile = widget.patientProfile;
  //  InterventionlevelOne levelOneEntity = widget.levelOneEntity;
    final Size size = MediaQuery.of(context).size;
    final ThemeData themeData = Theme.of(context);
    final _formKey = GlobalKey<FormBuilderState>();
    double pad = 18;

    return Scaffold(
      appBar: AppBar(
        title: Text(Level1of2.title),
        centerTitle: true,
      ),
      bottomNavigationBar: buttomBarWidget(context, _formKey,currentPage),
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
                     sectionTitleWidget(themeData, text: "What is Insomnia", textStyle: themeData.textTheme.headline4),
                     Padding(
                       padding: Level1of2.sidePad,
                       child: Image.asset('assets/images/Insomnia-img.jpg'),
                     ),
                     bodyTextWidget(themeData, text: LEVEL1_DATA["bullet6"]!),
                     bodyTextWidget(themeData, text: LEVEL1_DATA["bullet7"]!),
                     SizedBox(height: pad,),
                     sectionTitleWidget(themeData, text: LEVEL1_DATA["subHead2"]!, textStyle: themeData.textTheme.headline5),
                     checkBoxBuilderWidget(_formKey, themeData),

                    //  bodyTextWidget(themeData, text: LEVEL1_DATA["bullet4"]),
                    //  bodyTextWidget(themeData, text: LEVEL1_DATA["bullet5"]),

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
                padding: Level1of2.sidePad,
                child: Text('Page 2/7',
                textAlign: TextAlign.left,
                style: themeData.textTheme.bodyText2,),
              ),
              Padding(
                padding: Level1of2.sidePad,
                child: Text('Intro. to Health enSuite Insomnia',
                textAlign: TextAlign.right,
                style: themeData.textTheme.bodyText2,),
              ),

              ],
            ),
          );
  }

  Padding optionTextWidget(ThemeData themeData, {required String text}) {
    return Padding(
              padding: Level1of2.optionPad,
              child: Text(text, 
                style: themeData.textTheme.bodyText1,),
            );
  }

  FormBuilder checkBoxBuilderWidget(GlobalKey<FormBuilderState> _formKey, ThemeData themeData) {
    return FormBuilder(
                     key: _formKey,
                     child: FormBuilderCheckboxGroup(
                        name: "situationList", 
                        options: [
                          FormBuilderFieldOption(
                            value: "It often takes me more than 30 minutes to fall asleep.",
                            child: optionTextWidget(themeData, text: "It often takes me more than 30 minutes to fall asleep."),
                          ),
                          FormBuilderFieldOption(
                            value: "I wake up frequently throughout the night and have trouble getting back to sleep.",
                            child: optionTextWidget(themeData, text: "I wake up frequently throughout the night and have trouble getting back to sleep."),
                          ),
                          FormBuilderFieldOption(
                            value: "I regularly wake up too early in the morning and cannot get back to sleep.",
                            child: optionTextWidget(themeData, text: "I regularly wake up too early in the morning and cannot get back to sleep."),
                          ),
                          FormBuilderFieldOption(
                            value: "My sleep quality is poor. I would like to improve the quality of my sleep.",
                            child: optionTextWidget(themeData, text: "My sleep quality is poor. I would like to improve the quality of my sleep."),
                          ),
                        ],
                      ),
                   );
  }

  InterventionlevelOne getSelectedValue(GlobalKey<FormBuilderState> key, InterventionlevelOne levelOne){
    var result = key.currentState!.fields["situationList"]!.value;
  //  InterventionlevelOne levelOne = InterventionlevelOne();
  //  String choice = result[0]; // You have to loop through this result when it starts populating
    String choices = " ";
    for(int x = 0 ; x < result.length ; x++){ // The loop implemented
      choices = choices + result[x];
    }
   // levelOne.setwhichBestdescribesYoursituation(choice);
    levelOne.setwhichBestdescribesYoursituation(choices);
    return levelOne;
  }

  SafeArea buttomBarWidget(BuildContext context, GlobalKey<FormBuilderState> key, int currentPage,) {
    return SafeArea(
      child: BottomAppBar(
        color: Colors.transparent,
        child: Container(
          color: Colors.transparent,
          child: StoreConnector<AppState, PatientProfilePodo>(
            converter: (store) => store.state.patientProfilePodo,
            builder: (context, PatientProfilePodo patientprofile) => Row(
              mainAxisSize: MainAxisSize.max,
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: <Widget>[
                navIconButton(context, buttonText: "Back", buttonActon: (){
                  Navigator.of(context).pop();
                }),

                navIconButton(context, buttonText: "Next", buttonActon: (){
                  InterventionlevelOne levelOne = patientprofile.interventionLevelsEntity?.levelOneEntity ?? InterventionlevelOne();
                  InterventionlevelOne levelone = getSelectedValue(key, levelOne);
                  ApiAccess().submitLevelone(levelone: levelone);
                  Navigator.push(
                      context, new MaterialPageRoute(builder: (context) => Level1of3(currentPage))
                  );
                }
                ),
              ],
            ),
          ),
          // child: Row(
          //   mainAxisSize: MainAxisSize.max,
          //   mainAxisAlignment: MainAxisAlignment.spaceBetween,
          //   children: <Widget>[
          //     navIconButton(context, buttonText: "Back", buttonActon: (){
          //       Navigator.of(context).pop();
          //     }),
          //
          //     navIconButton(context, buttonText: "Next", buttonActon: (){
          //       InterventionlevelOne levelone = getSelectedValue(key, levelOne);
          //       ApiAccess().submitLevelone(levelone: levelone);
          //       Navigator.push(
          //           context, new MaterialPageRoute(builder: (context) => Level1of3(levelone,currentPage))
          //           );
          //       }
          //     ),
          //   ],
          // ),
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
                padding: Level1of2.sidePad,
                child: Text(text,
                  style: textStyle,
                ),
              );
  }

  Padding bodyTextWidget(ThemeData themeData, {required String text}) {
    return Padding(
              padding: Level1of2.sidePad,
              child: Text(text, 
                style: themeData.textTheme.bodyText1,),
            );
  }
}