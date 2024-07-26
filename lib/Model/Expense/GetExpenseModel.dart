/// texpid : "1"
/// texpdsc : "LUNCH EXPENSIS"
/// texpsts : "Yes"
/// tmthbgt : "20000"

class GetExpenseModel {
  GetExpenseModel({
      String? texpid, 
      String? texpdsc, 
      String? texpsts, 
      String? tmthbgt,}){
    _texpid = texpid;
    _texpdsc = texpdsc;
    _texpsts = texpsts;
    _tmthbgt = tmthbgt;
}

  GetExpenseModel.fromJson(dynamic json) {
    _texpid = json['texpid'];
    _texpdsc = json['texpdsc'];
    _texpsts = json['texpsts'];
    _tmthbgt = json['tmthbgt'];
  }
  String? _texpid;
  String? _texpdsc;
  String? _texpsts;
  String? _tmthbgt;
GetExpenseModel copyWith({  String? texpid,
  String? texpdsc,
  String? texpsts,
  String? tmthbgt,
}) => GetExpenseModel(  texpid: texpid ?? _texpid,
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