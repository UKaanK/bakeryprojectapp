import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:intl/intl.dart';

class DriverServices {
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;

  Future<void> saveOrUpdateGider(String yakitGideri, String ekstraGider,
      String ekstraGiderAciklama, String rolsId) async {
    // Bugünün tarihini al ve gün-ay-yıl formatına çevir
    String todayDate = DateFormat('dd.MM.yyyy').format(DateTime.now());

    // Firestore'dan belgeyi al
    DocumentReference documentRef = _firestore
        .collection('rols')
        .doc(rolsId)
        .collection("giderler")
        .doc(todayDate);

    // Firestore'a kayıt işlemi
    await _firestore.runTransaction((transaction) async {
      DocumentSnapshot snapshot = await transaction.get(documentRef);

      // Eğer belge mevcutsa güncelle, yoksa yeni belge oluştur
      if (snapshot.exists) {
        // Mevcut giderleri al
        int existingYakitGideri = snapshot['yakıt_gideri'] ?? 0;
        int existingEkstraGider = snapshot['ekstra_gider'] ?? 0;

        // Yakıt gideri kontrolü
        if (yakitGideri.isNotEmpty) {
          try {
            int yakitGideriValue = int.parse(yakitGideri);
            existingYakitGideri += yakitGideriValue; // Mevcut yakıt giderine ekle
          } catch (e) {
            throw FormatException("Geçersiz yakıt gideri formatı: ${e.toString()}");
          }
        }

        // Ekstra gider kontrolü
        if (ekstraGider.isNotEmpty) {
          try {
            int ekstraGiderValue = int.parse(ekstraGider);
            existingEkstraGider += ekstraGiderValue; // Mevcut ekstra giderine ekle

            // Ekstra gider açıklaması ekleme
            String existingEkstraGiderAciklama = snapshot["ekstra_gider_aciklama"] ?? "";
            transaction.update(documentRef, {
              'ekstra_gider_aciklama': existingEkstraGiderAciklama +
                  (existingEkstraGiderAciklama.isNotEmpty ? "," : "") +
                  ekstraGiderAciklama,
            });
          } catch (e) {
            throw FormatException("Geçersiz ekstra gider formatı: ${e.toString()}");
          }
        }

        // Güncelleme
        int totalGider = existingYakitGideri + existingEkstraGider;
        transaction.update(documentRef, {
          'yakıt_gideri': existingYakitGideri,
          'ekstra_gider': existingEkstraGider,
          'total_gider': totalGider,
          'date': DateTime.now(),
        });
      } else {
        // Yeni belge oluştur
        int yakitGideriValue = 0;
        int ekstraGiderValue = 0;

        if (yakitGideri.isNotEmpty) {
          try {
            yakitGideriValue = int.parse(yakitGideri);
          } catch (e) {
            throw FormatException("Geçersiz yakıt gideri formatı: ${e.toString()}");
          }
        }

        if (ekstraGider.isNotEmpty) {
          try {
            ekstraGiderValue = int.parse(ekstraGider);
          } catch (e) {
            throw FormatException("Geçersiz ekstra gider formatı: ${e.toString()}");
          }
        }

        await transaction.set(documentRef, {
          'yakıt_gideri': yakitGideriValue,
          'ekstra_gider': ekstraGiderValue,
          'ekstra_gider_aciklama': ekstraGiderAciklama,
          'total_gider': yakitGideriValue + ekstraGiderValue,
          'date': DateTime.now(),
        });
      }
    });
}

}
