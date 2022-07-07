import 'package:healthensuite/api/networkmodels/interventionlevels/leveltwoVariables.dart';
import 'package:healthensuite/api/networkmodels/loginPodo.dart';
import 'package:healthensuite/api/networkmodels/patientProfilePodo.dart';
import 'package:healthensuite/api/networkmodels/sleepDiaryPODO.dart';

class AppState{
  SleepDiariesPODO sleepDiariesPODO = SleepDiariesPODO().getCurrentSleepDiary();
  PatientProfilePodo patientProfilePodo = PatientProfilePodo();
  LoginPodo loginPodo = LoginPodo();
  LeveltwoVariables leveltwoVariables = LeveltwoVariables();
  AppState({
    required this.sleepDiariesPODO,
    required this.patientProfilePodo,
    required this.loginPodo,
    required this.leveltwoVariables
  });
}