/// detail : [{"Date":"03-07-2024","Trn#":"54","Type":"COL","customer":"Ali Electronics Saddar","Collection":"4100.00"}]
/// Total Amount : "4,100"

class CollectionsRegistersModel {
  CollectionsRegistersModel({
      List<Detail>? detail, 
      String? totalAmount,}){
    _detail = detail;
    _totalAmount = totalAmount;
}

  CollectionsRegistersModel.fromJson(dynamic json) {
    if (json['detail'] != null) {
      _detail = [];
      json['detail'].forEach((v) {
        _detail?.add(Detail.fromJson(v));
      });
    }
    _totalAmount = json['Total Amount'];
  }
  List<Detail>? _detail;
  String? _totalAmount;
CollectionsRegistersModel copyWith({  List<Detail>? detail,
  String? totalAmount,
}) => CollectionsRegistersModel(  detail: detail ?? _detail,
  totalAmount: totalAmount ?? _totalAmount,
);
  List<Detail>? get detail => _detail;
  String? get totalAmount => _totalAmount;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    if (_detail != null) {
      map['detail'] = _detail?.map((v) => v.toJson()).toList();
    }
    map['Total Amount'] = _totalAmount;
    return map;
  }

}

/// Date : "03-07-2024"
/// Trn# : "54"
/// Type : "COL"
/// customer : "Ali Electronics Saddar"
/// Collection : "4100.00"

class Detail {
  Detail({
      String? date, 
      String? trn, 
      String? type, 
      String? customer, 
      String? collection,}){
    _date = date;
    _trn = trn;
    _type = type;
    _customer = customer;
    _collection = collection;
}

  Detail.fromJson(dynamic json) {
    _date = json['Date'];
    _trn = json['Trn#'];
    _type = json['Type'];
    _customer = json['customer'];
    _collection = json['Collection'];
  }
  String? _date;
  String? _trn;
  String? _type;
  String? _customer;
  String? _collection;
Detail copyWith({  String? date,
  String? trn,
  String? type,
  String? customer,
  String? collection,
}) => Detail(  date: date ?? _date,
  trn: trn ?? _trn,
  type: type ?? _type,
  customer: customer ?? _customer,
  collection: collection ?? _collection,
);
  String? get date => _date;
  String? get trn => _trn;
  String? get type => _type;
  String? get customer => _customer;
  String? get collection => _collection;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['Date'] = _date;
    map['Trn#'] = _trn;
    map['Type'] = _type;
    map['customer'] = _customer;
    map['Collection'] = _collection;
    return map;
  }

}