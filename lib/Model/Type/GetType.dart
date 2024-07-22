/// ttypid : "1"
/// ttypdsc : "Subtain Khan"
/// ttypsts : "No"

class GetType {
  GetType({
      String? ttypid, 
      String? ttypdsc, 
      String? ttypsts,}){
    _ttypid = ttypid;
    _ttypdsc = ttypdsc;
    _ttypsts = ttypsts;
}

  GetType.fromJson(dynamic json) {
    _ttypid = json['ttypid'];
    _ttypdsc = json['ttypdsc'];
    _ttypsts = json['ttypsts'];
  }
  String? _ttypid;
  String? _ttypdsc;
  String? _ttypsts;
GetType copyWith({  String? ttypid,
  String? ttypdsc,
  String? ttypsts,
}) => GetType(  ttypid: ttypid ?? _ttypid,
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