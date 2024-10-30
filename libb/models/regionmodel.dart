class MarketModel {
  String name;
  Map<String, String> services;

  MarketModel({required this.name, required this.services});

  factory MarketModel.fromJson(Map<String, dynamic> json) {
    String marketName = json.keys.first; // İlk anahtar market adı
    Map<String, String> marketServices = Map<String, String>.from(
        json[marketName] as Map<dynamic, dynamic>);
    return MarketModel(
     name: marketName,
      services: marketServices
    );
    
  }

  Map<String, dynamic> toJson() {
    return {
      name: services,
    };
  }
}

class RegionModel {
  String regionName;
  List<MarketModel> market;

  RegionModel({required this.regionName, required this.market});

  factory RegionModel.fromJson(Map<String, dynamic> json) {
  // region_name alanı
  final String regionName = json['region_name'] ?? '';

  // market alanını kontrol et ve uygun şekilde işle
  final List<dynamic>? marketsData = json['market'] as List<dynamic>?; // null olabileceğini belirtin
  final List<MarketModel> markets = marketsData != null
      ? marketsData.map((marketData) => MarketModel.fromJson(marketData as Map<String, dynamic>)).toList()
      : []; // Eğer market null ise boş bir liste döndür

  return RegionModel(
    regionName: regionName,
    market: markets,
  );
}

  Map<String, dynamic> toJson() {
    return {
      'region_name': regionName,
      'market': market.map((m) => m.toJson()).toList(),
    };
  }
}
