import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:n3_imc/imc.dart';

class ImcService {
  static Future<void> saveImc(Imc imc) async{
    final docImc = FirebaseFirestore.instance.collection('imc').doc();
    imc.id = docImc.id;

    final json = imc.toJson();
    await docImc.set(json);
  }

  static Stream<List<Imc>> readImcs(){
    return FirebaseFirestore.instance.collection("imc").snapshots().map(
        (snapshot) => snapshot.docs.map((doc) => Imc.fromJson(doc.data())).toList());
  }
}