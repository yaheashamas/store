class LoginModel {
  late bool status;
  late String message;
  UserModel? Data;

  LoginModel.fromJson(Map<String, dynamic> json) {
    this.status = json['status'];
    this.message = json['message'];
    this.Data = json['data'] != null ? UserModel.fromJson(json['data']) : null;
  }
}

class UserModel {
  late int id;
  late String name;
  late String email;
  late String phone;
  String? image;
  int? points;
  int? credit;
  late String token;

  UserModel.fromJson(Map<String, dynamic> json) {
    this.id = json['id'];
    this.name = json['name'];
    this.email = json['email'];
    this.phone = json['phone'];
    this.image = json['image'];
    this.points = json['points'];
    this.credit = json['credit'];
    this.token = json['token'];
  }
}
