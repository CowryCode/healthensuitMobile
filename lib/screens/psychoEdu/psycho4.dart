import 'package:flutter/material.dart';
import 'package:healthensuite/api/network.dart';
import 'package:healthensuite/api/networkmodels/patientProfilePodo.dart';
import 'package:healthensuite/api/networkmodels/psychoeducationPODO.dart';
import 'package:healthensuite/screens/home/home_screen.dart';
import 'package:healthensuite/utilities/constants.dart';
import 'package:healthensuite/utilities/text_data.dart';



class MyChoice{
  String? choice;
  String? choiceValue;
  int? index;
  MyChoice({this.choice, this.index, this.choiceValue});
}

int? patientChoice;

class Psycho4 extends StatefulWidget {
  static final String title = 'Psychoeducation';
  static final sidePad = EdgeInsets.symmetric(horizontal: 18);
  final PsychoeducationDTO psychoeducationDTO;

  Future<PatientProfilePodo>? futureProfile;


  Psycho4(this.psychoeducationDTO,this.futureProfile);

  @override
  _Psycho4 createState() => _Psycho4();
}

class _Psycho4 extends State<Psycho4> {
  String patientName = "Henry";

  @override
  Widget build(BuildContext context) {
    PsychoeducationDTO psychEdu = widget.psychoeducationDTO;
    Future<PatientProfilePodo>? futureprofile = widget.futureProfile;

    final Size size = MediaQuery.of(context).size;
    final ThemeData themeData = Theme.of(context);
    double pad = 18;

    return Scaffold(
      appBar: AppBar(
        title: Text(Psycho4.title),
        centerTitle: true,
      ),
      bottomNavigationBar: buttomBarWidget(context, psychEdu, futureprofile),
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
                     sectionTitleWidget(themeData, text: "Sleeping pills", textStyle: themeData.textTheme.headline4),
                     Padding(
                       padding: Psycho4.sidePad,
                       child: Image.asset('assets/images/sleepPills1-img.jpg'),
                     ),
                     bodyTextWidget(themeData, text: LEVEL1_DATA["bullet12"]!),
                     bodyTextWidget(themeData, text: LEVEL1_DATA["bullet13"]!),
                     bodyTextWidget(themeData, text: LEVEL1_DATA["bullet14"]!),
                     SizedBox(height: pad,),
                     sectionTitleWidget(themeData, text: LEVEL1_DATA["subHead3"]!, textStyle: themeData.textTheme.headline5),
                      RadioGroup(),

                    bodyTextWidget(themeData, text: LEVEL1_DATA["bulletLastPsycho"]!),

                   ],
                ),
              ),
            ),
          ],
        ),
      ),
    );

  }

  SafeArea buttomBarWidget(BuildContext context, PsychoeducationDTO psychEdu,  Future<PatientProfilePodo>? futureProfile) {
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
              navIconButton(context, buttonText: "Submit", buttonActon: (){
                submitAlertDialog(
                    context: context,
                    title: "",
                    message: "Congratulations! You have finished the psychoeducation!",
                    psychEdu: psychEdu,
                    futureProfile: futureProfile);

                // PsychoeducationDTO completedPsychoeducationObject = getSelectedValue(psychEdu);
                // ApiAccess().submitPsychoEducation(psychoeducationDTO: completedPsychoeducationObject);
                // Navigator.of(context).push(MaterialPageRoute(
                //   builder: (context) => HomeScreen(futureProfile: futureProfile,),
                // ));
              }),
            ],
          ),
        ),
        elevation: 100,
      ),
    );
  }

  PsychoeducationDTO getSelectedValue(PsychoeducationDTO psychoeducationDTO){
   // int choice = RadioGroup().patientChoice;
    int? choice = patientChoice;
    if(choice == 5){
        psychoeducationDTO.setifeelconfident(true);
      }
      if(choice == 6){
        psychoeducationDTO.setithinkitsdifficult(true);
      }
      if(choice == 7){
        psychoeducationDTO.setidontknow(true);
      }
      psychoeducationDTO.setCompleteStatus(isCompleted: true);
      return psychoeducationDTO;
  }


  SingleChildScrollView headerWidget(ThemeData themeData) {
    return SingleChildScrollView(
            scrollDirection: Axis.horizontal,
            child: Row(
              mainAxisSize: MainAxisSize.max,
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Padding(
                padding: Psycho4.sidePad,
                child: Text('Page 4/4',
                textAlign: TextAlign.left,
                style: themeData.textTheme.bodyText2,),
              ),
              Padding(
                padding: Psycho4.sidePad,
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
                padding: Psycho4.sidePad,
                child: Text(text,
                  style: textStyle,
                ),
              );
  }

  Padding bodyTextWidget(ThemeData themeData, {required String text}) {
    return Padding(
              padding: Psycho4.sidePad,
              child: Text(text, 
                style: themeData.textTheme.bodyText1,),
            );
  }

  submitAlertDialog({required BuildContext context, required String title, required String message, required PsychoeducationDTO psychEdu, required Future<PatientProfilePodo>? futureProfile}){
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
                  onPressed: () {
                    PsychoeducationDTO completedPsychoeducationObject = getSelectedValue(psychEdu);
                    ApiAccess().submitPsychoEducation(psychoeducationDTO: completedPsychoeducationObject);
                    Navigator.of(context).push(MaterialPageRoute(
                      builder: (context) =>
                          HomeScreen(futureProfile: futureProfile, justLoggedIn: false),
                    ));
                  }
              ),
            ],
          );
        });
  }

}


class RadioGroup extends StatefulWidget {
  int patientChoice = 0;
  @override
  _RadioGroupState createState() => _RadioGroupState();
}

class _RadioGroupState extends State<RadioGroup> {
  String? defaultChoice = "";
    int? defaultIndex = -1;

    List<MyChoice> choices = [
      MyChoice(index: 0, choice: "I feel confident I will be able to stick to this plan.", choiceValue: ""),
      MyChoice(index: 1, choice: "I think it will be very difficult for me to stick to this plan.", choiceValue: ""),
      MyChoice(index: 2, choice: "I don’t know what the plan is. What can I do to find out?", choiceValue: ""),
    ];

  @override
  Widget build(BuildContext context) {
    final ThemeData themeData = Theme.of(context);
    
    return Column(
      children: [
        Wrap(
          children: [
            Container(
              child: Column(
                children: choices.map((data) => RadioListTile(
                  title: Text('${data.choice}', style: themeData.textTheme.bodyText1,),
                  groupValue: defaultIndex,
                  value: data.index,
                  onChanged: (dynamic value){
                    setState(() {
                        defaultChoice = data.choice; 
                        defaultIndex = data.index; 
                        if(value == 0){
                         // widget.patientChoice = 5;
                          RadioGroup().patientChoice = 5;
                          patientChoice = 5;
                          createAlertDialog(context, head: "Great!", body: "You can track your progress in the Medication Log.");
                        }
                        else if(value == 1){
                         // widget.patientChoice = 6;
                          RadioGroup().patientChoice = 6;
                          patientChoice = 6;
                          createAlertDialog(context, head: "Change can be difficult!", body: "This app provides tools that should help make it easier for you. If you need to modify the plan please consult your health care provider.");
                        }
                        else if(value == 2){
                        //  widget.patientChoice = 7;
                          RadioGroup().patientChoice = 7;
                          patientChoice = 7;
                          createAlertDialog(context, head: "Attention!", body: "Use the medications tab on the dashboard to view your tapering schedule.");
                        }
                        print('You clicked me: $value');         
                    });
                  },
                )).toList(),
              ),
            ),
          ],
        ),
      ],
    );
  }

  createAlertDialog(BuildContext context, {String? head, String? body}){
     final ThemeData themeData = Theme.of(context);
    return showDialog(
      context: context, 
      barrierDismissible: false,
      builder: (context){
        return AlertDialog(
          title: Text(head!, style: themeData.textTheme.headline5,),
          content: Text(body!, 
          style: themeData.textTheme.bodyText2,),
          actions: [
            MaterialButton(
              child: Text("Dismiss", style: TextStyle(color: appItemColorBlue, fontWeight: FontWeight.w700),),
              onPressed: (){
                Navigator.of(context).pop();
              }
            ),
          ],
        );
      });
  }
}