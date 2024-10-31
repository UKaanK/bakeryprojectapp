class BakeryModel {
  String regionName; // Bölge adı
  int ekmekFiyati; // Ekmek fiyatı
  int ekmekSayisi; // Üretilen ekmek sayısı
  String firinIsmi; // Fırın adı
  int devirEkmek; // Devir ekmek sayısı

  BakeryModel({
    required this.regionName,
    required this.devirEkmek,
    required this.ekmekFiyati,
    required this.ekmekSayisi,
    required this.firinIsmi,
  });

  // Firestore'dan gelen JSON verisini BakeryModel nesnesine dönüştürme
  factory BakeryModel.fromJson(Map<String, dynamic> json) {
    return BakeryModel(
      regionName: json["region_name"] ?? '', // Varsayılan değer boş string
      devirEkmek: json["devir_ekmek_sayisi"] ?? 0, // Varsayılan değer 0
      ekmekFiyati: json["ekmek_fiyati"] ?? 0,
      ekmekSayisi: json["ekmek_sayisi"] ?? 0,
      firinIsmi: json["firin_ismi"] ?? '',
    );
  }
}
