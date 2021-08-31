import 'package:flutter/material.dart';
import 'package:flutter_form_builder/flutter_form_builder.dart';
import 'package:healthensuite/api/network.dart';
import 'package:healthensuite/api/networkmodels/mysleepclock.dart';
import 'package:healthensuite/api/networkmodels/sleepwindowsPODO.dart';
//import 'package:intl/intl.dart';
import 'package:healthensuite/models/icon_button.dart';
import 'package:healthensuite/utilities/constants.dart';
//import 'package:healthensuite/utilities/drawer_navigation.dart';
//import 'package:healthensuite/utilities/constants.dart';


class SleepWindow extends StatelessWidget {

  final Function? onMenuTap;
  static final String title = 'Sleep Window';
  final _formKey = GlobalKey<FormBuilderState>();
  TimeOfDay? time;
  final SleepClockDTO sleepClockDTO;

  SleepWindow({Key? key, this.onMenuTap, required this.sleepClockDTO}) : super(key: key);
  
  @override
  Widget build(BuildContext context) {
    final Size size = MediaQuery.of(context).size;
    final ThemeData themeData = Theme.of(context);
    final sidePad = EdgeInsets.symmetric(horizontal: 20);
    double pad = 18;

    return Scaffold(
      //drawer: NavigationDrawerWidget(indexNum: 2,),
      appBar: AppBar(
        title: Text(title),
        centerTitle: true,
      ),
      body: FormBuilder(
        key: _formKey,
        child: Container(
          width: size.width,
          height: size.height,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              SizedBox(height: pad,),
              
              Expanded(
                flex: 1,
                child: SingleChildScrollView(
                  scrollDirection: Axis.vertical,
                  physics: ClampingScrollPhysics(),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      SizedBox(height: pad,),

                      timeQuestion(sidePad, themeData, context, question: "Enter your bed time", valName: "bTime"),

                      SizedBox(height: pad,),

                      timeQuestion(sidePad, themeData, context, question: "Enter your rise time", valName: "rTime"),

                      SizedBox(height: pad,),

                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                        children: [
                          IconUserButton(buttonText: "OK", buttonEvent: () {
                            saveSleepwindow(_formKey, sleepClockDTO);
                            Navigator.of(context).pop();
                          }, buttonIcon: Icons.arrow_forward,),
                          IconUserButton(buttonText: "Cancel", buttonEvent: () {
                            Navigator.of(context).pop();
                            }, buttonIcon: Icons.cancel)
                        ],
                      ),
                      SizedBox(height: pad,),
                    ],
                  ),
                ),
              )
            ],
          ),
        ),
        onChanged: () => print("Form has changed"),
      ), 
    );
  }

  void saveSleepwindow(GlobalKey<FormBuilderState> key, SleepClockDTO sleepclock){
    var revisedbedtime = key.currentState!.fields["bTime"]!.value;
    var revisedRisetime = key.currentState!.fields["rTime"]!.value;
    print("Revised bed time is ${revisedbedtime}");
    print("Revised rise time is ${revisedRisetime}");
    print("Formal bed time is ${sleepclock.averagebedtiime}");
    print("Formal rise time is ${sleepclock.averagerisetime}");

    Sleepwindows sleepwindow = Sleepwindows();
    sleepwindow.setbedtime("${sleepclock.averagebedtiime}");
    sleepwindow.setrisetime("${sleepclock.averagerisetime}");
    sleepwindow.setrevisedbedtime("${revisedbedtime}");
    sleepwindow.setrevisedrisetime("${revisedRisetime}");

    ApiAccess().submitsleepwindow(sleepwindow: sleepwindow);

  }


  //Builder Widget below


  Padding timeQuestion(EdgeInsets sidePad, ThemeData themeData, BuildContext context, {required String question, required String valName}) {
    return Padding(
              padding: sidePad,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(question,
                  style: themeData.textTheme.headline5,),
                  Row(
                    children: [
                      Expanded(
                        child: FormBuilderTextField(
                          name: valName,
                          initialValue: getText(_formKey, time, valName),
                          readOnly: true,
                          style: themeData.textTheme.bodyText1,
                        ),
                      ),
                      IconButton(
                        onPressed: () => pickTime(context, _formKey, valName, time),
                        icon: Icon(Icons.lock_clock),
                        color: appItemColorBlue,
                      ),
                    ],
                  ),
                  
                ],
              ),
            );
  }

  Future pickTime(BuildContext context, GlobalKey<FormBuilderState> key, String valName, TimeOfDay? time) async {
    final initialTime = TimeOfDay(hour: 9, minute: 0);
    final newTime = await showTimePicker(
      context: context,
      initialTime: time ?? initialTime,
    );

    if (newTime == null) return;

    time = newTime;
    print("New Time $time");
    getText(key, time, valName);
  }

  String getText(GlobalKey<FormBuilderState> key, TimeOfDay? time, String valName) {
    String timeVal = "Select Time";    
    if (time == null) {
      return timeVal;
    } else {
      final hours = time.hour.toString().padLeft(2, '0');
      final minutes = time.minute.toString().padLeft(2, '0');
      timeVal = '$hours:$minutes';
      key.currentState!.fields[valName]!.didChange(timeVal);
      return timeVal;
    }
  }


}