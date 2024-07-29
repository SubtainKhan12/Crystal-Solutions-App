/// ttypid : "7"
/// ttypdsc : "Trading "
/// ttypsts : "Yes"

class GetActiveType {
  GetActiveType({
      String? ttypid, 
      String? ttypdsc, 
      String? ttypsts,}){
    _ttypid = ttypid;
    _ttypdsc = ttypdsc;
    _ttypsts = ttypsts;
}

  GetActiveType.fromJson(dynamic json) {
    _ttypid = json['ttypid'];
    _ttypdsc = json['ttypdsc'];
    _ttypsts = json['ttypsts'];
  }
  String? _ttypid;
  String? _ttypdsc;
  String? _ttypsts;
GetActiveType copyWith({  String? ttypid,
  String? ttypdsc,
  String? ttypsts,
}) => GetActiveType(  ttypid: ttypid ?? _ttypid,
  ttypdsc: ttypdsc ?? _ttypdsc,
  ttypsts: ttypsts ?? _ttypsts,
);
  String? get ttypid => _ttypid;
  String? get ttypdsc => _ttypdsc;
  String? get ttypsts => _ttypsts;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['ttypid'] = _ttypid;
    map['ttypdsc'] = _ttypdsc;
    map['ttypsts'] = _ttypsts;
    return map;
  }

}