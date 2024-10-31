class UserModel {
  String name;
  String pwd;
  String roles;
  String rolsId;
  String telefonNo;

  UserModel(
      {required this.name,
      required this.pwd,
      required this.roles,
      required this.rolsId,
      required this.telefonNo,
      });

  factory UserModel.fromJson(Map<String, dynamic> json) {
    return UserModel(
      name: json['name'] ?? '',
      pwd: json['pwd'] ?? '',
      roles: json['roles'] ?? '',
      rolsId: json['rols_id'] ?? '',
      telefonNo: json['telefon_no'] ?? '',
    );
  }

  Map<String, dynamic> toJson() {
    return {'name': name, 'pwd': pwd, 'roles': roles, 'rols_id': rolsId , 'telefon_no' : telefonNo};
  }
}
