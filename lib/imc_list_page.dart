import 'package:flutter/material.dart';
import 'package:n3_imc/calculator_page.dart';
import 'package:n3_imc/imc_service.dart';

import 'imc.dart';

class ImcList extends StatefulWidget{
  @override
  State<StatefulWidget> createState() {
    return ImcListState();
  }

}

class ImcListState extends State<ImcList>{
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text("IMCs cadastrados"),),
      floatingActionButton: FloatingActionButton(
        child: const Icon(Icons.calculate),
        onPressed: () {
          Navigator.of(context).push(
            MaterialPageRoute(
              builder: (context) => CalcultorPage(),
            ),
          );
        },
      ),
      body: StreamBuilder(
        stream: ImcService.readImcs(),
        builder: (BuildContext context, AsyncSnapshot<List<Imc>> snapshot) {
          if(snapshot.hasError){
            return Text("There is something wrong! ${snapshot.error}");
          }
          if(snapshot.hasData){
            final imcs = snapshot.data!;

            if (imcs.length > 0){
              return ListView.builder(
                itemCount: imcs.length,
                itemBuilder: (context, index) => buildImc(context, imcs[index]),
              );
            }else{
              return Center(
                child: Text(
                  "Nenhum registro encontrado.",
                  style: TextStyle(
                    fontSize: 24.0,
                    color: Colors.grey,
                ),),
              );
            }
          }
        return const Center(child: CircularProgressIndicator());
        },
      )
    );
  }

  Widget buildImc(BuildContext context, Imc imc){
    return ListTile(
      leading: CircleAvatar(
        child: Text('${imc.result.toInt()}'),
      ),
      title: Text(imc.name),
      subtitle: Text('Altura: ${imc.height.toString()} cm / Peso: ${imc.weight.toString()} Kg'),
      onLongPress: () {
        showDialog(context: context, builder: (context)=>AlertDialog(
          title: Text("Atenção!"),
          content: Text("Deseja realmente excluir esse registro?"),
          actions: [
            TextButton(onPressed: () {
              ImcService.deleteImc(imc);
              Navigator.pop(context);
            }, child: Text("Ok")),
            TextButton(onPressed: () {
              Navigator.pop(context);
            }, child: Text("Cancelar"))
          ],
        ));
      },
    );
  }
}