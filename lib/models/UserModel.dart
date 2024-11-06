class UserModel {
  String name;
  String pwd;
  String roles;
  String rolsId;
  String telefonNo;
  Map<String, List<String>> servis; // Servis bilgisi için yeni alan

  UserModel(
      {required this.name,
      required this.pwd,
      required this.roles,
      required this.rolsId,
      required this.telefonNo,
       required this.servis, // Constructor'a ekleyin
      });

  factory UserModel.fromJson(Map<String, dynamic> json) {
    
    return UserModel(
      name: json['name'] ?? '',
      pwd: json['pwd'] ?? '',
      roles: json['roles'] ?? '',
      rolsId: json['rols_id'] ?? '',
      telefonNo: json['telefon_no'] ?? '',
       servis: Map<String, List<String>>.from(
          (json['servis'] ?? {}).map((key, value) => MapEntry(key, List<String>.from(value)))),
    );
  }

  Map<String, dynamic> toJson() {
    return {'name': name, 'pwd': pwd, 'roles': roles, 'rols_id': rolsId , 'telefon_no' : telefonNo,'servis': servis,};
  }
}
