/// trefid : "1"
/// trefdsc : "azan"
/// trefsts : "Yes"
/// temladd : "azan@gmail.com"

class GetReferenceModel {
  GetReferenceModel({
      String? trefid, 
      String? trefdsc, 
      String? trefsts, 
      String? temladd,}){
    _trefid = trefid;
    _trefdsc = trefdsc;
    _trefsts = trefsts;
    _temladd = temladd;
}

  GetReferenceModel.fromJson(dynamic json) {
    _trefid = json['trefid'];
    _trefdsc = json['trefdsc'];
    _trefsts = json['trefsts'];
    _temladd = json['temladd'];
  }
  String? _trefid;
  String? _trefdsc;
  String? _trefsts;
  String? _temladd;
GetReferenceModel copyWith({  String? trefid,
  String? trefdsc,
  String? trefsts,
  String? temladd,
}) => GetReferenceModel(  trefid: trefid ?? _trefid,
  trefdsc: trefdsc ?? _trefdsc,
  trefsts: trefsts ?? _trefsts,
  temladd: temladd ?? _temladd,
);
  String? get trefid => _trefid;
  String? get trefdsc => _trefdsc;
  String? get trefsts => _trefsts;
  String? get temladd => _temladd;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['trefid'] = _trefid;
    map['trefdsc'] = _trefdsc;
    map['trefsts'] = _trefsts;
    map['temladd'] = _temladd;
    return map;
  }

}