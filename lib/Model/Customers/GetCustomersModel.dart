/// tcstid : "9"
/// TCstDsc : "Ali Electronics Saddar"
/// TCstSts : "Yes"
/// TCntPer : "Baber"
/// TMobNUm : "03024899220"
/// TPhnNum : "03024899220"
/// TAdd001 : "Test"
/// TAdd002 : "Test"
/// TEmlAdd : "Test1234@gmail.com"
/// TShpNum : "2"
/// tsrvchg : null
/// TmthChg : "4000.00"
/// tsmschg : null
/// tadvchg : null
/// tposchg : null
/// ttotamt : null
/// TLatVal : "1"
/// TLngVal : "1"
/// TRefId : "7"
/// tctyid : "5"
/// TTypId : "9"
/// TColId : "5"
/// TSrvIp : ""
/// TCstPic : null

class GetCustomersModel {
  GetCustomersModel({
      String? tcstid, 
      String? tCstDsc, 
      String? tCstSts, 
      String? tCntPer, 
      String? tMobNUm, 
      String? tPhnNum, 
      String? tAdd001, 
      String? tAdd002, 
      String? tEmlAdd, 
      String? tShpNum, 
      dynamic tsrvchg, 
      String? tmthChg, 
      dynamic tsmschg, 
      dynamic tadvchg, 
      dynamic tposchg, 
      dynamic ttotamt, 
      String? tLatVal, 
      String? tLngVal, 
      String? tRefId, 
      String? tctyid, 
      String? tTypId, 
      String? tColId, 
      String? tSrvIp, 
      dynamic tCstPic,}){
    _tcstid = tcstid;
    _tCstDsc = tCstDsc;
    _tCstSts = tCstSts;
    _tCntPer = tCntPer;
    _tMobNUm = tMobNUm;
    _tPhnNum = tPhnNum;
    _tAdd001 = tAdd001;
    _tAdd002 = tAdd002;
    _tEmlAdd = tEmlAdd;
    _tShpNum = tShpNum;
    _tsrvchg = tsrvchg;
    _tmthChg = tmthChg;
    _tsmschg = tsmschg;
    _tadvchg = tadvchg;
    _tposchg = tposchg;
    _ttotamt = ttotamt;
    _tLatVal = tLatVal;
    _tLngVal = tLngVal;
    _tRefId = tRefId;
    _tctyid = tctyid;
    _tTypId = tTypId;
    _tColId = tColId;
    _tSrvIp = tSrvIp;
    _tCstPic = tCstPic;
}

  GetCustomersModel.fromJson(dynamic json) {
    _tcstid = json['tcstid'];
    _tCstDsc = json['TCstDsc'];
    _tCstSts = json['TCstSts'];
    _tCntPer = json['TCntPer'];
    _tMobNUm = json['TMobNUm'];
    _tPhnNum = json['TPhnNum'];
    _tAdd001 = json['TAdd001'];
    _tAdd002 = json['TAdd002'];
    _tEmlAdd = json['TEmlAdd'];
    _tShpNum = json['TShpNum'];
    _tsrvchg = json['tsrvchg'];
    _tmthChg = json['TmthChg'];
    _tsmschg = json['tsmschg'];
    _tadvchg = json['tadvchg'];
    _tposchg = json['tposchg'];
    _ttotamt = json['ttotamt'];
    _tLatVal = json['TLatVal'];
    _tLngVal = json['TLngVal'];
    _tRefId = json['TRefId'];
    _tctyid = json['tctyid'];
    _tTypId = json['TTypId'];
    _tColId = json['TColId'];
    _tSrvIp = json['TSrvIp'];
    _tCstPic = json['TCstPic'];
  }
  String? _tcstid;
  String? _tCstDsc;
  String? _tCstSts;
  String? _tCntPer;
  String? _tMobNUm;
  String? _tPhnNum;
  String? _tAdd001;
  String? _tAdd002;
  String? _tEmlAdd;
  String? _tShpNum;
  dynamic _tsrvchg;
  String? _tmthChg;
  dynamic _tsmschg;
  dynamic _tadvchg;
  dynamic _tposchg;
  dynamic _ttotamt;
  String? _tLatVal;
  String? _tLngVal;
  String? _tRefId;
  String? _tctyid;
  String? _tTypId;
  String? _tColId;
  String? _tSrvIp;
  dynamic _tCstPic;
GetCustomersModel copyWith({  String? tcstid,
  String? tCstDsc,
  String? tCstSts,
  String? tCntPer,
  String? tMobNUm,
  String? tPhnNum,
  String? tAdd001,
  String? tAdd002,
  String? tEmlAdd,
  String? tShpNum,
  dynamic tsrvchg,
  String? tmthChg,
  dynamic tsmschg,
  dynamic tadvchg,
  dynamic tposchg,
  dynamic ttotamt,
  String? tLatVal,
  String? tLngVal,
  String? tRefId,
  String? tctyid,
  String? tTypId,
  String? tColId,
  String? tSrvIp,
  dynamic tCstPic,
}) => GetCustomersModel(  tcstid: tcstid ?? _tcstid,
  tCstDsc: tCstDsc ?? _tCstDsc,
  tCstSts: tCstSts ?? _tCstSts,
  tCntPer: tCntPer ?? _tCntPer,
  tMobNUm: tMobNUm ?? _tMobNUm,
  tPhnNum: tPhnNum ?? _tPhnNum,
  tAdd001: tAdd001 ?? _tAdd001,
  tAdd002: tAdd002 ?? _tAdd002,
  tEmlAdd: tEmlAdd ?? _tEmlAdd,
  tShpNum: tShpNum ?? _tShpNum,
  tsrvchg: tsrvchg ?? _tsrvchg,
  tmthChg: tmthChg ?? _tmthChg,
  tsmschg: tsmschg ?? _tsmschg,
  tadvchg: tadvchg ?? _tadvchg,
  tposchg: tposchg ?? _tposchg,
  ttotamt: ttotamt ?? _ttotamt,
  tLatVal: tLatVal ?? _tLatVal,
  tLngVal: tLngVal ?? _tLngVal,
  tRefId: tRefId ?? _tRefId,
  tctyid: tctyid ?? _tctyid,
  tTypId: tTypId ?? _tTypId,
  tColId: tColId ?? _tColId,
  tSrvIp: tSrvIp ?? _tSrvIp,
  tCstPic: tCstPic ?? _tCstPic,
);
  String? get tcstid => _tcstid;
  String? get tCstDsc => _tCstDsc;
  String? get tCstSts => _tCstSts;
  String? get tCntPer => _tCntPer;
  String? get tMobNUm => _tMobNUm;
  String? get tPhnNum => _tPhnNum;
  String? get tAdd001 => _tAdd001;
  String? get tAdd002 => _tAdd002;
  String? get tEmlAdd => _tEmlAdd;
  String? get tShpNum => _tShpNum;
  dynamic get tsrvchg => _tsrvchg;
  String? get tmthChg => _tmthChg;
  dynamic get tsmschg => _tsmschg;
  dynamic get tadvchg => _tadvchg;
  dynamic get tposchg => _tposchg;
  dynamic get ttotamt => _ttotamt;
  String? get tLatVal => _tLatVal;
  String? get tLngVal => _tLngVal;
  String? get tRefId => _tRefId;
  String? get tctyid => _tctyid;
  String? get tTypId => _tTypId;
  String? get tColId => _tColId;
  String? get tSrvIp => _tSrvIp;
  dynamic get tCstPic => _tCstPic;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['tcstid'] = _tcstid;
    map['TCstDsc'] = _tCstDsc;
    map['TCstSts'] = _tCstSts;
    map['TCntPer'] = _tCntPer;
    map['TMobNUm'] = _tMobNUm;
    map['TPhnNum'] = _tPhnNum;
    map['TAdd001'] = _tAdd001;
    map['TAdd002'] = _tAdd002;
    map['TEmlAdd'] = _tEmlAdd;
    map['TShpNum'] = _tShpNum;
    map['tsrvchg'] = _tsrvchg;
    map['TmthChg'] = _tmthChg;
    map['tsmschg'] = _tsmschg;
    map['tadvchg'] = _tadvchg;
    map['tposchg'] = _tposchg;
    map['ttotamt'] = _ttotamt;
    map['TLatVal'] = _tLatVal;
    map['TLngVal'] = _tLngVal;
    map['TRefId'] = _tRefId;
    map['tctyid'] = _tctyid;
    map['TTypId'] = _tTypId;
    map['TColId'] = _tColId;
    map['TSrvIp'] = _tSrvIp;
    map['TCstPic'] = _tCstPic;
    return map;
  }

}