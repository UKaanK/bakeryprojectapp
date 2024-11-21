import 'package:bakeryprojectapp/models/bakerymodel.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class BakeryServices {
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;

  // Belirli fırınları al
  Future<List<BakeryModel>> getAllBakeries(String rolsId) async {
    try {
      var querySnapshot = await _firestore
          .collection('rols')
          .doc(rolsId)
          .collection('bakery')
          .get();

      print("Fırınlardan alınan belgeler: ${querySnapshot.docs.length}");

      List<BakeryModel> bakeries = querySnapshot.docs.map((doc) {
        print("Fırın verisi: ${doc.data()}");
        return BakeryModel.fromJson(doc.data() as Map<String, dynamic>);
      }).toList();
      print(bakeries);
      return bakeries;
    } catch (e) {
      print("Fırın verileri alınırken hata oluştu: $e");
      return [];
    }
  }

 Future<void> updateEkmekSayisi(String rolsId, String firinIsmi, String tarih, String yeniEkmekSayisi) async {
  DocumentReference documentRef = _firestore
      .collection('rols') // Koleksiyon adınızı buraya yazın
      .doc(rolsId)
      .collection('bakery')
      .doc(firinIsmi);
try {
  await _firestore.runTransaction((transaction) async {
    DocumentSnapshot snapshot = await transaction.get(documentRef);

    if (snapshot.exists) {
      var servisData = snapshot['servisler'] ?? [];
      List<Map<String, dynamic>> updatedServisler = [];
      bool tarihFound = false;

      for (var servis in servisData) {
        if (servis.keys.first == tarih) {
          var currentServis = servis[tarih];
          
          // Mevcut ekmek sayısını al ve yeni ekmek sayısını ekle
          int currentEkmekSayisi = currentServis['ekmek_sayisi'] ?? 0;
          int updatedEkmekSayisi = currentEkmekSayisi + int.parse(yeniEkmekSayisi); // Yeni ekmek sayısını ekleyin

          currentServis['ekmek_sayisi'] = updatedEkmekSayisi; // Güncellenmiş ekmek sayısını ayarla

          tarihFound = true;
        }
        updatedServisler.add(servis);
      }

      // Eğer tarih bulunmadıysa, yeni bir tarih ekle
      if (!tarihFound) {
        var newServis = {
          tarih: {
            'ekmek_sayisi': int.parse(yeniEkmekSayisi),
          }
        };
        updatedServisler.add(newServis);
      }

      transaction.update(documentRef, {
        'servisler': updatedServisler,
        'date': DateTime.now(),
      });
      print("Ekmek sayısı başarıyla güncellendi.");
    } else {
      print("Fırın bulunamadı: $firinIsmi");
    }
  });
} catch (e) {
  print(e);
}
  
}

}
