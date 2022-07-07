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

 LoginScreen({required this.loginStatus});

  @override
  _LoginScreenState createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  bool? _rememberMe = false;

  TextEditingController usernamecontroller = TextEditingController();
  TextEditingController passwordcontroller = TextEditingController();

  // LoginPodo? loginDetail1;
   bool? loginStatus;

  bool isLoading = false;



  @override
  void initState() {
    super.initState();
    loginStatus = widget.loginStatus;
    // if(loginStatus == true) {
      WidgetsBinding.instance.addPostFrameCallback((_) async {
        PatientProfilePodo? patientprofile = await ApiAccess()
            .getPatientProfile(null);
        if (patientprofile != null && patientprofile.firstName != null) {
          StoreProvider.of<AppState>(context).dispatch(
              UpdatePatientProfileAction(patientprofile));
          Navigator.push(context, new MaterialPageRoute(
              builder: (context) => HomeScreen(timedout: true)));
        }
        //TODO: IMPLEMENT AUTO LOGIN ONCE SIGNED IN
      });
    // }
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
          LoginPodo login = LoginPodo(showLoginloading: true);
          StoreProvider.of<AppState>(context).dispatch(UpdateLoginPodoAction(login));
        //  Future<PatientProfilePodo>? profile =  ApiAccess().login(username: un, password: pass);
          Future<LoginObject> loginObject =  ApiAccess().login(username: un, password: pass);
          Timer.periodic(Duration(seconds: timeout_duration), (timer){
            loginObject.then((value) => {
              StoreProvider.of<AppState>(context).dispatch(UpdatePatientProfileAction(value.getPatientprofile)),
              StoreProvider.of<AppState>(context).dispatch(UpdateLoginPodoAction(value.loginPodo)),
              timer.cancel(),
              Navigator.push(context, new MaterialPageRoute(builder: (context) => HomeScreen(timedout: true )))
            });
            timer.cancel();
            if (timer.tick == 1) {
              timer.cancel();
              showAlertDialog(context, "Login failed kindly check your login credentials and try again", "Failed Login");
            }
            {
              timer.cancel();
            }
          });
          // 04/07/2022 END
       // Navigator.push(context, new MaterialPageRoute(builder: (context) => HomeScreen(futureProfile: profile, timedout: true )));
        },
        child: Text(
          'LOGIN',
          style: TextStyle(
            color: Color(0xFF527DAA),
            letterSpacing: 1.5,
            fontSize: 18.0,
            fontWeight: FontWeight.bold,
            fontFamily: 'Montserrat',
          ),
        ),
      ),

    );
  }


  showAlertDialog(BuildContext context, String msg, String title) {

    // set up the button
    Widget okButton = TextButton(
      child: Text("OK"),
      onPressed: () {
        StoreProvider.of<AppState>(context).dispatch(UpdateLoginPodoAction(LoginPodo(showLoginloading: false)));
        Navigator.of(context).pop();
      },
    );

    // set up the AlertDialog
    AlertDialog alert = AlertDialog(
      title: Text(title),
      content: Text(msg),
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

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: AnnotatedRegion<SystemUiOverlayStyle>(
        value: SystemUiOverlayStyle.light,
        child: GestureDetector(
          onTap: () => FocusScope.of(context).unfocus(),
          child: Stack(fit: StackFit.expand,
            children: <Widget>[

              new Background("assets/images/girl.jpg"),
              Container(
                child: StoreConnector<AppState, LoginPodo>(
                  converter: (store) => store.state.loginPodo,
                  builder: (context, LoginPodo loginpodo) =>
                  loginpodo.showLoginloading ? Container(
                    child: Center(child: CircularProgressIndicator(),) ,
                  ) : Container(
                    height: double.infinity,
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
                          //_buildSignInWithText(),
                          //_buildSocialBtnRow(),
                          //_buildSignupBtn(),
                        ],
                      ),
                    ),
                  ),
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}

showAlertDialog({required BuildContext context, required String title, required String message, required Future<PatientProfilePodo>? patientprofile}) {

  // set up the button
  Widget okButton = TextButton(
    child: Text("OK"),
    onPressed: () {
      Navigator.of(context).push(MaterialPageRoute(builder: (context) => LoginScreen(loginStatus: false,)));
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



// import 'package:flutter/material.dart';
// import 'package:flutter/services.dart';
// import 'package:http/http.dart';
// import 'dart:convert';
// import 'package:healthensuite/screens/profile/profile_screen.dart';
// import 'package:healthensuite/utilities/constants.dart';
// import 'package:healthensuite/models/background.dart';
// import 'forgot_password.dart';
// //import 'package:healthensuite/models/name_logo.dart';
//
// class LoginScreen extends StatefulWidget {
//   @override
//   _LoginScreenState createState() => _LoginScreenState();
// }
//
// class _LoginScreenState extends State<LoginScreen> {
//   bool? _rememberMe = false;
//
//   getData() async{
//
//     Uri url = Uri.parse("https://jsonplaceholder.typicode.com/todos/1");
//     Response response = await get(url);
//     Map data = jsonDecode(response.body);
//     print(data);
//     print(data["title"]);
//
//   }
//
//   initializeLogin() async{
//     var url = Uri.parse("http://health001-env.eba-v5mudubf.us-east-2.elasticbeanstalk.com/insomnia/v1/authentication/login");
//     var username = "ifeanyiodenigbo10@gmail.com";
//     var password = "Pass@123";
//     var response = await post(url, body: {"password": password, "username": username});
//     //print('Response status: ${response.statusCode}');
//     print('Login Token: ${response.body}');
//
//     //print(await read(Uri.parse('https://example.com/foobar.txt')));
//   }
//
//   @override
//   void initState(){
//     super.initState();
//     //getData();
//     //initializeLogin();
//   }
//
//   Widget _buildEmailTF() {
//     return Column(
//       crossAxisAlignment: CrossAxisAlignment.start,
//       children: <Widget>[
//         Text(
//           'Username',
//           style: kLabelStyle,
//         ),
//         SizedBox(height: 10.0),
//         Container(
//           alignment: Alignment.centerLeft,
//           decoration: kBoxDecorationStyle,
//           height: 60.0,
//           child: TextField(
//             keyboardType: TextInputType.emailAddress,
//             style: TextStyle(
//               color: Colors.white,
//               fontFamily: 'Montserrat',
//             ),
//             decoration: InputDecoration(
//               border: InputBorder.none,
//               contentPadding: EdgeInsets.only(top: 14.0),
//               prefixIcon: Icon(
//                 Icons.person_sharp,
//                 color: Colors.white,
//               ),
//               hintText: 'Enter your Username',
//               hintStyle: kHintTextStyle,
//             ),
//           ),
//         ),
//       ],
//     );
//   }
//
//   Widget _buildPasswordTF() {
//     return Column(
//       crossAxisAlignment: CrossAxisAlignment.start,
//       children: <Widget>[
//         Text(
//           'Password',
//           style: kLabelStyle,
//         ),
//         SizedBox(height: 10.0),
//         Container(
//           alignment: Alignment.centerLeft,
//           decoration: kBoxDecorationStyle,
//           height: 60.0,
//           child: TextField(
//             obscureText: true,
//             style: TextStyle(
//               color: Colors.white,
//               fontFamily: 'Montserrat',
//             ),
//             decoration: InputDecoration(
//               border: InputBorder.none,
//               contentPadding: EdgeInsets.only(top: 14.0),
//               prefixIcon: Icon(
//                 Icons.lock,
//                 color: Colors.white,
//               ),
//               hintText: 'Enter your Password',
//               hintStyle: kHintTextStyle,
//             ),
//           ),
//         ),
//       ],
//     );
//   }
//
//   Widget _buildForgotPasswordBtn() {
//     return Container(
//       alignment: Alignment.centerRight,
//       child: FlatButton(
//         onPressed: ()  {Navigator.push(
//           context, new MaterialPageRoute(builder: (context) => AuthScreen())
//           );},
//         padding: EdgeInsets.only(right: 0.0),
//         child: Text(
//           'Forgot your Password?',
//           style: kLabelStyle,
//         ),
//       ),
//     );
//   }
//
//   Widget _buildRememberMeCheckbox() {
//     return Container(
//       height: 20.0,
//       child: Row(
//         children: <Widget>[
//           Theme(
//             data: ThemeData(unselectedWidgetColor: Colors.white),
//             child: Checkbox(
//               value: _rememberMe,
//               checkColor: Colors.blueAccent,
//               activeColor: Colors.white,
//               onChanged: (value) {
//                 setState(() {
//                   _rememberMe = value;
//                 });
//               },
//             ),
//           ),
//           Text(
//             'Remember me',
//             style: kLabelStyle,
//           ),
//         ],
//       ),
//     );
//   }
//
//   Widget _buildLoginBtn() {
//     return Container(
//       padding: EdgeInsets.symmetric(vertical: 25.0),
//       width: double.infinity,
//       child: ElevatedButton(
//         style: ElevatedButton.styleFrom(
//         primary: Colors.white, // background
//         //onPrimary: Colors.red, // foreground
//         elevation: 5.0,
//         padding: EdgeInsets.all(15.0),
//         shape: RoundedRectangleBorder(
//           borderRadius: BorderRadius.circular(30.0),
//           ),
//         ),
//         //onPressed: () => print('Login Button Pressed'),
//         onPressed: ()  {Navigator.push(
//           context, new MaterialPageRoute(builder: (context) => PatientScreen())
//           );},
//         child: Text(
//           'LOGIN',
//           style: TextStyle(
//             color: Color(0xFF527DAA),
//             letterSpacing: 1.5,
//             fontSize: 18.0,
//             fontWeight: FontWeight.bold,
//             fontFamily: 'Montserrat',
//           ),
//         ),
//       ),
//     );
//   }
//
//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       body: AnnotatedRegion<SystemUiOverlayStyle>(
//         value: SystemUiOverlayStyle.light,
//         child: GestureDetector(
//           onTap: () => FocusScope.of(context).unfocus(),
//           child: Stack(fit: StackFit.expand,
//             children: <Widget>[
//
//               new Background("assets/images/girl.jpg"),
//               Container(
//                 height: double.infinity,
//                 child: SingleChildScrollView(
//                   physics: AlwaysScrollableScrollPhysics(),
//                   padding: EdgeInsets.symmetric(
//                     horizontal: 40.0,
//                     vertical: 120.0,
//                   ),
//                   child: Column(
//                     mainAxisAlignment: MainAxisAlignment.center,
//                     children: <Widget>[
//                       Text(
//                         'Patient Sign In',
//                         style: TextStyle(
//                           color: Colors.white,
//                           fontFamily: 'Montserrat',
//                           fontSize: 30.0,
//                           fontWeight: FontWeight.bold,
//                         ),
//                       ),
//                       SizedBox(height: 30.0),
//                       _buildEmailTF(),
//                       SizedBox(
//                         height: 30.0,
//                       ),
//                       _buildPasswordTF(),
//                       _buildForgotPasswordBtn(),
//                       _buildRememberMeCheckbox(),
//                       _buildLoginBtn(),
//                       //_buildSignInWithText(),
//                       //_buildSocialBtnRow(),
//                       //_buildSignupBtn(),
//                     ],
//                   ),
//                 ),
//               )
//             ],
//           ),
//         ),
//       ),
//     );
//   }
// }