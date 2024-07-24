/// tcolid : "1"
/// tcoldsc : "Subtain Khan"
/// tcolsts : "Yes"
/// tadd001 : "House # 402 "
/// tadd002 : "GariShahu Lahore"
/// tmobnum : "03098855072"
/// temladd : "subtainkhan5656@gmail.com"

class GetCollectorsModel {
  GetCollectorsModel({
      String? tcolid, 
      String? tcoldsc, 
      String? tcolsts, 
      String? tadd001, 
      String? tadd002, 
      String? tmobnum, 
      String? temladd,}){
    _tcolid = tcolid;
    _tcoldsc = tcoldsc;
    _tcolsts = tcolsts;
    _tadd001 = tadd001;
    _tadd002 = tadd002;
    _tmobnum = tmobnum;
    _temladd = temladd;
}

  GetCollectorsModel.fromJson(dynamic json) {
    _tcolid = json['tcolid'];
    _tcoldsc = json['tcoldsc'];
    _tcolsts = json['tcolsts'];
    _tadd001 = json['tadd001'];
    _tadd002 = json['tadd002'];
    _tmobnum = json['tmobnum'];
    _temladd = json['temladd'];
  }
  String? _tcolid;
  String? _tcoldsc;
  String? _tcolsts;
  String? _tadd001;
  String? _tadd002;
  String? _tmobnum;
  String? _temladd;
GetCollectorsModel copyWith({  String? tcolid,
  String? tcoldsc,
  String? tcolsts,
  String? tadd001,
  String? tadd002,
  String? tmobnum,
  String? temladd,
}) => GetCollectorsModel(  tcolid: tcolid ?? _tcolid,
  tcoldsc: tcoldsc ?? _tcoldsc,
  tcolsts: tcolsts ?? _tcolsts,
  tadd001: tadd001 ?? _tadd001,
  tadd002: tadd002 ?? _tadd002,
  tmobnum: tmobnum ?? _tmobnum,
  temladd: temladd ?? _temladd,
);
  String? get tcolid => _tcolid;
  String? get tcoldsc => _tcoldsc;
  String? get tcolsts => _tcolsts;
  String? get tadd001 => _tadd001;
  String? get tadd002 => _tadd002;
  String? get tmobnum => _tmobnum;
  String? get temladd => _temladd;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['tcolid'] = _tcolid;
    map['tcoldsc'] = _tcoldsc;
    map['tcolsts'] = _tcolsts;
    map['tadd001'] = _tadd001;
    map['tadd002'] = _tadd002;
    map['tmobnum'] = _tmobnum;
    map['temladd'] = _temladd;
    return map;
  }

}