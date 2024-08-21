/// Col# : "137"
/// Date : "2024-08-20"
/// Description : "BILL FOR THE MONTH OF JULY"
/// Cust Id : "9"
/// Customer Name : "ALI ELECTRONICS SADDAR"
/// Contact Person : "BABER"
/// Address 1. : "Test"
/// Address 2. : "Test"
/// Mobile # : "03024899220"
/// Email : "Test1234@gmail.com"
/// Arrear : null
/// Server Chg : null
/// Advacne Chg : null
/// Monthly Chg : null
/// SMS Chg : null
/// PSO Chg : null
/// Other Chg : null
/// Amount : "100.00"
/// Image : "20240820111754."

class GetCollectionModel {
  GetCollectionModel({
      String? col, 
      String? date, 
      String? description, 
      String? custId, 
      String? customerName, 
      String? contactPerson, 
      String? address1, 
      String? address2, 
      String? mobile, 
      String? email, 
      dynamic arrear, 
      dynamic serverChg, 
      dynamic advacneChg, 
      dynamic monthlyChg, 
      dynamic sMSChg, 
      dynamic pSOChg, 
      dynamic otherChg, 
      String? amount, 
      String? image,}){
    _col = col;
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
    _amount = amount;
    _image = image;
}

  GetCollectionModel.fromJson(dynamic json) {
    _col = json['Col#'];
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
    _amount = json['Amount'];
    _image = json['Image'];
  }
  String? _col;
  String? _date;
  String? _description;
  String? _custId;
  String? _customerName;
  String? _contactPerson;
  String? _address1;
  String? _address2;
  String? _mobile;
  String? _email;
  dynamic _arrear;
  dynamic _serverChg;
  dynamic _advacneChg;
  dynamic _monthlyChg;
  dynamic _sMSChg;
  dynamic _pSOChg;
  dynamic _otherChg;
  String? _amount;
  String? _image;
GetCollectionModel copyWith({  String? col,
  String? date,
  String? description,
  String? custId,
  String? customerName,
  String? contactPerson,
  String? address1,
  String? address2,
  String? mobile,
  String? email,
  dynamic arrear,
  dynamic serverChg,
  dynamic advacneChg,
  dynamic monthlyChg,
  dynamic sMSChg,
  dynamic pSOChg,
  dynamic otherChg,
  String? amount,
  String? image,
}) => GetCollectionModel(  col: col ?? _col,
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
  amount: amount ?? _amount,
  image: image ?? _image,
);
  String? get col => _col;
  String? get date => _date;
  String? get description => _description;
  String? get custId => _custId;
  String? get customerName => _customerName;
  String? get contactPerson => _contactPerson;
  String? get address1 => _address1;
  String? get address2 => _address2;
  String? get mobile => _mobile;
  String? get email => _email;
  dynamic get arrear => _arrear;
  dynamic get serverChg => _serverChg;
  dynamic get advacneChg => _advacneChg;
  dynamic get monthlyChg => _monthlyChg;
  dynamic get sMSChg => _sMSChg;
  dynamic get pSOChg => _pSOChg;
  dynamic get otherChg => _otherChg;
  String? get amount => _amount;
  String? get image => _image;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['Col#'] = _col;
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
    map['Amount'] = _amount;
    map['Image'] = _image;
    return map;
  }

}