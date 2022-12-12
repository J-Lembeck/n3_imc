import 'package:flutter/material.dart';
import 'package:n3_imc/imc_list_page.dart';
import 'package:n3_imc/imc_service.dart';
import 'package:n3_imc/imc.dart';

String _result = "";
TextEditingController _controllerPeso = TextEditingController();
TextEditingController _controllerAltura = TextEditingController();
TextEditingController _controllerNome = TextEditingController();

class CalcultorPage extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    return CalcultorPageState();
  }
}

class CalcultorPageState extends State<CalcultorPage>{
  
  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return Scaffold(
      appBar: AppBar(title: Text("Calculadora de IMC"),),
      floatingActionButton: FloatingActionButton(
        child: const Icon(Icons.list),
        onPressed: () {
          Navigator.of(context).push(
            MaterialPageRoute(
              builder: (context) => ImcList(),
            ),
          );
        },
      ),
      body: SingleChildScrollView(
        child: Column(
          children:<Widget> [
            Padding(
              padding: const EdgeInsets.fromLTRB(8.0, 16.0, 8.0, 8.0),
              child: Text("Insira suas informações.", style: TextStyle(
                fontSize: 24.0,
              )),
            ),
            createTextInput("Informe seu nome:", _controllerNome),
            createTextInput("Informe seu peso (Kg):", _controllerPeso),
            createTextInput("Informe sua altura (cm):", _controllerAltura),
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Padding(
                padding: const EdgeInsets.all(8.0),
                child: Text(_result, style:  TextStyle(fontSize: 16.0),),
              ),
            ),
            Container(
              height: 50.0, width: 200.0,
              child: ElevatedButton (
                onPressed: (){
                  double? _weight = double.tryParse(_controllerPeso.text);
                  double? _height = double.tryParse(_controllerAltura.text);
                  String _name = _controllerNome.text;

                  if(_weight != null && _height != null) {
                    _height = _height / 100.0;
                    double _resultImc = (_weight / (_height * _height)).roundToDouble();
                    setState(() {
                      _result = "IMC: $_resultImc";
                    });

                    Imc newImc = Imc(
                      height: _height * 100,
                      weight: _weight,
                      name: _name,
                      result: _resultImc,
                    );

                    ImcService.saveImc(newImc);

                    _controllerPeso.clear();
                    _controllerAltura.clear();
                    _controllerNome.clear();
                    _result = "";

                    Navigator.of(context).push(MaterialPageRoute(builder: (context) => ImcList()));
                  }
                },
                child: Text("Gerar IMC"),
              ),
            )
          ],
        ),
      )
    );
  }

  Padding createTextInput(String text, TextEditingController _controller) {
    return Padding(
          padding: EdgeInsets.fromLTRB(8.0, 16.0, 8.0, 8.0),
          child: TextField(
            controller: _controller,
            keyboardType: TextInputType.number,
            decoration: InputDecoration(
              labelText: text,
              border: OutlineInputBorder(),
              labelStyle: TextStyle(
                fontSize: 24.0,
                color: Colors.purple,
              )
            ),
          ),
        );
  }

}