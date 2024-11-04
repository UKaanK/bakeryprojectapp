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
        return BakeryModel.fromJson(doc.data() as Map<String, dynamic>);
      }).toList();

      return bakeryList;
    } catch (e) {
      print("Bakery verileri alınırken hata oluştu: $e");
      return [];
    }
  }

  

  // Tüm fırınları çek ve konsolda göster
  void fetchBakeries(String rolsId, String regionName) async {
    List<BakeryModel> bakeries = await getAllBakeries(rolsId, regionName);

    for (var bakery in bakeries) {
      print("Fırın: ${bakery.firinIsmi}");
    }
  }
  
}
