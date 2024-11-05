import 'package:bakeryprojectapp/models/regionmodel.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class RegionService {
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;

  // Tüm bölgeleri çekmek için
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
// Method to get region names based on rolsId
  Future<List<String>> getRegionNames(String rolsId) async {
    try {
      QuerySnapshot querySnapshot = await _firestore
          .collection('rols')
          .doc(rolsId)
          .collection("region")
          .where('rolsId', isEqualTo: rolsId)
          .get();

      // Extracting the region names from the query result
      List<String> regionNames = querySnapshot.docs
          .map((doc) => doc['region_name'] as String)
          .toList();

      return regionNames;
    } catch (e) {
      print("Error fetching region names: $e");
      return [];
    }
  }
  // Tek bir bölgeyi çekmek için
  Future<RegionModel?> getRegionData(String rolsId, String regionId) async {
    try {
      var snapshot = await _firestore
          .collection('rols')
          .doc(rolsId)
          .collection('region')
          .doc(regionId)
          .get();

      if (snapshot.exists) {
        var region = RegionModel.fromJson(snapshot.data()!);
        print("Bölge Adı: ${region.regionName}"); // Bölge adını yazdırır
        return region;
      }
    } catch (e) {
      print("Region verileri alınırken hata oluştu: $e");
    }
    return null;
  }

  // Tüm bölgelerin isimlerini yazdırmak için
  Future<void> printRegionNames(String rolsId) async {
    List<RegionModel> regions = await getRegions(rolsId);
    
    for (var region in regions) {
      print("Bölge Adı: ${region.regionName}"); // Region Name'i yazdırır
    }
  }
}
