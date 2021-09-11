import 'package:flutter/material.dart';
import 'package:flutter_form_builder/flutter_form_builder.dart';
import 'package:healthensuite/api/network.dart';
import 'package:healthensuite/api/networkmodels/interventionlevels/levelthreePODO.dart';
import 'package:healthensuite/api/networkmodels/patientProfilePodo.dart';
import 'package:healthensuite/screens/home/home_screen.dart';
import 'package:healthensuite/utilities/constants.dart';
import 'package:healthensuite/utilities/text_data.dart';


class Level3 extends StatefulWidget {

  static final String title = 'Level 3';
  static final sidePad = EdgeInsets.symmetric(horizontal: 18);
  static final optionPad = EdgeInsets.only(bottom: 18.0);

  final Future<PatientProfilePodo>? patientProfile;


  Level3(this.patientProfile);

  @override
  _Level3State createState() => _Level3State();
}

class _Level3State extends State<Level3> {
  String patientName = "Henry";

  @override
  Widget build(BuildContext context) {
    final Size size = MediaQuery.of(context).size;
    final ThemeData themeData = Theme.of(context);
    double pad = 18;
    final _formKey = GlobalKey<FormBuilderState>();
    Future<PatientProfilePodo>? futureprofile = widget.patientProfile;

    //Future.delayed(Duration.zero, () => createAlertDialog(context, themeData));

    return Scaffold(
      appBar: AppBar(
        title: Text(Level3.title),
        centerTitle: true,
      ),
      bottomNavigationBar: buttomBarWidget(context, _formKey, futureprofile),
      body: Container(
        width: size.width,
        height: size.height,
        child: Column(
          children: [
            SizedBox(height: pad,),
            
            Align(
              alignment: Alignment.centerRight,
              child: Padding(
                padding: Level3.sidePad,
                child: Text('Page 1/1',
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
                     sectionTitleWidget(themeData, text: "Sleep Hygiene", textStyle: themeData.textTheme.headline4),
                     bodyTextWidget(themeData, text: LEVEL1_DATA["bullet51"]!),
                     bodyTextWidget(themeData, text: LEVEL1_DATA["bullet52"]!),
                     bodyTextWidget(themeData, text: LEVEL1_DATA["bullet53"]!),
                     SizedBox(height: pad,),
                     sectionTitleWidget(themeData, text: LEVEL1_DATA["subHead9"]!, textStyle: themeData.textTheme.headline5),
                     checkBoxBuilderWidget(_formKey, themeData),


                     SizedBox(height: pad,),
                     buildFeedbackForm(Level3.sidePad, themeData),

                   ],
                ),
              ),
            ),
          ],
        ),
      ),
    );

  }

  SafeArea buttomBarWidget(BuildContext context, GlobalKey<FormBuilderState> key,  Future<PatientProfilePodo>? futureProfile) {
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
                child: Text("Conclude Level 3", style: TextStyle(color: appItemColorBlue, fontWeight: FontWeight.w700),),
                onPressed: (){
                  getSubmitvalues(key);
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

  void getSubmitvalues(GlobalKey<FormBuilderState> key){
    var result = key.currentState!.fields["toDoList"]!.value;
    LevelthreeVariables level3 = LevelthreeVariables();
    String choices = result.toString();
    level3.updateFields(choices);
    ApiAccess().submitLevethree(level3: level3);
  }

   Padding sectionTitleWidget(ThemeData themeData, {required String text, TextStyle? textStyle} ) {
     return Padding(
                padding: Level3.sidePad,
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
          title: Text("Welcome To Level 3", style: themeData.textTheme.headline5,),
          content: SingleChildScrollView(
            scrollDirection: Axis.vertical,
                physics: ClampingScrollPhysics(),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                splashTextWidget(themeData, text: "Welcome $patientName,"),
                splashTextWidget(themeData, text: LEVEL1_DATA["splashBullet8"]!),
                splashTextWidget(themeData, text: LEVEL1_DATA["splashBullet9"]!),
                splashTextWidget(themeData, text: LEVEL1_DATA["splashBullet10"]!),
                splashTextWidget(themeData, text: LEVEL1_DATA["splashBullet11"]!),
                splashTextWidget(themeData, text: LEVEL1_DATA["splashBullet12"]!),
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
              padding: Level3.sidePad,
              child: Text(text, 
                style: themeData.textTheme.bodyText1,),
            );
  }

  Padding optionTextWidget(ThemeData themeData, {required String text}) {
    return Padding(
              padding: Level3.optionPad,
              child: Text(text, 
                style: themeData.textTheme.bodyText1,),
            );
  }

  FormBuilder checkBoxBuilderWidget(GlobalKey<FormBuilderState> _formKey, ThemeData themeData) {
    return FormBuilder(
                     key: _formKey,
                     child: FormBuilderCheckboxGroup(
                        name: "toDoList",
                        options: [
                          FormBuilderFieldOption(
                            value: "0",
                            child: optionTextWidget(themeData, text: LEVEL1_DATA["bullet54"]!),
                          ),
                          FormBuilderFieldOption(
                            value: "1",
                            child: optionTextWidget(themeData, text: LEVEL1_DATA["bullet55"]!),
                          ),
                          FormBuilderFieldOption(
                            value: "2",
                            child: optionTextWidget(themeData, text: LEVEL1_DATA["bullet56"]!),
                          ),
                          FormBuilderFieldOption(
                            value: "3",
                            child: optionTextWidget(themeData, text: LEVEL1_DATA["bullet57"]!),
                          ),
                          FormBuilderFieldOption(
                            value: "4",
                            child: optionTextWidget(themeData, text: LEVEL1_DATA["bullet58"]!),
                          ),
                          FormBuilderFieldOption(
                            value: "5",
                            child: optionTextWidget(themeData, text: LEVEL1_DATA["bullet59"]!),
                          ),
                          FormBuilderFieldOption(
                            value: "6",
                            child: optionTextWidget(themeData, text: LEVEL1_DATA["bullet60"]!),
                          ),
                          FormBuilderFieldOption(
                            value: "7",
                            child: optionTextWidget(themeData, text: LEVEL1_DATA["bullet61"]!),
                          ),
                          FormBuilderFieldOption(
                            value: "8",
                            child: optionTextWidget(themeData, text: LEVEL1_DATA["bullet62"]!),
                          ),
                          FormBuilderFieldOption(
                            value: "9",
                            child: optionTextWidget(themeData, text: LEVEL1_DATA["bullet63"]!),
                          ),
                        ],
                      ),
                   );
  }

  Padding buildFeedbackForm(EdgeInsets sidePad, ThemeData themeData){
      return Padding(
        padding: sidePad,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text("Additional Note About Today:",
              style: themeData.textTheme.headline5,),
            SizedBox(height: 10,),
            Container(
              //padding: sidePad,
              height: 200.0,
              child: FormBuilderTextField(
                name: "additionNote",
                maxLines: 10,
                decoration: InputDecoration(
                  hintText: "Please briefly type your note here",
                  hintStyle: themeData.textTheme.bodyText2,
                  border: OutlineInputBorder(
                    borderSide: BorderSide(color: appItemColorBlue)
                    ),
                ),
              ),
            ),
          ],
        ),
      );
  }

}