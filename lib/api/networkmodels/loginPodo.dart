class LoginPodo {
  int? profileID;
  int? personID;
  int? patientRawID;
  String? expirytimee;
  String? token;
  bool? successfull;
  Status? status;
  bool? provider;
  bool? admin;
  bool? superAdmin;
  bool? patient;
  bool showLoginloading = false;

  LoginPodo(
      {this.profileID,
        this.personID,
        this.patientRawID,
        this.expirytimee,
        this.token,
        this.successfull,
        this.status,
        this.provider,
        this.admin,
        this.superAdmin,
        this.patient,
        this.showLoginloading = false
      });

  LoginPodo getInitializedLoginPodo(){
    return LoginPodo(
      showLoginloading: false
    );
  }

  LoginPodo.fromJson(Map<String, dynamic> json) {
    profileID = json['profileID'];
    personID = json['personID'];
    patientRawID = json['patientRawID'];
    expirytimee = json['expirytimee'];
    token = json['token'];
    successfull = json['successfull'];
    status =
    json['status'] != null ? new Status.fromJson(json['status']) : null;
    provider = json['provider'];
    admin = json['admin'];
    superAdmin = json['superAdmin'];
    patient = json['patient'];
    showLoginloading = false;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['profileID'] = this.profileID;
    data['personID'] = this.personID;
    data['patientRawID'] = this.patientRawID;
    data['expirytimee'] = this.expirytimee;
    data['token'] = this.token;
    data['successfull'] = this.successfull;
    if (this.status != null) {
      data['status'] = this.status!.toJson();
    }
    data['provider'] = this.provider;
    data['admin'] = this.admin;
    data['superAdmin'] = this.superAdmin;
    data['patient'] = this.patient;
    data['showLoginloading'] = this.showLoginloading;
    return data;
  }
}

class Status {
  int? id;
  bool? consent;
  Null consentEmail;
  bool? eligible;
  bool? sleepDiariesCompleted;
  bool? baselineAssessmenPassed;
  bool? readInterventionGroupleveloneArticle;
  bool? readInterventionGroupleveltwoArticle;
  bool? readInterventionGrouplevelthreeArticle;
  bool? readInterventionGrouplevelfourArticle;
  bool? readInterventionGrouplevelfiveArticle;
  bool? readInterventionGrouplevelsixArticle;
  int? interventionLevel;
  int? nextPage;
  bool? enableSleepClockbutton;
  bool? levelonesubmiteligible;
  String? lastPsychoeducation;

  Status(
      {this.id,
        this.consent,
        this.consentEmail,
        this.eligible,
        this.sleepDiariesCompleted,
        this.baselineAssessmenPassed,
        this.readInterventionGroupleveloneArticle,
        this.readInterventionGroupleveltwoArticle,
        this.readInterventionGrouplevelthreeArticle,
        this.readInterventionGrouplevelfourArticle,
        this.readInterventionGrouplevelfiveArticle,
        this.readInterventionGrouplevelsixArticle,
        this.interventionLevel,
        this.nextPage,
        this.enableSleepClockbutton,
        this.levelonesubmiteligible,
        this.lastPsychoeducation});

  Status.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    consent = json['consent'];
    consentEmail = json['consentEmail'];
    eligible = json['eligible'];
    sleepDiariesCompleted = json['sleepDiariesCompleted'];
    baselineAssessmenPassed = json['baselineAssessmenPassed'];
    readInterventionGroupleveloneArticle =
    json['readInterventionGroupleveloneArticle'];
    readInterventionGroupleveltwoArticle =
    json['readInterventionGroupleveltwoArticle'];
    readInterventionGrouplevelthreeArticle =
    json['readInterventionGrouplevelthreeArticle'];
    readInterventionGrouplevelfourArticle =
    json['readInterventionGrouplevelfourArticle'];
    readInterventionGrouplevelfiveArticle =
    json['readInterventionGrouplevelfiveArticle'];
    readInterventionGrouplevelsixArticle =
    json['readInterventionGrouplevelsixArticle'];
    interventionLevel = json['interventionLevel'];
    nextPage = json['nextPage'];
    enableSleepClockbutton = json['enableSleepClockbutton'];
    levelonesubmiteligible = json['levelonesubmiteligible'];
    lastPsychoeducation = json['lastPsychoeducation'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['consent'] = this.consent;
    data['consentEmail'] = this.consentEmail;
    data['eligible'] = this.eligible;
    data['sleepDiariesCompleted'] = this.sleepDiariesCompleted;
    data['baselineAssessmenPassed'] = this.baselineAssessmenPassed;
    data['readInterventionGroupleveloneArticle'] =
        this.readInterventionGroupleveloneArticle;
    data['readInterventionGroupleveltwoArticle'] =
        this.readInterventionGroupleveltwoArticle;
    data['readInterventionGrouplevelthreeArticle'] =
        this.readInterventionGrouplevelthreeArticle;
    data['readInterventionGrouplevelfourArticle'] =
        this.readInterventionGrouplevelfourArticle;
    data['readInterventionGrouplevelfiveArticle'] =
        this.readInterventionGrouplevelfiveArticle;
    data['readInterventionGrouplevelsixArticle'] =
        this.readInterventionGrouplevelsixArticle;
    data['interventionLevel'] = this.interventionLevel;
    data['nextPage'] = this.nextPage;
    data['enableSleepClockbutton'] = this.enableSleepClockbutton;
    data['levelonesubmiteligible'] = this.levelonesubmiteligible;
    data['lastPsychoeducation'] = this.lastPsychoeducation;
    return data;
  }
}