import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:healthensuite/api/network.dart';
import 'package:healthensuite/api/networkUtilities.dart';
import 'package:healthensuite/api/networkmodels/loginPodo.dart';
import 'package:healthensuite/api/networkmodels/patientProfilePodo.dart';
import 'package:healthensuite/api/statemanagement/diskstorage.dart';
import 'package:healthensuite/screens/home/home_screen.dart';
import 'package:healthensuite/screens/login/forgot_password_email.dart';
import 'package:healthensuite/utilities/constants.dart';
import 'package:healthensuite/models/background.dart';
//import 'package:healthensuite/models/name_logo.dart';

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

  Future<LoginPodo>? _logindetailFuture;
  LoginPodo? loginDetail;
  bool? loginStatus;

  bool isLoading = false;

  // @override
  // void initState(){
  //   super.initState();
  //  // getData();
  // }

  @override
  void initState() {
    super.initState();
    loginStatus = widget.loginStatus;
    WidgetsBinding.instance!.addPostFrameCallback((_) async {
      if(loginStatus != null){
        if(loginStatus == true){
          Navigator.push(context, new MaterialPageRoute(builder: (context) => HomeScreen(futureProfile: null, justLoggedIn: false, timedout: true )));
        }
      }
    });
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
    return Container(
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
        //onPressed: () => print('Login Button Pressed'),
        onPressed: ()  {
          String un = usernamecontroller.value.text.trim();
          String pass = passwordcontroller.value.text.trim();
         // _logindetailFuture =  ApiAccess().login(username: un, password: pass);
          Future<PatientProfilePodo>? profile =  ApiAccess().login(username: un, password: pass);
          Navigator.push(context, new MaterialPageRoute(builder: (context) => HomeScreen(futureProfile: profile, justLoggedIn: true, timedout: true )));
          // _logindetailFuture!.then((value) => {
          //   // loginDetail = value
          //   if(value == null){
          //     showAlertDialog(context)
          // }else{
          //     Navigator.push(context, new MaterialPageRoute(builder: (context) => HomeScreen(futureProfile: null,)))
          //   }
          // } );


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


  showAlertDialog(BuildContext context) {

    // set up the button
    Widget okButton = TextButton(
      child: Text("OK"),
      onPressed: () { },
    );

    // set up the AlertDialog
    AlertDialog alert = AlertDialog(
      title: Text("My title"),
      content: Text("This is my message."),
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
              )
            ],
          ),
        ),
      ),
    );
  }
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