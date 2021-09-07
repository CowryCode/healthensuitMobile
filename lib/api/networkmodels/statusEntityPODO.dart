class StatusEntity {
  int? id;
  bool? consent;
  String? consentEmail;
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
  bool? enableSleepClockbutton;
  bool? levelonesubmiteligible;
  String? lastPsychoeducation;
  // DateCreated? dateCreated;
  String? dateCreated;

  StatusEntity(
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
        this.enableSleepClockbutton,
        this.levelonesubmiteligible,
        this.lastPsychoeducation,
        this.dateCreated});

  StatusEntity.fromJson(Map<String, dynamic> json) {
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
    enableSleepClockbutton = json['enableSleepClockbutton'];
    levelonesubmiteligible = json['levelonesubmiteligible'];
    lastPsychoeducation = json['lastPsychoeducation'];
    // lastPsychoeducation = json['lastPsychoeducation'] != null
    //     ? new TapperStartDate.fromJson(json['lastPsychoeducation'])
    //     : null;
    dateCreated = json['date_Created'];
    // dateCreated = json['date_Created'] != null
    //     ? new DateCreated.fromJson(json['date_Created'])
    //     : null;
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
    data['enableSleepClockbutton'] = this.enableSleepClockbutton;
    data['levelonesubmiteligible'] = this.levelonesubmiteligible;
    data['lastPsychoeducation'] = this.lastPsychoeducation;
    // if (this.lastPsychoeducation != null) {
    //   data['lastPsychoeducation'] = this.lastPsychoeducation!.toJson();
    // }
    data['date_Created'] = this.dateCreated;
    return data;
  }

  int? getInterventionLevel(){
    return this.interventionLevel;
  }

  bool? enableSleepclock(){
    return this.enableSleepClockbutton;
  }
}
