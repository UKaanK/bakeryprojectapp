import 'package:bakeryprojectapp/models/usermodel.dart';
import 'package:bakeryprojectapp/models/regionmodel.dart';
import 'package:bakeryprojectapp/screens/bakeryadmin/bakeryadminservicereports/bakeryadminreports_screen.dart';
import 'package:bakeryprojectapp/services/regionservices.dart';
import 'package:bakeryprojectapp/utilits/widgets/bakeryappbar.dart';
import 'package:bakeryprojectapp/utilits/widgets/button.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

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
    List<RegionModel> regions = await _regionService.getRegions();
    setState(() {
      regionNames = regions.map((region) => region.regionName).toList();
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Bölgeler" , style:GoogleFonts.cambo(
    fontSize: 35,
    fontWeight: FontWeight.bold,
    color: Colors.blue,
  ),),
        centerTitle: true,
        automaticallyImplyLeading: true,
      ),
      body: SingleChildScrollView(
        scrollDirection: Axis.vertical,
        child: ListView.builder(
          shrinkWrap: true,
          itemCount: regionNames.length,
          itemBuilder: (context, index) {
            return Padding(
              padding: const EdgeInsets.only(top: 8.0),
              child: Column(children: [
                customButton2(context, "${regionNames[index]}", () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => BakeryAdminReportsScreen(
                          regionName: regionNames[index],userModel:widget.userModel),
                    ),
                  );
                }),
              ]),
            );
          },
        ),
      ),
    );
  }
}
