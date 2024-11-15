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

  getBakeriesByDate(String format) {}
}
