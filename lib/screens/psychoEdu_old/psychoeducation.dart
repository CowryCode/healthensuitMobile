import 'package:flutter/material.dart';
import 'package:healthensuite/api/networkmodels/patientProfilePodo.dart';
import 'package:healthensuite/utilities/drawer_navigation.dart';
//import 'package:healthensuite/utilities/constants.dart';


class PsychoEducation extends StatefulWidget {

  final Function? onMenuTap;
  static final String title = 'Psychoeducation';

 // final Future<PatientProfilePodo>? patientProfile;

  const PsychoEducation({Key? key, this.onMenuTap,}) : super(key: key);

  @override
  _PsychoEducationState createState() => _PsychoEducationState();
}

class _PsychoEducationState extends State<PsychoEducation> {
   @override
  Widget build(BuildContext context) {
    // Future<PatientProfilePodo>? profile = widget.patientProfile;
     return Scaffold(
      drawer: NavigationDrawerWidget(indexNum: 5,),
      appBar: AppBar(
        title: Text(PsychoEducation.title),
        centerTitle: true,
      ),

    );
  }
}