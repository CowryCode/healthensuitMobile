import 'package:healthensuite/api/networkmodels/loginPodo.dart';
import 'package:healthensuite/api/networkmodels/patientProfilePodo.dart';

class LoginObject{
  final PatientProfilePodo patientProfilePodo;
  final LoginPodo loginPodo;
  LoginObject({ required this.loginPodo, required this.patientProfilePodo});

  PatientProfilePodo get getPatientprofile => this.patientProfilePodo;
  LoginPodo get getLoginPodo => this.loginPodo;
}