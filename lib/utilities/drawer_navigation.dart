import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:healthensuite/api/networkmodels/patientProfilePodo.dart';
import 'package:healthensuite/utilities/default.dart';
import 'package:healthensuite/utilities/constants.dart';
import 'package:healthensuite/screens/home/home_screen.dart';
import 'package:healthensuite/screens/profile/profile_screen.dart';
import 'package:healthensuite/screens/contactUs/my_feedback.dart';
import 'package:healthensuite/screens/contactUs/voluntary_withdrawal.dart';
import 'package:healthensuite/screens/programs/program_content.dart';
import 'package:healthensuite/screens/psychoEdu/psychoeducation.dart';
import 'package:healthensuite/screens/sleepClock/sleep_clock.dart';
import 'package:healthensuite/screens/sleepReport/sleep_report.dart';

int? indexClicked = 0;
// final name1 = 'Ifeanyi Paul';
// final email1 = 'mail@mail.com';
final assetImage ='assets/images/form-user.jpg';

class NavigationDrawerWidget extends StatefulWidget {
  final int? indexNum;
  Future<PatientProfilePodo>? patientprofile;

  NavigationDrawerWidget({this. indexNum, required this.patientprofile });

  @override
  _NavigationDrawerWidgetState createState() => _NavigationDrawerWidgetState();
}

class _NavigationDrawerWidgetState extends State<NavigationDrawerWidget> {
  final padding = EdgeInsets.symmetric(horizontal: 20);



  @override
  Widget build(BuildContext context) {
    Future<PatientProfilePodo>?  futureProfile = widget.patientprofile;

      indexClicked = widget.indexNum;
    return Drawer(
        child: FutureBuilder<PatientProfilePodo>(
        future: futureProfile,
        builder: (BuildContext context, AsyncSnapshot<PatientProfilePodo> snapshot){
          if(snapshot.hasData){
            PatientProfilePodo profile = snapshot.data!;
            return drawerContent(profile, futureProfile);
          }else{
            return Container(
              child: Center(child: CircularProgressIndicator(),),
            );
          }
        },
      )

    );
  }

  Material drawerContent(PatientProfilePodo profile, Future<PatientProfilePodo>?  futureProfile ){
     bool enableSleepClock = profile.statusEntity!.enableSleepclock()?? false;
    return Material(
      color:  appBackgroundColor,
      //color: Color.fromRGBO(50, 75, 205, 1),
      child: ListView(
        children: <Widget>[
          buildHeader(
            assetImage: assetImage,
            name: profile.firstName.toString(),
            email: profile.email.toString(),
            onClicked: () => Navigator.of(context).push(MaterialPageRoute(
              builder: (context) => PatientScreen(
                // name: "Full Name",
                // email: "patientemail@gmail.com",
                patientProfile: futureProfile,
              ),
            )),
          ),
          Divider(color: Defaults.drawerItemColor),
          Container(
            padding: padding,
            child: Column(
              children: [
                MenuItem(
                    index: 0,
                    onClicked: () => selectedItem(context, 0,futureProfile)
                ),
                MenuItem(
                    index: 1,
                    onClicked: () => selectedItem(context, 1,futureProfile)
                ),
                // MenuItem(
                //     index: 2,
                //     onClicked: () => selectedItem(context, 2,futureProfile)
                // ),
                Center(
                  child: ((){
                    if(enableSleepClock){
                     return  getSleepClock(futureProfile);
                    }else{
                      SizedBox(height: 10.0,);
                  }
                  }())
                ),
                MenuItem(
                    index: 3,
                    onClicked: () => selectedItem(context, 3,futureProfile)
                ),
                MenuItem(
                    index: 4,
                    onClicked: () => selectedItem(context, 4,futureProfile)
                ),
                MenuItem(
                    index: 5,
                    onClicked: () => selectedItem(context, 5,futureProfile)
                ),
                MenuItem(
                    index: 6,
                    onClicked: () => selectedItem(context, 6,futureProfile)
                ),
                MenuItem(
                    index: 7,
                    onClicked: () => selectedItem(context, 7,futureProfile)
                ),
                SizedBox(height: 10.0,),
                Divider(
                  height: 1.0,
                  thickness: 1.0,
                  color: Defaults.drawerItemColor,
                  indent: 3,
                  endIndent: 3,
                ),
                SizedBox(height: 10.0),
                Center(
                  child: Text("Health enSuite",
                    style: GoogleFonts.sanchez(
                      fontWeight: FontWeight.w500,
                      fontSize: 22.0,
                      color: Defaults.drawerItemColor,
                    ),
                  ),
                ),
                SizedBox(height: 20.0),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget getSleepClock(Future<PatientProfilePodo>? futureProfile ){
    return MenuItem(
        index: 2,
        onClicked: () => selectedItem(context, 2,futureProfile)
    );
  }

  Widget buildHeader({
    required String assetImage,
    required String name,
    required String email,
    required VoidCallback onClicked,
  }) =>
      InkWell(
        onTap: onClicked,
        child: Container(
          padding: padding.add(EdgeInsets.symmetric(vertical: 40)),
          child: Row(
            children: [
              CircleAvatar(radius: 30, backgroundImage: AssetImage(assetImage), backgroundColor: Colors.blueAccent,),
              SizedBox(width: 20),
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    name,
                    style: TextStyle(fontSize: 20, color: Colors.white),
                  ),
                  const SizedBox(height: 4),
                  Text(
                    email,
                    overflow:TextOverflow.fade,
                    style: TextStyle(fontSize: 14, color: Colors.white),
                  ),
               ],
              ),

            ],
          ),
        ),
      );

  Widget buildMenuItem({
    required String text,
    required IconData icon,
    VoidCallback? onClicked,
  }) {
    final color = Colors.white;
    final hoverColor = Colors.white70;

    return ListTile(
      leading: Icon(icon, color: color),
      title: Text(text, style: TextStyle(color: color)),
      hoverColor: hoverColor,
      onTap: onClicked,
    );
  }

  void selectedItem(BuildContext context, int index, Future<PatientProfilePodo>?  profile ) {
    Navigator.of(context).pop();

    switch (index) {
      case 0:
        Navigator.of(context).push(MaterialPageRoute(
          builder: (context) => HomeScreen(futureProfile: profile,),
        ));
        break;

      case 1:
        Navigator.of(context).push(MaterialPageRoute(
          builder: (context) => PatientScreen(
            // name: "Patient Name",
            // email: "patientEmail@gmail.com",
            patientProfile: profile,
          ),
        ));
        break;

      // case 2:
      //   Navigator.of(context).push(MaterialPageRoute(
      //     builder: (context) => SleepDiary(),
      //   ));
      //   break;

      case 2:
        Navigator.of(context).push(MaterialPageRoute(
          builder: (context) => SleepClock(patientProfile: profile,),
        ));
        break;
      case 3:
        Navigator.of(context).push(MaterialPageRoute(
          builder: (context) => SleepReport(patientProfile: profile,),
        ));
        break;

      case 4:
        Navigator.of(context).push(MaterialPageRoute(
          builder: (context) => ProgramContent(patientProfile: profile,),
        ));
        break;

      case 5:
        Navigator.of(context).push(MaterialPageRoute(
          builder: (context) => PsychoEducation(patientProfile: profile,),
        ));
        break;
      //  profile = widget.patientprofile;
      case 6:
        Navigator.of(context).push(MaterialPageRoute(
          builder: (context) => MyFeedback(patientProfile: widget.patientprofile,),
        ));
        break;

      case 7:
        Navigator.of(context).push(MaterialPageRoute(
          builder: (context) => VoluntaryWithdrawal(patientProfile: profile,),
        ));
        break;
    }
  }
}


class MenuItem extends StatelessWidget {
  const MenuItem({
    Key? key,
    required this.index,
    required this.onClicked
  }) : super(key: key);

  final int index;
  final VoidCallback onClicked;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 8.0),
      child: ListTile(
      onTap: onClicked,
      selected: indexClicked == index,
      selectedTileColor: Defaults.drawerItemSelectedTileColor,
      leading: Icon(
        Defaults.drawerItemIcon[index],
        size: 28,
        color: indexClicked == index
          ? Defaults.drawerItemSelectedColor
          : Defaults.drawerItemColor,
        ),
      title: Text(
        Defaults.drawerItemText[index],
        style: GoogleFonts.sanchez(
          fontSize: 18.0,
          fontWeight: FontWeight.w500,
          color: indexClicked == index 
            ? Defaults.drawerItemSelectedColor
            : Defaults.drawerItemColor,
          ),
        ),
      ),
    );
  }
}