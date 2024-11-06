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
  final Map<String, dynamic>
      services; // Burada String yerine dynamic kullanmalısınız

  Market({required this.name, required this.services});

  factory Market.fromJson(Map<String, dynamic> json) {
    String marketName = json.keys.first; // İlk anahtar market adı
    Map<String, dynamic> marketServices =
        Map<String, dynamic>.from(json[marketName] as Map<dynamic, dynamic>);

    return Market(name: marketName, services: marketServices);
  }

  Map<String, dynamic> toJson() {
    return {
      name: services,
    };
  }
}
