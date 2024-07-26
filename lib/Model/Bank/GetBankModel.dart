/// tbnkid : "1"
/// tbnkdsc : "Habib Bank Limited"
/// tbnksts : "Yes"

class GetBankModel {
  GetBankModel({
      String? tbnkid, 
      String? tbnkdsc, 
      String? tbnksts,}){
    _tbnkid = tbnkid;
    _tbnkdsc = tbnkdsc;
    _tbnksts = tbnksts;
}

  GetBankModel.fromJson(dynamic json) {
    _tbnkid = json['tbnkid'];
    _tbnkdsc = json['tbnkdsc'];
    _tbnksts = json['tbnksts'];
  }
  String? _tbnkid;
  String? _tbnkdsc;
  String? _tbnksts;
GetBankModel copyWith({  String? tbnkid,
  String? tbnkdsc,
  String? tbnksts,
}) => GetBankModel(  tbnkid: tbnkid ?? _tbnkid,
  tbnkdsc: tbnkdsc ?? _tbnkdsc,
  tbnksts: tbnksts ?? _tbnksts,
);
  String? get tbnkid => _tbnkid;
  String? get tbnkdsc => _tbnkdsc;
  String? get tbnksts => _tbnksts;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['tbnkid'] = _tbnkid;
    map['tbnkdsc'] = _tbnkdsc;
    map['tbnksts'] = _tbnksts;
    return map;
  }

}