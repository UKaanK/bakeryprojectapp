import 'package:bakeryprojectapp/models/UserModel.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class UserService {
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;

  Future<UserModel?> login(String rolsId, String pwd) async {
    try {
      var querySnapshot = await _firestore
          .collection("rols")
          .where('rols_id', isEqualTo: rolsId)
          .limit(1)
          .get();

          if (querySnapshot.docs.isNotEmpty) {
            var data = querySnapshot.docs.first.data();
            return UserModel.fromJson(data);
          }
    } catch (e) {
      print("Error during login: $e");
    }
    return null;
  }
}
