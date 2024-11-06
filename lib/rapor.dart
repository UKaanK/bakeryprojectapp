
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









