class BakeryModel {
  String firinIsmi; // Fırın adı
  List<BakeryService> servisler; // Servis verileri

  BakeryModel({
    required this.firinIsmi,
    required this.servisler,
  });

  // Firestore'dan gelen JSON verisini BakeryModel nesnesine dönüştürme
  factory BakeryModel.fromJson(Map<String, dynamic> json) {
    return BakeryModel(
      firinIsmi: json["firin_ismi"] ?? '',
      servisler: (json["servisler"] as List<dynamic>?)?.map((serviceData) {
            return BakeryService.fromJson(serviceData);
          }).toList() ??
          [],
    );
  }
   // Belirli bir tarih için ekmek sayısını ve devir ekmek sayısını döndür
  Map<String, int> getEkmekSayisiByDate(String date) {
    for (var service in servisler) {
      if (service.tarih == date) {
        return {
          'ekmek_sayisi': service.ekmekSayisi,
          'devir_ekmek_sayisi': service.devirEkmek,
        };
      }
    }
    // Eğer tarih bulunamazsa, null değer döndür
    return {
      'ekmek_sayisi': 0,
      'devir_ekmek_sayisi': 0,
    };
  }

  @override
  String toString() {
    return 'BakeryModel(firinIsmi: $firinIsmi, servisler: $servisler)';
  }
}

class BakeryService {
  String tarih; // Tarih
  int devirEkmek; // Devir ekmek sayısı
  int ekmekFiyati; // Ekmek fiyatı
  int ekmekSayisi; // Ekmek sayısı

  BakeryService({
    required this.tarih,
    required this.devirEkmek,
    required this.ekmekFiyati,
    required this.ekmekSayisi,
  });
 @override
  String toString() {
    return 'BakeryService(tarih: $tarih, devirEkmek: $devirEkmek, ekmekFiyati: $ekmekFiyati, ekmekSayisi: $ekmekSayisi)';
  }
  // Firestore'dan gelen JSON verisini BakeryService nesnesine dönüştürme
  factory BakeryService.fromJson(Map<String, dynamic> json) {
    return BakeryService(
      tarih: json.keys.first, // Tarih alanı, anahtar olarak kabul ediliyor
      devirEkmek: json[json.keys.first]["devir_ekmek_sayisi"] ?? 0,
      ekmekFiyati: json[json.keys.first]["ekmek_fiyati"] ?? 0,
      ekmekSayisi: json[json.keys.first]["ekmek_sayisi"] ?? 0,
    );
  }
}
