import 'package:healthensuite/api/networkmodels/interventionlevels/leveltwoVariables.dart';
import 'package:healthensuite/api/networkmodels/loginPodo.dart';
import 'package:healthensuite/api/networkmodels/patientProfilePodo.dart';
import 'package:healthensuite/api/networkmodels/sleepDiaryPODO.dart';

class UpdateSleepDiaryAction{
  final SleepDiariesPODO sleepDiariesPODO;
  UpdateSleepDiaryAction(this.sleepDiariesPODO);
}
class GetSleepDiaryList{
  final List<SleepDiariesPODO> sleepdiaries;
  GetSleepDiaryList(this.sleepdiaries);
}
class UpdatePatientProfileAction{
  final PatientProfilePodo patientProfilePodo;
  UpdatePatientProfileAction(this.patientProfilePodo);
}
class UpdateLoginPodoAction{
  final LoginPodo loginPodo;
  UpdateLoginPodoAction(this.loginPodo);
}
class UpdateLevelTwoVariableAction{
  final LeveltwoVariables leveltwoVariables;
  UpdateLevelTwoVariableAction(this.leveltwoVariables);
}