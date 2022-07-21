import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_redux/flutter_redux.dart';
import 'package:healthensuite/api/network.dart';
import 'package:healthensuite/api/networkUtilities.dart';
import 'package:healthensuite/api/networkmodels/interventionlevels/loginobject.dart';
import 'package:healthensuite/api/networkmodels/loginPodo.dart';
import 'package:healthensuite/api/networkmodels/patientProfilePodo.dart';
import 'package:healthensuite/api/statemanagement/actions.dart';
import 'package:healthensuite/api/statemanagement/app_state.dart';
import 'package:healthensuite/screens/home/home_screen.dart';
import 'package:healthensuite/screens/login/forgot_password_email.dart';
import 'package:healthensuite/utilities/constants.dart';
import 'package:healthensuite/models/background.dart';
import 'package:redux/redux.dart';

class LoginScreen extends StatefulWidget {
 bool loginStatus;
 bool dataloaded = false;
 LoginScreen({required this.loginStatus,});

   @override
   _LoginScreenState createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  bool? _rememberMe = false;

  TextEditingController usernamecontroller = TextEditingController();
  TextEditingController passwordcontroller = TextEditingController();

  // LoginPodo? loginDetail1;
   bool? loginStatus;
  bool justLoggedin = false;
  bool isLoading = false;


  Future<PatientProfilePodo>? patientprofile;// Just added 15/07/2022

  @override
  void initState() {
    super.initState();
    //TODO: Confirm voided patients before giving access from backend
    loginStatus = widget.loginStatus;
    print("GOT HERE AT THIS POINT LOGINS STATUS : $loginStatus : : : : : :  JUST LOGIN : $justLoggedin");
    if(loginStatus == true && justLoggedin == false ) {
      print("LOGIN STATUS : $loginStatus");
      print("JUST LOGIN STATUS : $justLoggedin");
      print("DATA LOADED STATUS : ${widget.dataloaded}");
      WidgetsBinding.instance.addPostFrameCallback((_) async{
        Future<PatientProfilePodo> profile = ApiAccess().getPatientProfile(null);
        patientprofile = profile;
        profile.then((value) =>
        {
          if (value != null && value.firstName != null) {
            setState((){
              widget.dataloaded = true;
            }),
            print("Widget check here : ${widget.dataloaded}" ),
            StoreProvider.of<AppState>(context).dispatch(UpdatePatientProfileAction(value)),
            Navigator.push(context, new MaterialPageRoute(
                builder: (context) => HomeScreen(timedout: true)))
          }
        });
      });
    }
  }

  Widget getLoginScreen(){
    return Container(height: double.infinity,
      child: SingleChildScrollView(
        physics: AlwaysScrollableScrollPhysics(),
        padding: EdgeInsets.symmetric(
          horizontal: 40.0,
          vertical: 120.0,
        ),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            Text(
              'Patient Sign In',
              style: TextStyle(
                color: Colors.white,
                fontFamily: 'Montserrat',
                fontSize: 30.0,
                fontWeight: FontWeight.bold,
              ),
            ),
            SizedBox(height: 30.0),
            _buildEmailTF(),
            SizedBox(
              height: 30.0,
            ),
            _buildPasswordTF(),
            _buildForgotPasswordBtn(),
            _buildRememberMeCheckbox(),
            _buildLoginBtn(),
          ],
        ),
      ),);
  }

  Widget _buildEmailTF() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: <Widget>[
        Text(
          'Username',
          style: kLabelStyle,
        ),
        SizedBox(height: 10.0),
        Container(
          alignment: Alignment.centerLeft,
          decoration: kBoxDecorationStyle,
          height: 60.0,
          child: TextField(
            keyboardType: TextInputType.emailAddress,
            style: TextStyle(
              color: Colors.white,
              fontFamily: 'Montserrat',
            ),
            decoration: InputDecoration(
              border: InputBorder.none,
              contentPadding: EdgeInsets.only(top: 14.0),
              prefixIcon: Icon(
                Icons.person_sharp,
                color: Colors.white,
              ),
              hintText: 'Enter your Username',
              hintStyle: kHintTextStyle,
            ),
            controller: usernamecontroller,
          ),
        ),
      ],
    );
  }

  Widget _buildPasswordTF() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: <Widget>[
        Text(
          'Password',
          style: kLabelStyle,
        ),
        SizedBox(height: 10.0),
        Container(
          alignment: Alignment.centerLeft,
          decoration: kBoxDecorationStyle,
          height: 60.0,
          child: TextField(
            obscureText: true,
            style: TextStyle(
              color: Colors.white,
              fontFamily: 'Montserrat',
            ),
            decoration: InputDecoration(
              border: InputBorder.none,
              contentPadding: EdgeInsets.only(top: 14.0),
              prefixIcon: Icon(
                Icons.lock,
                color: Colors.white,
              ),
              hintText: 'Enter your Password',
              hintStyle: kHintTextStyle,
            ),
            controller: passwordcontroller,
          ),
        ),
      ],
    );
  }

  Widget _buildForgotPasswordBtn() {
    return Container(
      alignment: Alignment.centerRight,
      child: TextButton(
        onPressed: ()  {Navigator.push(
            context, new MaterialPageRoute(builder: (context) => AuthScreenEmail())
        );},
        // padding: EdgeInsets.only(right: 0.0),
        child: Text(
          'Forgot your Password?',
          style: kLabelStyle,
        ),
      ),
    );
  }

  Widget _buildRememberMeCheckbox() {
    return Container(
      height: 20.0,
      child: Row(
        children: <Widget>[
          Theme(
            data: ThemeData(unselectedWidgetColor: Colors.white),
            child: Checkbox(
              value: _rememberMe,
              checkColor: Colors.blueAccent,
              activeColor: Colors.white,
              onChanged: (value) {
                setState(() {
                  _rememberMe = value;
                });
              },
            ),
          ),
          Text(
            'Remember me',
            style: kLabelStyle,
          ),
        ],
      ),
    );
  }

  Widget _buildLoginBtn() {
    return  Container(
      padding: EdgeInsets.symmetric(vertical: 25.0),
      width: double.infinity,
      child: ElevatedButton(
        style: ElevatedButton.styleFrom(
          primary: Colors.white, // background
          //onPrimary: Colors.red, // foreground
          elevation: 5.0,
          padding: EdgeInsets.all(15.0),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(30.0),
          ),
        ),
        onPressed: ()  {
          String un = usernamecontroller.value.text.trim();
          String pass = passwordcontroller.value.text.trim();
          // 04/07/2022 START
          // LoginPodo login = LoginPodo(showLoginloading: true);
          // StoreProvider.of<AppState>(context).dispatch(UpdateLoginPodoAction(login));
         // Future<LoginObject> loginObject =  ApiAccess().login(username: un, password: pass);
          Future<PatientProfilePodo>? profile =  ApiAccess().login(username: un, password: pass);

          setState(() {
            justLoggedin = true;
          });

          Timer.periodic(Duration(seconds: timeout_duration), (timer){
            profile!.then((value) => {
              StoreProvider.of<AppState>(context).dispatch(UpdatePatientProfileAction(value)),
              setState((){
                widget.dataloaded = true;
              }),
              timer.cancel(),
              Navigator.push(context, new MaterialPageRoute(builder: (context) => HomeScreen(timedout: true, showdisclaimer: true, )))
            });
            timer.cancel();
            if (timer.tick == 1) {
              timer.cancel();
              showAlertDialog(
                  context: context,
                  title: "Failed Login",
                  message: "Login failed kindly check your login credentials and try again. If you have withdrawn from this program at any point, kindly contact the research team ",
                  gotTologin: false);
              // showAlertDialog(
              //     context,
              //     "Login failed kindly check your login credentials and try again. "
              //         "If you have withdrawn from this program at any point, kindly contact the research team ", "Failed Login");
            }
            {
              timer.cancel();
            }
          });
       // Navigator.push(context, new MaterialPageRoute(builder: (context) => HomeScreen(futureProfile: profile, timedout: true )));
        },
        child: Text(
          'LOGIN',
          style: TextStyle(
            color: appItemColorBlue,
            // color: Color(0xFF527DAA),
            letterSpacing: 1.5,
            fontSize: 18.0,
            fontWeight: FontWeight.bold,
            fontFamily: 'Montserrat',
          ),
        ),
      ),

    );
  }

  //
  // showAlertDialog(BuildContext context, String msg, String title) {
  //
  //   // set up the button
  //   Widget okButton = TextButton(
  //     child: Text("OK"),
  //     onPressed: () {
  //       setState(() {
  //         justLoggedin = false;
  //       });
  //       // StoreProvider.of<AppState>(context).dispatch(UpdateLoginPodoAction(LoginPodo(showLoginloading: false)));
  //       Navigator.of(context).pop();
  //     },
  //   );
  //
  //   // set up the AlertDialog
  //   AlertDialog alert = AlertDialog(
  //     title: Text(title),
  //     content: Text(msg),
  //     actions: [
  //       okButton,
  //     ],
  //   );
  //
  //   // show the dialog
  //   showDialog(
  //     context: context,
  //     builder: (BuildContext context) {
  //       return alert;
  //     },
  //   );
  // }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: AnnotatedRegion<SystemUiOverlayStyle>(
        value: SystemUiOverlayStyle.light,
        child: GestureDetector(
          onTap: () => FocusScope.of(context).unfocus(),
          child: Stack(fit: StackFit.expand,
            children: <Widget>[
              new Background("assets/images/back-img.jpg"),
             widget.loginStatus == true && justLoggedin == false ? FutureBuilder<PatientProfilePodo>(
                future: patientprofile,
                builder: (BuildContext context, AsyncSnapshot<PatientProfilePodo> snapshot){
                  Timer.periodic(Duration(seconds: timeout_duration), (timer){
                      print(" STEP 1");
                      print("Ticker Value : ${timer.tick}");
                    if (timer.tick == 1) {
                      print(" STEP 2");
                        if (snapshot.hasData) {
                          print(" STEP 3");
                          timer.cancel();
                        } else {
                          print(" STEP 4");
                          print(" SNAPSHOT STATE IS : ${snapshot.connectionState}");
                          print(" Data Loaded is A ?  : ${widget.dataloaded}");
                          if(widget.dataloaded == false){
                            timer.cancel();
                            showAlertDialog(context: context,
                                title: "Failed Login",
                                message: "Couldn't login at this point, kindly wait for few minutes and try again",
                                gotTologin: true);
                          }else{
                            timer.cancel();
                          }
                          // showAlertDialog(context: context,
                          //     title: "Failed Login",
                          //     message: "Couldn't login at this point, kindly wait for few minutes and try again",
                          //     gotTologin: true);
                        }
                    }
                    // else if (timer.tick >= 1 ){
                    //   if(widget.dataloaded == true){
                    //     timer.cancel();
                    //   }else{
                    //     timer.cancel();
                    //         showAlertDialog(context: context,
                    //             title: "Failed Login",
                    //             message: "Couldn't login at this point, kindly wait for few minutes and try again",
                    //             gotTologin: true);
                    //   }
                    //   //timer.cancel();
                    //    print("THE CONNECTION STATE IS : ${snapshot.connectionState}");
                    //    print("DOES IT HAVE DATA ? : ${snapshot.hasData}");
                    //    print("TIMER IS DATA ? : ${widget.dataloaded}");
                    //
                    // }
                  });
                  if(snapshot.hasData ){
                    print(" STEP 5");
                    if(snapshot.data == null || snapshot.data!.firstName == null){
                      print(" STEP 6");
                     // tm.cancel();
                      return getLoginScreen();
                    }else{
                      print(" STEP 7");
                     // tm.cancel();
                      return Container(
                        child: Center(child: CircularProgressIndicator(),),
                      );
                    }
                  }else{
                    print(" STEP 8");
                   // tm.cancel();
                    return Container(
                       child: Center(child: CircularProgressIndicator(),),
                    );
                  }
                },
              ) : widget.loginStatus == false && justLoggedin == false ? getLoginScreen() : Container(
               child: Center(child: CircularProgressIndicator(),),
             )
            ],
          ),
        ),
      ),
    );
  }


  showAlertDialog({required BuildContext context, required String title, required String message, required bool gotTologin}) {

    // set up the button
    Widget okButton = TextButton(
      child: Text("OK"),
      onPressed: () {
        if(gotTologin == true) {
          Navigator.of(context).push(MaterialPageRoute(
              builder: (context) => LoginScreen(loginStatus: false,)));
        }else{
          setState(() {
            justLoggedin = false;
          });
          // StoreProvider.of<AppState>(context).dispatch(UpdateLoginPodoAction(LoginPodo(showLoginloading: false)));
          Navigator.of(context).pop();
        }
      },
    );

    // set up the AlertDialog
    AlertDialog alert = AlertDialog(
      // title: Text("My title"),
      title: Text(title),
      content: Text(message),
      actions: [
        okButton,
      ],
    );

    // show the dialog
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return alert;
      },
    );
  }
}

