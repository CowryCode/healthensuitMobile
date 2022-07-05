import 'package:flutter/material.dart';
import 'package:flutter_form_builder/flutter_form_builder.dart';
import 'package:flutter_redux/flutter_redux.dart';
import 'package:healthensuite/api/network.dart';
import 'package:healthensuite/api/networkmodels/interventionLevelsEntityPODO.dart';
import 'package:healthensuite/api/networkmodels/interventionlevels/levelonePODO.dart';
import 'package:healthensuite/api/networkmodels/patientProfilePodo.dart';
import 'package:healthensuite/api/statemanagement/actions.dart';
import 'package:healthensuite/api/statemanagement/app_state.dart';
import 'package:healthensuite/screens/home/home_screen.dart';
import 'package:healthensuite/utilities/constants.dart';
import 'package:healthensuite/utilities/text_data.dart';
import 'package:healthensuite/models/icon_button.dart';


class MyChoice{
  String? choice;
  String? choiceValue;
  int? index;
  MyChoice({this.choice, this.index, this.choiceValue});
}


class Level1of7 extends StatefulWidget {
  static final String title = 'Level 1';
  static final sidePad = EdgeInsets.symmetric(horizontal: 18);
//  final InterventionlevelOne levelone;

 // final Future<PatientProfilePodo>? patientProfile;

  final int currentPage = 7;
  final int previousPage;
  Level1of7(this.previousPage);

  @override
  _Level1of7State createState() => _Level1of7State();
}

class _Level1of7State extends State<Level1of7> {
  String patientName = "Henry";
  bool radioAloneIsVisible = false;
  bool radioRoomateIsVisible = false;
  bool formFieldIsVisible = false;
  int? defaultIndexbase = -1;
  int? defaultIndexAlone = -1;
  int? defaultIndexRoomate = -1;

  String sleepalone = "";
  String nominaterooMate = "";

  static final _formKey = GlobalKey<FormBuilderState>();

  @override
  Widget build(BuildContext context) {
   // Future<PatientProfilePodo>? futureprofile = widget.patientProfile;

  //  InterventionlevelOne levelone = widget.levelone;
    final Size size = MediaQuery.of(context).size;
    final ThemeData themeData = Theme.of(context);
    double pad = 18;

    return Scaffold(
      appBar: AppBar(
        title: Text(Level1of7.title),
        centerTitle: true,
      ),
      bottomNavigationBar: buttomBarWidget(context),
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
                reverse: true,
                child: Column(
                   crossAxisAlignment: CrossAxisAlignment.start,
                   children: [
                     SizedBox(height: pad,),
                     sectionTitleWidget(themeData, text: "Getting support and involving your partner", textStyle: themeData.textTheme.headline4),
                     bodyTextWidget(themeData, text: LEVEL1_DATA["bullet21"]!),

                     SizedBox(height: pad,),
                     sectionTitleWidget(themeData, text: LEVEL1_DATA["subHead4"]!, textStyle: themeData.textTheme.headline5),
                     bodyTextWidget(themeData, text: LEVEL1_DATA["bullet22"]!),

                     SizedBox(height: pad,),
                     sectionTitleWidget(themeData, text: LEVEL1_DATA["radioQ1"]!, textStyle: themeData.textTheme.headline5),
                     radioButtonBase(themeData),

                    Visibility(child: radioButtonAlone(themeData, context, _formKey,), visible: radioAloneIsVisible,),
                    Visibility(child: radioButtonRoomate(themeData,  _formKey, ), visible: radioRoomateIsVisible,),
                    SizedBox(height: pad,),
                    Visibility(child: formFieldWidget(themeData, _formKey,), visible: formFieldIsVisible,),

                   ],
                ),
              ),
            ),
          ],
        ),
      ),
    );

  }

  FormBuilder formFieldWidget(ThemeData themeData, GlobalKey<FormBuilderState> key ,) {
    return FormBuilder(
                    key: _formKey,
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        sectionTitleWidget(themeData, text: "Fill Support Person Data", textStyle: themeData.textTheme.headline5),
                        Padding(
                          padding: Level1of7.sidePad,
                          child: FormBuilderTextField(
                            name: "supName",
                            style: themeData.textTheme.headline5,
                            decoration: InputDecoration(
                              hintText: "Support Person Name",
                              hintStyle: themeData.textTheme.bodyText2,
                            ),
                          ),
                        ),
                        Padding(
                          padding: Level1of7.sidePad,
                          child: FormBuilderDropdown(
                            name: 'dropdown',
                            hint: Text("My Relationship"),
                            isExpanded: true,
                            items: [
                              "Spouse",
                              "Relative",
                              "Friend",
                              "Roommate",
                            ].map((option) {
                              return DropdownMenuItem(
                                child: Text("$option"),
                                value: option,
                              );
                            }).toList(),
                          ),
                        ),
                        Padding(
                          padding: Level1of7.sidePad,
                          child: FormBuilderTextField(
                            name: "supEmail",
                            style: themeData.textTheme.headline5,
                            keyboardType: TextInputType.emailAddress,
                            decoration: InputDecoration(
                              hintText: "Support Person Email",
                              hintStyle: themeData.textTheme.bodyText2,
                            ),
                          ),
                        ),
                        Center(
                          child: StoreConnector<AppState, PatientProfilePodo>(
                            converter: (store) => store.state.patientProfilePodo,
                            builder: (context, PatientProfilePodo profile) => IconUserButton(buttonText: "Submit", buttonEvent: () {
                              InterventionlevelOne l1 = profile.interventionLevelsEntity!.levelOneEntity ?? InterventionlevelOne();
                           //   InterventionlevelOne level1 = getLevelone(key, l1);
                              updateLevelOnestate(key,profile, l1);
                              createAlertDialog(
                                  context: context,
                                  title: "",
                                  message: "Congratulations! You have finished level 1!",
                                  key: key,
                                 );
                              // ApiAccess().submitLevelone(levelone: level1);
                              // Navigator.of(context).push(MaterialPageRoute(
                              //     builder: (context) => HomeScreen(futureProfile: futureProfile)));
                            },
                              buttonIcon: Icons.send,),
                          ),
                        ),
                      ],
                    ),
                  );
  }

//  InterventionlevelOne getLevelone(GlobalKey<FormBuilderState> key, InterventionlevelOne levelone){
  updateLevelOnestate(GlobalKey<FormBuilderState> key, PatientProfilePodo patientprofile ,InterventionlevelOne levelone){
    String suportname = key.currentState!.fields["supName"]!.value ;
    String relationship = key.currentState!.fields["dropdown"]!.value;
    String supemail = key.currentState!.fields["supEmail"]!.value;
    String stayalone = sleepalone;
    levelone.setsupportPersonname(suportname);
    levelone.setsupportPersonrelationshipt(relationship);
    levelone.setsupportPersonemail(supemail);
    levelone.setsleepalone(stayalone);
    levelone.setnominateRoommate(nominaterooMate);
    levelone.nullifyWhichBestdescribesYoursituation();
    levelone.nullifyHowIsitgoingSofar();

    InterventionLevelsEntity levelsEntity = patientprofile.interventionLevelsEntity ?? InterventionLevelsEntity();
    levelsEntity.setLevelOne(levelone);
    patientprofile.setInterventionLevelsEntity(levelsEntity);
    StoreProvider.of<AppState>(context).dispatch(
      UpdatePatientProfileAction(patientprofile)
    );

 //   return levelone;
  }

  SafeArea buttomBarWidget(BuildContext context) {
    return SafeArea(
      child: BottomAppBar(
        color: Colors.transparent,
        child: Container(
          color: Colors.transparent,
          child: Row(
            mainAxisSize: MainAxisSize.max,
            mainAxisAlignment: MainAxisAlignment.start,
            children: <Widget>[
              navIconButton(context, buttonText: "Back", buttonActon: (){
                Navigator.of(context).pop();
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
                padding: Level1of7.sidePad,
                child: Text('Page 7/7',
                textAlign: TextAlign.left,
                style: themeData.textTheme.bodyText2,),
              ),
              Padding(
                padding: Level1of7.sidePad,
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
                padding: Level1of7.sidePad,
                child: Text(text,
                  style: textStyle,
                ),
              );
  }

  Padding bodyTextWidget(ThemeData themeData, {required String text}) {
    return Padding(
              padding: Level1of7.sidePad,
              child: Text(text, 
                style: themeData.textTheme.bodyText1,),
            );
  }

  void checkForDoisplay(int i){

  }
  

  Column radioButtonBase(ThemeData themeData){
    
    String? defaultChoiceBase = "";
    List<MyChoice> choices = [
      MyChoice(index: 0, choice: "I sleep alone"),
      MyChoice(index: 1, choice: "I share my bedroom with another person, but I sleep in my own bed."),
      MyChoice(index: 2, choice: "I share a bed with another person."),
    ];

    return Column(
      children: [
        Wrap(
          children: [
            Container(
              child: Column(
                children: choices.map((data) => RadioListTile(
                  title: Text('${data.choice}', style: themeData.textTheme.bodyText1,),
                  groupValue: defaultIndexbase,
                  value: data.index,
                  onChanged: (dynamic value){
                        defaultChoiceBase = data.choice; 
                        defaultIndexbase = data.index; 
                        if(value == 0){
                         setState((){
                            radioAloneIsVisible = true;
                            radioRoomateIsVisible = false;
                            formFieldIsVisible = false;
                            sleepalone = "I sleep alone";
                          });
                        }
                        else if(value == 1){
                          setState((){
                            radioRoomateIsVisible = true;
                            radioAloneIsVisible = false;
                            formFieldIsVisible = false;
                            sleepalone = "I share my bedroom with another person, but I sleep in my own bed.";
                          });
                        }else if(value == 2) {
                          setState(() {
                            sleepalone = "I share a bed with another person.";
                          });
                        }
                        print('You clicked me: $value');  
                  },
                )).toList(),
              ),
            ),
          ],
        ),
      ],
    );
  }

  Column radioButtonAlone(ThemeData themeData, BuildContext context,  GlobalKey<FormBuilderState> key ,){
    List<MyChoice> choices = [
      MyChoice(index: 0, choice: "Yes"),
      MyChoice(index: 1, choice: "No"),
    ];
    String? defaultChoice = "";

    return Column(
      children: [
        sectionTitleWidget(themeData, text: LEVEL1_DATA["radioQ2"]!, textStyle: themeData.textTheme.headline5),
        Wrap(
          children: [
            Container(
              child: Column(
                children: choices.map((data) => RadioListTile(
                  title: Text('${data.choice}', style: themeData.textTheme.bodyText1,),
                  groupValue: defaultIndexAlone,
                  value: data.index,
                  onChanged: (dynamic value){
                    defaultChoice = data.choice; 
                    defaultIndexAlone = data.index; 
                    if(value == 0){
                      setState(() {
                        formFieldIsVisible = true;
                        radioRoomateIsVisible = false;
                      });  
                    }
                    else if(value == 1){
                      setState(() {
                        formFieldIsVisible = false;
                      });
                      createAlertDialog(
                          context: context,
                          title: "Remember!",
                          message: "Having someone to support you can make changing your thoughts and behaviours easier.",
                          key: key,
                          );
                    }
                    print('You clicked me: $value');
                    
                  },
                )).toList(),
              ),
            ),
          ],
        ),
      ],
    );
  }

  Column radioButtonRoomate(ThemeData themeData,  GlobalKey<FormBuilderState> key ,){
    List<MyChoice> choices = [
      MyChoice(index: 0, choice: "I would like to nominate this person."),
      MyChoice(index: 1, choice: "I would like to nominate someone else."),
      MyChoice(index: 2, choice: "I do not want to nominate a support person."),
    ];
    String? defaultChoice = "";

    return Column(
      children: [
        sectionTitleWidget(themeData, text: LEVEL1_DATA["radioQ3"]!, textStyle: themeData.textTheme.headline5),
        Wrap(
          children: [
            Container(
              child: Column(
                children: choices.map((data) => RadioListTile(
                  title: Text('${data.choice}', style: themeData.textTheme.bodyText1,),
                  groupValue: defaultIndexRoomate,
                  value: data.index,
                  onChanged: (dynamic value){
                    defaultChoice = data.choice; 
                    defaultIndexRoomate = data.index; 
                    if(value == 0){
                      setState(() {
                        formFieldIsVisible = true;
                        radioAloneIsVisible = false;
                        nominaterooMate = "I will like to nominate this person.";
                      });
                    }
                    else if(value == 1){
                      setState(() {
                        formFieldIsVisible = true;
                        radioAloneIsVisible = false;
                        nominaterooMate = "I will like to nominate someone else.";
                      });
                    }
                    else if(value == 2){
                      setState(() {
                        formFieldIsVisible = false;
                        nominaterooMate = "I do not want to nominate a support person.";
                      });
                      createAlertDialog(
                          context: context,
                          title: "Remember!",
                          message: "Having someone to support you can make changing your thoughts and behaviours easier.",
                          key: key,
                      );
                    }
                    print('You clicked me: $value');
                  },
                )).toList(),
              ),
            ),
          ],
        ),
      ],
    );
  }


  createAlertDialog({required BuildContext context, required String title, required String message, required GlobalKey<FormBuilderState> key,}){
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
            StoreConnector<AppState, PatientProfilePodo>(
              converter: (store) => store.state.patientProfilePodo,
              builder: (context, PatientProfilePodo profile) => MaterialButton(
                child: Text("Submit Anyway", style: TextStyle(color: appItemColorBlue, fontWeight: FontWeight.w700),),
                onPressed: (){
                  InterventionlevelOne levelone = profile.interventionLevelsEntity!.levelOneEntity ?? InterventionlevelOne();
                  levelone.setsleepalone(sleepalone);
                  levelone.setnominateRoommate(nominaterooMate);
                  levelone.nullifyHowIsitgoingSofar();
                  levelone.nullifyWhichBestdescribesYoursituation();
                  ApiAccess().submitLevelone(levelone: levelone);
                  Navigator.of(context).push(MaterialPageRoute(
                      builder: (context) => HomeScreen()));
                }
              ),
            ),
          ],
        );
      });
  }
}

