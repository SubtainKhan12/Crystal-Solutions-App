/// id : "1"
/// TusrId : "ghauri"
/// TUsrPwd : "112233"
/// TUsrNam : "Abdul Razaq Ghauri"
/// TusrTyp : "Admin"
/// TUsrSts : "Yes"
/// TMobNum : "03218811400"
/// TUsrEml : "ghauri@gmail.com"

class GetUsersModel {
  GetUsersModel({
      String? id, 
      String? tusrId, 
      String? tUsrPwd, 
      String? tUsrNam, 
      String? tusrTyp, 
      String? tUsrSts, 
      String? tMobNum, 
      String? tUsrEml,}){
    _id = id;
    _tusrId = tusrId;
    _tUsrPwd = tUsrPwd;
    _tUsrNam = tUsrNam;
    _tusrTyp = tusrTyp;
    _tUsrSts = tUsrSts;
    _tMobNum = tMobNum;
    _tUsrEml = tUsrEml;
}

  GetUsersModel.fromJson(dynamic json) {
    _id = json['id'];
    _tusrId = json['TusrId'];
    _tUsrPwd = json['TUsrPwd'];
    _tUsrNam = json['TUsrNam'];
    _tusrTyp = json['TusrTyp'];
    _tUsrSts = json['TUsrSts'];
    _tMobNum = json['TMobNum'];
    _tUsrEml = json['TUsrEml'];
  }
  String? _id;
  String? _tusrId;
  String? _tUsrPwd;
  String? _tUsrNam;
  String? _tusrTyp;
  String? _tUsrSts;
  String? _tMobNum;
  String? _tUsrEml;
GetUsersModel copyWith({  String? id,
  String? tusrId,
  String? tUsrPwd,
  String? tUsrNam,
  String? tusrTyp,
  String? tUsrSts,
  String? tMobNum,
  String? tUsrEml,
}) => GetUsersModel(  id: id ?? _id,
  tusrId: tusrId ?? _tusrId,
  tUsrPwd: tUsrPwd ?? _tUsrPwd,
  tUsrNam: tUsrNam ?? _tUsrNam,
  tusrTyp: tusrTyp ?? _tusrTyp,
  tUsrSts: tUsrSts ?? _tUsrSts,
  tMobNum: tMobNum ?? _tMobNum,
  tUsrEml: tUsrEml ?? _tUsrEml,
);
  String? get id => _id;
  String? get tusrId => _tusrId;
  String? get tUsrPwd => _tUsrPwd;
  String? get tUsrNam => _tUsrNam;
  String? get tusrTyp => _tusrTyp;
  String? get tUsrSts => _tUsrSts;
  String? get tMobNum => _tMobNum;
  String? get tUsrEml => _tUsrEml;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['id'] = _id;
    map['TusrId'] = _tusrId;
    map['TUsrPwd'] = _tUsrPwd;
    map['TUsrNam'] = _tUsrNam;
    map['TusrTyp'] = _tusrTyp;
    map['TUsrSts'] = _tUsrSts;
    map['TMobNum'] = _tMobNum;
    map['TUsrEml'] = _tUsrEml;
    return map;
  }

}