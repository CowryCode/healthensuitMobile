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
