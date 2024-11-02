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

      return bakeries;
    } catch (e) {
      print("Fırın verileri alınırken hata oluştu: $e");
      return [];
    }
  }

  // Belirli bir fırın verisini almak için
  Future<List<BakeryModel>> getBakeryData(String rolsId, String regionName) async {
    try {
      var querySnapshot = await _firestore
          .collection('rols')
          .doc(rolsId)
          .collection('region')
          .doc(regionName)
          .collection('bakery')
          .get();

      print("Alınan belge sayısı: ${querySnapshot.docs.length}");

      List<BakeryModel> bakeryList = querySnapshot.docs.map((doc) {
        Map<String, dynamic> data = doc.data() as Map<String, dynamic>;

        // Firestore'dan servisler verisini alıp, her servisi bir BakeryService nesnesine dönüştürme
        List<BakeryService> servisler = (data['servisler'] as List<dynamic>?)
            ?.map((serviceData) {
              String tarih = serviceData.keys.first;
              return BakeryService.fromJson({tarih: serviceData[tarih]});
            }).toList() ?? [];

        return BakeryModel(
         
          firinIsmi: data['firin_ismi'] ?? '',
          servisler: servisler,
        );
      }).toList();

      return bakeryList;
    } catch (e) {
      print("Bakery verileri alınırken hata oluştu: $e");
      return [];
    }
  }
}
