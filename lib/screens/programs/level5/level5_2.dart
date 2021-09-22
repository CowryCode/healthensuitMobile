import 'package:flutter/material.dart';
import 'package:flutter_form_builder/flutter_form_builder.dart';
import 'package:healthensuite/api/network.dart';
import 'package:healthensuite/api/networkmodels/interventionlevels/levelfivePODO.dart';
import 'package:healthensuite/api/networkmodels/patientProfilePodo.dart';
import 'package:healthensuite/utilities/constants.dart';
import 'package:healthensuite/utilities/text_data.dart';
import 'package:healthensuite/screens/programs/level5/level5_3.dart';

class Level5of2 extends StatefulWidget {

  static final String title = 'Level 5';
  static final sidePad = EdgeInsets.symmetric(horizontal: 18);

  final Future<PatientProfilePodo>? patientProfile;


  Level5of2(this.patientProfile);

  @override
  _Level50f2State createState() => _Level50f2State();
}

class _Level50f2State extends State<Level5of2> {
  String patientName = "Henry";
  static final _formKey = GlobalKey<FormBuilderState>();

  @override
  Widget build(BuildContext context) {
    Future<PatientProfilePodo>? futureprofile = widget.patientProfile;
    final Size size = MediaQuery.of(context).size;
    final ThemeData themeData = Theme.of(context);
    
    double pad = 18;

    return Scaffold(
      appBar: AppBar(
        title: Text(Level5of2.title),
        centerTitle: true,
      ),
      bottomNavigationBar: buttomBarWidget(context, _formKey, futureprofile),
      body: Container(
        width: size.width,
        height: size.height,
        child: FormBuilder(
          key: _formKey,
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
                       sectionTitleWidget(themeData, text: "Keep your expectations realistic", textStyle: themeData.textTheme.headline4),

                       thoughtCard(themeData, pad, context, text: LEVEL1_DATA["thought3"]!),
                       SizedBox(height: pad,),
                       formFieldWidget(themeData, hint: LEVEL1_DATA["textHint1"]!, title: LEVEL1_DATA["textTitle1"]!, valName:"sleepExpect"),
                       SizedBox(height: pad,),
                       bodyTextWidget(themeData, text: LEVEL1_DATA["bullet101"]!),

                       thoughtCard(themeData, pad, context, text: LEVEL1_DATA["thought4"]!),
                       SizedBox(height: pad,),
                       formFieldWidget(themeData, hint: LEVEL1_DATA["textHint1"]!, title: LEVEL1_DATA["textTitle1"]!, valName:"energyExpect"),
                       SizedBox(height: pad,),
                       bodyTextWidget(themeData, text: LEVEL1_DATA["bullet102"]!),

                       thoughtCard(themeData, pad, context, text: LEVEL1_DATA["thought5"]!),
                       SizedBox(height: pad,),
                       formFieldWidget(themeData, hint: LEVEL1_DATA["textHint1"]!, title: LEVEL1_DATA["textTitle1"]!, valName:"stayAsleepExpect"),
                       SizedBox(height: pad,),
                       bodyTextWidget(themeData, text: LEVEL1_DATA["bullet103"]!),

                       bodyTextWidget(themeData, text: LEVEL1_DATA["bullet104"]!),
                       thoughtCard(themeData, pad, context, text: LEVEL1_DATA["thought6"]!),
                       SizedBox(height: pad,),
                       formFieldWidget(themeData, hint: LEVEL1_DATA["textHint2"]!, title: LEVEL1_DATA["textTitle2"]!, valName:"otherExpect"),
                       SizedBox(height: pad,),
                       bodyTextWidget(themeData, text: LEVEL1_DATA["bullet103"]!),

                       thoughtCard(themeData, pad, context, text: LEVEL1_DATA["thought7"]!),
                       SizedBox(height: pad,),
                       formFieldWidget(themeData, hint: LEVEL1_DATA["textHint3"]!, title: LEVEL1_DATA["textTitle3"]!, valName:"otherWay"),
                       SizedBox(height: pad,),
                       bodyTextWidget(themeData, text: LEVEL1_DATA["bullet106"]!),
                       bodyTextWidget(themeData, text: LEVEL1_DATA["bullet107"]!),
                       
                     ],
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );

  }

  void submitVariables(GlobalKey<FormBuilderState> key){
    var hoursofsleep = key.currentState!.fields["sleepExpect"]!.value;
    var fullofenergy = key.currentState!.fields["energyExpect"]!.value;
    var fallasleep = key.currentState!.fields["stayAsleepExpect"]!.value;
    var didnotsleep = key.currentState!.fields["otherExpect"]!.value;
    var cancelsm = key.currentState!.fields["otherWay"]!.value;
    Levelfive L5 = Levelfive();
    L5.sethoursofsleepeachnight(hoursofsleep);
    L5.setfullofenergyeachday(fullofenergy);
    L5.setfallasleepfast(fallasleep);
    L5.setdidnotsleepwelllastnight(didnotsleep);
    L5.setcancelsocialmedia(cancelsm);
    ApiAccess().submitLevelfive(levelfive: L5);
  }

  SingleChildScrollView headerWidget(ThemeData themeData) {
    return SingleChildScrollView(
            scrollDirection: Axis.horizontal,
            child: Row(
              mainAxisSize: MainAxisSize.max,
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Padding(
                padding: Level5of2.sidePad,
                child: Text('Page 2/3',
                textAlign: TextAlign.left,
                style: themeData.textTheme.bodyText2,),
              ),
              Padding(
                padding: Level5of2.sidePad,
                child: Text('Changing Thoughts',
                textAlign: TextAlign.right,
                style: themeData.textTheme.bodyText2,),
              ),

              ],
            ),
          );
  }


  SafeArea buttomBarWidget(BuildContext context, GlobalKey<FormBuilderState> key, Future<PatientProfilePodo>? futureProfile) {
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

              navIconButton(context, buttonText: "Submit Your Views", buttonActon: (){
                submitAlertDialog(
                    context: context,
                    title: "Warning!",
                    message: "Are you sure you want to save at this moment ?",
                    key: key,
                    futureProfile: futureProfile);
               //  submitVariables(key);
               // Navigator.push(
               //      context, new MaterialPageRoute(builder: (context) => Level5of3(futureProfile))
               //      );
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
                padding: Level5of2.sidePad,
                child: Text(text,
                  style: textStyle,
                ),
              );
  }

  Padding bodyTextWidget(ThemeData themeData, {required String text}) {
    return Padding(
              padding: Level5of2.sidePad,
              child: Text(text, 
                style: themeData.textTheme.bodyText1,),
            );
  }

  MaterialButton videoButtonWidget({required String topic, Function? action}) {
     return MaterialButton(
                  child: Text(topic, 
                    style: TextStyle(color: appBackgroundColor, fontWeight: FontWeight.w700),
                  ),
                  onPressed: action as void Function()?
                );
   }

  Card thoughtCard(ThemeData themeData, double pad, BuildContext context, {required String text}) {
     return Card(
            child: Padding(
                  padding: Level5of2.sidePad,
                  child: Text(text,
                    style: themeData.textTheme.bodyText2,
                  ),
                ),
          );
   }


  Column formFieldWidget(ThemeData themeData, {required String hint, required String title, required String valName}) {
    return Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        sectionTitleWidget(themeData, text: title, textStyle: themeData.textTheme.headline5),
                        Padding(
                          padding: Level5of2.sidePad,
                          child: FormBuilderTextField(
                            name: valName,
                            style: themeData.textTheme.headline5,
                            decoration: InputDecoration(
                              hintText: hint,
                              hintStyle: themeData.textTheme.bodyText2,
                            ),
                          ),
                        ),
                      ],
                  );
  }


  submitAlertDialog({required BuildContext context, required String title, required String message, required GlobalKey<FormBuilderState> key, required Future<PatientProfilePodo>? futureProfile}){
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
                  onPressed: (){
                    submitVariables(key);
                    Navigator.push(
                        context, new MaterialPageRoute(builder: (context) => Level5of3(futureProfile))
                    );
                  }
              ),
            ],
          );
        });
  }

}