import 'dart:ffi';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_form_builder/flutter_form_builder.dart';
import 'package:healthensuite/api/network.dart';
import 'package:healthensuite/api/networkmodels/medicationsPODO.dart';
import 'package:healthensuite/api/networkmodels/otherMedicationsPODO.dart';
import 'package:healthensuite/api/networkmodels/sleepDiaryPODO.dart';
import 'package:healthensuite/api/statemanagement/behaviourlogic.dart';
import 'package:healthensuite/models/icon_button.dart';
import 'package:healthensuite/screens/home/home_screen.dart';
import 'package:healthensuite/utilities/constants.dart';


// ignore: must_be_immutable
class SleepDiary extends StatefulWidget {
  final Function? onMenuTap;
  static final String title = 'Sleep Diary';
  SleepDiariesPODO sleepDiariesPODO;


  SleepDiary({Key? key, this.onMenuTap, required this.sleepDiariesPODO}) : super(key: key);

  @override
  _SleepDiaryState createState() => _SleepDiaryState();
}

class _SleepDiaryState extends State<SleepDiary> {
  final _formKey = GlobalKey<FormBuilderState>();

  TimeOfDay? time;

  @override
  Widget build(BuildContext context) {
    final Size size = MediaQuery
        .of(context)
        .size;
    final ThemeData themeData = Theme.of(context);
    final sidePad = EdgeInsets.symmetric(horizontal: 20);
    double pad = 18;
    String drug1 = "Chlopazine";
    String drug2 = "Oxitocine";
    List<String> hours = generateNumbers(23);
    List<String> minutes = generateNumbers(59);

    String date = Workflow().convertDatetime2date(
        widget.sleepDiariesPODO.dateCreated.toString());

    TimeOfDay? bedtime = Workflow().convertStringtoTimeofDay(
        widget.sleepDiariesPODO.bedTime);
    TimeOfDay? trySleepTime = Workflow().convertStringtoTimeofDay(
        widget.sleepDiariesPODO.tryTosleepTime);
    int? wakeupCount = widget.sleepDiariesPODO.wakeUptimeCount;
    TimeOfDay? finalWakeupTime = Workflow().convertStringtoTimeofDay(
        widget.sleepDiariesPODO.finalWakeupTime);
    TimeOfDay? timeLeftbed = Workflow().convertStringtoTimeofDay(
        widget.sleepDiariesPODO.timeLeftbed);

    Medications? med1 = Workflow().getMedications(
        widget.sleepDiariesPODO.medications, isfirstmedication: true,
        isSecondmedication: false);
    Medications? med2 = Workflow().getMedications(
        widget.sleepDiariesPODO.medications, isfirstmedication: false,
        isSecondmedication: true);

    return Scaffold(
      //drawer: NavigationDrawerWidget(indexNum: 2,),
      appBar: AppBar(
        title: Text(SleepDiary.title),
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
              Align(
                alignment: Alignment.centerRight,
                child: Padding(
                  padding: sidePad,
                  child: Text(date,
                    textAlign: TextAlign.right,
                    style: themeData.textTheme.headline4,),
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

                      timeQuestion(sidePad, themeData, context, bedtime,
                          question: "What time did you get into bed last?",
                          valName: "inBed"),

                      SizedBox(height: pad,),

                      timeQuestion(sidePad, themeData, context, trySleepTime,
                          question: "What time did you try to go to sleep?",
                          valName: "tryBed"),

                      SizedBox(height: pad,),

                      hourMinute(sidePad, themeData, hours, minutes,
                          question: "How long did it take you to fall asleep? (Please select hour then minute)",
                          hrValName: "hrs1", mnValName: "mns1"),

                      SizedBox(height: pad,),

                      numberInput(sidePad, themeData, wakeupCount!,
                          question: "How many times did you wake up, not counting your final awakening?",
                          valName: "wakeTimes"),

                      SizedBox(height: pad,),

                      hourMinute(sidePad, themeData, hours, minutes,
                          question: "In total, how long did these awakenings last? (Please select hour then minute)",
                          hrValName: "hrs2", mnValName: "mns2"),

                      SizedBox(height: pad,),

                      timeQuestion(sidePad, themeData, context, finalWakeupTime,
                          question: "What time was your final awakening?",
                          valName: "finAwake"),

                      SizedBox(height: pad,),

                      timeQuestion(sidePad, themeData, context, timeLeftbed,
                          question: "What time did you get out of bed?",
                          valName: "outBed"),

                      SizedBox(height: pad,),

                      sleepQualityChoice(sidePad, themeData),

                      // SizedBox(height: pad,),

                      // drugNumberInput(sidePad, themeData,
                      //   question: "How much $drug1 did you take today?", valName: "drNum1"),
                      //
                      // SizedBox(height: pad,),
                      //
                      // drugNumberInput(sidePad, themeData,
                      //   question: "How much $drug2 did you take today?", valName: "drNum2"),

                      (() {
                        if (med1 != null) {
                          return drugNumberInput(sidePad, themeData,
                              question: "How much ${med1
                                  .medicationName} did you take today?",
                              valName: "drNum1",
                              valAmount: "${med1.amount}");
                        } else {
                          return SizedBox(height: 0.0,);
                        }
                      }()),


                      SizedBox(height: pad,),

                      (() {
                        if (med2 != null) {
                          return drugNumberInput(sidePad, themeData,
                              question: "How much ${med2
                                  .medicationName} did you take today?",
                              valName: "drNum1",
                              valAmount: "${med2.amount}");
                        } else {
                          return SizedBox(height: 0.0,);
                        }
                      }()),

                      SizedBox(height: pad,),

                      switchToMoreDrug(sidePad, themeData),

                      SizedBox(height: pad,),

                      normalTextInput(sidePad, themeData,
                          question: "Enter the medication name",
                          valName: "medName1"),

                      SizedBox(height: pad,),

                      drugNumberInput(sidePad, themeData,
                          question: "Enter the amount taken",
                          valName: "amTaken1",
                          valAmount: "0"),

                      SizedBox(height: pad,),

                      buildFeedbackForm(sidePad, themeData),

                      SizedBox(height: pad,),

                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                        children: [
                          IconUserButton(buttonText: "Submit", buttonEvent: () {
                            validateForm(_formKey);
                          }, buttonIcon: Icons.arrow_forward,),
                          IconUserButton(buttonText: "Cancel",
                              buttonEvent: () {},
                              buttonIcon: Icons.cancel)
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

  List<String> generateNumbers(int endNum) {
    List<String> nums = [];
    for (int i = 0; i <= endNum; i++) {
      nums.add(i.toString());
    }
    return nums;
  }

  Padding switchToMoreDrug(EdgeInsets sidePad, ThemeData themeData) {
    return Padding(
      padding: sidePad,
      child: FormBuilderSwitch(
        name: "moreDrug",
        initialValue: false,
        title: Text("Did you take any other medications before going to sleep?",
          style: themeData.textTheme.headline5,),
      ),
    );
  }

  Padding buildFeedbackForm(EdgeInsets sidePad, ThemeData themeData) {
    return Padding(
      padding: sidePad,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text("Anything else you would like to note:",
            style: themeData.textTheme.headline5,),
          SizedBox(height: 10,),
          Container(
            //padding: sidePad,
            height: 200.0,
            child: FormBuilderTextField(
              name: "otherNote",
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

  Padding drugNumberInput(EdgeInsets sidePad, ThemeData themeData,
      {required String question, required String valName, required String valAmount}) {
    return Padding(
      padding: sidePad,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(question,
            style: themeData.textTheme.headline5,),
          FormBuilderTextField(
            name: valName,
            initialValue: valAmount,
            inputFormatters: [FilteringTextInputFormatter.singleLineFormatter],
            keyboardType: TextInputType.numberWithOptions(decimal: true),
            style: themeData.textTheme.bodyText1,
          ),
        ],
      ),
    );
  }

  // Padding drugNumberInput(EdgeInsets sidePad, ThemeData themeData, {required String question, required String valName}) {
  //   return Padding(
  //     padding: sidePad,
  //     child: Column(
  //       crossAxisAlignment: CrossAxisAlignment.start,
  //       children: [
  //         Text(question,
  //           style: themeData.textTheme.headline5,),
  //         FormBuilderTextField(
  //           name: valName,
  //           inputFormatters: [FilteringTextInputFormatter.singleLineFormatter],
  //           keyboardType: TextInputType.numberWithOptions(decimal: true),
  //           style:  themeData.textTheme.bodyText1,
  //         ),
  //       ],
  //     ),
  //   );
  // }

  Padding normalTextInput(EdgeInsets sidePad, ThemeData themeData,
      {required String question, required String valName}) {
    return Padding(
      padding: sidePad,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(question,
            style: themeData.textTheme.headline5,),
          FormBuilderTextField(
            name: valName,
            style: themeData.textTheme.bodyText1,
          ),
        ],
      ),
    );
  }

  Padding numberInput(EdgeInsets sidePad, ThemeData themeData, int initialVal,
      {required String question, required String valName}) {
    return Padding(
      padding: sidePad,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(question,
            style: themeData.textTheme.headline5,),
          FormBuilderTextField(
            name: valName,
            inputFormatters: [FilteringTextInputFormatter.digitsOnly],
            keyboardType: TextInputType.number,
            initialValue: initialVal.toString(),
            style: themeData.textTheme.bodyText1,
          ),
        ],
      ),
    );
  }

  Padding hourMinute(EdgeInsets sidePad, ThemeData themeData,
      List<String> hours, List<String> minutes,
      {required String question, required String hrValName, required String mnValName}) {
    return Padding(
      padding: sidePad,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(question,
            style: themeData.textTheme.headline5,),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              Expanded(
                child: FormBuilderDropdown(
                  name: hrValName,
                  hint: Text("Select hours"),
                  style: themeData.textTheme.bodyText1,
                  items: hours.map((hr) =>
                      DropdownMenuItem(
                        child: Text("$hr"),
                        value: hr,
                      ),
                  ).toList(),
                ),
              ),
              Expanded(
                child: FormBuilderDropdown(
                  name: mnValName,
                  hint: Text("Select Minutes"),
                  style: themeData.textTheme.bodyText1,
                  items: minutes.map((mn) =>
                      DropdownMenuItem(
                        child: Text("$mn"),
                        value: mn,
                      ),
                  ).toList(),
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }

  Padding sleepQualityChoice(EdgeInsets sidePad, ThemeData themeData) {
    return Padding(
      padding: sidePad,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text('Please rate the overall quality of your sleep:',
            style: themeData.textTheme.headline5,),
          FormBuilderChoiceChip(
              name: "spQuality",
              alignment: WrapAlignment.spaceEvenly,
              spacing: 4,
              // decoration: InputDecoration(
              //   labelText: "Please rate the overall quality of your sleep:",
              //   labelStyle: themeData.textTheme.headline4,
              // ),
              options: [
                FormBuilderFieldOption(
                  child: Text("Very Poor"), value: "Very Poor",),
                FormBuilderFieldOption(child: Text("Poor"), value: "Poor",),
                FormBuilderFieldOption(child: Text("Fair"), value: "Fair",),
                FormBuilderFieldOption(child: Text("Good"), value: "Good",),
                FormBuilderFieldOption(
                  child: Text("Very Good"), value: "Very Good",),
              ]
          ),
        ],
      ),
    );
  }

  Padding timeQuestion(EdgeInsets sidePad, ThemeData themeData,
      BuildContext context, TimeOfDay? timeOfDay,
      {required String question, required String valName}) {
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
                  initialValue: getCurrentTime(_formKey, timeOfDay, valName),
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

  Future pickTime(BuildContext context, GlobalKey<FormBuilderState> key,
      String valName, TimeOfDay? time) async {
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

  String getText(GlobalKey<FormBuilderState> key, TimeOfDay? time,
      String valName) {
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

  String getCurrentTime(GlobalKey<FormBuilderState> key, TimeOfDay? time,
      String valName) {
    String timeVal = "Select Time";
    if (time == null) {
      return timeVal;
    } else {
      final hours = time.hour.toString().padLeft(2, '0');
      final minutes = time.minute.toString().padLeft(2, '0');
      timeVal = '$hours:$minutes';
      // key.currentState!.fields[valName]!.didChange(timeVal);
      return timeVal;
    }
  }

  void validateForm(GlobalKey<FormBuilderState> key) {
    if (key.currentState!.saveAndValidate()) {

      print(key.currentState!.value);

      var bedTime = key.currentState!.fields["inBed"]!.value;
      if(bedTime == "Select Time"){
        bedTime = widget.sleepDiariesPODO.bedTime;
      }
      var tryTosleepTime = key.currentState!.fields["tryBed"]!.value;
      if(tryTosleepTime == "Select Time"){
        tryTosleepTime = widget.sleepDiariesPODO.tryTosleepTime;
      }
      double durationB4sleep;
      var durationBeforesleepoffHOUR = key.currentState!.fields["hrs1"]!.value;
      var durationBeforesleepoffMINUTES = key.currentState!.fields["mns1"]!
          .value;
      if (durationBeforesleepoffHOUR == null ||
          durationBeforesleepoffMINUTES == null) {
        durationB4sleep = widget.sleepDiariesPODO.durationBeforesleepoff ?? 0.0;
      } else {
        durationB4sleep = double.parse(
            durationBeforesleepoffHOUR + "." + durationBeforesleepoffMINUTES);
      }
      // "In total, how long did these awakenings last?"
      double awakeningDurations;
      var totalWakeUpdurationHOUR = key.currentState!.fields["hrs2"]!.value;
      var totalWakeUpdurationMINUTE = key.currentState!.fields["mns2"]!.value;
      if (totalWakeUpdurationHOUR == null ||
          totalWakeUpdurationMINUTE == null) {
        awakeningDurations = widget.sleepDiariesPODO.totalWakeUpduration ?? 0.0;
      } else {
        awakeningDurations = double.parse(
            totalWakeUpdurationHOUR + "." + totalWakeUpdurationMINUTE);
      }
      // "Sleep quality"
      var slpQuality = key.currentState!.fields["spQuality"]!.value;
      var sleepQuality = slpQuality ?? widget.sleepDiariesPODO.sleepQuality;

      int wakeUptimeCount = int.parse(
          key.currentState!.fields["wakeTimes"]!.value);

      var finalWakeupTime = key.currentState!.fields["finAwake"]!.value;
      if(finalWakeupTime == "Select Time"){
        finalWakeupTime = widget.sleepDiariesPODO.finalWakeupTime;
      }
      var timeLeftbed = key.currentState!.fields["outBed"]!.value;
      if(timeLeftbed == "Select Time"){
        timeLeftbed = widget.sleepDiariesPODO.timeLeftbed;
      }

      var newMedname = key.currentState!.fields["medName1"]!.value;
      var newMedamount = key.currentState!.fields["amTaken1"]!.value;

      var otherThings = key.currentState!.fields["otherNote"]!.value;

      OtherMedicationsEntity? othermed;
      if(newMedname != null && newMedamount != null){
        othermed = OtherMedicationsEntity();
        othermed.setOthermedicationFields(newMedname, newMedamount);

      }

      Medications? med1 = Workflow().getMedications(
          widget.sleepDiariesPODO.medications, isfirstmedication: true,
          isSecondmedication: false);
      Medications? med2 = Workflow().getMedications(
          widget.sleepDiariesPODO.medications, isfirstmedication: false,
          isSecondmedication: true);

      List<Medications> currentMeds = List.filled(
          2, new Medications(), growable: true);

      if (med1 != null) {
        String? drugAmount1 = key.currentState!.fields["drNum1"]!.value;
        if (drugAmount1 != null) {
          med1.setDrugAmount(drugAmount1);
          currentMeds.removeAt(0);
          currentMeds.add(med1);
        }
        if (med2 != null) {
          String? drugAmount2 = key.currentState!.fields["drNum2"]!.value;
          print("Current Med 2 amount : $drugAmount2");
          if (drugAmount2 != null) {
            med2.setDrugAmount(drugAmount2);
            currentMeds.add(med2);
          }
        }
      }

      widget.sleepDiariesPODO.updateVariable(
          bedTime,
          tryTosleepTime,
          durationB4sleep,
          wakeUptimeCount,
          awakeningDurations,
          finalWakeupTime,
          timeLeftbed,
          sleepQuality,
          otherThings,
          currentMeds,
          othermed
      );


      Future<SleepDiariesPODO> savedSleepDiary = ApiAccess().saveSleepDiaries(
          sleepDiary: widget.sleepDiariesPODO);

      print("Bed : $bedTime , "
          "Try to sleep : $tryTosleepTime , "
          "Sleep Quality : $sleepQuality , "
          "Wake up count : $wakeUptimeCount ,"
          " Final Wake up : $finalWakeupTime ,"
          "Time Left Bed : $timeLeftbed , "
          "Awakening Duration : $awakeningDurations"
      //   "Current Med 1 Amount : $drugAmount1 , "
      // "Current Med 2 amount : $drugAmount2 , "
          "Duration before sleep $durationB4sleep "
          "New Med Name : $newMedname ,"
          " New Med Amount : $newMedamount ,"
          " Other things : $otherThings");

      print(
          "::::::::::::::::::::::::::::::::: SAVED ITEMS ::::::::::::::::::::::::::::::::::::::::::::::::::::");
      savedSleepDiary.then((value) =>
      {

        print("Bed : ${value.bedTime} , Try to sleep : ${value.tryTosleepTime} , "
            "Sleep Quality : ${value.sleepQuality} , Wake up count : ${value
            .wakeUptimeCount} , Final Wake up : ${value.finalWakeupTime} ,"
            "Time Left Bed : ${value
            .timeLeftbed}, Current Med 1 Amount : , Awakening Duration : ${value
            .totalWakeUpduration} "
            "Current Med 2 amount : , Duration before sleep ${value.bedTime} "
            "New Med Name : , New Med Amount : , Other things : "),
        Navigator.push(context, new MaterialPageRoute(builder: (context) => HomeScreen(futureProfile: null,)))
      });
    }
  }
}

// import 'package:flutter/material.dart';
// import 'package:flutter/services.dart';
// import 'package:flutter_form_builder/flutter_form_builder.dart';
// //import 'package:intl/intl.dart';
// import 'package:healthensuite/models/icon_button.dart';
// import 'package:healthensuite/utilities/constants.dart';
// //import 'package:healthensuite/utilities/drawer_navigation.dart';
// //import 'package:healthensuite/utilities/constants.dart';
//
//
// class SleepDiary extends StatelessWidget {
//
//   final Function? onMenuTap;
//   static final String title = 'Sleep Diary';
//   final _formKey = GlobalKey<FormBuilderState>();
//   TimeOfDay? time;
//
//   SleepDiary({Key? key, this.onMenuTap}) : super(key: key);
//
//   @override
//   Widget build(BuildContext context) {
//     final Size size = MediaQuery.of(context).size;
//     final ThemeData themeData = Theme.of(context);
//     final sidePad = EdgeInsets.symmetric(horizontal: 20);
//     double pad = 18;
//     String drug1 = "Chlopazine";
//     String drug2 = "Oxitocine";
//     List<String> hours = generateNumbers(23);
//     List<String> minutes = generateNumbers(59);
//
//     return Scaffold(
//       //drawer: NavigationDrawerWidget(indexNum: 2,),
//       appBar: AppBar(
//         title: Text(title),
//         centerTitle: true,
//       ),
//       body: FormBuilder(
//         key: _formKey,
//         child: Container(
//           width: size.width,
//           height: size.height,
//           child: Column(
//             crossAxisAlignment: CrossAxisAlignment.start,
//             children: [
//               SizedBox(height: pad,),
//               Align(
//                 alignment: Alignment.centerRight,
//                 child: Padding(
//                   padding: sidePad,
//                   child: Text('2020-05-30',
//                   textAlign: TextAlign.right,
//                   style: themeData.textTheme.headline4,),
//                 ),
//               ),
//               Expanded(
//                 flex: 1,
//                 child: SingleChildScrollView(
//                   scrollDirection: Axis.vertical,
//                   physics: ClampingScrollPhysics(),
//                   child: Column(
//                     crossAxisAlignment: CrossAxisAlignment.start,
//                     children: [
//                       SizedBox(height: pad,),
//
//                       timeQuestion(sidePad, themeData, context, question: "What time did you get into bed last?", valName: "inBed"),
//
//                       SizedBox(height: pad,),
//
//                       timeQuestion(sidePad, themeData, context, question: "What time did you try to go to sleep?", valName: "tryBed"),
//
//                       SizedBox(height: pad,),
//
//                       hourMinute(sidePad, themeData, hours, minutes,
//                         question: "How long did it take you to fall asleep? (Please select hour then minute)",
//                         hrValName: "hrs1", mnValName: "mns1"),
//
//                       SizedBox(height: pad,),
//
//                       numberInput(sidePad, themeData,
//                         question: "How many times did you wake up, not counting your final awakening?", valName: "wakeTimes"),
//
//                       SizedBox(height: pad,),
//
//                       hourMinute(sidePad, themeData, hours, minutes,
//                         question: "In total, how long did these awakenings last? (Please select hour then minute)",
//                         hrValName: "hrs2", mnValName: "mns2"),
//
//                       SizedBox(height: pad,),
//
//                       timeQuestion(sidePad, themeData, context, question: "What time was your final awakening?", valName: "finAwake"),
//
//                        SizedBox(height: pad,),
//
//                       timeQuestion(sidePad, themeData, context, question: "What time did you get out of bed?", valName: "outBed"),
//
//                       SizedBox(height: pad,),
//
//                       sleepQualityChoice(sidePad, themeData),
//
//                       SizedBox(height: pad,),
//
//                       drugNumberInput(sidePad, themeData,
//                         question: "How much $drug1 did you take today?", valName: "drNum1"),
//
//                       SizedBox(height: pad,),
//
//                       drugNumberInput(sidePad, themeData,
//                         question: "How much $drug2 did you take today?", valName: "drNum2"),
//
//                       SizedBox(height: pad,),
//
//                       switchToMoreDrug(sidePad, themeData),
//
//                       SizedBox(height: pad,),
//
//                       normalTextInput(sidePad, themeData,
//                         question: "Enter the medication name", valName: "medName1"),
//
//                       SizedBox(height: pad,),
//
//                       drugNumberInput(sidePad, themeData,
//                         question: "Enter the amount taken", valName: "amTaken1"),
//
//                       SizedBox(height: pad,),
//
//                       buildFeedbackForm(sidePad, themeData),
//
//                       SizedBox(height: pad,),
//
//                       Row(
//                         mainAxisAlignment: MainAxisAlignment.spaceEvenly,
//                         children: [
//                           IconUserButton(buttonText: "Submit", buttonEvent: () {validateForm(_formKey);}, buttonIcon: Icons.arrow_forward,),
//                           IconUserButton(buttonText: "Cancel", buttonEvent: () {}, buttonIcon: Icons.cancel)
//                         ],
//                       ),
//                       SizedBox(height: pad,),
//                     ],
//                   ),
//                 ),
//               )
//             ],
//           ),
//         ),
//         onChanged: () => print("Form has changed"),
//       ),
//     );
//   }
//
//
//   //Builder Widget below
//
//   Padding switchToMoreDrug(EdgeInsets sidePad, ThemeData themeData) {
//     return Padding(
//                       padding: sidePad,
//                       child: FormBuilderSwitch(
//                         name: "moreDrug",
//                         initialValue: false,
//                         title: Text("Did you take any other medications before going to sleep?",
//                           style: themeData.textTheme.headline5,),
//                       ),
//                     );
//   }
//
//   Padding buildFeedbackForm(EdgeInsets sidePad, ThemeData themeData){
//       return Padding(
//         padding: sidePad,
//         child: Column(
//           crossAxisAlignment: CrossAxisAlignment.start,
//           children: [
//             Text("Anything else you would like to note:",
//               style: themeData.textTheme.headline5,),
//             SizedBox(height: 10,),
//             Container(
//               //padding: sidePad,
//               height: 200.0,
//               child: FormBuilderTextField(
//                 name: "otherNote",
//                 maxLines: 10,
//                 decoration: InputDecoration(
//                   hintText: "Please briefly type your note here",
//                   hintStyle: themeData.textTheme.bodyText2,
//                   border: OutlineInputBorder(
//                     borderSide: BorderSide(color: appItemColorBlue)
//                     ),
//                 ),
//               ),
//             ),
//           ],
//         ),
//       );
//   }
//
//   Padding drugNumberInput(EdgeInsets sidePad, ThemeData themeData, {required String question, required String valName}) {
//     return Padding(
//                       padding: sidePad,
//                       child: Column(
//                         crossAxisAlignment: CrossAxisAlignment.start,
//                         children: [
//                           Text(question,
//                           style: themeData.textTheme.headline5,),
//                           FormBuilderTextField(
//                             name: valName,
//                             inputFormatters: [FilteringTextInputFormatter.singleLineFormatter],
//                             keyboardType: TextInputType.numberWithOptions(decimal: true),
//                             style:  themeData.textTheme.bodyText1,
//                           ),
//                         ],
//                       ),
//                     );
//   }
//
//   Padding normalTextInput(EdgeInsets sidePad, ThemeData themeData, {required String question, required String valName}) {
//     return Padding(
//                       padding: sidePad,
//                       child: Column(
//                         crossAxisAlignment: CrossAxisAlignment.start,
//                         children: [
//                           Text(question,
//                           style: themeData.textTheme.headline5,),
//                           FormBuilderTextField(
//                             name: valName,
//                             style:  themeData.textTheme.bodyText1,
//                           ),
//                         ],
//                       ),
//                     );
//   }
//
//   Padding numberInput(EdgeInsets sidePad, ThemeData themeData, {required String question, required String valName}) {
//     return Padding(
//                       padding: sidePad,
//                       child: Column(
//                         crossAxisAlignment: CrossAxisAlignment.start,
//                         children: [
//                           Text(question,
//                           style: themeData.textTheme.headline5,),
//                           FormBuilderTextField(
//                             name: valName,
//                             inputFormatters: [FilteringTextInputFormatter.digitsOnly],
//                             //inputFormatters: [FilteringTextInputFormatter.singleLineFormatter],
//                             //keyboardType: TextInputType.numberWithOptions(decimal: true),
//                             keyboardType: TextInputType.number,
//                             style:  themeData.textTheme.bodyText1,
//                           ),
//                         ],
//                       ),
//                     );
//   }
//
//   Padding hourMinute(EdgeInsets sidePad, ThemeData themeData, List<String> hours, List<String> minutes, {required String question, required String hrValName, required String mnValName}) {
//     return Padding(
//               padding: sidePad,
//               child: Column(
//                 crossAxisAlignment: CrossAxisAlignment.start,
//                 children: [
//                   Text(question,
//                     style: themeData.textTheme.headline5,),
//                   Row(
//                     mainAxisAlignment: MainAxisAlignment.spaceEvenly,
//                     children: [
//                       Expanded(
//                         child: FormBuilderDropdown(
//                           name: hrValName,
//                           hint: Text("Select hours"),
//                           style:  themeData.textTheme.bodyText1,
//                           items: hours.map((hr) => DropdownMenuItem(
//                             child: Text("$hr"),
//                             value: hr,
//                             ),
//                           ).toList(),
//                         ),
//                       ),
//                       Expanded(
//                         child: FormBuilderDropdown(
//                           name: mnValName,
//                           hint: Text("Select Minutes"),
//                           style:  themeData.textTheme.bodyText1,
//                           items: minutes.map((mn) => DropdownMenuItem(
//                             child: Text("$mn"),
//                             value: mn,
//                             ),
//                           ).toList(),
//                         ),
//                       ),
//                     ],
//                   ),
//                 ],
//               ),
//             );
//   }
//
//   Padding sleepQualityChoice(EdgeInsets sidePad, ThemeData themeData) {
//     return Padding(
//               padding: sidePad,
//               child: Column(
//                 crossAxisAlignment: CrossAxisAlignment.start,
//                 children: [
//                   Text('Please rate the overall quality of your sleep:',
//                   style: themeData.textTheme.headline5,),
//                   FormBuilderChoiceChip(
//                     name: "spQuality",
//                     alignment: WrapAlignment.spaceEvenly,
//                     spacing: 4,
//                     // decoration: InputDecoration(
//                     //   labelText: "Please rate the overall quality of your sleep:",
//                     //   labelStyle: themeData.textTheme.headline4,
//                     // ),
//                     options: [
//                       FormBuilderFieldOption(child: Text("Very Poor"), value: "Very Poor",),
//                       FormBuilderFieldOption(child: Text("Poor"), value: "Poor",),
//                       FormBuilderFieldOption(child: Text("Fair"), value: "Fair",),
//                       FormBuilderFieldOption(child: Text("Good"), value: "Good",),
//                       FormBuilderFieldOption(child: Text("Very Good"), value: "Very Good",),
//                     ]
//                   ),
//                 ],
//               ),
//             );
//   }
//
//   Padding timeQuestion(EdgeInsets sidePad, ThemeData themeData, BuildContext context, {required String question, required String valName}) {
//     return Padding(
//               padding: sidePad,
//               child: Column(
//                 crossAxisAlignment: CrossAxisAlignment.start,
//                 children: [
//                   Text(question,
//                   style: themeData.textTheme.headline5,),
//                   Row(
//                     children: [
//                       Expanded(
//                         child: FormBuilderTextField(
//                           name: valName,
//                           initialValue: getText(_formKey, time, valName),
//                           readOnly: true,
//                           style: themeData.textTheme.bodyText1,
//                         ),
//                       ),
//                       IconButton(
//                         onPressed: () => pickTime(context, _formKey, valName, time),
//                         icon: Icon(Icons.lock_clock),
//                         color: appItemColorBlue,
//                       ),
//                     ],
//                   ),
//
//                 ],
//               ),
//             );
//   }
//
//   Future pickTime(BuildContext context, GlobalKey<FormBuilderState> key, String valName, TimeOfDay? time) async {
//     final initialTime = TimeOfDay(hour: 9, minute: 0);
//     final newTime = await showTimePicker(
//       context: context,
//       initialTime: time ?? initialTime,
//     );
//
//     if (newTime == null) return;
//
//     time = newTime;
//     print("New Time $time");
//     getText(key, time, valName);
//   }
//
//   String getText(GlobalKey<FormBuilderState> key, TimeOfDay? time, String valName) {
//     String timeVal = "Select Time";
//     if (time == null) {
//       return timeVal;
//     } else {
//       final hours = time.hour.toString().padLeft(2, '0');
//       final minutes = time.minute.toString().padLeft(2, '0');
//       timeVal = '$hours:$minutes';
//       key.currentState!.fields[valName]!.didChange(timeVal);
//       return timeVal;
//     }
//   }
//
//   void validateForm(GlobalKey<FormBuilderState> key){
//         if(key.currentState!.saveAndValidate()){
//           //key.currentState.save();
//           print(key.currentState!.value);
//           //key.currentState.reset();
//           String? myVal = key.currentState!.fields["spQuality"]!.value;
//           print("Its value: $myVal");
//         }
//   }
//
//   List<String> generateNumbers(int endNum){
//     List<String> nums = [];
//     for(int i = 0; i <= endNum; i++){
//       nums.add(i.toString());
//     }
//     return nums;
//   }
//
// }