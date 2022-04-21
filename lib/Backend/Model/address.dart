class Address {
  String? id;
  String? name;
  String? mobile;
  String? buildingName;
  String? area;
  String? country;
  String? landmark;
  String? addressType;
  double? latitude;
  double? longitude;

  Address();

  Address.fromJSON(Map<String, dynamic> json) {
    try {
      id = json['_id'].toString();
      name = json['name'] ?? '';
      mobile = json['mobile'] ?? '';
      buildingName = json['building_name'] ?? '';
      area = json['area'] ?? '';
      country = json['country'] ?? '';
      landmark = json['landmark'] ?? '';
      addressType = json['address_type'] ?? '';
    } catch (e) {
      print(e);
    }
  }

  Map toMap() {
    var map = Map<String, dynamic>();
    map["_id"] = id ?? '0';
    map["name"] = name ?? '';
    map["mobile"] = mobile ?? '';
    map["building_name"] = buildingName ?? '';
    map["area"] = area ?? '';
    map["country"] = country ?? '';
    map["landmark"] = landmark ?? '';
    map['address_type'] = addressType ?? '';
    return map;
  }
}
