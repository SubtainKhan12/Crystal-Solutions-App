/// Inv# : "124"
/// Date : "2024-08-06"
/// Description : "BILL GENERATED FOR MONTH OF JULY"
/// Cust Id : "9"
/// Customer Name : "ALI ELECTRONICS SADDAR"
/// Contact Person : "BABER"
/// Address 1. : "Test"
/// Address 2. : "Test"
/// Mobile # : "03024899220"
/// Email : "Test1234@gmail.com"
/// Arrear : "0.00"
/// Server Chg : "0.00"
/// Advacne Chg : "0.00"
/// Monthly Chg : "4000.00"
/// SMS Chg : "0.00"
/// PSO Chg : "0.00"
/// Other Chg : "0.00"

class GetBillModel {
  GetBillModel({
      String? inv, 
      String? date, 
      String? description, 
      String? custId, 
      String? customerName, 
      String? contactPerson, 
      String? address1, 
      String? address2, 
      String? mobile, 
      String? email, 
      String? arrear, 
      String? serverChg, 
      String? advacneChg, 
      String? monthlyChg, 
      String? sMSChg, 
      String? pSOChg, 
      String? otherChg,}){
    _inv = inv;
    _date = date;
    _description = description;
    _custId = custId;
    _customerName = customerName;
    _contactPerson = contactPerson;
    _address1 = address1;
    _address2 = address2;
    _mobile = mobile;
    _email = email;
    _arrear = arrear;
    _serverChg = serverChg;
    _advacneChg = advacneChg;
    _monthlyChg = monthlyChg;
    _sMSChg = sMSChg;
    _pSOChg = pSOChg;
    _otherChg = otherChg;
}

  GetBillModel.fromJson(dynamic json) {
    _inv = json['Inv#'];
    _date = json['Date'];
    _description = json['Description'];
    _custId = json['Cust Id'];
    _customerName = json['Customer Name'];
    _contactPerson = json['Contact Person'];
    _address1 = json['Address 1.'];
    _address2 = json['Address 2.'];
    _mobile = json['Mobile #'];
    _email = json['Email'];
    _arrear = json['Arrear'];
    _serverChg = json['Server Chg'];
    _advacneChg = json['Advacne Chg'];
    _monthlyChg = json['Monthly Chg'];
    _sMSChg = json['SMS Chg'];
    _pSOChg = json['PSO Chg'];
    _otherChg = json['Other Chg'];
  }
  String? _inv;
  String? _date;
  String? _description;
  String? _custId;
  String? _customerName;
  String? _contactPerson;
  String? _address1;
  String? _address2;
  String? _mobile;
  String? _email;
  String? _arrear;
  String? _serverChg;
  String? _advacneChg;
  String? _monthlyChg;
  String? _sMSChg;
  String? _pSOChg;
  String? _otherChg;
GetBillModel copyWith({  String? inv,
  String? date,
  String? description,
  String? custId,
  String? customerName,
  String? contactPerson,
  String? address1,
  String? address2,
  String? mobile,
  String? email,
  String? arrear,
  String? serverChg,
  String? advacneChg,
  String? monthlyChg,
  String? sMSChg,
  String? pSOChg,
  String? otherChg,
}) => GetBillModel(  inv: inv ?? _inv,
  date: date ?? _date,
  description: description ?? _description,
  custId: custId ?? _custId,
  customerName: customerName ?? _customerName,
  contactPerson: contactPerson ?? _contactPerson,
  address1: address1 ?? _address1,
  address2: address2 ?? _address2,
  mobile: mobile ?? _mobile,
  email: email ?? _email,
  arrear: arrear ?? _arrear,
  serverChg: serverChg ?? _serverChg,
  advacneChg: advacneChg ?? _advacneChg,
  monthlyChg: monthlyChg ?? _monthlyChg,
  sMSChg: sMSChg ?? _sMSChg,
  pSOChg: pSOChg ?? _pSOChg,
  otherChg: otherChg ?? _otherChg,
);
  String? get inv => _inv;
  String? get date => _date;
  String? get description => _description;
  String? get custId => _custId;
  String? get customerName => _customerName;
  String? get contactPerson => _contactPerson;
  String? get address1 => _address1;
  String? get address2 => _address2;
  String? get mobile => _mobile;
  String? get email => _email;
  String? get arrear => _arrear;
  String? get serverChg => _serverChg;
  String? get advacneChg => _advacneChg;
  String? get monthlyChg => _monthlyChg;
  String? get sMSChg => _sMSChg;
  String? get pSOChg => _pSOChg;
  String? get otherChg => _otherChg;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['Inv#'] = _inv;
    map['Date'] = _date;
    map['Description'] = _description;
    map['Cust Id'] = _custId;
    map['Customer Name'] = _customerName;
    map['Contact Person'] = _contactPerson;
    map['Address 1.'] = _address1;
    map['Address 2.'] = _address2;
    map['Mobile #'] = _mobile;
    map['Email'] = _email;
    map['Arrear'] = _arrear;
    map['Server Chg'] = _serverChg;
    map['Advacne Chg'] = _advacneChg;
    map['Monthly Chg'] = _monthlyChg;
    map['SMS Chg'] = _sMSChg;
    map['PSO Chg'] = _pSOChg;
    map['Other Chg'] = _otherChg;
    return map;
  }

}