import 'package:bakeryprojectapp/models/dagitimmodel.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class DagitimServices {
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;

  // Market verilerini Firebase'den çekme
  Future<List<DagitimModel>> fetchMarketler(String rolsId) async {
    try {
      QuerySnapshot snapshot = await _firestore.collection('rols').doc(rolsId).collection("dagitim").get();
      return snapshot.docs.map((doc) {
        return DagitimModel.fromJson(doc.data() as Map<String, dynamic>);
      }).toList();
    } catch (e) {
      print("Veri çekme hatası: $e");
      return [];
    }
  }
}
