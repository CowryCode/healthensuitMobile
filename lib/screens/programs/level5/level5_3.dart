import 'package:flutter/material.dart';
import 'package:healthensuite/api/networkmodels/patientProfilePodo.dart';
import 'package:healthensuite/screens/home/home_screen.dart';
import 'package:healthensuite/utilities/constants.dart';
import 'package:healthensuite/utilities/text_data.dart';
import 'package:healthensuite/screens/programs/level4/level4_4.dart';


class Level5of3 extends StatefulWidget {

  static final String title = 'Level 5';
  static final sidePad = EdgeInsets.symmetric(horizontal: 18);

  final Future<PatientProfilePodo>? patientProfile;

  Level5of3(this.patientProfile);

  @override
  _Level5of3State createState() => _Level5of3State();
}

class _Level5of3State extends State<Level5of3> {
  String patientName = "Henry";

  @override
  Widget build(BuildContext context) {
    Future<PatientProfilePodo>? futureprofile = widget.patientProfile;
    final Size size = MediaQuery.of(context).size;
    final ThemeData themeData = Theme.of(context);
    
    double pad = 18;

    return Scaffold(
      appBar: AppBar(
        title: Text(Level5of3.title),
        centerTitle: true,
      ),
      bottomNavigationBar: buttomBarWidget(context, futureprofile),
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
                     sectionTitleWidget(themeData, text: "I’m trying but I can’t sleep!", textStyle: themeData.textTheme.headline4),
                     bodyTextWidget(themeData, text: LEVEL1_DATA["bullet108"]!),
                     

                     SizedBox(height: pad,),
                     sectionTitleWidget(themeData, text: LEVEL1_DATA["subHead17"]!, textStyle: themeData.textTheme.headline5),
                     bodyTextWidget(themeData, text: LEVEL1_DATA["bullet86"]!),

                     SizedBox(height: pad,),
                     sectionTitleWidget(themeData, text: LEVEL1_DATA["subHead18"]!, textStyle: themeData.textTheme.headline5),
                     bodyTextWidget(themeData, text: LEVEL1_DATA["bullet110"]!),
                     bodyTextWidget(themeData, text: LEVEL1_DATA["bullet111"]!),
                     bodyTextWidget(themeData, text: LEVEL1_DATA["bullet112"]!),
                     bodyTextWidget(themeData, text: LEVEL1_DATA["bullet113"]!),
                     bodyTextWidget(themeData, text: LEVEL1_DATA["bullet114"]!),
                     bodyTextWidget(themeData, text: LEVEL1_DATA["bullet115"]!),
                     bodyTextWidget(themeData, text: LEVEL1_DATA["bullet116"]!),
                     
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
                padding: Level5of3.sidePad,
                child: Text('Page 3/3',
                textAlign: TextAlign.left,
                style: themeData.textTheme.bodyText2,),
              ),
              Padding(
                padding: Level5of3.sidePad,
                child: Text('Changing Thoughts',
                textAlign: TextAlign.right,
                style: themeData.textTheme.bodyText2,),
              ),

              ],
            ),
          );
  }


  SafeArea buttomBarWidget(BuildContext context, Future<PatientProfilePodo>? futureProfile) {
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

              navIconButton(context, buttonText: "Conclude Level 5", buttonActon: (){
                Navigator.of(context).push(MaterialPageRoute(
                    builder: (context) => HomeScreen(futureProfile: futureProfile)));
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
                padding: Level5of3.sidePad,
                child: Text(text,
                  style: textStyle,
                ),
              );
  }

  Padding bodyTextWidget(ThemeData themeData, {required String text}) {
    return Padding(
              padding: Level5of3.sidePad,
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


}