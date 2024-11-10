class MarketModel {
  String name;
  Map<String, String> services;

  MarketModel({required this.name, required this.services});

  factory MarketModel.fromJson(Map<String, dynamic> json) {
    String marketName = json.keys.first; // İlk anahtar market adı
    // marketName ile ilişkili verileri al
    var marketServices = json[marketName] as Map<String, dynamic>;

    // Sadece String türünde verileri alıp dönüştür
    Map<String, String> services = {};
    marketServices.forEach((key, value) {
      if (value is String) {
        services[key] = value;
      } else {
        services[key] = value.toString(); // Diğer türleri String'e dönüştür
      }
    });

    return MarketModel(name: marketName, services: services);
  }

  Map<String, dynamic> toJson() {
    return {
      name: services,
    };
  }
}

class RegionModel {
  String regionName;
  final List<dynamic> rolsId;
  final List<MarketModel> market;

  RegionModel(
      {required this.regionName, required this.market, required this.rolsId});

  factory RegionModel.fromJson(Map<String, dynamic> json) {
    // region_name alanı
    final String regionName = json['region_name'] ?? '';

    // market alanını kontrol et ve uygun şekilde işle
    final List<dynamic>? marketsData =
        json['market'] as List<dynamic>?; // null olabileceğini belirtin
    final List<MarketModel> markets = marketsData != null
        ? marketsData
            .map((marketData) =>
                MarketModel.fromJson(marketData as Map<String, dynamic>))
            .toList()
        : []; // Eğer market null ise boş bir liste döndür

    return RegionModel(
      regionName: regionName,
      market: markets,
      rolsId: List<dynamic>.from(json['rols_id'] ?? []),
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'region_name': regionName,
      'market': market.map((m) => m.toJson()).toList(),
      'rols_id': rolsId
    };
  }
}
