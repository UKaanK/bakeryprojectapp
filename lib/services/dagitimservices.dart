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
        print(data);
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

  // Marketin dagitilan ekmek ve iade ekmek sayılarını güncelleme
  Future<void> updateMarketEkmek(String roleId, String tarih, String marketName,
      int dagitilanEkmek, int iadeEkmek, String servis) async {
    try {
      DocumentReference documentRef = _firestore
          .collection('rols')
          .doc(roleId)
          .collection('dagitim')
          .doc(tarih);

      await _firestore.runTransaction((transaction) async {
        DocumentSnapshot snapshot = await transaction.get(documentRef);

        if (snapshot.exists) {
          // Veriyi JSON formatında al
          var data = snapshot.data() as Map<String, dynamic>;
          var marketList = data['market'] as List<dynamic>;

          // Marketleri bul ve güncelle
          for (var marketData in marketList) {
            if (marketData['name'] == marketName) {
              marketData['dagitilan_ekmek'] = dagitilanEkmek;
              marketData[servis] = dagitilanEkmek;
              break;
            }
          }

          // Güncellenmiş market listesi ile Firestore belgesini güncelle
          transaction.update(documentRef, {
            'market': marketList,
          });
        } else {
          print("Document does not exist");
        }
      });
    } catch (e) {
      print("Error updating ekmek data: $e");
    }
  }

  // Marketin dagitilan ekmek ve iade ekmek sayılarını güncelleme
  Future<void> updateMarketIadeEkmek(
    String roleId,
    String tarih,
    String marketName,
    int iadeEkmek,
  ) async {
    try {
      DocumentReference documentRef = _firestore
          .collection('rols')
          .doc(roleId)
          .collection('dagitim')
          .doc(tarih);

      await _firestore.runTransaction((transaction) async {
        DocumentSnapshot snapshot = await transaction.get(documentRef);

        if (snapshot.exists) {
          // Veriyi JSON formatında al
          var data = snapshot.data() as Map<String, dynamic>;
          var marketList = data['market'] as List<dynamic>;

          // Marketleri bul ve güncelle
          for (var marketData in marketList) {
            if (marketData['name'] == marketName) {
              marketData['iade_ekmek'] = iadeEkmek;
              break;
            }
          }

          // Güncellenmiş market listesi ile Firestore belgesini güncelle
          transaction.update(documentRef, {
            'market': marketList,
          });
        } else {
          print("Document does not exist");
        }
      });
    } catch (e) {
      print("Error updating ekmek data: $e");
    }
  }

  Future<void> saveOrUpdateTahsilat(
    String rolsId, String marketName, String newTahsilat) async {
  // Bugünün tarihini al ve gün-ay-yıl formatına çevir
  String todayDate = "6.11.2024";

  // Firestore'dan belgeyi al
  DocumentReference documentRef = _firestore
      .collection('rols')
      .doc(rolsId)
      .collection("dagitim")
      .doc(todayDate);

  // Firestore'a kayıt işlemi
  await _firestore.runTransaction((transaction) async {
    DocumentSnapshot snapshot = await transaction.get(documentRef);

    // Eğer belge mevcutsa güncelle, yoksa yeni belge oluştur
    if (snapshot.exists) {
      // Mevcut marketler verisini al
      var marketData = snapshot['market'] ?? [];
      List<Map<String, dynamic>> updatedMarkets = [];

      bool marketFound = false;

      // Belirtilen marketi bul ve tahsilat değerini güncelle
      for (var market in marketData) {
        if (market.keys.first == marketName) {
          var currentMarket = market[marketName];
          
          // Yeni tahsilat değerini güncelle
          currentMarket['tahsilat'] = int.parse(newTahsilat);
          marketFound = true;
        }
        updatedMarkets.add(market);
      }

      if (!marketFound) {
        // Eğer market bulunmazsa yeni bir market ekleyebilirsiniz
        print("Market bulunamadı: $marketName");
      }

      // Güncellenmiş marketleri Firestore'a kaydet
      transaction.update(documentRef, {
        'market': updatedMarkets,
        'date': DateTime.now(),
      });

      print("Tahsilat başarıyla güncellendi.");
    } else {
      // Eğer belge yoksa yeni bir belge oluştur
      List<Map<String, dynamic>> newMarkets = [
        {
          marketName: {
            'tahsilat': int.parse(newTahsilat),
          }
        }
      ];

      // Yeni market bilgisiyle belgeyi oluştur
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
