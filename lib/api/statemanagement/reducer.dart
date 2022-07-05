import 'package:flutter/cupertino.dart';
import 'package:healthensuite/api/statemanagement/actions.dart';
import 'package:healthensuite/api/statemanagement/app_state.dart';

AppState appStateReducer(AppState state, dynamic action){
  if(action is UpdateSleepDiaryAction){
    return AppState(
      sleepDiariesPODO: action.sleepDiariesPODO,
      patientProfilePodo: state.patientProfilePodo,
      loginPodo: state.loginPodo,
      leveltwoVariables: state.leveltwoVariables
    );
  }else if (action is UpdatePatientProfileAction){
    return AppState(
      sleepDiariesPODO: state.sleepDiariesPODO,
      patientProfilePodo: action.patientProfilePodo,
      loginPodo: state.loginPodo,
      leveltwoVariables: state.leveltwoVariables
    );
  }else if(action is UpdateLoginPodoAction){
    return AppState(
      sleepDiariesPODO: state.sleepDiariesPODO,
      patientProfilePodo: state.patientProfilePodo,
      loginPodo: action.loginPodo,
      leveltwoVariables: state.leveltwoVariables
    );
  }else if(action is UpdateLevelTwoVariableAction){
    return AppState(
        sleepDiariesPODO: state.sleepDiariesPODO,
        patientProfilePodo: state.patientProfilePodo,
        loginPodo: state.loginPodo,
        leveltwoVariables: action.leveltwoVariables
    );
  }
  return state;
}