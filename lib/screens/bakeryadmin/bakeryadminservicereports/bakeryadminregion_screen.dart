import 'package:bakeryprojectapp/models/regionmodel.dart';
import 'package:bakeryprojectapp/models/usermodel.dart';
import 'package:bakeryprojectapp/screens/bakeryadmin/bakeryadminservicereports/bakeryadminreports_screen.dart';
import 'package:bakeryprojectapp/services/regionservices.dart';
import 'package:bakeryprojectapp/utilits/widgets/bakeryappbar.dart';
import 'package:flutter/material.dart';

class BakeryAdminRegionScreen extends StatefulWidget {
  final UserModel userModel;
  const BakeryAdminRegionScreen({super.key, required this.userModel});

  @override
  State<BakeryAdminRegionScreen> createState() =>
      _BakeryAdminRegionScreenState();
}

class _BakeryAdminRegionScreenState extends State<BakeryAdminRegionScreen> {
  final RegionService _regionService = RegionService();
  List<String> regionNames = []; // Bölge isimlerini tutacak liste
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    fetchRegions();
  }

  // Verileri çekme ve güncelleme fonksiyonu
  void fetchRegions() async {
    List<RegionModel> regions =
        await _regionService.getRegions(widget.userModel.rolsId);
    setState(() {
      regionNames = regions.map((region) => region.regionName).toList();
    });
  }

  List region = ["Ümraniye"];
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: bakeryappbar(),
      body: Center(
        child: SizedBox(
          width: MediaQuery.of(context).size.width / 1.2,
          height: MediaQuery.of(context).size.height,
          child: Expanded(
            child: SingleChildScrollView(
              scrollDirection: Axis.vertical,
              child: ListView.builder(
                shrinkWrap: true,
                itemCount: regionNames.length,
                itemBuilder: (context, index) {
                  return GestureDetector(
                    onTap: () => Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => BakeryAdminReportsScreen(regionId: regionNames[index],rolsId: widget.userModel.rolsId,),
                        )),
                    child: Padding(
                      padding: const EdgeInsets.only(top: 8.0),
                      child: Container(
                        alignment: Alignment.center,
                        width: MediaQuery.of(context).size.width / 1.2,
                        height: MediaQuery.of(context).size.height / 11,
                        color: Colors.blue,
                        child: Text(
                          "${regionNames[index]}",
                          style: TextStyle(
                              fontSize: 40,
                              color: Colors.white,
                              fontWeight: FontWeight.bold),
                        ),
                      ),
                    ),
                  );
                },
              ),
            ),
          ),
        ),
      ),
    );
  }
}
