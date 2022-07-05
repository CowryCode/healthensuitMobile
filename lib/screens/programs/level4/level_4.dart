import 'package:flutter/material.dart';
import 'package:healthensuite/api/network.dart';
import 'package:healthensuite/api/networkmodels/patientProfilePodo.dart';
import 'package:healthensuite/api/networkmodels/statusEntityPODO.dart';
import 'package:healthensuite/screens/programs/level2/level2_4.dart';
import 'package:healthensuite/screens/programs/level4/level4_3.dart';
import 'package:healthensuite/screens/programs/level4/level4_4.dart';
import 'package:healthensuite/utilities/constants.dart';
import 'package:healthensuite/utilities/text_data.dart';
import 'package:healthensuite/screens/programs/level4/level4_2.dart';


class Level4 extends StatefulWidget {

  static final String title = 'Level 4';
  static final sidePad = EdgeInsets.symmetric(horizontal: 18);
//  final Future<PatientProfilePodo>? patientProfile;
  final int currentPage = 1;

  Level4();

  @override
  _Level4State createState() => _Level4State();
}

class _Level4State extends State<Level4> {
  String patientName = "";
 // String sleepEfficiency = "86.9%";

  @override
  void initState() {
    super.initState();
  //  Future<PatientProfilePodo>? profile = widget.patientProfile;
  //   WidgetsBinding.instance!.addPostFrameCallback((_) async {
  //     StatusEntity? status;
  //     await profile!.then((value) => {
  //       status = value.statusEntity,
  //       patientName = value.firstName!
  //     });
  //
  //     int? nextLevel = status!.nextPage;
  //     bool? isCompleted = status!.readInterventionGrouplevelfourArticle;
  //     if(isCompleted!){
  //       Navigator.push(
  //           context, new MaterialPageRoute(builder: (context) => Level4_4of4(profile))
  //       );
  //     }else if(nextLevel == 2){
  //       Navigator.push(
  //           context, new MaterialPageRoute(builder: (context) => Level4_2of4(profile))
  //       );
  //     }else if(nextLevel == 3){
  //       Navigator.push(
  //           context, new MaterialPageRoute(builder: (context) => Level4_3of4(profile))
  //       );
  //     }else if(nextLevel == 4){
  //       Navigator.push(
  //           context, new MaterialPageRoute(builder: (context) => Level4_4of4(profile))
  //       );
  //     }
  //   });
  }

  @override
  Widget build(BuildContext context) {
  //  Future<PatientProfilePodo>? profile = widget.patientProfile;
    final Size size = MediaQuery.of(context).size;
    final ThemeData themeData = Theme.of(context);
    double pad = 18;

    //Future.delayed(Duration.zero, () => createAlertDialog(context, themeData));

    return Scaffold(
      appBar: AppBar(
        title: Text(Level4.title),
        centerTitle: true,
      ),
      bottomNavigationBar: buttomBarWidget(context),
      body: Container(
        width: size.width,
        height: size.height,
        child: Column(
          children: [
            SizedBox(height: pad,),
            
            Align(
              alignment: Alignment.centerRight,
              child: Padding(
                padding: Level4.sidePad,
                child: Text('Page 1/4',
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
                     sectionTitleWidget(themeData, text: "Relaxation Techniques", textStyle: themeData.textTheme.headline4),
                     Padding(
                       padding: Level4.sidePad,
                       child: Image.asset('assets/images/relaxation-img.jpg'),
                     ),
                     bodyTextWidget(themeData, text: LEVEL1_DATA["bullet64"]!),

                     SizedBox(height: pad,),
                     sectionTitleWidget(themeData, text: LEVEL1_DATA["subHead10"]!, textStyle: themeData.textTheme.headline5),
                     bodyTextWidget(themeData, text: LEVEL1_DATA["bullet65"]!),
                     bodyTextWidget(themeData, text: LEVEL1_DATA["bullet66"]!),
                     bodyTextWidget(themeData, text: LEVEL1_DATA["bullet67"]!),
                     bodyTextWidget(themeData, text: LEVEL1_DATA["bullet68"]!),
                     bodyTextWidget(themeData, text: LEVEL1_DATA["bullet69"]!),
                     bodyTextWidget(themeData, text: LEVEL1_DATA["bullet70"]!),
                     bodyTextWidget(themeData, text: LEVEL1_DATA["bullet71"]!),

                     SizedBox(height: pad,),
                     sectionTitleWidget(themeData, text: LEVEL1_DATA["subHead11"]!, textStyle: themeData.textTheme.headline5),
                     bodyTextWidget(themeData, text: LEVEL1_DATA["bullet72"]!),
                     bodyTextWidget(themeData, text: LEVEL1_DATA["bullet73"]!),
                     bodyTextWidget(themeData, text: LEVEL1_DATA["bullet74"]!),

                     SizedBox(height: pad,),
                     sectionTitleWidget(themeData, text: LEVEL1_DATA["subHead12"]!, textStyle: themeData.textTheme.headline5),
                     bodyTextWidget(themeData, text: LEVEL1_DATA["bullet75"]!),
                     

                   ],
                ),
              ),
            ),
          ],
        ),
      ),
    );

  }

  SafeArea buttomBarWidget(BuildContext context,) {
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
                  ApiAccess().savePage(currentPage: widget.currentPage, interventionLevel: 4);
                  Navigator.push(
                  context, new MaterialPageRoute(builder: (context) => Level4_2of4())
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
                padding: Level4.sidePad,
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
          title: Text("Welcome To Level 4", style: themeData.textTheme.headline5,),
          content: SingleChildScrollView(
            scrollDirection: Axis.vertical,
                physics: ClampingScrollPhysics(),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                splashTextWidget(themeData, text: "Welcome $patientName,"),
                splashTextWidget(themeData, text: LEVEL1_DATA["splashBullet13"]!),
                splashTextWidget(themeData, text: LEVEL1_DATA["splashBullet14"]!),
                splashTextWidget(themeData, text: LEVEL1_DATA["splashBullet15"]!),
                splashTextWidget(themeData, text: LEVEL1_DATA["splashBullet16"]!),
                splashTextWidget(themeData, text: LEVEL1_DATA["splashBullet17"]!),
                splashTextWidget(themeData, text: LEVEL1_DATA["splashBullet18"]!),
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
              padding: Level4.sidePad,
              child: Text(text, 
                style: themeData.textTheme.bodyText1,),
            );
  }
}