class UserModel {
  String name;
  String pwd;
  String roles;
  String rolsId;

  UserModel(
      {required this.name,
      required this.pwd,
      required this.roles,
      required this.rolsId});

  factory UserModel.fromJson(Map<String, dynamic> json) {
    return UserModel(
      name: json['name'] ?? '',
      pwd: json['pwd'] ?? '',
      roles: json['roles'] ?? '',
      rolsId: json['rols_id'] ?? '',
    );
  }

  Map<String, dynamic> toJson() {
    return {'name': name, 'pwd': pwd, 'roles': roles, 'rols_id': rolsId};
  }
}
