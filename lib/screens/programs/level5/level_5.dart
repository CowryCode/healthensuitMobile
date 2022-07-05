import 'package:flutter/material.dart';
import 'package:healthensuite/api/network.dart';
import 'package:healthensuite/api/networkmodels/interventionlevels/levelfivePODO.dart';
import 'package:healthensuite/api/networkmodels/patientProfilePodo.dart';
import 'package:healthensuite/api/networkmodels/statusEntityPODO.dart';
import 'package:healthensuite/screens/programs/level5/level5_3.dart';
import 'package:healthensuite/utilities/constants.dart';
import 'package:healthensuite/utilities/text_data.dart';
import 'package:healthensuite/screens/programs/level5/level5_2.dart';


class Level5_1of3 extends StatefulWidget {

  static final String title = 'Level 5';
  static final sidePad = EdgeInsets.symmetric(horizontal: 18);
  final Future<PatientProfilePodo>? patientProfile;
  final int currentPage = 1;

  Level5_1of3(this.patientProfile);

  @override
  _Level5_1of3State createState() => _Level5_1of3State();
}

class _Level5_1of3State extends State<Level5_1of3> {
  String patientName = "";


  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) => createAlertDialog(context));

    Future<PatientProfilePodo>? profile = widget.patientProfile;
    WidgetsBinding.instance!.addPostFrameCallback((_) async {
      StatusEntity? status;
      await profile!.then((value) => {
        status = value.statusEntity,
        patientName = value.firstName!,
      });

      int? nextLevel = status!.nextPage;
      bool? isCompleted = status!.readInterventionGrouplevelfiveArticle;
      if(isCompleted!){
        Navigator.push(
            context, new MaterialPageRoute(builder: (context) => Level5_3of3(profile))
        );
      }else if(nextLevel == 2){
        Navigator.push(
            context, new MaterialPageRoute(builder: (context) => Level5_2of3(profile))
        );
      }else if(nextLevel == 3){
        Navigator.push(
            context, new MaterialPageRoute(builder: (context) => Level5_3of3(profile))
        );
      }
    });
  }


  @override
  Widget build(BuildContext context) {
    Future<PatientProfilePodo>? profile = widget.patientProfile;
    final Size size = MediaQuery.of(context).size;
    final ThemeData themeData = Theme.of(context);
    double pad = 18;

    //Future.delayed(Duration.zero, () => createAlertDialog(context, themeData));

    return Scaffold(
      appBar: AppBar(
        title: Text(Level5_1of3.title),
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
                padding: Level5_1of3.sidePad,
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
                       padding: Level5_1of3.sidePad,
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
                  ApiAccess().savePage(currentPage: widget.currentPage, interventionLevel: 5);
                  Navigator.push(
                  context, new MaterialPageRoute(builder: (context) => Level5_2of3(futureProfile))
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
                padding: Level5_1of3.sidePad,
                child: Text(text,
                  style: textStyle,
                ),
              );
  }

  createAlertDialog(BuildContext context) {
    final ThemeData themeData = Theme.of(context);
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
              padding: Level5_1of3.sidePad,
              child: Text(text, 
                style: themeData.textTheme.bodyText1,),
            );
  }

  Card thoughtCard(ThemeData themeData, double pad, BuildContext context, {required String text}) {
     return Card(
            child: Padding(
                  padding: Level5_1of3.sidePad,
                  child: Text(text,
                    style: themeData.textTheme.bodyText2,
                  ),
                ),
          );
   }

}