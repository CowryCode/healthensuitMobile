import 'package:flutter/material.dart';
import 'package:flutter_form_builder/flutter_form_builder.dart';
import 'package:healthensuite/api/network.dart';
import 'package:healthensuite/api/networkmodels/interventionlevels/levelsixPODO.dart';
import 'package:healthensuite/api/networkmodels/patientProfilePodo.dart';
import 'package:healthensuite/screens/home/home_screen.dart';
import 'package:healthensuite/utilities/constants.dart';
import 'package:healthensuite/utilities/text_data.dart';
import 'package:healthensuite/screens/programs/level5/level5_2.dart';


class Level6 extends StatefulWidget {

  static final String title = 'Level 6';
  static final sidePad = EdgeInsets.symmetric(horizontal: 18);

  final Future<PatientProfilePodo>? patientProfile;


  Level6(this.patientProfile);

  @override
  _Level6State createState() => _Level6State();
}

class _Level6State extends State<Level6> {
  String patientName = "Henry";
  static final _formKey = GlobalKey<FormBuilderState>();

  @override
  Widget build(BuildContext context) {
    Future<PatientProfilePodo>? futureprofile = widget.patientProfile;
    final Size size = MediaQuery.of(context).size;
    final ThemeData themeData = Theme.of(context);
    double pad = 18;

    //Future.delayed(Duration.zero, () => createAlertDialog(context, themeData));

    return Scaffold(
      appBar: AppBar(
        title: Text(Level6.title),
        centerTitle: true,
      ),
      bottomNavigationBar: buttomBarWidget(context, _formKey, futureprofile),
      body: Container(
        width: size.width,
        height: size.height,
        child: FormBuilder(
          key: _formKey,
          child: Column(
            children: [
              SizedBox(height: pad,),
              
              Align(
                alignment: Alignment.centerRight,
                child: Padding(
                  padding: Level6.sidePad,
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
                       sectionTitleWidget(themeData, text: "Maintaining Your Progress", textStyle: themeData.textTheme.headline4),
                       bodyTextWidget(themeData, text: LEVEL1_DATA["bullet117"]!),
                       bodyTextWidget(themeData, text: LEVEL1_DATA["bullet118"]!),
                       bodyTextWidget(themeData, text: LEVEL1_DATA["bullet119"]!),
                       SizedBox(height: pad,),

                       formFieldWidget(themeData, hint: LEVEL1_DATA["textHint4"]!, valName:"yourResp"),

                       SizedBox(height: pad,),
                       bodyTextWidget(themeData, text: LEVEL1_DATA["bullet120"]!),

                       SizedBox(height: pad,),
                       formFieldWidget(themeData, hint: LEVEL1_DATA["textHint5"]!, valName:"yourStrat"),
                       
                       SizedBox(height: pad,),
                       sectionTitleWidget(themeData, text: LEVEL1_DATA["subHead19"]!, textStyle: themeData.textTheme.headline5),
                       bodyTextWidget(themeData, text: LEVEL1_DATA["bullet121"]!),
                       bodyTextWidget(themeData, text: LEVEL1_DATA["bullet122"]!),
                       bodyTextWidget(themeData, text: LEVEL1_DATA["bullet123"]!),
                       bodyTextWidget(themeData, text: LEVEL1_DATA["bullet124"]!),
                       bodyTextWidget(themeData, text: LEVEL1_DATA["bullet125"]!),
                       bodyTextWidget(themeData, text: LEVEL1_DATA["bullet126"]!),
                       bodyTextWidget(themeData, text: LEVEL1_DATA["bullet127"]!),
                       bodyTextWidget(themeData, text: LEVEL1_DATA["bullet128"]!),
                       bodyTextWidget(themeData, text: LEVEL1_DATA["bullet129"]!),
                       bodyTextWidget(themeData, text: LEVEL1_DATA["bullet130"]!),
                       bodyTextWidget(themeData, text: LEVEL1_DATA["bullet131"]!),

                      
                       SizedBox(height: pad,),
                       bodyTextWidget(themeData, text: LEVEL1_DATA["bullet132"]!),
                       bodyTextWidget(themeData, text: LEVEL1_DATA["bullet133"]!),

                     ],
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );

  }

  SafeArea buttomBarWidget(BuildContext context, GlobalKey<FormBuilderState> key, Future<PatientProfilePodo>? futureProfile) {
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
                child: Text("Conclude Level 6", style: TextStyle(color: appItemColorBlue, fontWeight: FontWeight.w700),),
                onPressed: (){
                  submitVariables(key);
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

  void submitVariables(GlobalKey<FormBuilderState> key){
    var reply = key.currentState!.fields["yourResp"]!.value;
    var strtgy = key.currentState!.fields["yourStrat"]!.value;

    LevelSix l6 = LevelSix();
    l6.setfears(reply);
    l6.setStrategy(strtgy);
    ApiAccess().submitLevelsix(levelsix: l6);
  }

   Padding sectionTitleWidget(ThemeData themeData, {required String text, TextStyle? textStyle} ) {
     return Padding(
                padding: Level6.sidePad,
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
          title: Text("Welcome To Level 6", style: themeData.textTheme.headline5,),
          content: SingleChildScrollView(
            scrollDirection: Axis.vertical,
                physics: ClampingScrollPhysics(),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                splashTextWidget(themeData, text: "Welcome $patientName,"),
                splashTextWidget(themeData, text: LEVEL1_DATA["splashBullet24"]!),
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
              padding: Level6.sidePad,
              child: Text(text, 
                style: themeData.textTheme.bodyText1,),
            );
  }

   Column formFieldWidget(ThemeData themeData, {required String hint, required String valName}) {
    return Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Padding(
                          padding: Level5of2.sidePad,
                          child: FormBuilderTextField(
                            name: valName,
                            style: themeData.textTheme.headline5,
                            decoration: InputDecoration(
                              hintText: hint,
                              hintStyle: themeData.textTheme.bodyText2,
                            ),
                          ),
                        ),
                      ],
                  );
  }

}