/// tempid : "1"
/// tempnam : "subtain khan"
/// tempsts : "Yes"
/// tfthnam : "Sajjad Khan"
/// tadd001 : "GariShahu"
/// tadd002 : "Lahore"
/// tmobnum : "03098855070"
/// temladd : "subtain@gmail.com"
/// tempsal : "1000.00"
/// tnicnum : "9837386378"
/// tbnknam : "Jazz Cash"
/// tbnkacc : "03098855070"
/// taccttl : "1"
/// tnicfnt : null
/// tnicbak : null
/// tcvpic : null
/// tdsgid : "1"

class GetEmployeeModel {
  GetEmployeeModel({
      String? tempid, 
      String? tempnam, 
      String? tempsts, 
      String? tfthnam, 
      String? tadd001, 
      String? tadd002, 
      String? tmobnum, 
      String? temladd, 
      String? tempsal, 
      String? tnicnum, 
      String? tbnknam, 
      String? tbnkacc, 
      String? taccttl, 
      dynamic tnicfnt, 
      dynamic tnicbak, 
      dynamic tcvpic, 
      String? tdsgid,}){
    _tempid = tempid;
    _tempnam = tempnam;
    _tempsts = tempsts;
    _tfthnam = tfthnam;
    _tadd001 = tadd001;
    _tadd002 = tadd002;
    _tmobnum = tmobnum;
    _temladd = temladd;
    _tempsal = tempsal;
    _tnicnum = tnicnum;
    _tbnknam = tbnknam;
    _tbnkacc = tbnkacc;
    _taccttl = taccttl;
    _tnicfnt = tnicfnt;
    _tnicbak = tnicbak;
    _tcvpic = tcvpic;
    _tdsgid = tdsgid;
}

  GetEmployeeModel.fromJson(dynamic json) {
    _tempid = json['tempid'];
    _tempnam = json['tempnam'];
    _tempsts = json['tempsts'];
    _tfthnam = json['tfthnam'];
    _tadd001 = json['tadd001'];
    _tadd002 = json['tadd002'];
    _tmobnum = json['tmobnum'];
    _temladd = json['temladd'];
    _tempsal = json['tempsal'];
    _tnicnum = json['tnicnum'];
    _tbnknam = json['tbnknam'];
    _tbnkacc = json['tbnkacc'];
    _taccttl = json['taccttl'];
    _tnicfnt = json['tnicfnt'];
    _tnicbak = json['tnicbak'];
    _tcvpic = json['tcvpic'];
    _tdsgid = json['tdsgid'];
  }
  String? _tempid;
  String? _tempnam;
  String? _tempsts;
  String? _tfthnam;
  String? _tadd001;
  String? _tadd002;
  String? _tmobnum;
  String? _temladd;
  String? _tempsal;
  String? _tnicnum;
  String? _tbnknam;
  String? _tbnkacc;
  String? _taccttl;
  dynamic _tnicfnt;
  dynamic _tnicbak;
  dynamic _tcvpic;
  String? _tdsgid;
GetEmployeeModel copyWith({  String? tempid,
  String? tempnam,
  String? tempsts,
  String? tfthnam,
  String? tadd001,
  String? tadd002,
  String? tmobnum,
  String? temladd,
  String? tempsal,
  String? tnicnum,
  String? tbnknam,
  String? tbnkacc,
  String? taccttl,
  dynamic tnicfnt,
  dynamic tnicbak,
  dynamic tcvpic,
  String? tdsgid,
}) => GetEmployeeModel(  tempid: tempid ?? _tempid,
  tempnam: tempnam ?? _tempnam,
  tempsts: tempsts ?? _tempsts,
  tfthnam: tfthnam ?? _tfthnam,
  tadd001: tadd001 ?? _tadd001,
  tadd002: tadd002 ?? _tadd002,
  tmobnum: tmobnum ?? _tmobnum,
  temladd: temladd ?? _temladd,
  tempsal: tempsal ?? _tempsal,
  tnicnum: tnicnum ?? _tnicnum,
  tbnknam: tbnknam ?? _tbnknam,
  tbnkacc: tbnkacc ?? _tbnkacc,
  taccttl: taccttl ?? _taccttl,
  tnicfnt: tnicfnt ?? _tnicfnt,
  tnicbak: tnicbak ?? _tnicbak,
  tcvpic: tcvpic ?? _tcvpic,
  tdsgid: tdsgid ?? _tdsgid,
);
  String? get tempid => _tempid;
  String? get tempnam => _tempnam;
  String? get tempsts => _tempsts;
  String? get tfthnam => _tfthnam;
  String? get tadd001 => _tadd001;
  String? get tadd002 => _tadd002;
  String? get tmobnum => _tmobnum;
  String? get temladd => _temladd;
  String? get tempsal => _tempsal;
  String? get tnicnum => _tnicnum;
  String? get tbnknam => _tbnknam;
  String? get tbnkacc => _tbnkacc;
  String? get taccttl => _taccttl;
  dynamic get tnicfnt => _tnicfnt;
  dynamic get tnicbak => _tnicbak;
  dynamic get tcvpic => _tcvpic;
  String? get tdsgid => _tdsgid;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['tempid'] = _tempid;
    map['tempnam'] = _tempnam;
    map['tempsts'] = _tempsts;
    map['tfthnam'] = _tfthnam;
    map['tadd001'] = _tadd001;
    map['tadd002'] = _tadd002;
    map['tmobnum'] = _tmobnum;
    map['temladd'] = _temladd;
    map['tempsal'] = _tempsal;
    map['tnicnum'] = _tnicnum;
    map['tbnknam'] = _tbnknam;
    map['tbnkacc'] = _tbnkacc;
    map['taccttl'] = _taccttl;
    map['tnicfnt'] = _tnicfnt;
    map['tnicbak'] = _tnicbak;
    map['tcvpic'] = _tcvpic;
    map['tdsgid'] = _tdsgid;
    return map;
  }

}