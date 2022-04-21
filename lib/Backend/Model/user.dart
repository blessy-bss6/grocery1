class User {
  String? id;
  String fName = '';
  String? lName;
  String? email;
  String? otp;
  String? roles;
  String? password;
  String? referrerCode;
  String? token = '';
  String? status;
  String? accountType;
  String? dob;
  String? mobile;
  String? image = 'https';
  String? address;
  String? gender;

  User();

  // {
  // "success": 1,
  // "message": "Login Successfully",
  // "id": 69,
  // "email": "aakhan2021@gmail.com",
  // "roles": 1,
  // "token": "eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJyZXN1bHQiOnsiaWQiOjY5LCJHb29nbGVJZCI6IjEwODYwNjI4Mzc0MjE4NzI5MTEyOCIsIkZhY2Vib29rSWQiOiIiLCJGaXJzdE5hbWUiOiJBU0lGIEFMSSIsIkxhc3ROYW1lIjoiS0hBTiIsIkdlbmRlciI6IiIsIkVtYWlsIjoiYWFraGFuMjAyMUBnbWFpbC5jb20iLCJQaG90b1VybCI6Imh0dHBzOi8vbGg2Lmdvb2dsZXVzZXJjb250ZW50LmNvbS8tR3M0bWZrNURVSm8vQUFBQUFBQUFBQUkvQUFBQUFBQUFBQUEvQU1adXVjbWNiSUx2WE9wRlBwSDhGWklfS2tENFFhTHVfUS9zOTYtYy9waG90by5qcGciLCJNYXBMb2NhdGlvbiI6IjEyMzQ1LCBFYXN0IGJpbGxpIG5hZ2FycyIsIkFwdE9yRmxhdCI6IkFwdCAzMzEyIiwiTGFuZG1hcmsiOiJOZWFyIEthbGkgTWFuZGlyIiwiTGF0aXR1ZGUiOm51bGwsIkxvbmdpdHVkZSI6bnVsbCwiUmVmZXJyZXJDb2RlIjoiIiwiVG9rZW5WZXJzaW9uIjoyLCJVc2VySWQiOjY5LCJSb2xlSWQiOjEsIlZlcnNpb24iOjF9LCJpYXQiOjE2MzQyMDc5MzYsImV4cCI6MTYzNDM4MDczNn0.0Gm3NUmZ4yfNl9A2SD1UaucSR4mIl853Qhgm_cnnnFI"
  // }

  User.fromJSON(Map<String, dynamic> json) {
    try {
      id = json['id'].toString();
      fName = json['name'] ?? '';
      email = json['email'] ?? '';
      token = json['token'];
      mobile = json['mobile'] != null ? json['mobile'].toString() : '';
      roles = json['roles'] != null ? json['roles'].toString() : '';
      status = json['status'] != null ? json['status'].toString() : '';
      dob = json['dob'] != null ? json['dob'] : '';
      accountType = json['account_type'] != null ? json['account_type'] : '';
      email = json['email'] != null ? json['email'] : '';
      gender = json['gender'] != null ? json['gender'] : '';
      image = json['avatar'] != null ? json['avatar'] : '';
    } catch (e) {
      print(e);
    }
  }

  Map toMap() {
    var map = Map<String, dynamic>();
    map["id"] = id;
    map["email"] = email;
    map["name"] = fName;
    map["password"] = password;
    map["mobile"] = mobile;
    map["address"] = address;
    return map;
  }
}
