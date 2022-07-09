final baseURL = "http://10.0.2.2:8083";
// final baseURL = "https://apiv3.healthensuite.com/"; //just updated 0001
final loginURL = "${baseURL}/insomnia/v1/authentication/login";
final confirmUsername_URL = "${baseURL}/insomnia/v1/authentication/confirmusernamemobile";
final loginwithCode_URL = "${baseURL}/insomnia/v1/authentication/loginwithcode";
final changepassword_URL = "${baseURL}/insomnia/v1/authentication/mobilechangepassword";
final patientprofile_url = "${baseURL}/insomnia/v1/patient/accessid";
final save_sleepdiary_url = "${baseURL}/insomnia/v1/patient/submit-sleepdiary";
final my_sleepclock_url = "${baseURL}/insomnia/v1/dashboard/mysleepclock";
final my_sleepreport_url = "${baseURL}/insomnia/v1/dashboard/mysleepreport";
final my_feedback_url = "${baseURL}/insomnia/v1/dashboard/feedback";
final voluntry_withdrawal_url = "${baseURL}/insomnia/v1/dashboard/withdraw";
final psychoeducation_url = "${baseURL}/insomnia/v1/intervention/psycho"; //
final get_Incomplete_psychoeducation_url = "${baseURL}/insomnia/v1/intervention/getpsychoeducation"; //
final levelone_url = "${baseURL}/insomnia/v1/intervention/savelevelone";
final get_leveltwo_variables_url = "${baseURL}/insomnia/v1/intervention/getleveltwovariables";
final leveltwo_url = "${baseURL}/insomnia/v1/intervention/saveleveltwo";
final levelthree_url = "${baseURL}/insomnia/v1/intervention/savelevelthree";
final levelfour_url = "${baseURL}/insomnia/v1/intervention/savelevelfour";
final levelfive_url = "${baseURL}/insomnia/v1/intervention/savelevelfive";
final levelSix_url = "${baseURL}/insomnia/v1/intervention/savelevelsix";
final Save_Page_url = "${baseURL}/insomnia/v1/intervention/savepage";
final sleepwindow_url = "${baseURL}/insomnia/v1/dashboard/saveleepwindow";
final sharesleep_report_url = "${baseURL}/insomnia/v1/dashboard/sharereport";
final submitDeviceIdentifier_URL = "${baseURL}/insomnia/v1/patient/deviceidentifier";
// Meta data keys
final key_login_token = "logintoken";
final key_Login_Status = "logincheck";
final key_Device_Identifier = "deviceIdentifier";
final key_temp_int = "tempint";
final keyUsername = "Name";
final keyUseremail = "Email";
// STATUS ENTITIES
final key_Intervention_Level = "interventionLevel";
final key_Next_Page = "nextPage";
final key_Level_One = "levelOne";
final key_Level_Two = "levelTwo";
final key_Level_Three = "levelThree";
final key_Level_Four = "levelFour";
final key_Level_Five = "levelFive";
final key_Level_Six = "levelSix";

// GLOBAL VIARIABLES
 final int timeout_duration = 10;
