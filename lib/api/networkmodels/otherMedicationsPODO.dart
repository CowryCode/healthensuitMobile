class OtherMedicationsEntity {
  int? id;
  String? medicationName;
  String? amount;
  String? dateCreated;

  OtherMedicationsEntity({this.medicationName, this.amount});

  OtherMedicationsEntity.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    medicationName = json['medicationName'];
    amount = json['amount'];
    dateCreated = json['date_Created'];
    // dateCreated = json['date_Created'] != null
    //     ? new DateCreated.fromJson(json['date_Created'])
    //     : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['medicationName'] = this.medicationName;
    data['amount'] = this.amount;
    data['date_Created'] = this.dateCreated;
    // if (this.dateCreated != null) {
    //   data['date_Created'] = this.dateCreated!.toJson();
    // }
    return data;
  }

  void setDrugAmount(String drugAmount){
   // double amnt = double.parse(drugAmount);
    this.amount = drugAmount;
  }

  void setOthermedicationFields(String medicationName, String amount){
    this.medicationName = medicationName;
    setDrugAmount(amount);
  }
}
