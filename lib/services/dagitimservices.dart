
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:bakeryprojectapp/models/dagitimmodel.dart';
import 'package:intl/intl.dart';

class DagitimService {
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;

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
        print("<s"+data.toString());
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

  // Marketin dagitilan ekmek ve iade ekmek sayılarını güncelleme (ekleyerek güncelleme)
  Future<void> updateMarketEkmek(String roleId, String marketName,
      String dagitilanEkmek, String servis, String todayDate) async {
    DocumentReference documentRef = _firestore
        .collection('rols')
        .doc(roleId)
        .collection("dagitim")
        .doc(todayDate);

    await _firestore.runTransaction((transaction) async {
      DocumentSnapshot snapshot = await transaction.get(documentRef);

      if (snapshot.exists) {
        var marketData = snapshot['market'] ?? [];
        List<Map<String, dynamic>> updatedMarkets = [];
        bool marketFound = false;

        for (var market in marketData) {
          if (market.keys.first == marketName) {
            var currentMarket = market[marketName];
            int currentEkmek = currentMarket['dagitilan_ekmek'] ?? 0;
            int currentServis = currentMarket[servis] ?? 0;
            int totalEkmek = currentMarket["total_ekmek"] ?? 0;

            currentMarket['dagitilan_ekmek'] =
                currentEkmek + int.parse(dagitilanEkmek);
            currentMarket[servis] = currentServis + int.parse(dagitilanEkmek);
            currentMarket['total_ekmek'] =
                currentEkmek + int.parse(dagitilanEkmek);

                 currentMarket['aractaki_ekmek'] =
                currentMarket['aractaki_ekmek']  - int.parse(dagitilanEkmek);

            marketFound = true;
          }
          updatedMarkets.add(market);
        }

        if (!marketFound) {
          print("Market bulunamadı: $marketName");
        }

        transaction.update(documentRef, {
          'market': updatedMarkets,
          'date': DateTime.now(),
        });
        print("Tahsilat başarıyla güncellendi.");
      } else {
        List<Map<String, dynamic>> newMarkets = [
          {
            marketName: {
              'dagitilan_ekmek': int.parse(dagitilanEkmek),
              servis: int.parse(dagitilanEkmek),
              'total_ekmek': int.parse(dagitilanEkmek),
            }
          }
        ];
        await transaction.set(documentRef, {
          'market': newMarkets,
          'date': DateTime.now(),
        });
        print("Yeni market ve iade ekmek bilgisi eklendi.");
      }
    });
  }

  // updateMarketIadeEkmek (ekleyerek güncelleme)
  Future<void> updateMarketIadeEkmek(String roleId, String marketName,
      String iadeEkmek, String todayDate) async {
    DocumentReference documentRef = _firestore
        .collection('rols')
        .doc(roleId)
        .collection("dagitim")
        .doc(todayDate);

    await _firestore.runTransaction((transaction) async {
      DocumentSnapshot snapshot = await transaction.get(documentRef);

      if (snapshot.exists) {
        var marketData = snapshot['market'] ?? [];
        List<Map<String, dynamic>> updatedMarkets = [];
        bool marketFound = false;

        for (var market in marketData) {
          if (market.keys.first == marketName) {
            var currentMarket = market[marketName];
            int currentIadeEkmek = currentMarket['iade_ekmek'] ?? 0;
            int totalEkmek = currentMarket['total_ekmek'];
            currentMarket['iade_ekmek'] =
                currentIadeEkmek + int.parse(iadeEkmek);
            marketFound = true;
            currentMarket['total_ekmek'] = totalEkmek - int.parse(iadeEkmek);
          }
          updatedMarkets.add(market);
        }

        if (!marketFound) {
          print("Market bulunamadı: $marketName");
        }

        transaction.update(documentRef, {
          'market': updatedMarkets,
          'date': DateTime.now(),
        });
        print("İade ekmek başarıyla güncellendi.");
      } else {
        List<Map<String, dynamic>> newMarkets = [
          {
            marketName: {
              'iade_ekmek': int.parse(iadeEkmek),
            }
          }
        ];
        await transaction.set(documentRef, {
          'market': newMarkets,
          'date': DateTime.now(),
        });
        print("Yeni market ve iade ekmek bilgisi eklendi.");
      }
    });
  }

  // saveOrUpdateTahsilat (ekleyerek güncelleme)
  Future<void> saveOrUpdateTahsilat(String rolsId, String marketName,
      String newTahsilat, String todayDate) async {
    DocumentReference documentRef = _firestore
        .collection('rols')
        .doc(rolsId)
        .collection("dagitim")
        .doc(todayDate);

    await _firestore.runTransaction((transaction) async {
      DocumentSnapshot snapshot = await transaction.get(documentRef);

      if (snapshot.exists) {
        var marketData = snapshot['market'] ?? [];
        List<Map<String, dynamic>> updatedMarkets = [];
        bool marketFound = false;

        for (var market in marketData) {
          if (market.keys.first == marketName) {
            var currentMarket = market[marketName];
            int currentTahsilat = currentMarket['tahsilat'] ?? 0;

            currentMarket['tahsilat'] =
                currentTahsilat + int.parse(newTahsilat);
            marketFound = true;
          }
          updatedMarkets.add(market);
        }

        if (!marketFound) {
          print("Market bulunamadı: $marketName");
        }

        transaction.update(documentRef, {
          'market': updatedMarkets,
          'date': DateTime.now(),
        });
        print("Tahsilat başarıyla güncellendi.");
      } else {
        List<Map<String, dynamic>> newMarkets = [
          {
            marketName: {
              'tahsilat': int.parse(newTahsilat),
            }
          }
        ];
        await transaction.set(documentRef, {
          'market': newMarkets,
          'date': DateTime.now(),
        });
        print("Yeni market ve tahsilat bilgisi eklendi.");
      }
    });
  }

// Belirli bir market ismine göre veri getirme
  Future<DagitimModel?> getMarketByName(
      String roleId, String tarih, String marketName) async {
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
        List<Market> markets =
            marketData.map((i) => Market.fromJson(i)).toList();

        // Belirli bir marketi bulma
        var selectedMarket = markets.firstWhere(
          (market) => market.name == marketName,
        );

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




