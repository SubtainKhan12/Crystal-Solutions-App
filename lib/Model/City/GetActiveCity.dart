/// tctyid : "5"
/// tctydsc : "Lahore "
/// tctysts : "Yes"

class GetActiveCity {
  GetActiveCity({
      String? tctyid, 
      String? tctydsc, 
      String? tctysts,}){
    _tctyid = tctyid;
    _tctydsc = tctydsc;
    _tctysts = tctysts;
}

  GetActiveCity.fromJson(dynamic json) {
    _tctyid = json['tctyid'];
    _tctydsc = json['tctydsc'];
    _tctysts = json['tctysts'];
  }
  String? _tctyid;
  String? _tctydsc;
  String? _tctysts;
GetActiveCity copyWith({  String? tctyid,
  String? tctydsc,
  String? tctysts,
}) => GetActiveCity(  tctyid: tctyid ?? _tctyid,
  tctydsc: tctydsc ?? _tctydsc,
  tctysts: tctysts ?? _tctysts,
);
  String? get tctyid => _tctyid;
  String? get tctydsc => _tctydsc;
  String? get tctysts => _tctysts;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['tctyid'] = _tctyid;
    map['tctydsc'] = _tctydsc;
    map['tctysts'] = _tctysts;
    return map;
  }

}