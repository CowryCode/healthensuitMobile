import 'package:flutter/material.dart';
import 'package:healthensuite/api/networkmodels/patientProfilePodo.dart';
import 'package:healthensuite/utilities/constants.dart';
import 'package:healthensuite/utilities/text_data.dart';
import 'package:healthensuite/screens/programs/level5/level5_2.dart';


class Level5 extends StatefulWidget {

  static final String title = 'Level 5';
  static final sidePad = EdgeInsets.symmetric(horizontal: 18);
  final Future<PatientProfilePodo>? patientProfile;

  Level5(this.patientProfile);

  @override
  _Level5State createState() => _Level5State();
}

class _Level5State extends State<Level5> {
  String patientName = "Henry";

  @override
  Widget build(BuildContext context) {
    Future<PatientProfilePodo>? profile = widget.patientProfile;
    final Size size = MediaQuery.of(context).size;
    final ThemeData themeData = Theme.of(context);
    double pad = 18;

    //Future.delayed(Duration.zero, () => createAlertDialog(context, themeData));

    return Scaffold(
      appBar: AppBar(
        title: Text(Level5.title),
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
                padding: Level5.sidePad,
                child: Text('Page 1/3',
                textAlign: TextAlign.right,
                style: themeData.textTheme.bodyText2,),
              ),
            ),
            Expanded(
              flex: 1,
              child: SingleChildScrollView(
                scrollDirection: Axis.vertical,
                physics: ClampingScrollPhysics(),
                child: Column(
                   crossAxisAlignment: CrossAxisAlignment.start,
                   children: [
                     SizedBox(height: pad,),
                     sectionTitleWidget(themeData, text: "Changing Thoughts", textStyle: themeData.textTheme.headline4),
                     bodyTextWidget(themeData, text: LEVEL1_DATA["bullet96"]!),
                     bodyTextWidget(themeData, text: LEVEL1_DATA["bullet97"]!),
                     bodyTextWidget(themeData, text: LEVEL1_DATA["bullet98"]!),
                     SizedBox(height: pad,),

                     Padding(
                       padding: Level5.sidePad,
                       child: Image.asset('assets/images/thoughts-img.jpg'),
                     ),
                     SizedBox(height: pad,),
                     thoughtCard(themeData, pad, context, text: LEVEL1_DATA["thought1"]!),

                     SizedBox(height: pad,),
                     sectionTitleWidget(themeData, text: LEVEL1_DATA["subHead16"]!, textStyle: themeData.textTheme.headline5),
                     bodyTextWidget(themeData, text: LEVEL1_DATA["bullet99"]!),
                     
                     SizedBox(height: pad,),
                     thoughtCard(themeData, pad, context, text: LEVEL1_DATA["thought2"]!),
                     SizedBox(height: pad,),
                     bodyTextWidget(themeData, text: LEVEL1_DATA["bullet100"]!),

                     

                   ],
                ),
              ),
            ),
          ],
        ),
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
            mainAxisAlignment: MainAxisAlignment.end,
            children: <Widget>[
              MaterialButton(
                child: Text("Next", style: TextStyle(color: appItemColorBlue, fontWeight: FontWeight.w700),),
                onPressed: (){
                  Navigator.push(
                  context, new MaterialPageRoute(builder: (context) => Level5of2(futureProfile))
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

   Padding sectionTitleWidget(ThemeData themeData, {required String text, TextStyle? textStyle} ) {
     return Padding(
                padding: Level5.sidePad,
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
          title: Text("Welcome To Level 5", style: themeData.textTheme.headline5,),
          content: SingleChildScrollView(
            scrollDirection: Axis.vertical,
                physics: ClampingScrollPhysics(),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                splashTextWidget(themeData, text: "Welcome $patientName,"),
                splashTextWidget(themeData, text: LEVEL1_DATA["splashBullet19"]!),
                splashTextWidget(themeData, text: LEVEL1_DATA["splashBullet20"]!),
                splashTextWidget(themeData, text: LEVEL1_DATA["splashBullet21"]!),
                splashTextWidget(themeData, text: LEVEL1_DATA["splashBullet22"]!),
                splashTextWidget(themeData, text: LEVEL1_DATA["splashBullet23"]!),
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
              padding: Level5.sidePad,
              child: Text(text, 
                style: themeData.textTheme.bodyText1,),
            );
  }

  Card thoughtCard(ThemeData themeData, double pad, BuildContext context, {required String text}) {
     return Card(
            child: Padding(
                  padding: Level5.sidePad,
                  child: Text(text,
                    style: themeData.textTheme.bodyText2,
                  ),
                ),
          );
   }

}