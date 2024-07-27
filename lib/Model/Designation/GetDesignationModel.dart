/// tdsgid : "1"
/// tdsgdsc : "Mobile App Developer"
/// tdsgsts : "Yes"

class GetDesignationModel {
  GetDesignationModel({
      String? tdsgid, 
      String? tdsgdsc, 
      String? tdsgsts,}){
    _tdsgid = tdsgid;
    _tdsgdsc = tdsgdsc;
    _tdsgsts = tdsgsts;
}

  GetDesignationModel.fromJson(dynamic json) {
    _tdsgid = json['tdsgid'];
    _tdsgdsc = json['tdsgdsc'];
    _tdsgsts = json['tdsgsts'];
  }
  String? _tdsgid;
  String? _tdsgdsc;
  String? _tdsgsts;
GetDesignationModel copyWith({  String? tdsgid,
  String? tdsgdsc,
  String? tdsgsts,
}) => GetDesignationModel(  tdsgid: tdsgid ?? _tdsgid,
  tdsgdsc: tdsgdsc ?? _tdsgdsc,
  tdsgsts: tdsgsts ?? _tdsgsts,
);
  String? get tdsgid => _tdsgid;
  String? get tdsgdsc => _tdsgdsc;
  String? get tdsgsts => _tdsgsts;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['tdsgid'] = _tdsgid;
    map['tdsgdsc'] = _tdsgdsc;
    map['tdsgsts'] = _tdsgsts;
    return map;
  }

}