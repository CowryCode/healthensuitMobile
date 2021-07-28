import 'package:flutter/material.dart';
import 'package:flutter_form_builder/flutter_form_builder.dart';
import 'package:healthensuite/utilities/constants.dart';
import 'package:healthensuite/utilities/text_data.dart';
import 'package:healthensuite/models/icon_button.dart';


class MyChoice{
  String? choice;
  String? choiceValue;
  int? index;
  MyChoice({this.choice, this.index, this.choiceValue});
}


class Level1of7 extends StatefulWidget {

  static final String title = 'Level 1';
  static final sidePad = EdgeInsets.symmetric(horizontal: 18);
  

  @override
  _Level1of7State createState() => _Level1of7State();
}

class _Level1of7State extends State<Level1of7> {
  String patientName = "Henry";
  bool radioAloneIsVisible = false;
  bool radioRoomateIsVisible = false;
  bool formFieldIsVisible = false;
  int? defaultIndexbase = -1;
  int? defaultIndexAlone = -1;
  int? defaultIndexRoomate = -1; 
  
  static final _formKey = GlobalKey<FormBuilderState>();

  @override
  Widget build(BuildContext context) {
    final Size size = MediaQuery.of(context).size;
    final ThemeData themeData = Theme.of(context);
    double pad = 18;

    return Scaffold(
      appBar: AppBar(
        title: Text(Level1of7.title),
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
                reverse: true,
                child: Column(
                   crossAxisAlignment: CrossAxisAlignment.start,
                   children: [
                     SizedBox(height: pad,),
                     sectionTitleWidget(themeData, text: "Getting support and involving your partner", textStyle: themeData.textTheme.headline4),
                     bodyTextWidget(themeData, text: LEVEL1_DATA["bullet21"]!),

                     SizedBox(height: pad,),
                     sectionTitleWidget(themeData, text: LEVEL1_DATA["subHead4"]!, textStyle: themeData.textTheme.headline5),
                     bodyTextWidget(themeData, text: LEVEL1_DATA["bullet22"]!),

                     SizedBox(height: pad,),
                     sectionTitleWidget(themeData, text: LEVEL1_DATA["radioQ1"]!, textStyle: themeData.textTheme.headline5),
                     radioButtonBase(themeData),

                    Visibility(child: radioButtonAlone(themeData, context), visible: radioAloneIsVisible,),
                    Visibility(child: radioButtonRoomate(themeData), visible: radioRoomateIsVisible,),
                    SizedBox(height: pad,),
                    Visibility(child: formFieldWidget(themeData), visible: formFieldIsVisible,),

                   ],
                ),
              ),
            ),
          ],
        ),
      ),
    );

  }

  FormBuilder formFieldWidget(ThemeData themeData) {
    return FormBuilder(
                    key: _formKey,
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        sectionTitleWidget(themeData, text: "Fill Support Person Data", textStyle: themeData.textTheme.headline5),
                        Padding(
                          padding: Level1of7.sidePad,
                          child: FormBuilderTextField(
                            name: "supName",
                            style: themeData.textTheme.headline5,
                            decoration: InputDecoration(
                              hintText: "Support Person Name",
                              hintStyle: themeData.textTheme.bodyText2,
                            ),
                          ),
                        ),
                        Padding(
                          padding: Level1of7.sidePad,
                          child: FormBuilderDropdown(
                            name: 'dropdown',
                            hint: Text("My Relationship"),
                            isExpanded: true,
                            items: [
                              "Spouse",
                              "Relative",
                              "Friend",
                              "Roommate",
                            ].map((option) {
                              return DropdownMenuItem(
                                child: Text("$option"),
                                value: option,
                              );
                            }).toList(),
                          ),
                        ),
                        Padding(
                          padding: Level1of7.sidePad,
                          child: FormBuilderTextField(
                            name: "supEmail",
                            style: themeData.textTheme.headline5,
                            keyboardType: TextInputType.emailAddress,
                            decoration: InputDecoration(
                              hintText: "Support Person Email",
                              hintStyle: themeData.textTheme.bodyText2,
                            ),
                          ),
                        ),
                        Center(
                          child: IconUserButton(buttonText: "Submit", buttonEvent: () {}, buttonIcon: Icons.send,),
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
            mainAxisAlignment: MainAxisAlignment.start,
            children: <Widget>[
              navIconButton(context, buttonText: "Back", buttonActon: (){
                Navigator.of(context).pop();
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
                padding: Level1of7.sidePad,
                child: Text('Page 7/7',
                textAlign: TextAlign.left,
                style: themeData.textTheme.bodyText2,),
              ),
              Padding(
                padding: Level1of7.sidePad,
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

  MaterialButton navIconButton(BuildContext context, {required String buttonText, Function? buttonActon}){
    return  MaterialButton(
              child: Text(buttonText, style: TextStyle(color: appItemColorBlue, fontWeight: FontWeight.w700),),
              onPressed: buttonActon as void Function()?,
            );
  }

   Padding sectionTitleWidget(ThemeData themeData, {required String text, TextStyle? textStyle} ) {
     return Padding(
                padding: Level1of7.sidePad,
                child: Text(text,
                  style: textStyle,
                ),
              );
  }

  Padding bodyTextWidget(ThemeData themeData, {required String text}) {
    return Padding(
              padding: Level1of7.sidePad,
              child: Text(text, 
                style: themeData.textTheme.bodyText1,),
            );
  }

  void checkForDoisplay(int i){

  }
  

  Column radioButtonBase(ThemeData themeData){
    
    String? defaultChoiceBase = "";
    List<MyChoice> choices = [
      MyChoice(index: 0, choice: "I sleep alone"),
      MyChoice(index: 1, choice: "I share my bedroom with another person, but I sleep in my own bed."),
      MyChoice(index: 2, choice: "I share a bed with another person."),
    ];

    return Column(
      children: [
        Wrap(
          children: [
            Container(
              child: Column(
                children: choices.map((data) => RadioListTile(
                  title: Text('${data.choice}', style: themeData.textTheme.bodyText1,),
                  groupValue: defaultIndexbase,
                  value: data.index,
                  onChanged: (dynamic value){
                        defaultChoiceBase = data.choice; 
                        defaultIndexbase = data.index; 
                        if(value == 0){
                         setState((){
                            radioAloneIsVisible = true;
                            radioRoomateIsVisible = false;
                            formFieldIsVisible = false;
                          });
                        }
                        else if(value == 1){
                          setState((){
                            radioRoomateIsVisible = true;
                            radioAloneIsVisible = false;
                            formFieldIsVisible = false;
                          });
                        }

                        print('You clicked me: $value');  
                  },
                )).toList(),
              ),
            ),
          ],
        ),
      ],
    );
  }

  Column radioButtonAlone(ThemeData themeData, BuildContext context){
    List<MyChoice> choices = [
      MyChoice(index: 0, choice: "Yes"),
      MyChoice(index: 1, choice: "No"),
    ];
    String? defaultChoice = "";

    return Column(
      children: [
        sectionTitleWidget(themeData, text: LEVEL1_DATA["radioQ2"]!, textStyle: themeData.textTheme.headline5),
        Wrap(
          children: [
            Container(
              child: Column(
                children: choices.map((data) => RadioListTile(
                  title: Text('${data.choice}', style: themeData.textTheme.bodyText1,),
                  groupValue: defaultIndexAlone,
                  value: data.index,
                  onChanged: (dynamic value){
                    defaultChoice = data.choice; 
                    defaultIndexAlone = data.index; 
                    if(value == 0){
                      setState(() {
                        formFieldIsVisible = true;
                        radioRoomateIsVisible = false;
                      });  
                    }
                    else if(value == 1){
                      setState(() {
                        formFieldIsVisible = false;
                      });
                      createAlertDialog(context);
                    }
                    print('You clicked me: $value');
                    
                  },
                )).toList(),
              ),
            ),
          ],
        ),
      ],
    );
  }

  Column radioButtonRoomate(ThemeData themeData){
    List<MyChoice> choices = [
      MyChoice(index: 0, choice: "I would like to nominate this person."),
      MyChoice(index: 1, choice: "I would like to nominate someone else."),
      MyChoice(index: 2, choice: "I do not want to nominate a support person."),
    ];
    String? defaultChoice = "";

    return Column(
      children: [
        sectionTitleWidget(themeData, text: LEVEL1_DATA["radioQ3"]!, textStyle: themeData.textTheme.headline5),
        Wrap(
          children: [
            Container(
              child: Column(
                children: choices.map((data) => RadioListTile(
                  title: Text('${data.choice}', style: themeData.textTheme.bodyText1,),
                  groupValue: defaultIndexRoomate,
                  value: data.index,
                  onChanged: (dynamic value){
                    defaultChoice = data.choice; 
                    defaultIndexRoomate = data.index; 
                    if(value == 0){
                      setState(() {
                        formFieldIsVisible = true;
                        radioAloneIsVisible = false;
                      });  
                    }
                    else if(value == 1){
                      setState(() {
                        formFieldIsVisible = true;
                        radioAloneIsVisible = false;
                      });  
                    }
                    else if(value == 2){
                      setState(() {
                        formFieldIsVisible = false;
                      });
                      createAlertDialog(context);
                    }
                    print('You clicked me: $value');
                  },
                )).toList(),
              ),
            ),
          ],
        ),
      ],
    );
  }


  createAlertDialog(BuildContext context){
     final ThemeData themeData = Theme.of(context);
    return showDialog(
      context: context, 
      barrierDismissible: false,
      builder: (context){
        return AlertDialog(
          title: Text("Remember!", style: themeData.textTheme.headline5,),
          content: Text("Having someone to support you can make changing your thoughts and behaviours easier.", 
          style: themeData.textTheme.bodyText2,),
          actions: [
            MaterialButton(
              child: Text("Go Back", style: TextStyle(color: appItemColorBlue, fontWeight: FontWeight.w700),),
              onPressed: (){
                Navigator.of(context).pop();
              }
            ),
            MaterialButton(
              child: Text("Submit Anyway", style: TextStyle(color: appItemColorBlue, fontWeight: FontWeight.w700),),
              onPressed: (){}
            ),
          ],
        );
      });
  }


}

