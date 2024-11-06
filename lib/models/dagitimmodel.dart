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
    Map<String, dynamic> marketServices =
        Map<String, dynamic>.from(json[marketName] as Map<dynamic, dynamic>);
    int aractakiEkmek =marketServices.contain
    return Market(
      name: marketName,
      services: marketServices,
      aractakiEkmek: aractakiEkmek
    );
  }

  Map<String, dynamic> toJson() {
    return {
      name: services,
    };
  }
}
