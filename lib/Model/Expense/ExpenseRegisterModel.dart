/// detail : [{"Date":"02-08-2024","Trn#":"7","expense":"Lunch Expense ","Description":"vegetable potato onion","Amount":"950.00"},{"Date":"01-08-2024","Trn#":"6","expense":"Lunch Expense ","Description":"Chicken Rice Tomato Onion Yogurt ","Amount":"1050.00"}]

class ExpenseRegisterModel {
  ExpenseRegisterModel({
      List<Detail>? detail,}){
    _detail = detail;
}

  ExpenseRegisterModel.fromJson(dynamic json) {
    if (json['detail'] != null) {
      _detail = [];
      json['detail'].forEach((v) {
        _detail?.add(Detail.fromJson(v));
      });
    }
  }
  List<Detail>? _detail;
ExpenseRegisterModel copyWith({  List<Detail>? detail,
}) => ExpenseRegisterModel(  detail: detail ?? _detail,
);
  List<Detail>? get detail => _detail;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    if (_detail != null) {
      map['detail'] = _detail?.map((v) => v.toJson()).toList();
    }
    return map;
  }

}

/// Date : "02-08-2024"
/// Trn# : "7"
/// expense : "Lunch Expense "
/// Description : "vegetable potato onion"
/// Amount : "950.00"

class Detail {
  Detail({
      String? date, 
      String? trn, 
      String? expense, 
      String? description, 
      String? amount,}){
    _date = date;
    _trn = trn;
    _expense = expense;
    _description = description;
    _amount = amount;
}

  Detail.fromJson(dynamic json) {
    _date = json['Date'];
    _trn = json['Trn#'];
    _expense = json['expense'];
    _description = json['Description'];
    _amount = json['Amount'];
  }
  String? _date;
  String? _trn;
  String? _expense;
  String? _description;
  String? _amount;
Detail copyWith({  String? date,
  String? trn,
  String? expense,
  String? description,
  String? amount,
}) => Detail(  date: date ?? _date,
  trn: trn ?? _trn,
  expense: expense ?? _expense,
  description: description ?? _description,
  amount: amount ?? _amount,
);
  String? get date => _date;
  String? get trn => _trn;
  String? get expense => _expense;
  String? get description => _description;
  String? get amount => _amount;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['Date'] = _date;
    map['Trn#'] = _trn;
    map['expense'] = _expense;
    map['Description'] = _description;
    map['Amount'] = _amount;
    return map;
  }

}