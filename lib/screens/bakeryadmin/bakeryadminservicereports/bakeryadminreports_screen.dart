// import 'package:bakeryprojectapp/models/regionmodel.dart';
// import 'package:bakeryprojectapp/services/regionservices.dart';
// import 'package:bakeryprojectapp/utilits/widgets/bakeryappbar.dart';
// import 'package:flutter/material.dart';

// class BakeryAdminReportsScreen extends StatefulWidget {
//   final String rolsId;
//   final String regionId;

//   const BakeryAdminReportsScreen(
//       {super.key, required this.rolsId, required this.regionId});

//   @override
//   State<BakeryAdminReportsScreen> createState() =>
//       _BakeryAdminReportsScreenState();
// }

// class _BakeryAdminReportsScreenState extends State<BakeryAdminReportsScreen> {
//   final RegionService _regionService = RegionService();

//   List<String> columns = ['Market', 'Toplam'];
//   List<List<String>> rows = [];

//   @override
//   void initState() {
//     super.initState();
//     fetchRegionData();
//   }

//   void fetchRegionData() async {
//     RegionModel? regionData =
//         await _regionService.getRegionData(widget.rolsId, widget.regionId);

//     if (regionData != null) {
//       setState(() {
//         // Servis anahtarlarını bir küme (set) olarak al ve sıralı liste oluştur
//         Set<String> allServiceKeys = {};
//         for (var market in regionData.market) {
//           allServiceKeys.addAll(market.services.keys);
//         }
//         // Anahtarları sıralı bir listeye dönüştür
//         List<String> dynamicColumns = allServiceKeys.toList();
//         dynamicColumns.sort(); // Anahtarları alfabetik sıralama

//         columns = ['Market', ...dynamicColumns, 'Toplam'];

//         // Satır verilerini ayarla
//         rows = regionData.market.map((market) {
//           List<String> row = [market.name];
//           int rowTotal = 0; // Satır toplamı için değişken
//           for (var col in dynamicColumns) {
//             int value =
//                 int.tryParse(market.services[col]?.toString() ?? '0') ?? 0;
//             row.add(value.toString()); // Servis değerlerini al
//             rowTotal += value; // Satır toplamını güncelle
//           }
//           row.add(rowTotal.toString()); // Satır toplamını ekle
//           return row;
//         }).toList();

//         // Toplam satırını ekle
//         List<String> totalRow = ['Toplam'];
//         for (var col in dynamicColumns) {
//           // Her bir hizmet için toplam hesapla
//           int total = 0;
//           for (var market in regionData.market) {
//             total +=
//                 (int.tryParse(market.services[col]?.toString() ?? '0') ?? 0);
//           }
//           totalRow.add(total.toString());
//         }

//         // Toplam satırına toplam hücresini ekle
//         totalRow.add(rows
//             .fold(0, (sum, row) => sum + (int.tryParse(row.last) ?? 0))
//             .toString()); // Toplam satırının en sağındaki toplam

//         // Toplam satırını ekleyin
//         rows.add(totalRow);
//       });
//     }
//   }

//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: bakeryappbar(),
//       body: Center(
//         child: SingleChildScrollView(
//           scrollDirection: Axis.horizontal,
//           child: DataTable(
//             border: TableBorder.all(width: 2),
//             columnSpacing: 15.0,
//             columns: columns.map((column) {
//               return DataColumn(
//                 label: Text(
//                   column,
//                   style: const TextStyle(
//                       fontWeight: FontWeight.bold, color: Colors.black),
//                 ),
//               );
//             }).toList(),
//             rows: rows.map((row) {
//               return DataRow(
//                 cells: row.map((cell) {
//                   return DataCell(
//                     Text(cell, textAlign: TextAlign.start),
//                   );
//                 }).toList(),
//               );
//             }).toList(),
//           ),
//         ),
//       ),
//     );
//   }
// }

// /*
// import 'package:bakeryprojectapp/models/regionmodel.dart';
// import 'package:bakeryprojectapp/services/regionservices.dart';
// import 'package:bakeryprojectapp/utilits/widgets/bakeryappbar.dart';
// import 'package:flutter/material.dart';

// class BakeryAdminReportsScreen extends StatefulWidget {
//   final String rolsId;
//   final String regionId;

//   const BakeryAdminReportsScreen({super.key, required this.rolsId, required this.regionId});

//   @override
//   State<BakeryAdminReportsScreen> createState() => _BakeryAdminReportsScreenState();
// }

// class _BakeryAdminReportsScreenState extends State<BakeryAdminReportsScreen> {
//   final RegionService _regionService = RegionService();

//   List<String> columns = ['Market', 'Toplam'];
//   List<List<String>> rows = [];
//   List<String> totalRow = ['Toplam']; // Genel toplam satırı

//   @override
//   void initState() {
//     super.initState();
//     fetchRegionData();
//   }

//   void fetchRegionData() async {
//     RegionModel? regionData = await _regionService.getRegionData(widget.rolsId, widget.regionId);

//     if (regionData != null) {
//       setState(() {
//         Set<String> allServiceKeys = {};
//         for (var market in regionData.market) {
//           allServiceKeys.addAll(market.services.keys);
//         }
//         List<String> dynamicColumns = allServiceKeys.toList()..sort();
//         columns = ['Market', ...dynamicColumns, 'Toplam'];

//         rows = regionData.market.map((market) {
//           List<String> row = [market.name];
//           int rowTotal = 0;
//           for (var col in dynamicColumns) {
//             int value = int.tryParse(market.services[col]?.toString() ?? '0') ?? 0;
//             row.add(value.toString());
//             rowTotal += value;
//           }
//           row.add(rowTotal.toString()); // Her market için toplamı ekle
//           return row;
//         }).toList();

//         // Genel toplam hesaplama
//         totalRow = ['Toplam'];
//         for (var col in dynamicColumns) {
//           int columnTotal = regionData.market.fold(0, (sum, market) {
//             return sum + (int.tryParse(market.services[col]?.toString() ?? '0') ?? 0);
//           });
//           totalRow.add(columnTotal.toString());
//         }

//         // En sağdaki genel toplamı hesapla
//         int grandTotal = rows.fold(0, (sum, row) => sum + (int.tryParse(row.last) ?? 0));
//         totalRow.add(grandTotal.toString()); // Genel toplamı ekle

//         rows.add(totalRow); // Genel toplam satırını tablonun sonuna ekle
//       });
//     }
//   }

//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: bakeryappbar(title: Text(widget.regionId)),
//       body: Center(
//         child: SingleChildScrollView(
//           scrollDirection: Axis.horizontal,
//           child: DataTable(
//             border: TableBorder.all(width: 2, color: Colors.grey.shade300),
//             columnSpacing: 30.0,
//             headingRowColor: WidgetStateProperty.resolveWith((states) => Colors.blueAccent),
//             headingTextStyle: const TextStyle(
//               fontWeight: FontWeight.bold,
//               color: Colors.white,
//               fontSize: 18,
//             ),
//             columns: columns.map((column) {
//               return DataColumn(
//                 label: Padding(
//                   padding: const EdgeInsets.symmetric(vertical: 12.0),
//                   child: Text(column),
//                 ),
//               );
//             }).toList(),
//             rows: rows.asMap().entries.map((entry) {
//               int index = entry.key;
//               List<String> row = entry.value;
//               return DataRow(
//                 color: WidgetStateProperty.resolveWith(
//                   (states) => index == rows.length - 1
//                       ? Colors.lightBlue.shade100 // Genel toplam satırı için farklı renk
//                       : index % 2 == 0
//                           ? Colors.grey.shade100
//                           : Colors.white,
//                 ),
//                 cells: row.map((cell) {
//                   return DataCell(
//                     Padding(
//                       padding: const EdgeInsets.symmetric(vertical: 16.0, horizontal: 8.0),
//                       child: Text(
//                         cell,
//                         textAlign: TextAlign.start,
//                         softWrap: true,
//                         overflow: TextOverflow.visible,
//                         maxLines: 3,
//                         style: TextStyle(
//                           fontSize: 16,
//                           fontWeight: index == rows.length - 1 ? FontWeight.bold : FontWeight.normal,
//                         ),
//                       ),
//                     ),
//                   );
//                 }).toList(),
//               );
//             }).toList(),
//           ),
//         ),
//       ),
//     );
//   }
// }

/*



//  bu kısım 15 kasım 2024 de düzenlendi 


import 'package:bakeryprojectapp/services/regionservices.dart';
import 'package:bakeryprojectapp/utilits/widgets/bakeryappbar.dart';
import 'package:flutter/material.dart';

class BakeryAdminReportsScreen extends StatefulWidget {
  final String regionName; // Bölge ismini widget'a ekleyelim

  const BakeryAdminReportsScreen({super.key, required this.regionName});

  @override
  State<BakeryAdminReportsScreen> createState() =>
      _BakeryAdminReportsScreenState();
}

class _BakeryAdminReportsScreenState extends State<BakeryAdminReportsScreen> {
  final RegionService _regionService = RegionService();
  List<Map<String, dynamic>> marketData = [];

  @override
  void initState() {
    super.initState();
    fetchRegionData();
  }

  // Bölgeye ait verileri almak için servis çağrısı
  void fetchRegionData() async {
    // Verileri çek
    List<Map<String, dynamic>> markets =
        await _regionService.getMarketsByRegionNameAndExactDate(widget.regionName,DateTime(2024,11,6));

    setState(() {
      // `marketData`'yı düzenle
      marketData = markets.map((market) {
        // Her market için hizmet verilerini al
        Map<String, int> services = {};

        // Her bir market için veriyi kontrol et
        market.forEach((marketName, marketDetails) {
          if (marketDetails is Map<String, dynamic>) {
            marketDetails.forEach((key, value) {
              // Değerlerin sayısal olduğunu doğrula ve ekle
              services[key] = int.tryParse(value.toString()) ?? 0;
            });
          }
        });

        return {
          'marketName': market.keys.first, // Market adı
          'services': services, // Hizmet verileri
        };
      }).toList();
    });
  }

  // Bir marketin toplam hizmet değerini hesaplama
  int calculateMarketTotal(Map<String, int> services) {
    return services.values.fold(0, (sum, value) => sum + value);
  }

  // Genel toplamı hesapla
  int calculateGeneralTotal() {
    return marketData.fold(
        0,
        (sum, market) =>
            sum + calculateMarketTotal(market['services'] as Map<String, int>));
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: bakeryappbar(
        automaticallyImplyLeading: true,
        title: Text(widget.regionName),
      ),
      body: Column(
        children: [
          Expanded(
            child: Padding(
              padding: const EdgeInsets.all(16.0),
              child: marketData.isEmpty
                  ? Center(child: CircularProgressIndicator())
                  : ListView.builder(
                      itemCount: marketData.length,
                      itemBuilder: (context, index) {
                        final data = marketData[index];
                        final marketTotal = calculateMarketTotal(
                            data['services'] as Map<String, int>);

                        return Card(
                          elevation: 5,
                          margin: EdgeInsets.symmetric(vertical: 8),
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(15),
                          ),
                          child: Padding(
                            padding: const EdgeInsets.all(16.0),
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Row(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceBetween,
                                  children: [
                                    Row(
                                      children: [
                                        Icon(
                                          Icons.store,
                                          color: Colors.blueAccent,
                                          size: 22,
                                        ),
                                        SizedBox(width: 8),
                                        Text(
                                          data['marketName'],
                                          style: TextStyle(
                                            fontSize: 20,
                                            fontWeight: FontWeight.bold,
                                            color: Colors.blueAccent,
                                          ),
                                        ),
                                      ],
                                    ),
                                    Icon(
                                      Icons.arrow_drop_down_circle,
                                      color: Colors.grey.shade400,
                                    ),
                                  ],
                                ),
                                SizedBox(height: 10),
                                Column(
                                  children:
                                      (data['services'] as Map<String, int>)
                                          .entries
                                          .map((entry) {
                                    return Row(
                                      mainAxisAlignment:
                                          MainAxisAlignment.spaceBetween,
                                      children: [
                                        Text(
                                          entry.key,
                                          style: TextStyle(
                                              fontSize: 16,
                                              color: Colors.grey.shade700),
                                        ),
                                        Text(
                                          entry.value.toString(),
                                          style: TextStyle(
                                              fontSize: 16,
                                              color: Colors.grey.shade900),
                                        ),
                                      ],
                                    );
                                  }).toList(),
                                ),
                                Divider(),
                                Row(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceBetween,
                                  children: [
                                    Row(
                                      children: [
                                        Icon(
                                          Icons.attach_money,
                                          color: Colors.green,
                                          size: 20,
                                        ),
                                        Text(
                                          'Toplam',
                                          style: TextStyle(
                                            fontSize: 18,
                                            fontWeight: FontWeight.bold,
                                            color: Colors.black,
                                          ),
                                        ),
                                      ],
                                    ),
                                    Text(
                                      marketTotal.toString(),
                                      style: TextStyle(
                                        fontSize: 18,
                                        fontWeight: FontWeight.bold,
                                        color: Colors.black,
                                      ),
                                    ),
                                  ],
                                ),
                              ],
                            ),
                          ),
                        );
                      },
                    ),
            ),
          ),
          // Genel toplam göstergesi
          Card(
            color: Color.fromARGB(255, 78, 214, 255),
            margin: EdgeInsets.all(0),
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.only(
                topLeft: Radius.circular(20),
                topRight: Radius.circular(20),
              ),
            ),
            child: Padding(
              padding: const EdgeInsets.all(16.0),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    'Genel Toplam',
                    style: TextStyle(
                      fontSize: 20,
                      fontWeight: FontWeight.bold,
                      color: Colors.white,
                    ),
                  ),
                  Text(
                    calculateGeneralTotal().toString(),
                    style: TextStyle(
                      fontSize: 20,
                      fontWeight: FontWeight.bold,
                      color: Colors.white,
                    ),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}






*/import 'package:flutter/material.dart';
import 'package:bakeryprojectapp/models/usermodel.dart';
import 'package:bakeryprojectapp/services/regionservices.dart';
import 'package:bakeryprojectapp/utilits/widgets/bakeryappbar.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:intl/intl.dart';

class BakeryAdminReportsScreen extends StatefulWidget {
  final String regionName; // Bölge ismini widget'a ekleyelim
  final UserModel userModel;

  const BakeryAdminReportsScreen({
    super.key,
    required this.regionName,
    required this.userModel,
  });

  @override
  State<BakeryAdminReportsScreen> createState() =>
      _BakeryAdminReportsScreenState();
}

class _BakeryAdminReportsScreenState extends State<BakeryAdminReportsScreen> {
  final RegionService _regionService = RegionService();
  List<Map<String, dynamic>> marketData = [];
  DateTime selectedDate = DateTime.now(); // Varsayılan tarih
  bool isLoading = true; // Veriler yükleniyor mu?

  final Map<String, String> serviceNames = {
    'total_ekmek': 'Total Ekmek',
    'iade_ekmek': 'İade Ekmek',
    'dagitilan_ekmek': 'Dağıtılan Ekmek',
    'aractaki_ekmek': 'Araçtaki Ekmek',
    'tahsilat': 'Tahsilat',
  };

  @override
  void initState() {
    super.initState();
    fetchRegionData(); // İlk veri yüklemesi
  }

  // Tarih seçici
  Future<void> _selectDate(BuildContext context) async {
    final DateTime? pickedDate = await showDatePicker(
      context: context,
      initialDate: selectedDate,
      firstDate: DateTime(2022),
      lastDate: DateTime(2030),
    );
    if (pickedDate != null && pickedDate != selectedDate) {
      setState(() {
        selectedDate = pickedDate;
        isLoading = true; // Yeni veri yüklemesi başladığında yükleniyor durumu
      });
      fetchRegionData(); // Yeni tarihe göre verileri çek
    }
  }

  // Bölgeye ait verileri almak için servis çağrısı
  void fetchRegionData() async {
    try {
      List<Map<String, dynamic>> markets = await _regionService
          .getMarketsByRegionNameAndDate(widget.regionName, selectedDate);

      setState(() {
        marketData = markets.map((market) {
          Map<String, int> services = {};

          market.forEach((marketName, marketDetails) {
            if (marketDetails is Map<String, dynamic>) {
              marketDetails.forEach((key, value) {
                if (key != "date") {
                  // "date" alanını hariç tut
                  services[key] = int.tryParse(value.toString()) ?? 0;
                }
              });
            }
          });

          return {
            'marketName': market.keys.first,
            'services': services,
          };
        }).toList();
        isLoading = false; // Veri yüklendi
      });
    } catch (e) {
      setState(() {
        isLoading = false; // Hata durumunda yükleniyor ekranını kapat
      });
      print('Veri çekme hatası: $e');
    }
  }

  // Bir marketin toplam hizmet değerini hesaplama
  int calculateMarketTotal(Map<String, int> services) {
    return services.values.fold(0, (sum, value) => sum + value);
  }

  // Genel toplamı hesapla
  int calculateGeneralTotal() {
    return marketData.fold(
        0,
        (sum, market) =>
            sum + calculateMarketTotal(market['services'] as Map<String, int>));
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: bakeryappbar(
        automaticallyImplyLeading: true,
        title: Text(
          widget.regionName,
          style: GoogleFonts.abrilFatface(
            fontSize: 35,
            fontWeight: FontWeight.bold,
            color: Colors.blue,
          ),
        ),
      ),
      body: Column(
        children: [
          // Tarih Seçici
          Padding(
            padding: const EdgeInsets.symmetric(vertical: 16.0),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                ElevatedButton.icon(
                  onPressed: () => _selectDate(context),
                  icon: const Icon(Icons.calendar_today, color: Colors.white),
                  label: Text(
                    "Seçilen Tarih : ${DateFormat('dd.MM.yyyy').format(selectedDate)}",
                    style: const TextStyle(fontSize: 16, color: Colors.white),
                  ),
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Colors.blue, // Mavi renk
                    padding: const EdgeInsets.symmetric(
                        horizontal: 20, vertical: 12),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(10),
                    ),
                  ),
                ),
              ],
            ),
          ),
          Expanded(
            child: Padding(
              padding: const EdgeInsets.all(16.0),
              child: isLoading
                  ? const Center(child: CircularProgressIndicator())
                  : ListView.builder(
                      itemCount: marketData.length,
                      itemBuilder: (context, index) {
                        final data = marketData[index];
                        final marketTotal = calculateMarketTotal(
                            data['services'] as Map<String, int>);

                        final sortedServices =
                            (data['services'] as Map<String, int>)
                                .entries
                                .toList();

                        sortedServices.sort((a, b) => a.key.compareTo(b.key));

                        return Card(
                          elevation: 5,
                          margin: const EdgeInsets.symmetric(vertical: 8),
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(15),
                          ),
                          child: Padding(
                            padding: const EdgeInsets.all(16.0),
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Row(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceBetween,
                                  children: [
                                    Row(
                                      children: [
                                        const Icon(
                                          Icons.store,
                                          color: Colors.blue,
                                          size: 22,
                                        ),
                                        const SizedBox(width: 8),
                                        Text(
                                          data['marketName'],
                                          style: const TextStyle(
                                            fontSize: 20,
                                            fontWeight: FontWeight.bold,
                                            color: Colors.blue,
                                          ),
                                        ),
                                      ],
                                    ),
                                    Icon(
                                      Icons.arrow_drop_down_circle,
                                      color: const Color.fromARGB(
                                          255, 162, 196, 250),
                                    ),
                                  ],
                                ),
                                const SizedBox(height: 10),
                                Column(
                                  children: sortedServices.map((entry) {
                                    return Row(
                                      mainAxisAlignment:
                                          MainAxisAlignment.spaceBetween,
                                      children: [
                                        Text(
                                          serviceNames[entry.key] ??
                                              'Servis ${entry.key}',
                                          style: TextStyle(
                                              fontSize: 16,
                                              color: Colors.grey.shade700),
                                        ),
                                        Text(
                                          entry.value.toString(),
                                          style: TextStyle(
                                              fontSize: 16,
                                              color: Colors.grey.shade900),
                                        ),
                                      ],
                                    );
                                  }).toList(),
                                ),
                                const Divider(),
                                Row(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceBetween,
                                  children: [
                                    const Row(
                                      children: [
                                        Icon(
                                          Icons.attach_money,
                                          color: Colors.green,
                                          size: 20,
                                        ),
                                        Text(
                                          'Toplam',
                                          style: TextStyle(
                                            fontSize: 18,
                                            fontWeight: FontWeight.bold,
                                            color: Colors.black,
                                          ),
                                        ),
                                      ],
                                    ),
                                    Text(
                                      marketTotal.toString(),
                                      style: const TextStyle(
                                        fontSize: 18,
                                        fontWeight: FontWeight.bold,
                                        color: Colors.black,
                                      ),
                                    ),
                                  ],
                                ),
                              ],
                            ),
                          ),
                        );
                      },
                    ),
            ),
          ),
          Padding(
            padding:
                const EdgeInsets.symmetric(horizontal: 16.0, vertical: 8.0),
            child: Card(
              elevation: 4,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(15),
              ),
              child: Padding(
                padding: const EdgeInsets.all(16.0),
                child: Column(
                  children: [
                    _buildInfoRow(Icons.local_shipping, "Dağıtılan Ekmek",
                        calculateDagitilanEkmekTotal(), Colors.blue),
                    const SizedBox(height: 8),
                    _buildInfoRow(Icons.assignment_return, "İade Ekmek",
                        calculateIadeEkmekTotal(), Colors.red),
                    const SizedBox(height: 8),
                    _buildInfoRow(Icons.money, "Tahsilat",
                        calculateTahsilatTotal(), Colors.green),
                  ],
                ),
              ),
            ),
          ),
          Card(
            color: const Color.fromARGB(255, 78, 214, 255),
            margin: const EdgeInsets.all(0),
            shape: const RoundedRectangleBorder(),
            child: Padding(
              padding: const EdgeInsets.all(16.0),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  const Text(
                    'Genel Toplam',
                    style: TextStyle(
                      fontSize: 20,
                      fontWeight: FontWeight.bold,
                      color: Colors.white,
                    ),
                  ),
                  Text(
                    calculateGeneralTotal().toString(),
                    style: const TextStyle(
                      fontSize: 20,
                      fontWeight: FontWeight.bold,
                      color: Colors.white,
                    ),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }

  int calculateDagitilanEkmekTotal() {
    return marketData.fold(
      0,
      (sum, market) =>
          sum + ((market['services']?['dagitilan_ekmek'] ?? 0) as int),
    );
  }

  int calculateIadeEkmekTotal() {
    return marketData.fold(
      0,
      (sum, market) => sum + ((market['services']?['iade_ekmek'] ?? 0) as int),
    );
  }

  int calculateTahsilatTotal() {
    return marketData.fold(
      0,
      (sum, market) => sum + ((market['services']?['tahsilat'] ?? 0) as int),
    );
  }

  Widget _buildInfoRow(
      IconData icon, String label, int value, Color iconColor) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Row(
          children: [
            Icon(icon, color: iconColor, size: 24),
            const SizedBox(width: 8),
            Text(
              label,
              style: const TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
            ),
          ],
        ),
        Text(
          value.toString(),
          style: const TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
        ),
      ],
    );
  }
}