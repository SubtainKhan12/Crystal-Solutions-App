/// Date : "2024-06-01"
/// Trn# : "5"
/// Type : "COL"
/// Description : "Collection For June, 2024."
/// Arr Chg : "100.00"
/// Srv Chg : "200.00"
/// Adv Chg : "400.00"
/// Mth Chg : "300.00"
/// SMS Chg : "500.00"
/// POS Chg : "600.00"
/// Debit : "800.00"
/// Credit : null

class CustomerLedgerModel {
  CustomerLedgerModel({
      String? date, 
      String? trn, 
      String? type, 
      String? description, 
      String? arrChg, 
      String? srvChg, 
      String? advChg, 
      String? mthChg, 
      String? sMSChg, 
      String? pOSChg, 
      String? debit, 
      dynamic credit,}){
    _date = date;
    _trn = trn;
    _type = type;
    _description = description;
    _arrChg = arrChg;
    _srvChg = srvChg;
    _advChg = advChg;
    _mthChg = mthChg;
    _sMSChg = sMSChg;
    _pOSChg = pOSChg;
    _debit = debit;
    _credit = credit;
}

  CustomerLedgerModel.fromJson(dynamic json) {
    _date = json['Date'];
    _trn = json['Trn#'];
    _type = json['Type'];
    _description = json['Description'];
    _arrChg = json['Arr Chg'];
    _srvChg = json['Srv Chg'];
    _advChg = json['Adv Chg'];
    _mthChg = json['Mth Chg'];
    _sMSChg = json['SMS Chg'];
    _pOSChg = json['POS Chg'];
    _debit = json['Debit'];
    _credit = json['Credit'];
  }
  String? _date;
  String? _trn;
  String? _type;
  String? _description;
  String? _arrChg;
  String? _srvChg;
  String? _advChg;
  String? _mthChg;
  String? _sMSChg;
  String? _pOSChg;
  String? _debit;
  dynamic _credit;
CustomerLedgerModel copyWith({  String? date,
  String? trn,
  String? type,
  String? description,
  String? arrChg,
  String? srvChg,
  String? advChg,
  String? mthChg,
  String? sMSChg,
  String? pOSChg,
  String? debit,
  dynamic credit,
}) => CustomerLedgerModel(  date: date ?? _date,
  trn: trn ?? _trn,
  type: type ?? _type,
  description: description ?? _description,
  arrChg: arrChg ?? _arrChg,
  srvChg: srvChg ?? _srvChg,
  advChg: advChg ?? _advChg,
  mthChg: mthChg ?? _mthChg,
  sMSChg: sMSChg ?? _sMSChg,
  pOSChg: pOSChg ?? _pOSChg,
  debit: debit ?? _debit,
  credit: credit ?? _credit,
);
  String? get date => _date;
  String? get trn => _trn;
  String? get type => _type;
  String? get description => _description;
  String? get arrChg => _arrChg;
  String? get srvChg => _srvChg;
  String? get advChg => _advChg;
  String? get mthChg => _mthChg;
  String? get sMSChg => _sMSChg;
  String? get pOSChg => _pOSChg;
  String? get debit => _debit;
  dynamic get credit => _credit;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['Date'] = _date;
    map['Trn#'] = _trn;
    map['Type'] = _type;
    map['Description'] = _description;
    map['Arr Chg'] = _arrChg;
    map['Srv Chg'] = _srvChg;
    map['Adv Chg'] = _advChg;
    map['Mth Chg'] = _mthChg;
    map['SMS Chg'] = _sMSChg;
    map['POS Chg'] = _pOSChg;
    map['Debit'] = _debit;
    map['Credit'] = _credit;
    return map;
  }

}