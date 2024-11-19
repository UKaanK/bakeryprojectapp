/*
import 'package:bakeryprojectapp/models/dagitimmodel.dart';
import 'package:bakeryprojectapp/models/usermodel.dart';
import 'package:bakeryprojectapp/services/dagitimservices.dart';
import 'package:bakeryprojectapp/utilits/widgets/bakeryappbar.dart';
import 'package:flutter/material.dart';

class RaporPage extends StatefulWidget {
  final UserModel userModel;

  RaporPage({required this.userModel});

  @override
  State<RaporPage> createState() => _RaporPageState();
}

class _RaporPageState extends State<RaporPage> {
  final DagitimService _dagitimService = DagitimService();
  List<Map<String, dynamic>> marketData = [];

  @override
  void initState() {
    super.initState();
    fetchDagitimData();
  }

  void fetchDagitimData() async {
    DagitimModel? regionData = await _dagitimService.getDagitimData(
        widget.userModel.rolsId, "6.11.2024");

    if (regionData != null) {
      setState(() {
        marketData = regionData.market.map((market) {
          Map<String, int> services = {};

          // Her hizmeti ayrı ayrı kaydet
          market.services.forEach((key, value) {
            int serviceValue = int.tryParse(value.toString()) ?? 0;
            services[key] = serviceValue;
          });

          return {
            'marketName': market.name,
            'services': services,
          };
        }).toList();
      });
    }
  }

  int calculateMarketTotal(Map<String, int> services) {
    // Belirli bir marketteki tüm hizmetlerin toplamını hesapla
    return services.values.fold(0, (sum, value) => sum + value);
  }

  int calculateGeneralTotal() {
    // marketData'daki tüm marketlerin hizmet toplamlarını hesapla
    return marketData.fold(
        0,
        (sum, market) =>
            sum + calculateMarketTotal(market['services'] as Map<String, int>));
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: bakeryappbar(
          automaticallyImplyLeading: true, title: Text("Raporlar")),
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

*/

/*

import 'package:bakeryprojectapp/models/dagitimmodel.dart';
import 'package:bakeryprojectapp/models/usermodel.dart';
import 'package:bakeryprojectapp/services/dagitimservices.dart';
import 'package:bakeryprojectapp/utilits/widgets/bakeryappbar.dart';
import 'package:flutter/material.dart';

class RaporPage extends StatefulWidget {
  final UserModel userModel;

   RaporPage({required this.userModel});

  @override
  State<RaporPage> createState() => _RaporPageState();
}

class _RaporPageState extends State<RaporPage> {
  final DagitimService _dagitimService = DagitimService();
  List<Map<String, dynamic>> marketData = [];

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
    fetchDagitimData();
  }

  // Anahtar adını ekran için uygun şekilde döndüren metot
  String getServiceDisplayName(String key) {
    return serviceNames[key] ?? 'Servis $key';
  }

  void fetchDagitimData() async {
    DagitimModel? regionData = await _dagitimService.getDagitimData(
        widget.userModel.rolsId, "6.11.2024");

    if (regionData != null) {
      setState(() {
        marketData = regionData.market.map((market) {
          Map<String, int> services = {};

          // Ana hizmetleri kaydet
          services['total_ekmek'] = int.tryParse(market.services['total_ekmek'].toString()) ?? 0;
          services['iade_ekmek'] = int.tryParse(market.services['iade_ekmek'].toString()) ?? 0;
          services['dagitilan_ekmek'] = int.tryParse(market.services['dagitilan_ekmek'].toString()) ?? 0;
          services['aractaki_ekmek'] = int.tryParse(market.services['aractaki_ekmek'].toString()) ?? 0;
          services['tahsilat'] = int.tryParse(market.services['tahsilat'].toString()) ?? 0;

          // Ek olarak herhangi bir s1, s2 gibi servisleri ekleyin
          market.services.forEach((key, value) {
            if (!services.containsKey(key)) {
              services[key] = int.tryParse(value.toString()) ?? 0;
            }
          });

          return {
            'marketName': market.name,
            'services': services,
          };
        }).toList();
      });
    }
  }

  int calculateMarketTotal(Map<String, int> services) {
    return services.values.fold(0, (sum, value) => sum + value);
  }

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
          automaticallyImplyLeading: true, title:const  Text("Raporlar")),
      body: Column(
        children: [
          Expanded(
            child: Padding(
              padding: const EdgeInsets.all(16.0),
              child: marketData.isEmpty
                  ? const Center(child: CircularProgressIndicator())
                  : ListView.builder(
                      itemCount: marketData.length,
                      itemBuilder: (context, index) {
                        final data = marketData[index];
                        final marketTotal = calculateMarketTotal(
                            data['services'] as Map<String, int>);

                        // services map'ini sıralıyoruz
                        final sortedServices = (data['services'] as Map<String, int>?)
                            ?.entries
                            .toList();

                        // Eğer null değilse alfabetik olarak sıralıyoruz
                        sortedServices?.sort((a, b) => a.key.compareTo(b.key));

                        return Card(
                          elevation: 5,
                          margin:const  EdgeInsets.symmetric(vertical: 8),
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
                                       const  Icon(
                                          Icons.store,
                                          color: Colors.blueAccent,
                                          size: 22,
                                        ),
                                       const  SizedBox(width: 8),
                                        Text(
                                          data['marketName'],
                                          style: const TextStyle(
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
                                const SizedBox(height: 10),
                                Column(
                                  children: (sortedServices ?? [])
                                      .map((entry) {
                                    return Row(
                                      mainAxisAlignment:
                                          MainAxisAlignment.spaceBetween,
                                      children: [
                                        Text(
                                          getServiceDisplayName(entry.key),
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
                               const  Divider(),
                                Row(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceBetween,
                                  children: [
                                  const   Row(
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
          Card(
            color: const Color.fromARGB(255, 78, 214, 255),
            margin: const  EdgeInsets.all(0),
            shape: const RoundedRectangleBorder(
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
}

*/













/*
import 'package:bakeryprojectapp/models/dagitimmodel.dart';
import 'package:bakeryprojectapp/models/usermodel.dart';
import 'package:bakeryprojectapp/services/dagitimservices.dart';
import 'package:bakeryprojectapp/utilits/widgets/bakeryappbar.dart';
import 'package:flutter/material.dart';

class RaporPage extends StatefulWidget {
  final UserModel userModel;

  RaporPage({required this.userModel});

  @override
  State<RaporPage> createState() => _RaporPageState();
}

class _RaporPageState extends State<RaporPage> {
  final DagitimService _dagitimService = DagitimService();
  List<Map<String, dynamic>> marketData = [];

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
    fetchDagitimData();
  }

  String getServiceDisplayName(String key) {
    return serviceNames[key] ?? 'Servis $key';
  }

  void fetchDagitimData() async {
    DagitimModel? regionData = await _dagitimService.getDagitimData(
        widget.userModel.rolsId, "6.11.2024");

    if (regionData != null) {
      setState(() {
        marketData = regionData.market.map((market) {
          Map<String, int> services = {};

          services['total_ekmek'] =
              int.tryParse(market.services['total_ekmek'].toString()) ?? 0;
          services['iade_ekmek'] =
              int.tryParse(market.services['iade_ekmek'].toString()) ?? 0;
          services['dagitilan_ekmek'] =
              int.tryParse(market.services['dagitilan_ekmek'].toString()) ?? 0;
          services['aractaki_ekmek'] =
              int.tryParse(market.services['aractaki_ekmek'].toString()) ?? 0;
          services['tahsilat'] =
              int.tryParse(market.services['tahsilat'].toString()) ?? 0;

          market.services.forEach((key, value) {
            if (!services.containsKey(key)) {
              services[key] = int.tryParse(value.toString()) ?? 0;
            }
          });

          return {
            'marketName': market.name,
            'services': services,
          };
        }).toList();
      });
    }
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

  int calculateMarketTotal(Map<String, int> services) {
    return services.values.fold(0, (sum, value) => sum + value);
  }

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
          automaticallyImplyLeading: true, title: const Text("Raporlar")),
      body: Column(
        children: [
          Expanded(
            child: Padding(
              padding: const EdgeInsets.all(16.0),
              child: marketData.isEmpty
                  ? const Center(child: CircularProgressIndicator())
                  : ListView.builder(
                      itemCount: marketData.length,
                      itemBuilder: (context, index) {
                        final data = marketData[index];
                        final marketTotal = calculateMarketTotal(
                            data['services'] as Map<String, int>);

                        final sortedServices =
                            (data['services'] as Map<String, int>?)
                                ?.entries
                                .toList();

                        sortedServices?.sort((a, b) => a.key.compareTo(b.key));

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
                                      color: Color.fromARGB(255, 162, 196, 250),
                                    ),
                                  ],
                                ),
                                const SizedBox(height: 10),
                                Column(
                                  children: (sortedServices ?? []).map((entry) {
                                    return Row(
                                      mainAxisAlignment:
                                          MainAxisAlignment.spaceBetween,
                                      children: [
                                        Text(
                                          getServiceDisplayName(entry.key),
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


*/


import 'package:flutter/material.dart';
import 'package:bakeryprojectapp/models/dagitimmodel.dart';
import 'package:bakeryprojectapp/models/usermodel.dart';
import 'package:bakeryprojectapp/services/dagitimservices.dart';
import 'package:bakeryprojectapp/utilits/widgets/bakeryappbar.dart';

class RaporPage extends StatefulWidget {
  final UserModel userModel;

  RaporPage({required this.userModel});

  @override
  State<RaporPage> createState() => _RaporPageState();
}

class _RaporPageState extends State<RaporPage> {
  final DagitimService _dagitimService = DagitimService();
  List<Map<String, dynamic>> marketData = [];
  String selectedDate = "6.11.2024"; // Varsayılan tarih

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
    fetchDagitimData(selectedDate);
  }

  String getServiceDisplayName(String key) {
    return serviceNames[key] ?? 'Servis $key';
  }

  void fetchDagitimData(String date) async {
    DagitimModel? regionData = await _dagitimService.getDagitimData(
        widget.userModel.rolsId, date);

    if (regionData != null) {
      setState(() {
        marketData = regionData.market.map((market) {
          Map<String, int> services = {};

          market.services.forEach((key, value) {
            services[key] = int.tryParse(value.toString()) ?? 0;
          });

          return {
            'marketName': market.name,
            'services': services,
          };
        }).toList();
      });
    } else {
      setState(() {
        marketData = [];
      });
    }
  }

  void _pickDate() async {
    final selected = await showDatePicker(
      context: context,
      initialDate: DateTime.now(),
      firstDate: DateTime(2022),
      lastDate: DateTime(2030),
    );
    if (selected != null) {
      setState(() {
        selectedDate = "${selected.day}.${selected.month}.${selected.year}";
      });
      fetchDagitimData(selectedDate);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: bakeryappbar(
        automaticallyImplyLeading: true,
        title: const Text("Raporlar"),
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
                  onPressed: _pickDate,
                  icon: const Icon(Icons.calendar_today, color: Colors.white),
                  label: Text(
                    "Seçilen Tarih : $selectedDate",
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
              child: marketData.isEmpty
                  ? const Center(child: CircularProgressIndicator())
                  : ListView.builder(
                      itemCount: marketData.length,
                      itemBuilder: (context, index) {
                        final data = marketData[index];
                        final marketTotal = calculateMarketTotal(
                            data['services'] as Map<String, int>);

                        final sortedServices =
                            (data['services'] as Map<String, int>?)
                                ?.entries
                                .toList();

                        sortedServices?.sort((a, b) => a.key.compareTo(b.key));

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
                                      color: Color.fromARGB(255, 162, 196, 250),
                                    ),
                                  ],
                                ),
                                const SizedBox(height: 10),
                                Column(
                                  children: (sortedServices ?? []).map((entry) {
                                    return Row(
                                      mainAxisAlignment:
                                          MainAxisAlignment.spaceBetween,
                                      children: [
                                        Text(
                                          getServiceDisplayName(entry.key),
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

  int calculateMarketTotal(Map<String, int> services) {
    return services.values.fold(0, (sum, value) => sum + value);
  }

  int calculateGeneralTotal() {
    return marketData.fold(
        0,
        (sum, market) =>
            sum + calculateMarketTotal(market['services'] as Map<String, int>));
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
