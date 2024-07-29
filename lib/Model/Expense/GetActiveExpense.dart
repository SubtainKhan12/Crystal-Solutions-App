/// texpid : "3"
/// texpdsc : "Staff Salary"
/// texpsts : "Yes"
/// tmthbgt : "1"

class GetActiveExpense {
  GetActiveExpense({
      String? texpid, 
      String? texpdsc, 
      String? texpsts, 
      String? tmthbgt,}){
    _texpid = texpid;
    _texpdsc = texpdsc;
    _texpsts = texpsts;
    _tmthbgt = tmthbgt;
}

  GetActiveExpense.fromJson(dynamic json) {
    _texpid = json['texpid'];
    _texpdsc = json['texpdsc'];
    _texpsts = json['texpsts'];
    _tmthbgt = json['tmthbgt'];
  }
  String? _texpid;
  String? _texpdsc;
  String? _texpsts;
  String? _tmthbgt;
GetActiveExpense copyWith({  String? texpid,
  String? texpdsc,
  String? texpsts,
  String? tmthbgt,
}) => GetActiveExpense(  texpid: texpid ?? _texpid,
  texpdsc: texpdsc ?? _texpdsc,
  texpsts: texpsts ?? _texpsts,
  tmthbgt: tmthbgt ?? _tmthbgt,
);
  String? get texpid => _texpid;
  String? get texpdsc => _texpdsc;
  String? get texpsts => _texpsts;
  String? get tmthbgt => _tmthbgt;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['texpid'] = _texpid;
    map['texpdsc'] = _texpdsc;
    map['texpsts'] = _texpsts;
    map['tmthbgt'] = _tmthbgt;
    return map;
  }

}