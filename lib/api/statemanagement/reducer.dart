import 'package:healthensuite/api/statemanagement/actions.dart';
import 'package:healthensuite/api/statemanagement/app_state.dart';

AppState appStateReducer(AppState state, dynamic action){
  if(action is UpdateSleepDiaryAction){
    return AppState(
      sleepDiariesPODO: action.sleepDiariesPODO,
      patientProfilePodo: state.patientProfilePodo
    );
  }else if (action is UpdatePatientProfileAction){
    return AppState(
      sleepDiariesPODO: state.sleepDiariesPODO,
      patientProfilePodo: action.patientProfilePodo
    );
  }
  return state;
}