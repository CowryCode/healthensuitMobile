import 'package:flutter/material.dart';
import 'package:healthensuite/api/network.dart';
import 'package:healthensuite/api/networkmodels/patientProfilePodo.dart';
import 'package:healthensuite/screens/home/home_screen.dart';
import 'package:healthensuite/utilities/constants.dart';
import 'package:healthensuite/utilities/text_data.dart';


class Level4_4of4 extends StatefulWidget {

  static final String title = 'Level 4';
  static final sidePad = EdgeInsets.symmetric(horizontal: 18);
//  final Future<PatientProfilePodo>? patientProfile;


  Level4_4of4();

  @override
  _Level4_4of4State createState() => _Level4_4of4State();
}

class _Level4_4of4State extends State<Level4_4of4> {
  String patientName = "Henry";

  @override
  Widget build(BuildContext context) {
  // Future<PatientProfilePodo>? profile = widget.patientProfile;
    final Size size = MediaQuery.of(context).size;
    final ThemeData themeData = Theme.of(context);
    
    double pad = 18;

    return Scaffold(
      appBar: AppBar(
        title: Text(Level4_4of4.title),
        centerTitle: true,
      ),
      bottomNavigationBar: buttomBarWidget(context,),
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
                     sectionTitleWidget(themeData, text: "Relaxation using suggestions", textStyle: themeData.textTheme.headline4),
                     bodyTextWidget(themeData, text: LEVEL1_DATA["bullet92"]!),
                     bodyTextWidget(themeData, text: LEVEL1_DATA["bullet93"]!),

                     videoButtonWidget(topic: "Relaxation suggestion", action: (){}),                   

                     sectionTitleWidget(themeData, text: LEVEL1_DATA["subHead15"]!, textStyle: themeData.textTheme.headline5),
                     bodyTextWidget(themeData, text: LEVEL1_DATA["bullet94"]!),
                     bodyTextWidget(themeData, text: LEVEL1_DATA["bullet95"]!),                   
                     
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
                padding: Level4_4of4.sidePad,
                child: Text('Page 4/4',
                textAlign: TextAlign.left,
                style: themeData.textTheme.bodyText2,),
              ),
              Padding(
                padding: Level4_4of4.sidePad,
                child: Text('Relaxation Techniques',
                textAlign: TextAlign.right,
                style: themeData.textTheme.bodyText2,),
              ),

              ],
            ),
          );
  }


  SafeArea buttomBarWidget(BuildContext context, ) {
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

              navIconButton(context, buttonText: "Conclude Level 4", buttonActon: (){
                submitAlertDialog(
                    context: context,
                    title: "",
                    message: "Congratulations! You have finished level 4!",
                    );
                // ApiAccess().submitLevelfour(levelfour: true);
                // Navigator.of(context).push(MaterialPageRoute(
                //     builder: (context) => HomeScreen(futureProfile: futureProfile)));
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
                padding: Level4_4of4.sidePad,
                child: Text(text,
                  style: textStyle,
                ),
              );
  }

  Padding bodyTextWidget(ThemeData themeData, {required String text}) {
    return Padding(
              padding: Level4_4of4.sidePad,
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

  submitAlertDialog({required BuildContext context, required String title, required String message,}){
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
                    ApiAccess().submitLevelfour(levelfour: true);
                    Navigator.of(context).push(MaterialPageRoute(
                        builder: (context) => HomeScreen()));

                  }
              ),
            ],
          );
        });
  }

}