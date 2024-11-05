/*
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
  Map<String, List<BakeryModel>> groupedBakeries = {}; // Bölgelere göre gruplama
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
                                        bakery.getEkmekSayisiByDate(
                                                DateFormat('dd.MM.yyyy')
                                                    .format(selectedDate))?['ekmek_sayisi']
                                                ?.toString() ??
                                            '-',
                                        textAlign: TextAlign.start,
                                      )),
                                      DataCell(Text(
                                        bakery.getEkmekSayisiByDate(
                                                DateFormat('dd.MM.yyyy')
                                                    .format(selectedDate))?['devir_ekmek_sayisi']
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
                  TextButton(onPressed: ()=> Navigator.push(context, MaterialPageRoute(builder: (context) => BakeryAdminProductionOrderScreen(),)), child: Text("TIKLA"))
              ],
            );
          }
        },
      ),
    );
  }
}


*/





/*
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
  Map<String, List<BakeryModel>> groupedBakeries = {}; // Bölgelere göre gruplama
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

  Widget customButton(BuildContext context, String text, VoidCallback onPressed) {
    final screenWidth = MediaQuery.of(context).size.width;
    final screenHeight = MediaQuery.of(context).size.height;

    return Padding(
      padding: EdgeInsets.symmetric(vertical: screenHeight * 0.03),
      child: GestureDetector(
        onTap: onPressed,
        child: Container(
          alignment: Alignment.center,
          width: screenWidth * 0.6,
          height: screenHeight * 0.08,
          decoration: BoxDecoration(
            color: Colors.blueAccent,
            borderRadius: BorderRadius.circular(screenWidth * 0.1), // Yuvarlatılmış köşeler
            boxShadow: [
              BoxShadow(
                color: Colors.blueAccent.withOpacity(0.3),
                blurRadius: 10,
                offset: Offset(0, 5),
              ),
            ],
          ),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text(
                text,
                style: TextStyle(
                  color: Colors.white,
                  fontSize: screenWidth * 0.06,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: bakeryappbar(
        title: Text("Üretim Ekranı"),
      ),
      body: Stack(
        children: [
          Column(
            children: [
              SizedBox(height: 16),
              Center(
                child: GestureDetector(
                  onTap: () => _selectDate(context),
                  child: Container(
                    padding: EdgeInsets.symmetric(vertical: 12, horizontal: 20),
                    decoration: BoxDecoration(
                      color: Colors.blueAccent,
                      borderRadius: BorderRadius.circular(8),
                    ),
                    child: Row(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        Icon(Icons.calendar_today, color: Colors.white),
                        SizedBox(width: 8),
                        Text(
                          "Seçilen Tarih: ${DateFormat('dd.MM.yyyy').format(selectedDate)}",
                          style: TextStyle(
                              color: Colors.white,
                              fontWeight: FontWeight.bold,
                              fontSize: 16),
                        ),
                      ],
                    ),
                  ),
                ),
              ),
              SizedBox(height: 10),
              Center(
                child: Container(
                  width: MediaQuery.of(context).size.width * 0.6,
                  padding: EdgeInsets.symmetric(horizontal: 16),
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(8),
                    border: Border.all(color: Colors.grey),
                  ),
                  child: DropdownButton<String>(
                    value: selectedBolge.isEmpty ? null : selectedBolge,
                    hint: Text('Bir bölge seçin'),
                    isExpanded: true,
                    underline: SizedBox(),
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
                ),
              ),
              SizedBox(height: 10),
            ],
          ),
          Padding(
            padding: EdgeInsets.only(top: 140), // Card'lar için üstten boşluk
            child: FutureBuilder(
              future: _bakeryDataFuture,
              builder: (context, snapshot) {
                if (snapshot.connectionState == ConnectionState.waiting) {
                  return Center(child: CircularProgressIndicator());
                } else if (snapshot.hasError) {
                  return Center(child: Text("Bir hata oluştu: ${snapshot.error}"));
                } else if (!snapshot.hasData || selectedBolge.isEmpty) {
                  return Center(child: Text("Veri bulunamadı."));
                } else {
                  return ListView(
                    children: groupedBakeries[selectedBolge]!.map((bakery) {
                      return Card(
                        margin: EdgeInsets.symmetric(
                            vertical: 12.0, horizontal: 16.0), // Üstten daha fazla boşluk
                        child: Padding(
                          padding: EdgeInsets.all(16.0),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                bakery.firinIsmi,
                                style: TextStyle(
                                    fontWeight: FontWeight.bold,
                                    fontSize: 16),
                              ),
                              SizedBox(height: 8),
                              Text(
                                "Ekmek Sayısı: ${bakery.getEkmekSayisiByDate(DateFormat('dd.MM.yyyy').format(selectedDate))?['ekmek_sayisi']?.toString() ?? '-'}",
                                style: TextStyle(fontSize: 14),
                              ),
                            ],
                          ),
                        ),
                      );
                    }).toList(),
                  );
                }
              },
            ),
          ),
        ],
      ),
      bottomNavigationBar: Padding(
        padding: const EdgeInsets.all(16.0),
        child: customButton(
          context,
          'ÜRETİM GİR',
          () {
            Navigator.push(
              context,
              MaterialPageRoute(
                  builder: (context) => BakeryAdminProductionOrderScreen()),
            );
          },
        ),
      ),
    );
  }
}

*/


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
  Map<String, List<BakeryModel>> groupedBakeries = {}; // Bölgelere göre gruplama
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

  Widget customButton(BuildContext context, String text, VoidCallback onPressed) {
    final screenWidth = MediaQuery.of(context).size.width;
    final screenHeight = MediaQuery.of(context).size.height;

    return Padding(
      padding: EdgeInsets.symmetric(vertical: screenHeight * 0.03),
      child: GestureDetector(
        onTap: onPressed,
        child: Container(
          alignment: Alignment.center,
          width: screenWidth * 0.6,
          height: screenHeight * 0.08,
          decoration: BoxDecoration(
            color: Colors.blueAccent,
            borderRadius: BorderRadius.circular(screenWidth * 0.1), // Yuvarlatılmış köşeler
            boxShadow: [
              BoxShadow(
                color: Colors.blueAccent.withOpacity(0.3),
                blurRadius: 10,
                offset: Offset(0, 5),
              ),
            ],
          ),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text(
                text,
                style: TextStyle(
                  color: Colors.white,
                  fontSize: screenWidth * 0.06,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: bakeryappbar(
        title: Text("Üretim Ekranı"),
      ),
      body: Stack(
        children: [
          Column(
            children: [
              SizedBox(height: 16),
              Center(
                child: GestureDetector(
                  onTap: () => _selectDate(context),
                  child: Container(
                    padding: EdgeInsets.symmetric(vertical: 12, horizontal: 20),
                    decoration: BoxDecoration(
                      color: Colors.blueAccent,
                      borderRadius: BorderRadius.circular(8),
                    ),
                    child: Row(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        Icon(Icons.calendar_today, color: Colors.white),
                        SizedBox(width: 8),
                        Text(
                          "Seçilen Tarih: ${DateFormat('dd.MM.yyyy').format(selectedDate)}",
                          style: TextStyle(
                              color: Colors.white,
                              fontWeight: FontWeight.bold,
                              fontSize: 16),
                        ),
                      ],
                    ),
                  ),
                ),
              ),
              SizedBox(height: 10),
              Center(
                child: Container(
                  width: MediaQuery.of(context).size.width * 0.6,
                  padding: EdgeInsets.symmetric(horizontal: 16),
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(8),
                    border: Border.all(color: Colors.grey),
                  ),
                  child: DropdownButton<String>(
                    value: selectedBolge.isEmpty ? null : selectedBolge,
                    hint: Text('Bir bölge seçin'),
                    isExpanded: true,
                    underline: SizedBox(),
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
                ),
              ),
              SizedBox(height: 10),
            ],
          ),
          Padding(
            padding: EdgeInsets.only(top: 140), // Card'lar için üstten boşluk
            child: FutureBuilder(
              future: _bakeryDataFuture,
              builder: (context, snapshot) {
                if (snapshot.connectionState == ConnectionState.waiting) {
                  return Center(child: CircularProgressIndicator());
                } else if (snapshot.hasError) {
                  return Center(child: Text("Bir hata oluştu: ${snapshot.error}"));
                } else if (!snapshot.hasData || selectedBolge.isEmpty) {
                  return Center(child: Text("Veri bulunamadı."));
                } else {
                  return ListView.builder(
                    itemCount: groupedBakeries[selectedBolge]!.length,
                    itemBuilder: (context, index) {
                      var bakery = groupedBakeries[selectedBolge]![index];
                      return Card(
                        margin: EdgeInsets.symmetric(vertical: 12.0, horizontal: 16.0),
                        child: Padding(
                          padding: EdgeInsets.all(16.0),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                bakery.firinIsmi,
                                style: TextStyle(
                                    fontWeight: FontWeight.bold,
                                    fontSize: 16),
                              ),
                              SizedBox(height: 8),
                              Text(
                                "Ekmek Sayısı: ${bakery.getEkmekSayisiByDate(DateFormat('dd.MM.yyyy').format(selectedDate))?['ekmek_sayisi']?.toString() ?? '-'}",
                                style: TextStyle(fontSize: 14),
                              ),
                            ],
                          ),
                        ),
                      );
                    },
                  );
                }
              },
            ),
          ),
        ],
      ),
      bottomNavigationBar: Padding(
        padding: const EdgeInsets.all(16.0),
        child: customButton(
          context,
          'ÜRETİM GİR',
          () {
            Navigator.push(
              context,
              MaterialPageRoute(
                  builder: (context) => BakeryAdminProductionOrderScreen()),
            );
          },
        ),
      ),
    );
  }
}
