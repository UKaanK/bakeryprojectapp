import 'package:bakeryprojectapp/models/usermodel.dart';
import 'package:bakeryprojectapp/models/bakerymodel.dart';
import 'package:bakeryprojectapp/screens/bakeryadmin/bakeryadminproduction/bakeryadminproductionorder_screen.dart';
import 'package:bakeryprojectapp/services/bakeryservices.dart';
import 'package:bakeryprojectapp/utilits/widgets/bakeryappbar.dart';
import 'package:flutter/cupertino.dart';
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
  List<BakeryModel> bakeryList = [];
  Map<String, List<BakeryModel>> groupedBakeries =
      {}; // Bölgelere göre gruplama
  String selectedBolge = ''; // Seçilen bölge
  late Future<void> _bakeryDataFuture;
  DateTime selectedDate = DateTime.now();

  @override
  void initState() {
    super.initState();
    _bakeryDataFuture = fetchBakeryData();
  }

  Future<List<BakeryModel>> fetchBakeryData() async {
    try {
      var bakeries =
          await _bakeryServices.getAllBakeries(widget.userModel.rolsId);

      if (bakeries == null || bakeries.isEmpty) {
        throw Exception("Fırın verileri bulunamadı.");
      }

      setState(() {
        bakeryList = bakeries;
        groupBakeriesByBolge(); // Bölgelere göre gruplama yapılacak
      });
      return bakeries;
    } catch (e) {
      print("Hata: $e");
      return [];
    }
  }

  void groupBakeriesByBolge() {
    groupedBakeries.clear();
    for (var bakery in bakeryList) {
      if (!groupedBakeries.containsKey(bakery.regionName)) {
        groupedBakeries[bakery.regionName] = [];
      }
      groupedBakeries[bakery.regionName]!.add(bakery);
    }
  }

  Future<void> _selectDate(BuildContext context) async {
    final DateTime? picked = await showDatePicker(
      context: context,
      initialDate: selectedDate,
      firstDate: DateTime(2000),
      lastDate: DateTime.now(),
    );
    if (picked != null && picked != selectedDate) {
      setState(() {
        selectedDate = picked;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: bakeryappbar(
        automaticallyImplyLeading: false,
        title: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(
              "Seçilen Tarih: ${DateFormat('dd.MM.yyyy').format(selectedDate)}",
              style: TextStyle(fontSize: 14),
            ),
            IconButton(
              icon: Icon(Icons.calendar_today),
              onPressed: () => _selectDate(context),
            ),
          ],
        ),
      ),
      body: FutureBuilder(
        future: _bakeryDataFuture,
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return Center(child: CircularProgressIndicator());
          } else if (snapshot.hasError) {
            return Center(child: Text("Bir hata oluştu: ${snapshot.error}"));
          } else if (!snapshot.hasData) {
            return Center(child: Text("Veri bulunamadı."));
          } else {
            return Column(
              children: [
                // Bölge seçimi için DropdownButton
                DropdownButton<String>(
                  value: selectedBolge.isEmpty ? null : selectedBolge,
                  hint: Text('Bir bölge seçin'),
                  items: groupedBakeries.keys.map((String bolge) {
                    return DropdownMenuItem<String>(
                      value: bolge,
                      child: Text(bolge),
                    );
                  }).toList(),
                  onChanged: (value) {
                    setState(() {
                      selectedBolge = value ?? '';
                    });
                  },
                ),
                if (selectedBolge.isNotEmpty)
                  Expanded(
                    child: ListView(
                      children: groupedBakeries[selectedBolge]!.map((bakery) {
                        return Column(
                          children: [
                            Text(
                              bakery.firinIsmi,
                              style: TextStyle(
                                  fontWeight: FontWeight.bold, fontSize: 16),
                            ),
                            SizedBox(height: 8),
                            SizedBox(
                              width: MediaQuery.of(context).size.width,
                              height: MediaQuery.of(context).size.height / 3,
                              child: DataTable(
                                columns: [
                                  DataColumn(label: Text('Ekmek Sayısı')),
                                  DataColumn(label: Text('Devir Ekmek Sayısı')),
                                ],
                                rows: [
                                  DataRow(
                                    cells: [
                                      DataCell(Text(
                                        bakery
                                                .getEkmekSayisiByDate(
                                                    DateFormat('dd.MM.yyyy')
                                                        .format(selectedDate))?[
                                                    'ekmek_sayisi']
                                                ?.toString() ??
                                            '-',
                                        textAlign: TextAlign.start,
                                      )),
                                      DataCell(Text(
                                        bakery
                                                .getEkmekSayisiByDate(
                                                    DateFormat('dd.MM.yyyy')
                                                        .format(selectedDate))?[
                                                    'devir_ekmek_sayisi']
                                                ?.toString() ??
                                            '-',
                                        textAlign: TextAlign.start,
                                      )),
                                    ],
                                  ),
                                ],
                              ),
                            ),
                          ],
                        );
                      }).toList(),
                    ),
                  ),
                TextButton(
                    onPressed: () => Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) =>
                              BakeryAdminProductionOrderScreen(),
                        )),
                    child: Text("TIKLA"))
              ],
            );
          }
        },
      ),
    );
  }
}
