/// tbnkid : "4"
/// tbnkdsc : "Meezan Bank"
/// tbnksts : "Yes"

class GetActiveBank {
  GetActiveBank({
      String? tbnkid, 
      String? tbnkdsc, 
      String? tbnksts,}){
    _tbnkid = tbnkid;
    _tbnkdsc = tbnkdsc;
    _tbnksts = tbnksts;
}

  GetActiveBank.fromJson(dynamic json) {
    _tbnkid = json['tbnkid'];
    _tbnkdsc = json['tbnkdsc'];
    _tbnksts = json['tbnksts'];
  }
  String? _tbnkid;
  String? _tbnkdsc;
  String? _tbnksts;
GetActiveBank copyWith({  String? tbnkid,
  String? tbnkdsc,
  String? tbnksts,
}) => GetActiveBank(  tbnkid: tbnkid ?? _tbnkid,
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