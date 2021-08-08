import 'package:flutter/material.dart';
import 'package:healthensuite/api/network.dart';
import 'package:healthensuite/api/networkmodels/patientProfilePodo.dart';
import 'package:healthensuite/screens/home/home_screen.dart';
import 'package:healthensuite/utilities/drawer_navigation.dart';
import 'package:healthensuite/utilities/constants.dart';
import 'package:healthensuite/models/icon_button.dart';


class VoluntaryWithdrawal extends StatefulWidget{

  final Function? onMenuTap;
    static final String title = 'Voluntary Withdrawal';
    static final sidePad = EdgeInsets.symmetric(horizontal: 18);

  final Future<PatientProfilePodo>? patientProfile;


  const VoluntaryWithdrawal({Key? key, this.onMenuTap, required this.patientProfile}) : super(key: key);

  @override
  _VoluntaryWithdrawalState createState() => _VoluntaryWithdrawalState();
}

class _VoluntaryWithdrawalState extends State<VoluntaryWithdrawal> {

  TextEditingController withdrawalNote = TextEditingController();

  get patientProfile => widget.patientProfile;

  @override
  Widget build(BuildContext context) {

    Future<PatientProfilePodo>? profile = widget.patientProfile;

    final Size size = MediaQuery.of(context).size;
    final ThemeData themeData = Theme.of(context);
    double pad = 18;
    return Scaffold(
      drawer: NavigationDrawerWidget(indexNum: 7,  patientprofile: profile,),
      appBar: AppBar(
        title: Text(VoluntaryWithdrawal.title),
        centerTitle: true,
      ),
      body: SingleChildScrollView(
        scrollDirection: Axis.vertical,
        physics: ClampingScrollPhysics(),
        child: Container(
          width: size.width,
          height: size.height,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              SizedBox(height: pad,),
              Padding(
                padding: VoluntaryWithdrawal.sidePad,
                child: Text("To withdraw from the program, please contact us:", style: themeData.textTheme.headline4,),
              ),
              SizedBox(height: pad,),
              Padding(
                padding: VoluntaryWithdrawal.sidePad,
                child: Text("By Email: TeamHealthEnSuite@iwk.nshealth.ca", style: themeData.textTheme.headline5,),
              ),
              SizedBox(height: pad,),
              Padding(
                padding: VoluntaryWithdrawal.sidePad,
                child: Text("By Phone: (902) 470 7934 or call toll-free number: 1-877-341-8309 press 5", style: themeData.textTheme.headline5,),
              ),
              SizedBox(height: pad,),
              Center(
                child: Text("OR", style: themeData.textTheme.headline4,),
              ),
              SizedBox(height: pad,),
              Padding(
                padding: VoluntaryWithdrawal.sidePad,
                child: Text("Fill and submit withdrawal note below", style: themeData.textTheme.headline5,),
              ),
              buildNoteForm(context),
              Center(
                child: IconUserButton(buttonText: "Submit Withdrawal Note", buttonEvent: () {createAlertDialog(context);}, buttonIcon: Icons.note,)
              ),
            ],
          ),
        ),
      ),
    );
  }

   buildNoteForm(BuildContext context){
    final ThemeData themeData = Theme.of(context);
      return Container(
        padding: VoluntaryWithdrawal.sidePad,
        height: 200.0,
        child: TextField(
          maxLines: 10,
          decoration: InputDecoration(
            hintText: "Please enter withdrawal note here",
            hintStyle: themeData.textTheme.bodyText2,
            border: OutlineInputBorder(
              borderSide: BorderSide(color: appItemColorBlue)
              ),
          ),
          controller: withdrawalNote,
        ),
      );
  }

  createAlertDialog(BuildContext context){
     final ThemeData themeData = Theme.of(context);
    return showDialog(
      context: context,
      builder: (context){
        return AlertDialog(
          title: Text("Want to go ahead and withdraw?", style: themeData.textTheme.headline5,),
          content: Text("You will loose login access on the app and be removed from the program once you submit this note.",
          style: themeData.textTheme.bodyText2,),
          actions: [
            MaterialButton(
              child: Text("Submit", style: TextStyle(color: appItemColorBlue, fontWeight: FontWeight.w700),),
              onPressed: (){
                String txt = withdrawalNote.value.text;
                Future<bool> response = ApiAccess().voluntaryWithdrawal(withdrawalNote:txt);
                response.then((value) => {
                  if(value){
                    Navigator.push(context, new MaterialPageRoute(builder: (context) => HomeScreen(futureProfile: patientProfile,)))
                  }else{
                    Navigator.push(context, new MaterialPageRoute(builder: (context) => HomeScreen(futureProfile: patientProfile,)))
                  }
                });

              //  Navigator.of(context).pop();
              }
            ),
          ],
        );
      });
  }
}