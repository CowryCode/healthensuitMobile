import 'package:healthensuite/api/networkmodels/patientProfilePodo.dart';
import 'package:healthensuite/api/networkmodels/sleepDiaryPODO.dart';

class AppState{
  SleepDiariesPODO? sleepDiariesPODO = SleepDiariesPODO().getCurrentSleepDiary();
  PatientProfilePodo? patientProfilePodo = PatientProfilePodo();
  AppState({
    this.sleepDiariesPODO,
    this.patientProfilePodo
  });
}