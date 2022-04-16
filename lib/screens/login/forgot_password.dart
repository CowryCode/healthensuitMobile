import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:healthensuite/api/network.dart';
import 'package:healthensuite/screens/login/login_screen.dart';
import 'package:healthensuite/screens/login/reset_password.dart';
import 'package:healthensuite/utilities/constants.dart';

class AuthScreen extends StatefulWidget {
  @override
  _AuthScreenState createState() => _AuthScreenState();
}

class _AuthScreenState extends State<AuthScreen> {

  TextEditingController codeController = TextEditingController();


  Widget _buildEmailTF() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: <Widget>[
        Text(
          'Secret Code',
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
                Icons.security_rounded,
                color: Colors.white,
              ),
              hintText: 'Enter the secret code here',
              hintStyle: kHintTextStyle,
            ),
            controller: codeController,
          ),
        ),
      ],
    );
  }

  Widget _buildSignInInsteadBtn() {
    return Container(
      alignment: Alignment.centerRight,
      child: FlatButton(
        onPressed: ()  {Navigator.push(
          context, new MaterialPageRoute(builder: (context) => LoginScreen(loginStatus: false,))
          );},
        padding: EdgeInsets.only(right: 0.0),
        child: Text(
          'Sign in instead',
          style: kLabelStyle,
        ),
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
        onPressed: () {
          if(codeController.value.text.isNotEmpty){
            String password = codeController.value.text.trim();
            Future<bool> checkCode =  ApiAccess().changePasswordverifyCode(code: password);
            checkCode.then((value) => {
              if(value){
                Navigator.push(context, new MaterialPageRoute(builder: (context) => ResetPasswordScreen()))
              }else{
                print("This is code you put here no work ni ooooo")
              }
            });
          }else{
            print("Do nothing . . . ");
          }
         },
        child: Text(
          'SUBMIT',
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


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: AnnotatedRegion<SystemUiOverlayStyle>(
        value: SystemUiOverlayStyle.light,
        child: GestureDetector(
          onTap: () => FocusScope.of(context).unfocus(),
          child: Stack(
            children: <Widget>[
              Container(
                height: double.infinity,
                width: double.infinity,
                decoration: BoxDecoration(
                  gradient: LinearGradient(
                    begin: Alignment.topCenter,
                    end: Alignment.bottomCenter,
                    colors: [
                      Color(0xFF73AEF5),
                      Color(0xFF61A4F1),
                      Color(0xFF478DE0),
                      Color(0xFF398AE5),
                    ],
                    stops: [0.1, 0.4, 0.7, 0.9],
                  ),
                ),
              ),
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
                        'Forgot Password',
                        style: TextStyle(
                          color: Colors.white,
                          fontFamily: 'Montserrat',
                          fontSize: 30.0,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      SizedBox(height: 30.0),
                      Text(
                        'To reset your password, please enter the secret code that was sent to your registered email address. You may need to check your spam folder.',
                        style: TextStyle(
                          color: Colors.white,
                          fontFamily: 'Montserrat',
                          fontSize: 15.0,
                        ),
                      ),
                      SizedBox(height: 30.0),
                      _buildEmailTF(),
                      _buildSignInInsteadBtn(),
                      //SizedBox(height: 30.0,),

                      _buildLoginBtn(),
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