
import 'package:bakeryprojectapp/models/regionmodel.dart';
import 'package:cloud_firestore/cloud_firestore.dart';


class RegionService {
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;

 Future<List<RegionModel>> getRegions(String rolsId) async {
  try {
    var querySnapshot = await _firestore
        .collection('rols')
        .doc(rolsId)
        .collection("region")
        .get();

    print("Koleksiyondan alınan belgeler: ${querySnapshot.docs.length}");

    List<RegionModel> regions = querySnapshot.docs.map((doc) {
      print("Belgelerin verisi: ${doc.data()}"); // Aldığınız veriyi kontrol edin
      return RegionModel.fromJson(doc.data() as Map<String, dynamic>);
    }).toList();

    return regions;
  } catch (e) {
    print("Veriler alınırken hata oluştu: $e");
    return [];
  }
}


  void fetchRegions(String rolsId) async {
  RegionService regionService = RegionService();
  List<RegionModel> regions = await regionService.getRegions(rolsId);
  
  for (var region in regions) {
    print("Bölge: ${region.regionName},");
    
  }
}
 Future<RegionModel?> getRegionData(String rolsId, String regionId) async {
    try {
      var snapshot = await _firestore
          .collection('rols')
          .doc(rolsId)
          .collection('region')
          .doc(regionId)
          .get();

      if (snapshot.exists) {
        return RegionModel.fromJson(snapshot.data()!);
      }
    } catch (e) {
      print("Region verileri alınırken hata oluştu: $e");
    }
    return null;
  }


}
