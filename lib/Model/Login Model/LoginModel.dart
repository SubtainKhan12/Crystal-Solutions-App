/// user : {"id":"1","TusrId":"ghauri","TUsrPwd":"112233","TUsrNam":"Abdul Razaq Ghauri","TusrTyp":"Admin","TUsrSts":"Yes","TMobNum":"03218811400","TUsrEml":"ghauri@gmail.com"}
/// error : 200
/// message : "login success"

class LoginModel {
  LoginModel({
      User? user, 
      num? error, 
      String? message,}){
    _user = user;
    _error = error;
    _message = message;
}

  LoginModel.fromJson(dynamic json) {
    _user = json['user'] != null ? User.fromJson(json['user']) : null;
    _error = json['error'];
    _message = json['message'];
  }
  User? _user;
  num? _error;
  String? _message;
LoginModel copyWith({  User? user,
  num? error,
  String? message,
}) => LoginModel(  user: user ?? _user,
  error: error ?? _error,
  message: message ?? _message,
);
  User? get user => _user;
  num? get error => _error;
  String? get message => _message;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    if (_user != null) {
      map['user'] = _user?.toJson();
    }
    map['error'] = _error;
    map['message'] = _message;
    return map;
  }

}

/// id : "1"
/// TusrId : "ghauri"
/// TUsrPwd : "112233"
/// TUsrNam : "Abdul Razaq Ghauri"
/// TusrTyp : "Admin"
/// TUsrSts : "Yes"
/// TMobNum : "03218811400"
/// TUsrEml : "ghauri@gmail.com"

class User {
  User({
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

  User.fromJson(dynamic json) {
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
User copyWith({  String? id,
  String? tusrId,
  String? tUsrPwd,
  String? tUsrNam,
  String? tusrTyp,
  String? tUsrSts,
  String? tMobNum,
  String? tUsrEml,
}) => User(  id: id ?? _id,
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