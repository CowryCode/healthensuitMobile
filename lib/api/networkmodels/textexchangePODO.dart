class TextexchangePODO {
  String? code;
  String? code1;
  String? code2;

  TextexchangePODO({this.code, this.code1, this.code2});

  TextexchangePODO.fromJson(Map<String, dynamic> json) {
    code = json['code'];
    code1 = json['code1'];
    code2 = json['code2'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['code'] = this.code;
    data['code1'] = this.code1;
    data['code2'] = this.code2;
    return data;
  }
}