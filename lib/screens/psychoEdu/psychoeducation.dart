import 'package:flutter/material.dart';
import 'package:healthensuite/api/network.dart';
import 'package:healthensuite/api/networkmodels/patientProfilePodo.dart';
import 'package:healthensuite/api/networkmodels/psychoeducationPODO.dart';
import 'package:healthensuite/api/networkmodels/statusEntityPODO.dart';
import 'package:healthensuite/screens/psychoEdu/psycho3.dart';
import 'package:healthensuite/screens/psychoEdu/psycho4.dart';
import 'package:healthensuite/utilities/drawer_navigation.dart';
import 'package:flutter_form_builder/flutter_form_builder.dart';
import 'package:healthensuite/utilities/text_data.dart';
import 'package:healthensuite/utilities/constants.dart';
import 'package:healthensuite/screens/psychoEdu/psycho2.dart';


class PsychoEducation extends StatefulWidget {

  final Function? onMenuTap;
  static final String title = 'Psychoeducation';
  static final sidePad = EdgeInsets.symmetric(horizontal: 18);
  final Future<PatientProfilePodo>? patientProfile;
  final int currentPage = 1;

  PsychoeducationDTO? updatedPED;
  PsychoEducation({Key? key, this.onMenuTap, required this.patientProfile}) : super(key: key);

  @override
  _PsychoEducationState createState() => _PsychoEducationState();
}

class _PsychoEducationState extends State<PsychoEducation> {
  @override
  void initState() {
    super.initState();
    Future<PatientProfilePodo>? profile = widget.patientProfile;
    Future<PsychoeducationDTO> psychoeducation  = ApiAccess().getIncompletePsychoeducation();
    WidgetsBinding.instance!.addPostFrameCallback((_) async {
      StatusEntity? status;
     PsychoeducationDTO? psyEdu;
      await profile!.then((value) => {
        status = value.statusEntity,
      });
      await psychoeducation.then((value) => {
        widget.updatedPED = value,
        psyEdu = value
      });
      int? nextLevel = status!.nextPage;
      bool? isCompleted = psyEdu!.completed;
      if(!isCompleted!) {
        if (nextLevel == 2) {
          Navigator.push(
              context, new MaterialPageRoute(
              builder: (context) => Psycho2(widget.updatedPED!, profile))
          );
        } else if (nextLevel == 3) {
          Navigator.push(
              context, new MaterialPageRoute(
              builder: (context) => Psycho3(widget.updatedPED!, profile))
          );
        } else if (nextLevel == 4) {
          Navigator.push(
              context, new MaterialPageRoute(
              builder: (context) => Psycho4(widget.updatedPED!, profile))
          );
        }
      }
    });
  }

   @override
  Widget build(BuildContext context) {
     Future<PatientProfilePodo>? profile = widget.patientProfile;
     final Size size = MediaQuery.of(context).size;
    final ThemeData themeData = Theme.of(context);
    final _formKey = GlobalKey<FormBuilderState>();
    double pad = 18;

    return Scaffold(
      drawer: NavigationDrawerWidget(indexNum: 5,patientprofile: profile,),
      appBar: AppBar(
        title: Text(PsychoEducation.title),
        centerTitle: true,
      ),
     bottomNavigationBar: buttomBarWidget(context, _formKey, profile),
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
                       padding: PsychoEducation.sidePad,
                       child: Image.asset('assets/images/Insomnia-img.jpg'),
                     ),
                     bodyTextWidget(themeData, text: LEVEL1_DATA["bullet6"]!),
                     bodyTextWidget(themeData, text: LEVEL1_DATA["bullet7"]!),
                     SizedBox(height: pad,),
                     sectionTitleWidget(themeData, text: LEVEL1_DATA["subHead2"]!, textStyle: themeData.textTheme.headline5),
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
                padding: PsychoEducation.sidePad,
                child: Text('Page 1/4',
                textAlign: TextAlign.left,
                style: themeData.textTheme.bodyText2,),
              ),
              Padding(
                padding: PsychoEducation.sidePad,
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
                           value: "1",
                           child: bodyTextWidget(themeData, text: "It often takes me more than 30 minutes to fall asleep."),
                         ),
                         FormBuilderFieldOption(
                           value: "2",
                           child: bodyTextWidget(themeData, text: "I wake up frequently throughout the night and have trouble getting back to sleep."),
                         ),
                         FormBuilderFieldOption(
                           value: "3",
                           child: bodyTextWidget(themeData, text: "I regularly wake up too early in the morning and cannot get back to sleep."),
                         ),
                         FormBuilderFieldOption(
                           value: "4",
                           child: bodyTextWidget(themeData, text: "My sleep quality is poor. I would like to improve the quality of my sleep."),
                         ),
                       ],
                      ),
                   );
  }

  SafeArea buttomBarWidget(BuildContext context, GlobalKey<FormBuilderState> key,Future<PatientProfilePodo>? futureProfile) {
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
                PsychoeducationDTO psyEdu = getSelectedValue(key, widget.updatedPED!);
                // Intervention Levels ends in 6, we used 7 to represent PsychoEducation
                 ApiAccess().submitPsychoEducation(psychoeducationDTO: psyEdu);
                Navigator.push(
                    context, new MaterialPageRoute(builder: (context) => Psycho2(psyEdu, futureProfile))
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

  PsychoeducationDTO getSelectedValue(GlobalKey<FormBuilderState> key, PsychoeducationDTO psychoeducationDTO){
     var result = key.currentState!.fields["situationList"]!.value;
   //  PsychoeducationDTO psychoeducationDTO = PsychoeducationDTO();
     print("::::THE ID IS ::::::::::: ${psychoeducationDTO.id}");
    psychoeducationDTO.setmorethan30MinstoSleep(false);
     psychoeducationDTO.setwakeupfrequentlyatnight(false);
     psychoeducationDTO.setwakeuptooearly(false);
     psychoeducationDTO.setsleepqualitypoor(false);
     psychoeducationDTO.setifeelconfident(false);
     psychoeducationDTO.setithinkitsdifficult(false);
     psychoeducationDTO.setidontknow(false);
     psychoeducationDTO.setCompleteStatus(isCompleted: false);

     if(result.length > 0){
       for(int i = 0; i < result.length ; i++){
         String choice = result[i];
         if(choice != null){
           if(int.parse(choice) == 1){
             psychoeducationDTO.setmorethan30MinstoSleep(true);
           }
           if(int.parse(choice) == 2){
             psychoeducationDTO.setwakeupfrequentlyatnight(true);
           }
           if(int.parse(choice) == 3){
             psychoeducationDTO.setwakeuptooearly(true);
           }
           if(int.parse(choice) == 4){
             psychoeducationDTO.setsleepqualitypoor(true);
           }
         }
       }
     }
     return psychoeducationDTO;
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
                padding: PsychoEducation.sidePad,
                child: Text(text,
                  style: textStyle,
                ),
              );
  }

  Padding bodyTextWidget(ThemeData themeData, {required String text}) {
    return Padding(
              padding: PsychoEducation.sidePad,
              child: Text(text, 
                style: themeData.textTheme.bodyText1,),
            );
  }
}