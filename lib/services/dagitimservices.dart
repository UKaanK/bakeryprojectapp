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
}

