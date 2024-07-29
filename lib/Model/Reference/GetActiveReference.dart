/// trefid : "7"
/// trefdsc : "Office"
/// trefsts : "Yes"
/// temladd : "crystalsolutions6686@gmail.com"

class GetActiveReference {
  GetActiveReference({
      String? trefid, 
      String? trefdsc, 
      String? trefsts, 
      String? temladd,}){
    _trefid = trefid;
    _trefdsc = trefdsc;
    _trefsts = trefsts;
    _temladd = temladd;
}

  GetActiveReference.fromJson(dynamic json) {
    _trefid = json['trefid'];
    _trefdsc = json['trefdsc'];
    _trefsts = json['trefsts'];
    _temladd = json['temladd'];
  }
  String? _trefid;
  String? _trefdsc;
  String? _trefsts;
  String? _temladd;
GetActiveReference copyWith({  String? trefid,
  String? trefdsc,
  String? trefsts,
  String? temladd,
}) => GetActiveReference(  trefid: trefid ?? _trefid,
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