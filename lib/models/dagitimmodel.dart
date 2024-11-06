class DagitimModel {
  final int aractakiEkmek;
  final int dagitilanEkmek;
  final int iadeEkmek;
  final Map<String, int> dynamicFields; // s1, s2, s3 gibi dinamik alanlar
  final int tahsilat;
  final int totalEkmek;

  DagitimModel({
    required this.aractakiEkmek,
    required this.dagitilanEkmek,
    required this.iadeEkmek,
    required this.dynamicFields,
    required this.tahsilat,
    required this.totalEkmek,
  });

  // JSON'dan DagitimModel oluşturma
  factory DagitimModel.fromJson(Map<String, dynamic> json) {
    var dynamicFields = <String, int>{};

    // Dinamik alanlar (s1, s2, s3 vb.) varsa, onları ekleyelim
    json.forEach((key, value) {
      if (key.startsWith('s')) {
        dynamicFields[key] = value as int;
      }
    });

    return DagitimModel(
      aractakiEkmek: json['aractaki_ekmek'],
      dagitilanEkmek: json['dagitilan_ekmek'],
      iadeEkmek: json['iade_ekmek'],
      dynamicFields: dynamicFields,
      tahsilat: json['tahsilat'],
      totalEkmek: json['total_ekmek'],
    );
  }

  // JSON'a dönüştürme
  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = {};

    data['aractaki_ekmek'] = aractakiEkmek;
    data['dagitilan_ekmek'] = dagitilanEkmek;
    data['iade_ekmek'] = iadeEkmek;
    data['tahsilat'] = tahsilat;
    data['total_ekmek'] = totalEkmek;

    // Dinamik alanları JSON'a ekleyelim
    dynamicFields.forEach((key, value) {
      data[key] = value;
    });

    return data;
  }
}
