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

 Future<List<Map<String, dynamic>>> getMarketsByRegionNameAndDate(
      String regionName, DateTime targetDate) async {
    List<Map<String, dynamic>> filteredMarkets = [];

    try {
      // rols koleksiyonundaki belgeleri al
      var rolsSnapshot =
          await FirebaseFirestore.instance.collection('rols').get();

      // rols koleksiyonundaki her belgeyi kontrol et
      for (var rolsDoc in rolsSnapshot.docs) {
        // dagitim koleksiyonunu al
        var dagitimSnapshot =
            await rolsDoc.reference.collection("dagitim").get();

        // dagitim koleksiyonundaki her bir belgeyi kontrol et
        for (var element in dagitimSnapshot.docs) {
          var data = element.data();

          // Belge ID'sini kullanarak `region_name`'ı al
          var region = data['region_name'];

          // Eğer belge `region_name` ile eşleşiyorsa
          if (region == regionName) {
            // Belge ID'sindeki tarihi DateTime'a dönüştür
            var marketDateString = element.id;
            var marketDateParts = marketDateString.split('.');
            if (marketDateParts.length == 3) {
              int day = int.parse(marketDateParts[0]);
              int month = int.parse(marketDateParts[1]);
              int year = int.parse(marketDateParts[2]);

              var marketDate = DateTime(year, month, day);

              // targetDate ile karşılaştır
              if (marketDate.year == targetDate.year &&
                  marketDate.month == targetDate.month &&
                  marketDate.day == targetDate.day) {
                // Eğer tarih eşleşiyorsa, market verilerini al
                var marketArray = data['market'] as List?;

                if (marketArray != null) {
                  // market verilerini listeye ekle
                  for (var market in marketArray) {
                    market.forEach((marketName, marketDetails) {
                      filteredMarkets.add({marketName: marketDetails});
                    });
                  }
                }
              }
            }
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
