import 'package:bakeryprojectapp/models/regionmodel.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class RegionService {
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;

  // Tüm bölgeleri çekmek için
  Future<List<RegionModel>> getRegions() async {
    try {
      var querySnapshot =
          await FirebaseFirestore.instance.collection('region').get();

      print("Koleksiyondan alınan belgeler: ${querySnapshot.docs.length}");

      List<RegionModel> regions = querySnapshot.docs.map((doc) {
        print("Belgelerin verisi: ${doc.data()}"); // Veriyi kontrol etmek için
        return RegionModel.fromJson(doc.data() as Map<String, dynamic>);
      }).toList();

      return regions;
    } catch (e) {
      print("Veriler alınırken hata oluştu: $e");
      return [];
    }
  }

  Future<RegionModel?> getRegionByName(String regionName) async {
    try {
      // Firestore'dan region adını al
      final querySnapshot = await FirebaseFirestore.instance
          .collection('region')
          .where('region_name', isEqualTo: regionName)
          .get();

      if (querySnapshot.docs.isEmpty) {
        print("Region with name $regionName not found.");
        return null;
      }

      // İlk belgeyi al
      var data = querySnapshot.docs.first.data();

      // Tüm marketleri içeren RegionModel döndür
      var region = RegionModel.fromJson(data);

      return region;
    } catch (e) {
      print("Error: $e");
      return null;
    }
  }

  Future<List<Map<String, dynamic>>> getMarketsByRegionName(
      String regionName) async {
    List<Map<String, dynamic>> regionData = [];

    try {
      // Belirtilen `region_name`e göre belgeyi bul
      var regionSnapshot = await _firestore
          .collection('region')
          .where('region_name', isEqualTo: regionName)
          .get();

      if (regionSnapshot.docs.isNotEmpty) {
        // İlk belgeyi al (örneğin, `region_name` benzersiz olarak varsayılırsa)
        var regionDoc = regionSnapshot.docs.first;

        // Tüm veriyi al (market ve diğer alanlar)
        var data = regionDoc.data();

        // `market` verisini almak
        var marketArray = data['market'] as List?;
        if (marketArray != null) {
          // Her bir marketin verisini almak
          for (var market in marketArray) {
            // Market adı (anahtar) ile marketin detaylarını al
            market.forEach((marketName, marketDetails) {
              regionData.add({
                marketName: marketDetails,
              });
            });
          }
        }
      }

      return regionData;
    } catch (e) {
      print("Veri erişilirken hata oluştu: $e");
      return [];
    }
  }
}
