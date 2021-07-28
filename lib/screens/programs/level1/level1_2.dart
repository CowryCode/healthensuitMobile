import 'package:flutter/material.dart';
import 'package:flutter_form_builder/flutter_form_builder.dart';
import 'package:healthensuite/utilities/constants.dart';
import 'package:healthensuite/utilities/text_data.dart';
import 'package:healthensuite/screens/programs/level1/level1_3.dart';


class Level1of2 extends StatefulWidget {

  static final String title = 'Level 1';
  static final sidePad = EdgeInsets.symmetric(horizontal: 18);

  @override
  _Level1of2State createState() => _Level1of2State();
}

class _Level1of2State extends State<Level1of2> {
  String patientName = "Henry";

  @override
  Widget build(BuildContext context) {
    final Size size = MediaQuery.of(context).size;
    final ThemeData themeData = Theme.of(context);
    final _formKey = GlobalKey<FormBuilderState>();
    double pad = 18;

    return Scaffold(
      appBar: AppBar(
        title: Text(Level1of2.title),
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
                     sectionTitleWidget(themeData, text: "What is Insomnia", textStyle: themeData.textTheme.headline4),
                     Padding(
                       padding: Level1of2.sidePad,
                       child: Image.asset('assets/images/Insomnia-img.jpg'),
                     ),
                     bodyTextWidget(themeData, text: LEVEL1_DATA["bullet6"]),
                     bodyTextWidget(themeData, text: LEVEL1_DATA["bullet7"]),
                     SizedBox(height: pad,),
                     sectionTitleWidget(themeData, text: LEVEL1_DATA["subHead2"], textStyle: themeData.textTheme.headline5),
                     checkBoxBuilderWidget(_formKey, themeData),

                    //  bodyTextWidget(themeData, text: LEVEL1_DATA["bullet4"]),
                    //  bodyTextWidget(themeData, text: LEVEL1_DATA["bullet5"]),

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
                padding: Level1of2.sidePad,
                child: Text('Page 2/7',
                textAlign: TextAlign.left,
                style: themeData.textTheme.bodyText2,),
              ),
              Padding(
                padding: Level1of2.sidePad,
                child: Text('Intro. to Health enSuite Insomnia',
                textAlign: TextAlign.right,
                style: themeData.textTheme.bodyText2,),
              ),

              ],
            ),
          );
  }

  FormBuilder checkBoxBuilderWidget(GlobalKey<FormBuilderState> _formKey, ThemeData themeData) {
    return FormBuilder(
                     key: _formKey,
                     child: FormBuilderCheckboxGroup(
                        name: "situationList", 
                        options: [
                          FormBuilderFieldOption(
                            value: "It often takes me more than 30 minutes to fall asleep.",
                            child: bodyTextWidget(themeData, text: "It often takes me more than 30 minutes to fall asleep."),
                          ),
                          FormBuilderFieldOption(
                            value: "I wake up frequently throughout the night and have trouble getting back to sleep.",
                            child: bodyTextWidget(themeData, text: "It often takes me more than 30 minutes to fall asleep."),
                          ),
                          FormBuilderFieldOption(
                            value: "I regularly wake up too early in the morning and cannot get back to sleep.",
                            child: bodyTextWidget(themeData, text: "It often takes me more than 30 minutes to fall asleep."),
                          ),
                          FormBuilderFieldOption(
                            value: "My sleep quality is poor. I would like to improve the quality of my sleep.",
                            child: bodyTextWidget(themeData, text: "My sleep quality is poor. I would like to improve the quality of my sleep."),
                          ),
                        ],
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
                    context, new MaterialPageRoute(builder: (context) => Level1of3())
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
                padding: Level1of2.sidePad,
                child: Text(text,
                  style: textStyle,
                ),
              );
  }

  Padding bodyTextWidget(ThemeData themeData, {String text}) {
    return Padding(
              padding: Level1of2.sidePad,
              child: Text(text, 
                style: themeData.textTheme.bodyText1,),
            );
  }
}