import 'package:bakeryprojectapp/models/bakerymodel.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class BakeryServices {
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;

  // Belirli bir rol ve bölge altındaki tüm fırınları al
  Future<List<BakeryModel>> getAllBakeries(String rolsId, String regionName) async {
    try {
      var querySnapshot = await _firestore
          .collection('rols')
          .doc(rolsId)
          .collection('region')
          .doc(regionName)
          .collection('bakery')
          .get();

      print("Fırınlardan alınan belgeler: ${querySnapshot.docs.length}");

      List<BakeryModel> bakeries = querySnapshot.docs.map((doc) {
        print("Fırın verisi: ${doc.data()}");
        return BakeryModel.fromJson(doc.data() as Map<String, dynamic>);
      }).toList();

      return bakeries;
    } catch (e) {
      print("Fırın verileri alınırken hata oluştu: $e");
      return [];
    }
  }

  // Belirli bir fırın verisini almak için
  Future<BakeryModel?> getBakeryData(String rolsId, String regionName, String bakeryId) async {
    try {
      var snapshot = await _firestore
          .collection('rols')
          .doc(rolsId)
          .collection('region')
          .doc(regionName)
          .collection('bakery')
          .doc(bakeryId)
          .get();

      if (snapshot.exists) {
        print("Fırın verisi: ${snapshot.data()}");
        return BakeryModel.fromJson(snapshot.data()!);
      } else {
        print("Fırın verisi bulunamadı: $bakeryId");
      }
    } catch (e) {
      print("Fırın verisi alınırken hata oluştu: $e");
    }
    return null;
  }

  // Tüm fırınları çek ve konsolda göster
  void fetchBakeries(String rolsId, String regionName) async {
    List<BakeryModel> bakeries = await getAllBakeries(rolsId, regionName);

    for (var bakery in bakeries) {
      print("Fırın: ${bakery.firinIsmi}");
    }
  }
}
