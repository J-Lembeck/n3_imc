import 'package:flutter/material.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:n3_imc/imc_list_page.dart';

Future<void> main() async{
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  runApp(const calcIMC());
}

class calcIMC extends StatelessWidget {
  const calcIMC({Key? key}) : super(key: key);

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Calculadora IMC',
      theme: ThemeData(
        backgroundColor: Colors.black26,
        primarySwatch: Colors.purple,
      ),
      home: ImcList(),
    );
  }
}