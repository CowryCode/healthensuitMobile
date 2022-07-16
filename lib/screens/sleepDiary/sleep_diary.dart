
import 'dart:math';

import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:flutter/services.dart';
import 'package:flutter_form_builder/flutter_form_builder.dart';
import 'package:flutter_redux/flutter_redux.dart';
import 'package:healthensuite/api/network.dart';
import 'package:healthensuite/api/networkmodels/medicationsPODO.dart';
import 'package:healthensuite/api/networkmodels/otherMedicationsPODO.dart';
import 'package:healthensuite/api/networkmodels/patientProfilePodo.dart';
import 'package:healthensuite/api/networkmodels/sleepDiaryPODO.dart';
import 'package:healthensuite/api/statemanagement/actions.dart';
import 'package:healthensuite/api/statemanagement/app_state.dart';
import 'package:healthensuite/api/statemanagement/behaviourlogic.dart';
import 'package:healthensuite/models/icon_button.dart';
import 'package:healthensuite/screens/home/home_screen.dart';
import 'package:healthensuite/utilities/constants.dart';
import 'package:healthensuite/utilities/text_data.dart';


// ignore: must_be_immutable
class SleepDiary extends StatefulWidget {
  final Function? onMenuTap;
  static final String title = 'Sleep Diary';
  SleepDiariesPODO sleepDiariesPODO;

  //Confirm if there are medications
  bool isMed1 = false;
  bool isMed2 = false;

  SleepDiary({Key? key, this.onMenuTap, required this.sleepDiariesPODO}) : super(key: key);

  @override
  _SleepDiaryState createState() => _SleepDiaryState();
}

class _SleepDiaryState extends State<SleepDiary> {
  final _formKey = GlobalKey<FormBuilderState>();
  bool moreDrugIsVisible = false;
  bool extraDrugIsVisible = false;
  bool secondExtraDrugIsVisible = false;
  bool extraMedFieldIsOkay = true;

  TimeOfDay? time;

  @override
  Widget build(BuildContext context) {
    final Size size = MediaQuery
        .of(context)
        .size;
    final ThemeData themeData = Theme.of(context);
    final sidePad = EdgeInsets.symmetric(horizontal: 20);
    double pad = 18;

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

    List<int>? totalWakeupDuration = Workflow().convertMinutestoHRnMin(timeinMinutes: widget.sleepDiariesPODO.totalWakeUpduration);
    List<int>? durationB4sleep = Workflow().convertMinutestoHRnMin(timeinMinutes: widget.sleepDiariesPODO.durationBeforesleepoff);



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
              bodyTextWidget(themeData, sidePad, text: SLEEP_DIARY_DATA["para1"]!),
              bodyTextWidget(themeData, sidePad, text: SLEEP_DIARY_DATA["para2"]!),
              Expanded(
                flex: 1,
                child: SingleChildScrollView(
                  scrollDirection: Axis.vertical,
                  physics: ClampingScrollPhysics(),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      SizedBox(height: pad,),

                      timeQuestion(sidePad, themeData, context,
                          timeOfDay: bedtime ?? TimeOfDay(hour: 19, minute: 0),
                          question: "1. What time did you get into bed last night? (Required)",
                          valName: "inBed"),
                      // timeQuestion(sidePad, themeData, context, bedtime,
                      //     question: "What time did you get into bed last?",
                      //     valName: "inBed"),

                      SizedBox(height: pad,),

                      timeQuestion(sidePad, themeData, context,
                          timeOfDay: trySleepTime ?? TimeOfDay(hour: 19, minute: 30),
                          question: "2. What time did you try to go to sleep? (Required)",
                          valName: "tryBed"),
                      // timeQuestion(sidePad, themeData, context, trySleepTime,
                      //     question: "What time did you try to go to sleep?",
                      //     valName: "tryBed"),

                      SizedBox(height: pad,),

                      hourMinute(sidePad, themeData, hours, minutes,durationB4sleep,
                          question: "3. How long did it take you to fall asleep? (Please select hour then minute)",
                          hrValName: "hrs1", mnValName: "mns1"),

                      SizedBox(height: pad,),

                      numberInput(sidePad, themeData, wakeupCount!,
                          question: "4. How many times did you wake up, not counting your final awakening? (Required)",
                          valName: "wakeTimes"),

                      SizedBox(height: pad,),

                      hourMinute(sidePad, themeData, hours, minutes, totalWakeupDuration,
                          question: "5. In total, how long did these awakenings last? (Please select hour then minute)",
                          hrValName: "hrs2", mnValName: "mns2"),

                      SizedBox(height: pad,),

                      timeQuestion(sidePad, themeData, context,
                          timeOfDay: finalWakeupTime ?? TimeOfDay(hour: 5, minute: 0),
                          question: "6. What time was your final awakening? (Required)",
                          valName: "finAwake"),
                      // timeQuestion(sidePad, themeData, context, finalWakeupTime,
                      //     question: "What time was your final awakening?",
                      //     valName: "finAwake"),

                      SizedBox(height: pad,),

                      timeQuestion(sidePad, themeData, context,
                          timeOfDay: timeLeftbed ?? TimeOfDay(hour: 5, minute: 30),
                          question: "7. What time did you get out of bed? (Required)",
                          valName: "outBed"),
                      // timeQuestion(sidePad, themeData, context, timeLeftbed,
                      //     question: "What time did you get out of bed?",
                      //     valName: "outBed"),

                      SizedBox(height: pad,),

                      (() {
                        if (med1 != null) {
                        //  widget.isMed1 = true;
                          return drugNumberInput(sidePad, themeData,
                              question: "How much ${med1.medicationName} (milligrams) did you take today? (Required)",
                              valName: "drNum1",
                              valAmount: "${med1.amount}");
                        } else {
                          return SizedBox(height: 0.0,);
                        }
                      }()),


                      SizedBox(height: pad,),

                      (() {
                        if (med2 != null) {
                         // widget.isMed2 = true;
                          return drugNumberInput(sidePad, themeData,
                              question: "How much ${med2.medicationName} (milligrams) did you take today? (Required)",
                              valName: "drNum2",
                              valAmount: "${med2.amount}");
                        } else {
                          return SizedBox(height: 0.0,);
                        }
                      }()),

                      switchToMoreDrug(sidePad, themeData,
                      questionTxt: "Did you take any other medications before going to sleep? (Optional)"),

                      Visibility(child: SizedBox(height: pad,), visible: moreDrugIsVisible,),
                      Visibility(child:  Padding(
                            padding: sidePad,
                            child: Text(SLEEP_DIARY_DATA["extraMedSubHead"]!,
                              style: themeData.textTheme.headline5,),
                          ), visible: moreDrugIsVisible,),
                      Visibility(child: SizedBox(height: pad,), visible: moreDrugIsVisible,),
                      Visibility(child: normalTextInput(sidePad, themeData,question: "Enter the medication name 1", valName: "medName1"), visible: moreDrugIsVisible,),
                      Visibility(child: SizedBox(height: pad,), visible: moreDrugIsVisible,),
                      Visibility(child: normalTextInput(sidePad, themeData,question: "Enter the amount taken 1", valName: "amTaken1"), visible: moreDrugIsVisible,),

                      Visibility(child: SizedBox(height: pad,), visible: moreDrugIsVisible,),
                      Visibility(child: switchToExtraDrug(sidePad, themeData,
                          questionTxt: "Add more medication?"),
                        visible: moreDrugIsVisible,),

                      Visibility(child: SizedBox(height: pad,), visible: extraDrugIsVisible,),
                      Visibility(child: normalTextInput(sidePad, themeData,question: "Enter the medication name 2", valName: "medName2"), visible: extraDrugIsVisible,),
                      Visibility(child: SizedBox(height: pad,), visible: extraDrugIsVisible,),
                      Visibility(child: normalTextInput(sidePad, themeData,question: "Enter the amount taken 2", valName: "amTaken2"), visible: extraDrugIsVisible,),

                      Visibility(child: SizedBox(height: pad,), visible: extraDrugIsVisible,),
                      Visibility(child: switchToSecondExtraDrug(sidePad, themeData,
                          questionTxt: "Add more medication?"),
                        visible: extraDrugIsVisible,),

                      Visibility(child: SizedBox(height: pad,), visible: secondExtraDrugIsVisible,),
                      Visibility(child: normalTextInput(sidePad, themeData,question: "Enter the medication name 3", valName: "medName3"), visible: secondExtraDrugIsVisible,),
                      Visibility(child: SizedBox(height: pad,), visible: secondExtraDrugIsVisible,),
                      Visibility(child: normalTextInput(sidePad, themeData,question: "Enter the amount taken 3", valName: "amTaken3"), visible: secondExtraDrugIsVisible,),
                      // SizedBox(height: pad,),
                      //
                      // normalTextInput(sidePad, themeData,
                      //     question: "Enter the medication name",
                      //     valName: "medName1"),
                      //
                      // SizedBox(height: pad,),
                      //
                      // drugNumberInput(sidePad, themeData,
                      //     question: "Enter the amount taken",
                      //     valName: "amTaken1",
                      //     valAmount: "0"),

                      SizedBox(height: pad,),

                      sleepQualityChoice(sidePad, themeData),

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

  Padding bodyTextWidget(ThemeData themeData, EdgeInsets sidePad, {required String text}) {
    return Padding(
      padding: sidePad,
      child: Text(text,
        style: themeData.textTheme.bodyText1,),
    );
  }

  Padding switchToMoreDrug(EdgeInsets sidePad, ThemeData themeData, {required String questionTxt}) {
    return Padding(
      padding: sidePad,
      child: FormBuilderSwitch(
        name: "moreDrug",
        initialValue: moreDrugIsVisible,
        title: Text(questionTxt,
          style: themeData.textTheme.headline5,),
        onChanged: (val){
          if(val == true){
            setState(() {
              moreDrugIsVisible = true;
            });
          }
          else if(val == false){
            setState(() {
              moreDrugIsVisible = false;
              extraDrugIsVisible = false;
              secondExtraDrugIsVisible = false;
            });
          }
        },
      ),
    );
  }

  Padding switchToExtraDrug(EdgeInsets sidePad, ThemeData themeData, {required String questionTxt}) {
    return Padding(
      padding: sidePad,
      child: FormBuilderSwitch(
        name: "extraDrug",
        initialValue: extraDrugIsVisible,
        title: Text(questionTxt,
          style: themeData.textTheme.headline5,),
        onChanged: (val){
          if(val == true){
            setState(() {
              extraDrugIsVisible = true;
            });
          }
          else if(val == false){
            setState(() {
              extraDrugIsVisible = false;
              secondExtraDrugIsVisible = false;
            });
          }
        },
      ),
    );
  }

  Padding switchToSecondExtraDrug(EdgeInsets sidePad, ThemeData themeData, {required String questionTxt}) {
    return Padding(
      padding: sidePad,
      child: FormBuilderSwitch(
        name: "secondExtraDrug",
        initialValue: secondExtraDrugIsVisible,
        title: Text(questionTxt,
          style: themeData.textTheme.headline5,),
        onChanged: (val){
          if(val == true){
            setState(() {
              secondExtraDrugIsVisible = true;
            });
          }
          else if(val == false){
            setState(() {
              secondExtraDrugIsVisible = false;
            });
          }
        },
      ),
    );
  }


  Padding buildFeedbackForm(EdgeInsets sidePad, ThemeData themeData) {
    return Padding(
      padding: sidePad,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text("Anything else you would like to note: (Optional)",
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
            validator: FormBuilderValidators.compose([
              FormBuilderValidators.min(context, 0),
            ]),
            autovalidateMode: AutovalidateMode.onUserInteraction,
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
            validator: FormBuilderValidators.compose([
              FormBuilderValidators.required(context,
                errorText: "Please enter number of times you woke up"),
              FormBuilderValidators.numeric(context),
              FormBuilderValidators.min(context, 0),
            ]),
            autovalidateMode: AutovalidateMode.onUserInteraction,
            style: themeData.textTheme.bodyText1,
          ),
        ],
      ),
    );
  }

  Padding hourMinute(EdgeInsets sidePad, ThemeData themeData,
      List<String> hours, List<String> minutes, initialTime,
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
                  // validator: FormBuilderValidators.compose(
                  //     [FormBuilderValidators.required(context,
                  //     errorText: "Hour is required")]),
                 // hint: Text("Select hours"),
                  hint: Text(initialTime == null ? "Select hours" : "${initialTime[0]}"),
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
                  // validator: FormBuilderValidators.compose(
                  //     [FormBuilderValidators.required(context,
                  //         errorText: "Minute is required")]),
                 // hint: Text("Select Minutes"),
                  hint: Text(initialTime == null ? "Select Minutes" : "${initialTime[1]}"),
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
          Text('Please rate the overall quality of your sleep: (Required)',
            style: themeData.textTheme.headline5,),
          FormBuilderChoiceChip(
              name: "spQuality",
              alignment: WrapAlignment.spaceEvenly,
              selectedColor: appItemColorBlue,
              validator: FormBuilderValidators.compose([
                FormBuilderValidators.required(context,
                  errorText: 'Please select one option above',)]),
              autovalidateMode: AutovalidateMode.onUserInteraction,
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
              ],
            onChanged: (value){
              validateExtraMedOptions(_formKey);
            },
          ),
        ],
      ),
    );
  }

  Padding timeQuestion(EdgeInsets sidePad, ThemeData themeData,
      BuildContext context,
      { required TimeOfDay timeOfDay, required String question, required String valName}) {
    return Padding(
      padding: sidePad,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(question,
            style: themeData.textTheme.headline5,),
          FormBuilderDateTimePicker(
            name: valName,
            // onChanged: _onChanged,
            inputType: InputType.time,
            decoration: const InputDecoration(
              labelText: 'Select Time (Required)',
            ),
            initialTime: timeOfDay,
            // initialTime: TimeOfDay(hour: timeOfDay, minute: 0),
            style: themeData.textTheme.bodyText1,
            validator: FormBuilderValidators.compose([
              FormBuilderValidators.required(context,
                errorText: 'Please set time for this question',)]),
              autovalidateMode: AutovalidateMode.onUserInteraction,
          ),
          // Row(
          //   children: [
          //     Expanded(
          //       child: FormBuilderTextField(
          //         name: valName,
          //         autovalidateMode: AutovalidateMode.always,
          //         initialValue: getCurrentTime(_formKey, timeOfDay, valName),
          //         readOnly: true,
          //         style: themeData.textTheme.bodyText1,
          //       ),
          //     ),
          //     IconButton(
          //       onPressed: () => pickTime(context, _formKey, valName, time),
          //       icon: Icon(Icons.lock_clock),
          //       color: appItemColorBlue,
          //     ),
          //   ],
          // ),

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

  bool validateExtraMedOptions(GlobalKey<FormBuilderState> key){

    bool firstBoolIsPositive = key.currentState!.fields["moreDrug"]!.value;
    print("I am here: $firstBoolIsPositive");
    bool secondBoolIsPositive;
    bool thirdBoolIsPositive;

    if(firstBoolIsPositive){
      secondBoolIsPositive = key.currentState!.fields["extraDrug"]!.value;
      String? newMedname = key.currentState!.fields["medName1"]!.value;
      String? newMedamount = key.currentState!.fields["amTaken1"]!.value;
      if(newMedname == null || newMedname == "" || newMedamount == null || newMedamount == ""){
        extraMedFieldIsOkay = false;
        createAlertDialog(context,
            msg: "You selected that you took other medications before going to sleep. Please fill the medication details properly or unselect the other medication button.");
      }else if(secondBoolIsPositive){
        thirdBoolIsPositive = key.currentState!.fields["secondExtraDrug"]!.value;
        String? newMedname2 = key.currentState!.fields["medName2"]!.value;
        String? newMedamount2 = key.currentState!.fields["amTaken2"]!.value;
        extraMedFieldIsOkay = false;
        if(newMedname2 == null || newMedname2 == "" || newMedamount2 == null || newMedamount2 == ""){
          createAlertDialog(context,
              msg: "You selected that you took more than one other medications before going to sleep. Please fill the medication details properly or unselect the other medication button.");
        }else if(thirdBoolIsPositive){
          String? newMedname3 = key.currentState!.fields["medName3"]!.value;
          String? newMedamount3 = key.currentState!.fields["amTaken3"]!.value;
          extraMedFieldIsOkay = false;
          if(newMedname3 == null || newMedname3 == "" || newMedamount3 == null || newMedamount3 == ""){
            createAlertDialog(context,
                msg: "You selected that you took more than two other medications before going to sleep. Please fill the medication details properly or unselect the other medication button.");
          }
        }else{
          extraMedFieldIsOkay = true;
        }
      }
    }else{
      extraMedFieldIsOkay = true;
    }
    return extraMedFieldIsOkay;
  }

  void validateForm(GlobalKey<FormBuilderState> key) {
    if (key.currentState!.saveAndValidate()) {
      // widget.sleepDiariesPODO

      extraMedFieldIsOkay = validateExtraMedOptions(_formKey);
      if(!extraMedFieldIsOkay){
        return;
      }
      print(key.currentState!.value);

      DateFormat dateFormat = DateFormat("hh:mm a");

      String? bedTime;
      String? bedTime_1;
      dynamic? bedtimeField = key.currentState!.fields["inBed"];
      if(bedtimeField != null){
       // String? bedTime = key.currentState!.fields["inBed"]!.value.toString();
         bedTime = key.currentState!.fields["inBed"]!.value.toString();
         print("BEST TIME BEFORE FORMAT: ${bedTime}");
         bedTime_1 = Workflow().converTimeTo24HoursFormat(dateTime: bedTime);
         bedTime = dateFormat.format(DateTime.parse(bedTime));
      }

      String? tryTosleepTime;
      String? tryTosleepTime_1;
      dynamic? tryTosleepTimeField = key.currentState!.fields["tryBed"];
      if(tryTosleepTimeField != null){
       // String? tryTosleepTime = key.currentState!.fields["tryBed"]!.value.toString();
        tryTosleepTime = key.currentState!.fields["tryBed"]!.value.toString();
        tryTosleepTime_1 = Workflow().converTimeTo24HoursFormat(dateTime: tryTosleepTime);
        tryTosleepTime = dateFormat.format(DateTime.parse(tryTosleepTime));
      }
      String? durationBeforesleepoffHOUR;
      dynamic? durationBeforesleepoffHOURField =  key.currentState!.fields["hrs1"]!.value;
      if(durationBeforesleepoffHOURField != null){
      //  String durationBeforesleepoffHOUR = key.currentState!.fields["hrs1"]!.value.toString();
        durationBeforesleepoffHOUR = key.currentState!.fields["hrs1"]!.value.toString();
      }else{
        durationBeforesleepoffHOUR = "0";
      }
      String? durationBeforesleepoffMINUTES;
      dynamic? durationBeforesleepoffMINUTESField = key.currentState!.fields["mns1"]!.value;
      if(durationBeforesleepoffMINUTESField != null){
         durationBeforesleepoffMINUTES = key.currentState!.fields["mns1"]!.value.toString();
      }else{
        durationBeforesleepoffMINUTES = "0";
      }
      //TODO: CONVERTED EVERYTHING TO MINUTE, KINDLY CONFIRM WITH WEB
      // double durationB4sleep = double.parse(
      //     durationBeforesleepoffHOUR + "." + durationBeforesleepoffMINUTES);
      print("Show the value here: $durationBeforesleepoffHOUR and the minute: $durationBeforesleepoffMINUTES");
      double durationB4sleep = convertHoursandMinutesToMinutes(hours: durationBeforesleepoffHOUR, mins: durationBeforesleepoffMINUTES );
      int? wakeUptimeCount;
      dynamic? wakeUptimeCountField = key.currentState!.fields["wakeTimes"];
      if(wakeUptimeCountField != null){
       // int? wakeUptimeCount = int.parse(key.currentState!.fields["wakeTimes"]!.value);
        wakeUptimeCount = int.parse(key.currentState!.fields["wakeTimes"]!.value);
      }

      String? totalWakeUpdurationHOUR;
      dynamic? totalWakeUpdurationHOURField = key.currentState!.fields["hrs2"]!.value;
      if(totalWakeUpdurationHOURField != null){
      //  String totalWakeUpdurationHOUR = key.currentState!.fields["hrs2"]!.value.toString();
        totalWakeUpdurationHOUR = key.currentState!.fields["hrs2"]!.value.toString();
      }else{
        totalWakeUpdurationHOUR = "0";
      }

      String? totalWakeUpdurationMINUTE;
      dynamic? totalWakeUpdurationMINUTEField = key.currentState!.fields["mns2"]!.value;
      if(totalWakeUpdurationMINUTEField != null){
       // String totalWakeUpdurationMINUTE = key.currentState!.fields["mns2"]!.value.toString();
        totalWakeUpdurationMINUTE = key.currentState!.fields["mns2"]!.value.toString();
      }else{
        totalWakeUpdurationMINUTE = "0";
      }
      //TODO: CONVERTED EVERYTHING TO MINUTE, KINDLY CONFIRM WITH WEB
      // double awakeningDurations = double.parse(
      //     totalWakeUpdurationHOUR + "." + totalWakeUpdurationMINUTE);
      double awakeningDurations = convertHoursandMinutesToMinutes(
          hours: totalWakeUpdurationHOUR,mins: totalWakeUpdurationMINUTE );

      String? finalWakeupTime;
      String? finalWakeupTime_1;
      dynamic? finalWakeupTimeField =  key.currentState!.fields["finAwake"];
      if(finalWakeupTimeField != null){
      //  String? finalWakeupTime = key.currentState!.fields["finAwake"]!.value.toString();
        finalWakeupTime = key.currentState!.fields["finAwake"]!.value.toString();
        finalWakeupTime_1 = Workflow().converTimeTo24HoursFormat(dateTime: finalWakeupTime);
        finalWakeupTime = dateFormat.format(DateTime.parse(finalWakeupTime));
      }

      String? timeLeftbed;
      String? timeLeftbed_1;
      dynamic? timeLeftbedField = key.currentState!.fields["outBed"];
      if(timeLeftbedField != null){
       // String? timeLeftbed = key.currentState!.fields["outBed"]!.value.toString();
        timeLeftbed = key.currentState!.fields["outBed"]!.value.toString();
        timeLeftbed_1 = Workflow().converTimeTo24HoursFormat(dateTime: timeLeftbed);
        timeLeftbed = dateFormat.format(DateTime.parse(timeLeftbed));
      }

      String? slpQuality;
      dynamic? slpQualityField = key.currentState!.fields["spQuality"];
      if(slpQualityField != null){
       // String? slpQuality = key.currentState!.fields["spQuality"]!.value;
        slpQuality = key.currentState!.fields["spQuality"]!.value;
      }
      String? drugAmount1;
      dynamic? drugAmount1Field = key.currentState!.fields["drNum1"];
      if(drugAmount1Field != null){
       // String? drugAmount1 = key.currentState!.fields["drNum1"]!.value;
        drugAmount1 = key.currentState!.fields["drNum1"]!.value;
      }
      String? drugAmount2;
      dynamic? drugAmount2Field = key.currentState!.fields["drNum2"];
      if(drugAmount2Field != null){
       // String? drugAmount2 = key.currentState!.fields["drNum2"]!.value;
        drugAmount2 = key.currentState!.fields["drNum2"]!.value;
      }
      String? newMedname;
      dynamic? newMednameField = key.currentState!.fields["medName1"];
      if(newMednameField != null){
        // String? newMedname = key.currentState!.fields["medName1"]!.value;
        newMedname = key.currentState!.fields["medName1"]!.value;
      }
      String? newMedamount;
      dynamic? newMedamountField = key.currentState!.fields["amTaken1"];
      if(newMedamountField != null){
     //   String? newMedamount = key.currentState!.fields["amTaken1"]!.value;
       newMedamount = key.currentState!.fields["amTaken1"]!.value;
      }
      String? newMedname2;
      dynamic? newMedname2Field = key.currentState!.fields["medName2"];
      if(newMedname2Field != null){
        //String? newMedname2 = key.currentState!.fields["medName2"]!.value;
        newMedname2 = key.currentState!.fields["medName2"]!.value;
      }
      String? newMedamount2;
      dynamic? newMedamount2Field = key.currentState!.fields["amTaken2"];
      if(newMedamount2Field != null){
       // String? newMedamount2 = key.currentState!.fields["amTaken2"]!.value;
        newMedamount2 = key.currentState!.fields["amTaken2"]!.value;
      }
      String? newMedname3;
      dynamic? newMedname3Field = key.currentState!.fields["medName3"];
      if(newMedname3Field != null){
       // String? newMedname3 = key.currentState!.fields["medName3"]!.value;
        newMedname3 = key.currentState!.fields["medName3"]!.value;
      }
      String? newMedamount3;
      dynamic? newMedamount3Field  = key.currentState!.fields["amTaken3"];
      if(newMedamount3Field != null){
      //  String? newMedamount3 = key.currentState!.fields["amTaken3"]!.value;
        newMedamount3 = key.currentState!.fields["amTaken3"]!.value;
      }
      String? otherThings;
      dynamic? otherThingsField = key.currentState!.fields["otherNote"]!.value;
      if(otherThingsField != null){
       // String? otherThings = key.currentState!.fields["otherNote"]!.value;
        otherThings = key.currentState!.fields["otherNote"]!.value;
      }else{
        otherThings = "";
      }
      bool sleepTimeIsOkay = compareTimeSelected(firstTime: bedTime, secondTime: tryTosleepTime);
      bool sleepAndAwakeTimeIsOkay = compareTimeSelected(firstTime: tryTosleepTime, secondTime: finalWakeupTime);
      bool wakeTimeIsOkay = compareTimeSelected(firstTime: finalWakeupTime, secondTime: timeLeftbed);

      if(!sleepTimeIsOkay){
        createAlertDialog(context,
        msg: "Check Question #1 and #2. The time you tried to sleep is before your bed time.");
      }
      else if(!sleepAndAwakeTimeIsOkay){
        createAlertDialog(context,
            msg: "Check Question #2 and #6. The time you tried to sleep is the same or beyond your wake up time.");
      }
      else if(!wakeTimeIsOkay){
        createAlertDialog(context,
            msg: "Check Question #6 and #7. Your out of bed time is before your final awakening time.");
      }
      else{
        //TODO This is the echoed data
        // print("BetTime: $bedTime, \nTryToSleepTime: $tryTosleepTime, "
        //     "\nTakeYouToSleep: $durationB4sleep, \nTimesWakeUpCount: $wakeUptimeCount, "
        //     "\nWakeUpDurationTime: $awakeningDurations, \nFinalWakeupTime: $finalWakeupTime, "
        //     "\nTimeLeftbed: $timeLeftbed, \nSlpQuality: $slpQuality, "
        //     "\nDrugAmount1: $drugAmount1, \nDrugAmount2: $drugAmount2, "
        //     "\nNewMedname1: $newMedname, \nNewMedamount1: $newMedamount, "
        //     "\nNewMedname2: $newMedname2, \nNewMedamount2: $newMedamount2, "
        //     "\nNewMedname3: $newMedname3, \nNewMedamount3: $newMedamount3, "
        //     "\nOtherThings: $otherThings");

        // List<OtherMedicationsEntity> othermeds = [
        //   med1,med2,med3
        // ];
        List<OtherMedicationsEntity>? othermeds;
        OtherMedicationsEntity? med1;
        OtherMedicationsEntity? med2;
        OtherMedicationsEntity? med3;
        if(newMedname != null && newMedamount != null ){
          med1 = OtherMedicationsEntity();
          med1.setOthermedicationFields(newMedname, newMedamount);
        }
        if(newMedname2 != null && newMedamount2 != null){
          med2 = OtherMedicationsEntity();
          med2.setOthermedicationFields(newMedname2, newMedamount2);
        }
        if(newMedname3 != null && newMedamount3 != null){
          med3 = OtherMedicationsEntity();
          med3.setOthermedicationFields(newMedname3, newMedamount3);
        }

        if(med1 != null && med2 != null && med3 != null){
          othermeds = [med1, med2, med3];
        } else if (med1 != null && med2 != null && med3 == null){
          othermeds = [med1, med2];
        }else if (med1 != null && med2 == null && med3 == null){
          othermeds = [med1];
        }

        // Medications? currentMed1 = Workflow().getMedications(
        //     widget.sleepDiariesPODO.medications, isfirstmedication: true,
        //     isSecondmedication: false);
        // Medications? currentMed2 = Workflow().getMedications(
        //     widget.sleepDiariesPODO.medications, isfirstmedication: false,
        //     isSecondmedication: true);

        List<Medications>? currentmedds = widget.sleepDiariesPODO.medications;
        if(currentmedds != null){
          if(currentmedds.length == 1){
            Medications currentMed1 = currentmedds.elementAt(0);
            currentMed1.setDrugAmount(drugAmount: drugAmount1);
            currentmedds.insert(0, currentMed1);
          }else if (currentmedds.length == 2){
            Medications currentMed1 = currentmedds.elementAt(0);
            Medications currentMed2 = currentmedds.elementAt(1);
            currentMed1.setDrugAmount(drugAmount: drugAmount1);
            currentMed2.setDrugAmount(drugAmount: drugAmount2);
            currentmedds.insert(0, currentMed1);
            currentmedds.insert(2, currentMed2);
          }
        }
       SleepDiariesPODO updatedSD =   widget.sleepDiariesPODO.updateVariable(
            bedTime: bedTime_1,
            tryTosleepTime: tryTosleepTime_1,
            durationBeforesleepoff: durationB4sleep,
            wakeUptimeCount: wakeUptimeCount,
            totalWakeUpduration: awakeningDurations,
            finalWakeupTime: finalWakeupTime_1,
            timeLeftbed: timeLeftbed_1,
            sleepQuality: slpQuality,
            medications: currentmedds,
            otherMeds: othermeds,
            otherThings: otherThings,
            );

         ApiAccess().saveSleepDiaries(sleepDiary: updatedSD);
        PatientProfilePodo patientProfilePodo = StoreProvider.of<AppState>(context).state.patientProfilePodo;
        patientProfilePodo.updateSleepDiary(updatedSD);

        StoreProvider.of<AppState>(context).dispatch(UpdatePatientProfileAction(patientProfilePodo));
          Navigator.push(context, new MaterialPageRoute(builder: (context) => HomeScreen()));

      }
    }else{
      createAlertDialog(context,
          msg: "All required fields are not properly filled. Please review and fill the required fields");
      print("All fields are not properly filled!!!");
    }
  }

  double convertHoursandMinutesToMinutes({String? hours, String? mins}){
    if(hours == null && mins == null ){
      return 0.0;
    }else if(hours != null && mins == null){
      return double.parse(hours) * 60;
    }else if (hours == null && mins != null){
      return double.parse(mins);
    }else if (hours != null && mins != null){
      double totalhours = double.parse(hours) * 60;
      return totalhours + double.parse(mins);
    }else {
      return 0.0;
    }
  }


  bool compareTimeSelected({String? firstTime, String? secondTime}){
    if(firstTime == null || secondTime == null){
      return false;
    }

    bool timeIsOkay = true;

    DateFormat dateFormat = DateFormat("yyyy-MM-dd hh:mm a");

    DateTime dt1 = dateFormat.parse("0001-01-01 "+ firstTime);
    DateTime dt2 = DateTime.now();
    if(firstTime.contains('PM') && secondTime.contains('AM')){
      dt2 = dateFormat.parse("0001-01-02 "+ secondTime);
    }else{
      dt2 = dateFormat.parse("0001-01-01 "+ secondTime);
    }

    if(dt1.isBefore(dt2)){
      print("DT1 is before DT2");
      return timeIsOkay;
    }
    if(dt1.isAfter(dt2)){
      print("DT1 is after DT2");
      timeIsOkay = false;
      return timeIsOkay;
    }
    return timeIsOkay;
  }

  createAlertDialog(BuildContext context, {required String msg}) {
    final ThemeData themeData = Theme.of(context);
    return showDialog(
        context: context,
        barrierDismissible: false,
        builder: (context){
          return AlertDialog(
            title: Text("Attention", style: themeData.textTheme.headline5,),
            content: SingleChildScrollView(
              scrollDirection: Axis.vertical,
              physics: ClampingScrollPhysics(),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(msg,
                    style: themeData.textTheme.bodyText1,)
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

}