import 'package:email_validator/email_validator.dart';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:flutter/services.dart';
import 'package:flutter_form_builder/flutter_form_builder.dart';
import 'package:flutter_redux/flutter_redux.dart';
import 'package:healthensuite/api/networkmodels/patientProfilePodo.dart';
import 'package:healthensuite/api/statemanagement/app_state.dart';
import 'package:healthensuite/utilities/constants.dart';
import 'package:healthensuite/utilities/drawer_navigation.dart';
import 'row_item.dart';
import 'package:healthensuite/models/icon_button.dart';
import 'row_item_edit.dart';
import 'patient_name.dart';


class PatientScreen extends StatefulWidget{

  final Function? onMenuTap;
  // final String? name;
  // final String? email;

  static final String title = 'My Profile';

//  final Future<PatientProfilePodo>? patientProfile;

 // const PatientScreen({Key? key, this.onMenuTap,  required this.patientProfile}) : super(key: key);
  const PatientScreen({Key? key, this.onMenuTap}) : super(key: key);

  @override
  _PatientScreenState createState() => _PatientScreenState();
}

class _PatientScreenState extends State<PatientScreen> {

  final _emailFormKey = GlobalKey<FormBuilderState>();
  final _passwordFormKey = GlobalKey<FormBuilderState>();

  bool isObs = false;
  @override
  Widget build(BuildContext context) {
   // Future<PatientProfilePodo>?  profile = widget.patientProfile;
    return Scaffold(
      drawer: NavigationDrawerWidget(indexNum: 1),
      appBar: AppBar(
          title: Text(PatientScreen.title),
          centerTitle: true,
        ),
      body:  getContent()

      // body:  FutureBuilder<PatientProfilePodo>(
      //   future: profile,
      //   builder: (BuildContext context, AsyncSnapshot<PatientProfilePodo> snapshot){
      //     if(snapshot.hasData){
      //       PatientProfilePodo profileData = snapshot.data!;
      //       return getContent(profile: profileData);
      //     }else{
      //       return Container(
      //         child: Center(child: CircularProgressIndicator(),),
      //       );
      //     }
      //   },
      // ),
    );
  }

  //Container getContent({required PatientProfilePodo profile}){
  Container getContent(){
    final sidePad = EdgeInsets.symmetric(horizontal: 2);
    return Container(
      child: StoreConnector<AppState, PatientProfilePodo>(
        converter: (store) => store.state.patientProfilePodo,
        builder: (context, PatientProfilePodo patientprofile) => Container(
          decoration: BoxDecoration(
            borderRadius: BorderRadius.all(Radius.circular(40)),
            color: appBodyColor,
          ),
          child: SingleChildScrollView(
            scrollDirection: Axis.vertical,
            physics: ClampingScrollPhysics(),
            child: Container(
              padding: const EdgeInsets.only(left: 16, right: 16, top: 48),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: <Widget>[
                  SizedBox(height: 10),
                  Center(
                    child: CircleAvatar(
                      //backgroundColor: Colors.white,
                      radius: 40.0,
                      backgroundImage: AssetImage('assets/images/form-user.jpg'),
                    ),
                  ),
                  Divider(
                    color: appItemColorBlue,
                    height: 60.0,
                  ),
                //  PatientName(patientNameText: widget.name, buttonEvent: (){},),
                  PatientName(patientNameText: "${patientprofile.firstName} ${patientprofile.lastName}", buttonEvent: (){},),

                  SizedBox(height: 30.0),

                  RowItem(rowIcon: Icons.house, rowText: "No Address in Profile",),

                  SizedBox(height: 30.0),
                 // RowItem(rowIcon: Icons.phone_android, rowText: "902-111-3333",),
                  RowItem(rowIcon: Icons.phone_android, rowText: "${patientprofile.phoneNumber}",),


                  SizedBox(height: 20.0),
                //  RowItemEdit(rowIcon: Icons.email, rowText: widget.email, buttonIcon: Icons.edit, buttonEvent: (){},),
                  RowItemEdit(rowIcon: Icons.email, rowText: "${patientprofile.email}", buttonIcon: Icons.edit,
                    buttonEvent: (){
                      createAlertDialog(context, sidePad,
                        dialogFormKey: _emailFormKey,
                        question1: "Current Email Address",
                        fieldName1: "curEmail",
                        question2: "New Email Address",
                        fieldName2: "newEmail",
                        question3: "Re-enter New Email Address",
                        fieldName3: "reNewEmail",
                        initVal: patientprofile.email.toString(),
                        isObscure: false,
                        validatorTxt: "CheckEmail",
                        textInputType: TextInputType.emailAddress,
                        otherInitVal: "",
                        dialogHeaderTxt: "Update Email",
                        isEmail: true,
                        errorMsg: "New Email does not match. Please re-type it and try again.",
                      );
                    },
                  ),


                  SizedBox(height: 20.0),

                  IconUserButton(buttonText: "Change Password", buttonIcon: Icons.edit,
                    buttonEvent: () {
                      createAlertDialog(context, sidePad,
                        dialogFormKey: _passwordFormKey,
                        question1: "Current Password",
                        fieldName1: "curPassword",
                        question2: "New Password",
                        fieldName2: "newPassword",
                        question3: "Re-enter New Password",
                        fieldName3: "reNewPassword",
                        initVal: "",
                        validatorTxt: "CheckPassword",
                        textInputType: TextInputType.visiblePassword,
                        isObscure: true,
                        otherInitVal: "",
                        dialogHeaderTxt: "Update Password",
                        isEmail: false,
                        errorMsg: "New Password does not match. Please re-type it and try again.",
                      );
                    },
                  ),


                ],
              ),
            ),
          ),

        ),
      ),
    );
  }

  createAlertDialog(BuildContext context, EdgeInsets sidePad,
      {required GlobalKey<FormBuilderState> dialogFormKey,
        required String question1, required String fieldName1,
        required String question2, required String fieldName2,
        required String question3, required String fieldName3,
        required String initVal, required String validatorTxt,
        required TextInputType textInputType, required String otherInitVal,
        required String dialogHeaderTxt, required String errorMsg,
        required bool isObscure, required bool isEmail}){
    final ThemeData themeData = Theme.of(context);
    double pad = 28;
    return showDialog(
        context: context,
        barrierDismissible: false,
        builder: (context){
          return AlertDialog(
            title: Text(dialogHeaderTxt, style: themeData.textTheme.labelMedium,),
            content: FormBuilder(
              key: dialogFormKey,
              child: SingleChildScrollView(
                scrollDirection: Axis.vertical,
                physics: ClampingScrollPhysics(),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    textInput(sidePad, themeData, question: question1, fieldName: fieldName1,
                        initVal: initVal, validatorTxt: validatorTxt, textInputType: textInputType,
                        isObscure: isObscure),
                    SizedBox(height: pad,),
                    textInput(sidePad, themeData, question: question2, fieldName: fieldName2,
                        initVal: otherInitVal, validatorTxt: validatorTxt, textInputType: textInputType,
                        isObscure: isObscure),
                    SizedBox(height: pad,),
                    textInput(sidePad, themeData, question: question3, fieldName: fieldName3,
                        initVal: otherInitVal, validatorTxt: validatorTxt, textInputType: textInputType,
                        isObscure: isObscure),
                  ],
                ),
              ),
            ),
            actions: [
              MaterialButton(
                  child: Text("Cancel", style: TextStyle(fontWeight: FontWeight.w700),),
                  onPressed: (){
                    Navigator.of(context).pop();
                  }
              ),
              MaterialButton(
                  child: Text("Save Changes", style: TextStyle(color: appItemColorBlue, fontWeight: FontWeight.w700),),
                  onPressed: (){
                    validateForm(dialogFormKey, context,
                        valName1: fieldName1,
                        valName2: fieldName2,
                        valName3: fieldName3,
                        errorMsg: errorMsg,
                        isEmail: isEmail
                    );
                    // Navigator.of(context).pop();
                  }
              ),
            ],
          );
        });
  }

  Padding textInput(EdgeInsets sidePad, ThemeData themeData,
      {required String question, required String fieldName,
      required String initVal, required String validatorTxt,
      required TextInputType textInputType, required bool isObscure}) {
    bool isEmail(String input) => EmailValidator.validate(input);
    return Padding(
      padding: sidePad,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(question,
            style: themeData.textTheme.headline5,),
          FormBuilderTextField(
            name: fieldName,
            style: themeData.textTheme.bodyText1,
            keyboardType: textInputType,
            initialValue: initVal,
            obscureText: isObscure,
            decoration: InputDecoration(),
            validator: (value) {
              String? msg = "";
              if (validatorTxt == "CheckEmail") {
                if(value!.isEmpty || !isEmail(value)){
                  msg = "Invalid email address";
                  return msg;
                }
              }else{
                if(value!.isEmpty || value.length < 6){
                  msg = "Enter at least 6 characters";
                  return msg;
                }
              }
            },
            autovalidateMode: AutovalidateMode.onUserInteraction,
          ),
        ],
      ),
    );
  }

  // Padding passwordTextInput(EdgeInsets sidePad, ThemeData themeData,
  //     {required String question, required String fieldName,
  //       required String initVal, required String validatorTxt,
  //       required TextInputType textInputType, required bool isObscure}) {
  //   bool isEmail(String input) => EmailValidator.validate(input);
  //   return Padding(
  //     padding: sidePad,
  //     child: Column(
  //       crossAxisAlignment: CrossAxisAlignment.start,
  //       children: [
  //         Text(question,
  //           style: themeData.textTheme.headline5,),
  //         FormBuilderTextField(
  //           name: fieldName,
  //           style: themeData.textTheme.bodyText1,
  //           keyboardType: textInputType,
  //           initialValue: initVal,
  //           obscureText: isObs,
  //           decoration: InputDecoration(
  //             labelText: 'Password',
  //             hintText: 'Enter your password',
  //             // Here is key idea
  //             suffixIcon: IconButton(
  //               icon: Icon(
  //                 // Based on passwordVisible state choose the icon
  //                 isObs
  //                     ? Icons.visibility
  //                     : Icons.visibility_off,
  //                 color: Theme.of(context).primaryColorDark,
  //               ),
  //               onPressed: () {
  //                 // Update the state i.e. toogle the state of passwordVisible variable
  //                 setState(() {
  //                   isObs = !isObs;
  //                 });
  //               },
  //             ),
  //           ),
  //           validator: (value) {
  //             String? msg = "";
  //             if (validatorTxt == "CheckEmail") {
  //               if(value!.isEmpty || !isEmail(value)){
  //                 msg = "Invalid email address";
  //                 return msg;
  //               }
  //             }else{
  //               if(value!.isEmpty || value.length < 6){
  //                 msg = "Enter at least 6 characters";
  //                 return msg;
  //               }
  //             }
  //           },
  //           autovalidateMode: AutovalidateMode.onUserInteraction,
  //         ),
  //       ],
  //     ),
  //   );
  // }

  void validateForm(GlobalKey<FormBuilderState> key,  BuildContext context, {required String valName1,
    required String valName2, required String valName3, required String errorMsg, required bool isEmail}){
    if (key.currentState!.saveAndValidate()){
      print(key.currentState!.value);
      String? txtField1 = key.currentState!.fields[valName1]!.value;
      String? txtField2 = key.currentState!.fields[valName2]!.value;
      String? txtField3 = key.currentState!.fields[valName3]!.value;

      if(txtField2 == txtField3){
        //TODO This is the echoed data
        print("TxtField1: $txtField1, \nTxtField2: $txtField2, \nTxtField3: $txtField3");
        if(isEmail){
          //TODO Enter the email update function here
          Navigator.of(context).pop();
        }else{
          //TODO Enter the password update function here
          Navigator.of(context).pop();
        }
      }else{
        simpleAlertDialog(context, msg: errorMsg);
      }
    }else{
      simpleAlertDialog(context, msg: "All fields are not properly filled.");
      print("All fields are not properly filled!!!");
    }
  }

  simpleAlertDialog(BuildContext context, {required String msg}) {
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