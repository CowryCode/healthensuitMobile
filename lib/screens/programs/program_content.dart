import 'package:flutter/material.dart';
import 'package:healthensuite/utilities/drawer_navigation.dart';
import 'package:healthensuite/utilities/constants.dart';
import 'package:healthensuite/screens/programs/level1/level_1.dart';


class ProgramContent extends StatefulWidget{

  final Function? onMenuTap;
   static final String title = 'Program Content';
   static final sidePad = EdgeInsets.symmetric(horizontal: 18);

  const ProgramContent({Key? key, this.onMenuTap}) : super(key: key);

  @override
  _ProgramContentState createState() => _ProgramContentState();
}

class _ProgramContentState extends State<ProgramContent> {
  double progress = .15;
  int levelVal = 1;

   @override
  Widget build(BuildContext context) {
    final Size size = MediaQuery.of(context).size;
    final ThemeData themeData = Theme.of(context);
    double pad = 18;

    return Scaffold(
      drawer: NavigationDrawerWidget(indexNum: 4,),
      appBar: AppBar(
        title: Text(ProgramContent.title),
        centerTitle: true,
      ),
      body: Container(
        width: size.width,
        height: size.height,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            SizedBox(height: pad,),
            sectionOneCard(pad, themeData, size),

            sectionTwoCard(themeData, pad, context),
          ],
        ),
      ),
    );
  }

   Card sectionTwoCard(ThemeData themeData, double pad, BuildContext context) {
     return Card(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                sectionTitleWidget(themeData, text: "Intervention Group Content"),
                Padding(
                  padding: ProgramContent.sidePad,
                  child: Text("Only current or previous levels are available to access",
                    style: themeData.textTheme.bodyText2,
                  ),
                ),
                SizedBox(height: pad,),
                Padding(
                  padding: ProgramContent.sidePad,
                  child: Text("Table of Content",
                    style: themeData.textTheme.headline5,
                  ),
                ),
                levelButtonWidget(topic: "Level 1: Introduction to Health enSuite Insomnia", 
                action: (){
                  Navigator.push(
                  context, new MaterialPageRoute(builder: (context) => Level1())
                  );
                }),
                levelButtonWidget(topic: "Level 2: Introduction to Sleep Restriction", action: (){}),
                levelButtonWidget(topic: "Level 3: Sleep Hygiene", action: (){}),
                levelButtonWidget(topic: "Level 4: Relaxation techniques", action: (){}),
                levelButtonWidget(topic: "Level 5: Changing Thoughts", action: (){}),
                levelButtonWidget(topic: "Level 6: Maintaining Your Progress", action: (){}),
                
              ],
            ),
          );
   }

   MaterialButton levelButtonWidget({required String topic, Function? action}) {
     return MaterialButton(
                  child: Text(topic, 
                    style: TextStyle(color: appBackgroundColor, fontWeight: FontWeight.w700),
                  ),
                  onPressed: action as void Function()?
                );
   }

   Card sectionOneCard(double pad, ThemeData themeData, Size size) {
     return Card(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                SizedBox(height: pad,),
                sectionTitleWidget(themeData, text: "My Progress"),
                Padding(
                  padding: ProgramContent.sidePad,
                  child: SizedBox(
                    width: size.width,
                    height: size.height/30,
                    child: Stack(
                      fit: StackFit.expand,
                      children: [
                        LinearProgressIndicator(
                          value: progress,
                          valueColor: AlwaysStoppedAnimation(appBackgroundColor),
                          backgroundColor: appItemColorLightGrey,
                        ),
                        Center(child: buildProgress(themeData, size.height/30)),
                      ],
                    ),
                  ),
                ),
                Padding(
                  padding: ProgramContent.sidePad,
                  child: Text("Status: Level $levelVal of 6",
                    style: themeData.textTheme.headline6,
                  ),
                ),
                SizedBox(height: pad,),
              ],
            ),
          );
   }

   Padding sectionTitleWidget(ThemeData themeData, {required String text}) {
     return Padding(
                  padding: ProgramContent.sidePad,
                  child: Text(text,
                    style: themeData.textTheme.headline4,
                  ),
                );
   }

  Widget buildProgress(ThemeData themeData, double barSize) {
    if (progress == 1) {
      print("Height: $barSize");
      return Icon(
          Icons.done,
          color: appItemColorWhite,
          size: barSize,
        );
    } else {
      return Text(
        myPercentage(),
        style: themeData.textTheme.headline4,
      );
    }
  }

  String myPercentage(){
    int perc = (progress * 100).toInt();
    String val = perc.toString() + '%';
    return val;
  }

}