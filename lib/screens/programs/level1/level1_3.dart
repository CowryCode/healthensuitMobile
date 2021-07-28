import 'package:flutter/material.dart';
import 'package:healthensuite/utilities/constants.dart';
import 'package:healthensuite/utilities/text_data.dart';
import 'package:healthensuite/screens/programs/level1/level1_4.dart';


class Level1of3 extends StatefulWidget {

  static final String title = 'Level 1';
  static final sidePad = EdgeInsets.symmetric(horizontal: 18);

  @override
  _Level1of3State createState() => _Level1of3State();
}

class _Level1of3State extends State<Level1of3> {
  String patientName = "Henry";

  @override
  Widget build(BuildContext context) {
    final Size size = MediaQuery.of(context).size;
    final ThemeData themeData = Theme.of(context);
    double pad = 18;

    return Scaffold(
      appBar: AppBar(
        title: Text(Level1of3.title),
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
                child: Column(
                   crossAxisAlignment: CrossAxisAlignment.start,
                   children: [
                     SizedBox(height: pad,),
                     sectionTitleWidget(themeData, text: "What causes insomnia?", textStyle: themeData.textTheme.headline4),
                     Padding(
                       padding: Level1of3.sidePad,
                       child: Image.asset('assets/images/causesInsomnia-img.jpg'),
                     ),
                     bodyTextWidget(themeData, text: LEVEL1_DATA["bullet8"]),
                     bodyTextWidget(themeData, text: LEVEL1_DATA["bullet9"]),

                   ],
                ),
              ),
            ),
          ],
        ),
      ),
    );

  }

  SafeArea buttomBarWidget(BuildContext context) {
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
                 Navigator.push(
                    context, new MaterialPageRoute(builder: (context) => Level1of4())
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
                padding: Level1of3.sidePad,
                child: Text('Page 3/7',
                textAlign: TextAlign.left,
                style: themeData.textTheme.bodyText2,),
              ),
              Padding(
                padding: Level1of3.sidePad,
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

  MaterialButton navIconButton(BuildContext context, {String buttonText, Function buttonActon}){
    return  MaterialButton(
              child: Text(buttonText, style: TextStyle(color: appItemColorBlue, fontWeight: FontWeight.w700),),
              onPressed: buttonActon,
            );
  }

   Padding sectionTitleWidget(ThemeData themeData, {String text, TextStyle textStyle} ) {
     return Padding(
                padding: Level1of3.sidePad,
                child: Text(text,
                  style: textStyle,
                ),
              );
  }

  Padding bodyTextWidget(ThemeData themeData, {String text}) {
    return Padding(
              padding: Level1of3.sidePad,
              child: Text(text, 
                style: themeData.textTheme.bodyText1,),
            );
  }
}