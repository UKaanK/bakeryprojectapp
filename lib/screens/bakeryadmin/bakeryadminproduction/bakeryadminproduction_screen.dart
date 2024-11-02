import 'package:bakeryprojectapp/models/UserModel.dart';
import 'package:bakeryprojectapp/models/bakerymodel.dart';
import 'package:bakeryprojectapp/models/regionmodel.dart';
import 'package:bakeryprojectapp/screens/bakeryadmin/bakeryadminproduction/bakeryadminproductionorder_screen.dart';
import 'package:bakeryprojectapp/services/bakeryservices.dart';
import 'package:bakeryprojectapp/services/regionservices.dart';
import 'package:bakeryprojectapp/utilits/widgets/bakeryappbar.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

class BakeryAdminProductionScreen extends StatefulWidget {
  final UserModel userModel;
  const BakeryAdminProductionScreen({super.key, required this.userModel});

  @override
  State<BakeryAdminProductionScreen> createState() =>
      _BakeryAdminProductionScreenState();
}

class _BakeryAdminProductionScreenState
    extends State<BakeryAdminProductionScreen> {
  final BakeryServices _bakeryServices = BakeryServices();
  final RegionService _regionService = RegionService();
  List<BakeryModel> bakeryList = [];
  List<String> firinbaslik = [];
  List<List<String>> firinsatir =
      []; // Satır verilerini dinamik hale getiriyoruz

  late Future<void> _bakeryDataFuture;

  @override
  void initState() {
    super.initState();
    _bakeryDataFuture = fetchBakeryData();
  }

  Future<List<BakeryModel>> fetchBakeryData() async {
    try {
      var bakeries =
          await _bakeryServices.getAllBakeries(widget.userModel.rolsId);
      print("Bakeries: $bakeries");

      if (bakeries == null || bakeries.isEmpty) {
        throw Exception("Fırın verileri bulunamadı.");
      }

      String today = DateFormat('dd.MM.yyyy').format(DateTime.now());
      List<BakeryModel> filteredBakeryData = [];

// firinbaslik listesini güncellemek için fırın isimlerini ekliyoruz
      setState(() {
        firinbaslik = [
          'Tarih',
        ];
        for (var bakery in bakeries) {
          firinbaslik.add(bakery.firinIsmi);
        }
      });
      for (var bakery in bakeries) {
        var serviceData = bakery.getEkmekSayisiByDate(today);
        //  print("Service Data for ${bakery.firinIsmi}: $serviceData");

        if (serviceData != null &&
            serviceData.containsKey('ekmek_sayisi') &&
            serviceData.containsKey('devir_ekmek_sayisi')) {
          filteredBakeryData.add(BakeryModel(
            firinIsmi: bakery.firinIsmi,
            servisler: bakery.servisler,
            // Diğer gerekli alanları ekleyin
          ));
          // Satır verisini oluştur
          firinsatir.add([
            today, // Tarih
            bakery.firinIsmi,
            serviceData['ekmek_sayisi'].toString(),
            serviceData['devir_ekmek_sayisi'].toString(),
            ""
          ]);
        }
      }

      print("Filtered Bakery Data: $filteredBakeryData");
      return filteredBakeryData; // Burada verileri döndürün
    } catch (e) {
      print("Hata: $e");
      return []; // Hata durumunda boş bir liste döndür
    }
  }

  // Dinamik sütun başlıkları (Market ve Servis başlıkları)
  final List<String> columns = ['FIRIN', 'EKMEK', 'Devir Ekmek Sayısı'];

  DateTime dateTime = DateTime.now();

  @override
  Widget build(BuildContext context) {
    String tarih =
        "${dateTime.day.toString()}.${dateTime.month.toString()}.${dateTime.year.toString()}";
    return Scaffold(
      appBar: bakeryappbar(
        centerTitle: true,
        title: Text(
          tarih,
        ),
      ),
      body: FutureBuilder(
        future: _bakeryDataFuture, // Değişken olarak çağırıyoruz
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return Center(child: CircularProgressIndicator());
          } else if (snapshot.hasError) {
            print("Hata: ${snapshot.error}");
            return Center(child: Text("Bir hata oluştu: ${snapshot.error}"));
          } else if (!snapshot.hasData) {
            return Center(child: Text("Veri bulunamadı."));
          } else {
            List<BakeryModel> bakeryList = snapshot.data as List<BakeryModel>;
            String today = DateFormat('dd.MM.yyyy')
                .format(DateTime.now()); // Bugünün tarihini alıyoruz
            return SingleChildScrollView(
              scrollDirection: Axis.vertical,
              child: Column(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Padding(
                    padding: const EdgeInsets.only(bottom: 50.0),
                    child: Container(
                      width: MediaQuery.of(context).size.width,
                      alignment: Alignment.center,
                      child: DataTable(
                        columns: columns.map((column) {
                          return DataColumn(
                            label: Text(column,
                                style: TextStyle(fontWeight: FontWeight.bold)),
                          );
                        }).toList(),
                        rows: bakeryList.map((bakery) {
                          var serviceData = bakery.getEkmekSayisiByDate(today);
                          return DataRow(cells: [
                            DataCell(Text(bakery.firinIsmi)),
                            DataCell(
                                Text(serviceData['ekmek_sayisi'].toString())),
                            DataCell(Text(
                                serviceData['devir_ekmek_sayisi'].toString())),
                          ]);
                        }).toList(),
                      ),
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.only(bottom: 30.0),
                    child: Container(
                      width: MediaQuery.of(context).size.width,
                      alignment: Alignment.center,
                      child: DataTable(
                        border: TableBorder.all(width: 2),
                        columnSpacing: 20.0,
                        columns: firinbaslik.map((column) {
                          return DataColumn(
                            label: Text(
                              column,
                              style: const TextStyle(
                                  fontWeight: FontWeight.bold,
                                  color: Colors.black),
                            ),
                          );
                        }).toList(),
                        rows: firinsatir.map((row) {
                          return DataRow(
                            cells: row.map((cell) {
                              return DataCell(
                                Text(
                                  cell,
                                  textAlign: TextAlign.start,
                                ),
                              );
                            }).toList(),
                          );
                        }).toList(),
                      ),
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.only(bottom: 20, top: 20),
                    child: Text(
                      "ORT. ÜRETİLMESİ GEREKEN EKMEK:",
                      style: TextStyle(fontWeight: FontWeight.bold),
                    ),
                  ),
                  Container(
                    alignment: Alignment.center,
                    width: MediaQuery.of(context).size.width / 1.5,
                    height: MediaQuery.of(context).size.height / 11,
                    color: Colors.blue,
                    child: GestureDetector(
                      onTap: () => Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) =>
                              BakeryAdminProductionOrderScreen(),
                        ),
                      ),
                      child: Text(
                        "ÜRETİM EMRİ GİR",
                        textAlign: TextAlign.center,
                        style: TextStyle(
                            color: Colors.white,
                            fontWeight: FontWeight.bold,
                            fontSize: 25),
                      ),
                    ),
                  )
                ],
              ),
            );
          }
        },
      ),
    );
  }
}
