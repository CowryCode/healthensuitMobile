
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
                          timeOfDay: TimeOfDay(hour: 19, minute: 0),
                          question: "1. What time did you get into bed last night? (Required)",
                          valName: "inBed"),
                      // timeQuestion(sidePad, themeData, context, bedtime,
                      //     question: "What time did you get into bed last?",
                      //     valName: "inBed"),

                      SizedBox(height: pad,),

                      timeQuestion(sidePad, themeData, context,
                          timeOfDay: TimeOfDay(hour: 19, minute: 30),
                          question: "2. What time did you try to go to sleep? (Required)",
                          valName: "tryBed"),
                      // timeQuestion(sidePad, themeData, context, trySleepTime,
                      //     question: "What time did you try to go to sleep?",
                      //     valName: "tryBed"),

                      SizedBox(height: pad,),

                      hourMinute(sidePad, themeData, hours, minutes,
                          question: "3. How long did it take you to fall asleep? (Please select hour then minute)",
                          hrValName: "hrs1", mnValName: "mns1"),

                      SizedBox(height: pad,),

                      numberInput(sidePad, themeData, wakeupCount!,
                          question: "4. How many times did you wake up, not counting your final awakening? (Required)",
                          valName: "wakeTimes"),

                      SizedBox(height: pad,),

                      hourMinute(sidePad, themeData, hours, minutes,
                          question: "5. In total, how long did these awakenings last? (Please select hour then minute)",
                          hrValName: "hrs2", mnValName: "mns2"),

                      SizedBox(height: pad,),

                      timeQuestion(sidePad, themeData, context,
                          timeOfDay: TimeOfDay(hour: 5, minute: 0),
                          question: "6. What time was your final awakening? (Required)",
                          valName: "finAwake"),
                      // timeQuestion(sidePad, themeData, context, finalWakeupTime,
                      //     question: "What time was your final awakening?",
                      //     valName: "finAwake"),

                      SizedBox(height: pad,),

                      timeQuestion(sidePad, themeData, context,
                          timeOfDay: TimeOfDay(hour: 5, minute: 30),
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
                  // validator: FormBuilderValidators.compose(
                  //     [FormBuilderValidators.required(context,
                  //     errorText: "Hour is required")]),
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
                  // validator: FormBuilderValidators.compose(
                  //     [FormBuilderValidators.required(context,
                  //         errorText: "Minute is required")]),
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
      {required TimeOfDay timeOfDay, required String question, required String valName}) {
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

      extraMedFieldIsOkay = validateExtraMedOptions(_formKey);
      if(!extraMedFieldIsOkay){
        return;
      }
      print(key.currentState!.value);

      DateFormat dateFormat = DateFormat("hh:mm a");

      String? bedTime = key.currentState!.fields["inBed"]!.value.toString();
      bedTime = dateFormat.format(DateTime.parse(bedTime));
      String? tryTosleepTime = key.currentState!.fields["tryBed"]!.value.toString();
      tryTosleepTime = dateFormat.format(DateTime.parse(tryTosleepTime));
      String durationBeforesleepoffHOUR = key.currentState!.fields["hrs1"]!.value.toString();
      String durationBeforesleepoffMINUTES = key.currentState!.fields["mns1"]!.value.toString();
      double durationB4sleep = double.parse(
          durationBeforesleepoffHOUR + "." + durationBeforesleepoffMINUTES);
      int wakeUptimeCount = int.parse(
          key.currentState!.fields["wakeTimes"]!.value);
      String totalWakeUpdurationHOUR = key.currentState!.fields["hrs2"]!.value.toString();
      String totalWakeUpdurationMINUTE = key.currentState!.fields["mns2"]!.value.toString();
      double awakeningDurations = double.parse(
          totalWakeUpdurationHOUR + "." + totalWakeUpdurationMINUTE);
      String? finalWakeupTime = key.currentState!.fields["finAwake"]!.value.toString();
      finalWakeupTime = dateFormat.format(DateTime.parse(finalWakeupTime));
      String? timeLeftbed = key.currentState!.fields["outBed"]!.value.toString();
      timeLeftbed = dateFormat.format(DateTime.parse(timeLeftbed));
      String? slpQuality = key.currentState!.fields["spQuality"]!.value;
      String? drugAmount1 = key.currentState!.fields["drNum1"]!.value;
      String? drugAmount2 = key.currentState!.fields["drNum2"]!.value;
      String? newMedname = key.currentState!.fields["medName1"]!.value;
      String? newMedamount = key.currentState!.fields["amTaken1"]!.value;
      String? newMedname2 = key.currentState!.fields["medName2"]!.value;
      String? newMedamount2 = key.currentState!.fields["amTaken2"]!.value;
      String? newMedname3 = key.currentState!.fields["medName3"]!.value;
      String? newMedamount3 = key.currentState!.fields["amTaken3"]!.value;
      String? otherThings = key.currentState!.fields["otherNote"]!.value;

      bool sleepTimeIsOkay = compareTimeSelected(bedTime, tryTosleepTime);
      bool sleepAndAwakeTimeIsOkay = compareTimeSelected(tryTosleepTime, finalWakeupTime);
      bool wakeTimeIsOkay = compareTimeSelected(finalWakeupTime, timeLeftbed);

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
        print("BetTime: $bedTime, \nTryToSleepTime: $tryTosleepTime, "
            "\nTakeYouToSleep: $durationB4sleep, \nTimesWakeUpCount: $wakeUptimeCount, "
            "\nWakeUpDurationTime: $awakeningDurations, \nFinalWakeupTime: $finalWakeupTime, "
            "\nTimeLeftbed: $timeLeftbed, \nSlpQuality: $slpQuality, "
            "\nDrugAmount1: $drugAmount1, \nDrugAmount2: $drugAmount2, "
            "\nNewMedname1: $newMedname, \nNewMedamount1: $newMedamount, "
            "\nNewMedname2: $newMedname2, \nNewMedamount2: $newMedamount2, "
            "\nNewMedname3: $newMedname3, \nNewMedamount3: $newMedamount3, "
            "\nOtherThings: $otherThings");
      }

      // if(bedTime == "Select Time (Required)"){
      //   bedTime = widget.sleepDiariesPODO.bedTime;
      // }
      //
      // if(tryTosleepTime == "Select Time (Required)"){
      //   tryTosleepTime = widget.sleepDiariesPODO.tryTosleepTime;
      // }
      //
      // if (durationBeforesleepoffHOUR == null ||
      //     durationBeforesleepoffMINUTES == null) {
      //   durationB4sleep = widget.sleepDiariesPODO.durationBeforesleepoff ?? 0.0;
      // } else {
      //   durationB4sleep = double.parse(
      //       durationBeforesleepoffHOUR + "." + durationBeforesleepoffMINUTES);
      // }
      //
      // // "In total, how long did these awakenings last?"
      //
      // if (totalWakeUpdurationHOUR == null ||
      //     totalWakeUpdurationMINUTE == null) {
      //   awakeningDurations = widget.sleepDiariesPODO.totalWakeUpduration ?? 0.0;
      // } else {
      //   awakeningDurations = double.parse(
      //       totalWakeUpdurationHOUR + "." + totalWakeUpdurationMINUTE);
      // }
      // // "Sleep quality"
      // var sleepQuality = slpQuality ?? widget.sleepDiariesPODO.sleepQuality;
      //
      //
      // if(finalWakeupTime == "Select Time (Required)"){
      //   finalWakeupTime = widget.sleepDiariesPODO.finalWakeupTime;
      // }
      //
      // if(timeLeftbed == "Select Time (Required)"){
      //   timeLeftbed = widget.sleepDiariesPODO.timeLeftbed;
      // }
      //
      // OtherMedicationsEntity? othermed;
      //
      // if(moreDrugIsVisible == true){
      //   var newMedname = key.currentState!.fields["medName1"]!.value;
      //   var newMedamount = key.currentState!.fields["amTaken1"]!.value;
      //   if(newMedname != null && newMedamount != null){
      //     othermed = OtherMedicationsEntity();
      //     othermed.setOthermedicationFields(newMedname, newMedamount);
      //
      //   }
      // }
      //
      // Medications? med1 = Workflow().getMedications(
      //     widget.sleepDiariesPODO.medications, isfirstmedication: true,
      //     isSecondmedication: false);
      // Medications? med2 = Workflow().getMedications(
      //     widget.sleepDiariesPODO.medications, isfirstmedication: false,
      //     isSecondmedication: true);
      //
      // // print("Medication 1 ID is : ${med1!.id}");
      // // print("Medication 2 ID is : ${med2!.id}");
      //
      //  List<Medications> currentMeds = List.filled(
      //      2, new Medications(), growable: true);
      //
      // if (med1 != null) {
      //   currentMeds.clear();
      //   drugAmount1 = key.currentState!.fields["drNum1"]!.value;
      //   if (drugAmount1 != null) {
      //     med1.setDrugAmount(drugAmount1);
      //     currentMeds.add(med1);
      //   }
      //   if (med2 != null) {
      //     drugAmount2 = key.currentState!.fields["drNum2"]!.value;
      //     if (drugAmount2 != null) {
      //       med2.setDrugAmount(drugAmount2);
      //       currentMeds.add(med2);
      //     }
      //   }
      //   widget.sleepDiariesPODO.updateCurrentmeds(currentMeds);
      // }
      //
      // widget.sleepDiariesPODO.updateVariable(
      //     bedTime,
      //     tryTosleepTime,
      //     durationB4sleep,
      //     wakeUptimeCount,
      //     awakeningDurations,
      //     finalWakeupTime,
      //     timeLeftbed,
      //     sleepQuality,
      //     otherThings,
      //     othermed
      // );
      //
      // Future<SleepDiariesPODO> savedSleepDiary = ApiAccess().saveSleepDiaries(
      //     sleepDiary: widget.sleepDiariesPODO);
      //
      // PatientProfilePodo patientProfilePodo = StoreProvider.of<AppState>(context).state.patientProfilePodo;
      // patientProfilePodo.updateSleepDiary(widget.sleepDiariesPODO);
      //
      // StoreProvider.of<AppState>(context).dispatch(UpdatePatientProfileAction(patientProfilePodo));
      //
      // print("Bed : $bedTime , "
      //     "Try to sleep : $tryTosleepTime , "
      //     "Sleep Quality : $sleepQuality , "
      //     "Wake up count : $wakeUptimeCount ,"
      //     " Final Wake up : $finalWakeupTime ,"
      //     "Time Left Bed : $timeLeftbed , "
      //     "Awakening Duration : $awakeningDurations"
      //     "Current Med 1 Amount : $drugAmount1 , "
      //     "Current Med 2 amount : $drugAmount2 , "
      //     "Duration before sleep $durationB4sleep "
      //     // "New Med Name : $newMedname ,"
      //     // " New Med Amount : $newMedamount ,"
      //     " Other things : $otherThings");
      //
      // print(
      //     "::::::::::::::::::::::::::::::::: SAVED ITEMS ::::::::::::::::::::::::::::::::::::::::::::::::::::");
      // savedSleepDiary.then((value) =>
      // {     print("Bed : ${value.bedTime} , Try to sleep : ${value.tryTosleepTime} , "
      //       "Sleep Quality : ${value.sleepQuality} , Wake up count : ${value
      //       .wakeUptimeCount} , Final Wake up : ${value.finalWakeupTime} ,"
      //       "Time Left Bed : ${value
      //       .timeLeftbed}, Current Med 1 Amount : , Awakening Duration : ${value
      //       .totalWakeUpduration} "
      //       "Current Med 2 amount : , Duration before sleep ${value.bedTime} "
      //       "New Med Name : , New Med Amount : , Other things : "),
      //   Navigator.push(context, new MaterialPageRoute(builder: (context) => HomeScreen()))
      //
      // });
    }else{
      createAlertDialog(context,
          msg: "All required fields are not properly filled. Please review and fill the required fields");
      print("All fields are not properly filled!!!");
    }
  }

  bool compareTimeSelected(String firstTime, String secondTime){
    bool timeIsOkay = true;

    DateFormat dateFormat = DateFormat("yyyy-MM-dd hh:mm a");

    DateTime dt1 = dateFormat.parse("0001-01-01 "+ firstTime);
    DateTime dt2 = DateTime.now();
    if(firstTime.contains('PM') && secondTime.contains('AM')){
      dt2 = dateFormat.parse("0001-01-02 "+ secondTime);
    }else{
      dt2 = dateFormat.parse("0001-01-01 "+ secondTime);
    }

    // if(dt1.compareTo(dt2) == 0){
    //   print("Both date time are at same moment.");
    // }
    // if(dt1.compareTo(dt2) < 0){
    //   print("DT1 is before DT2");
    // }

    if(dt1.isBefore(dt2)){
      print("DT1 is before DT2");
      return timeIsOkay;
    }

    // if(dt1.compareTo(dt2) > 0){
    //   print("DT1 is after DT2");
    // }
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