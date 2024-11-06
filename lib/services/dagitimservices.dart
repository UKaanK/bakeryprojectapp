import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:bakeryprojectapp/models/dagitimmodel.dart';

class DagitimService {
  // getDagitimData fonksiyonunda artık DagitimModel? döndürüyoruz
  Future<DagitimModel?> getDagitimData(String roleId, String tarih) async {
    try {
      // Firebase veya API'den veri çekmek
      final snapshot = await FirebaseFirestore.instance
          .collection('rols')
          .doc(roleId)
          .collection('dagitim')
          .doc(tarih)
          .get();

      if (snapshot.exists) {
        // Veriyi JSON formatında almak
        var data = snapshot.data();
        // Burada json verisini DagitimModel'e çevireceğiz
        return DagitimModel.fromJson(data!);
      } else {
        print("Document does not exist");
        return null;
      }
    } catch (e) {
      print("Error: $e");
      return null;
    }
  }
    // Belirli bir market ismine göre veri getirme
  Future<DagitimModel?> getMarketByName(String roleId, String tarih, String marketName) async {
    try {
      final snapshot = await FirebaseFirestore.instance
          .collection('rols')
          .doc(roleId)
          .collection('dagitim')
          .doc(tarih)
          .get();

      if (snapshot.exists) {
        // Veriyi JSON formatında almak
        var data = snapshot.data();
        
        // marketler listesini almak
        var marketData = data?['market'] as List;
        List<Market> markets = marketData.map((i) => Market.fromJson(i)).toList();

        // Belirli bir marketi bulma
        var selectedMarket = markets.firstWhere((market) => market.name == marketName,);

        if (selectedMarket != null) {
          return DagitimModel(market: [selectedMarket]);
        } else {
          print("Market with name $marketName not found.");
          return null;
        }
      } else {
        print("Document does not exist");
        return null;
      }
    } catch (e) {
      print("Error: $e");
      return null;
    }
  }

}

