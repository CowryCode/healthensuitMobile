import 'package:flutter/material.dart';
import 'package:healthensuite/api/network.dart';
import 'package:healthensuite/api/networkmodels/patientProfilePodo.dart';
import 'package:healthensuite/api/networkmodels/psychoeducationPODO.dart';
import 'package:healthensuite/utilities/constants.dart';
import 'package:healthensuite/utilities/text_data.dart';
import 'package:healthensuite/screens/psychoEdu/psycho3.dart';


class Psycho2 extends StatefulWidget {
 // Future<PatientProfilePodo>? futureProfile;
  static final String title = 'Psychoeducation';
  static final sidePad = EdgeInsets.symmetric(horizontal: 18);
  final PsychoeducationDTO psychoeducationDTO;
  final int currentPage = 2;

  Psycho2(this.psychoeducationDTO,);

  @override
  _Psycho2 createState() => _Psycho2();
}

class _Psycho2 extends State<Psycho2> {
  String patientName = "Henry";

  @override
  Widget build(BuildContext context) {
    PsychoeducationDTO psychEdu = widget.psychoeducationDTO;
   // Future<PatientProfilePodo>? profile = widget.futureProfile;

    final Size size = MediaQuery.of(context).size;
    final ThemeData themeData = Theme.of(context);
    double pad = 18;

    return Scaffold(
      appBar: AppBar(
        title: Text(Psycho2.title),
        centerTitle: true,
      ),
      bottomNavigationBar: buttomBarWidget(context, psychEdu,),
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
                     sectionTitleWidget(themeData, text: "What causes insomnia?", textStyle: themeData.textTheme.headline4),
                     Padding(
                       padding: Psycho2.sidePad,
                       child: Image.asset('assets/images/causesInsomnia-img.jpg'),
                     ),
                     bodyTextWidget(themeData, text: LEVEL1_DATA["bullet8"]!),
                     bodyTextWidget(themeData, text: LEVEL1_DATA["bullet9"]!),

                   ],
                ),
              ),
            ),
          ],
        ),
      ),
    );

  }

  SafeArea buttomBarWidget(BuildContext context, PsychoeducationDTO psychoeducationDTO) {
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

              navIconButton(context, buttonText: "Next", buttonActon: (){
                ApiAccess().savePage(currentPage: widget.currentPage, interventionLevel: 7);
                Navigator.push(
                    context, new MaterialPageRoute(builder: (context) => Psycho3(psychoeducationDTO))
                    );
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
                padding: Psycho2.sidePad,
                child: Text('Page 2/4',
                textAlign: TextAlign.left,
                style: themeData.textTheme.bodyText2,),
              ),
              Padding(
                padding: Psycho2.sidePad,
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
                padding: Psycho2.sidePad,
                child: Text(text,
                  style: textStyle,
                ),
              );
  }

  Padding bodyTextWidget(ThemeData themeData, {required String text}) {
    return Padding(
              padding: Psycho2.sidePad,
              child: Text(text, 
                style: themeData.textTheme.bodyText1,),
            );
  }
}