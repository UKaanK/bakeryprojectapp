// dagitimmodel.dart
class DagitimModel {
  final List<Market> market;

  DagitimModel({required this.market});

  factory DagitimModel.fromJson(Map<String, dynamic> json) {
    var list = json['market'] as List;
    List<Market> marketList = list.map((i) => Market.fromJson(i)).toList();

    return DagitimModel(
      market: marketList,
    );
  }
}

class Market {
  final String name;
  final int aractakiEkmek;
  final int dagitilanEkmek;
  final int iadeEkmek;
  final int tahsilat;
  final int totalEkmek;
  final Map<String, dynamic>
      services; // Burada String yerine dynamic kullanmalısınız

  Market(
      {required this.name,
      required this.services,
      required this.aractakiEkmek,
      required this.dagitilanEkmek,
      required this.iadeEkmek,
      required this.tahsilat,
      required this.totalEkmek});

  factory Market.fromJson(Map<String, dynamic> json) {
    String marketName = json.keys.first; // İlk anahtar market adı
        Map<String, dynamic> marketData = json[marketName] as Map<String, dynamic>;

    Map<String, dynamic> marketServices =
        Map<String, dynamic>.from(json[marketName] as Map<dynamic, dynamic>);
     return Market(
      name: marketName,
      services: marketServices,
      aractakiEkmek: marketData['aractaki_ekmek'] ?? 0,
      dagitilanEkmek: marketData['dagitilan_ekmek'] ?? 0,
      iadeEkmek: marketData['iade_ekmek'] ?? 0,
      tahsilat: marketData['tahsilat'] ?? 0,
      totalEkmek: marketData['total_ekmek'] ?? 0,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      name: services,
    };
  }
}
