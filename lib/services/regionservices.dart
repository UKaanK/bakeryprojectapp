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

  Future<List<Map<String, dynamic>>> getMarketsByRegionNameAndExactDate(
    String regionName, DateTime targetDate) async {
  List<Map<String, dynamic>> filteredMarkets = [];

  try {
    // region_name ile eşleşen belgeyi Firestore'dan al
    var regionSnapshot = await FirebaseFirestore.instance
        .collection('region')
        .where('region_name', isEqualTo: regionName)
        .get();

    if (regionSnapshot.docs.isNotEmpty) {
      var regionDoc = regionSnapshot.docs.first;
      var data = regionDoc.data();
      var marketArray = data['market'] as List?;

      if (marketArray != null) {
        // Her market elemanını dolaşarak belirtilen tarihe göre filtrele
        for (var market in marketArray) {
          market.forEach((marketName, marketDetails) {
            var marketDate = DateTime.parse(marketDetails['date']);

            // Tarih tam olarak targetDate ile eşleşiyorsa listeye ekle
            if (marketDate.year == targetDate.year &&
                marketDate.month == targetDate.month &&
                marketDate.day == targetDate.day) {
              filteredMarkets.add({marketName: marketDetails});
            }
          });
        }
      }
    }
    return filteredMarkets;
  } catch (e) {
    print("Veri erişilirken hata oluştu: $e");
    return [];
  }
}
}
