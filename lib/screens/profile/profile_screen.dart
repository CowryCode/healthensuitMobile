import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
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
                  RowItemEdit(rowIcon: Icons.email, rowText: "${patientprofile.email}", buttonIcon: Icons.edit, buttonEvent: (){},),


                  SizedBox(height: 20.0),

                  IconUserButton(buttonText: "Change Password", buttonEvent: () {}, buttonIcon: Icons.edit,)


                ],
              ),
            ),
          ),

        ),
      ),
    );
  }
}