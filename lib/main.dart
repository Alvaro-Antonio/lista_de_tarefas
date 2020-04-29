import 'dart:convert';
import 'dart:io';

import 'package:flutter/material.dart';
import 'package:path_provider/path_provider.dart';

void main(){
  runApp(MaterialApp(
    title: "Lista de Tarefas",
    home: _Home(),

  ));
}

class _Home extends StatefulWidget {
  @override
  __HomeState createState() => __HomeState();
}

class __HomeState extends State<_Home> {
  List _toDoList = [];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Lista De Tarefas"),
        centerTitle: true,
        backgroundColor: Colors.blueAccent,
      ),
      body: Column(
        children: <Widget>[
          Container(
            padding: EdgeInsets.fromLTRB(17.0, 1.0, 7.0, 1.0),
            child: Row(
              children: <Widget>[
                Expanded(
                  child: TextField(
                    decoration: InputDecoration(
                      labelText: "Nova Tarefa",
                      labelStyle: TextStyle(color: Colors.blueAccent),
                    ),
                  ),
                ),
                RaisedButton(
                  color: Colors.blueAccent,
                  child: Text("ADD"),
                  textColor: Colors.white,
                  onPressed: (){

                  },
                )
              ],
            ),
          )
        ],
      ),
    );
  }


  /* Funções de leitura de arquivos*/
  Future<File> _getFile() async{
    final directory = await getApplicationDocumentsDirectory();
    return File("${directory.path}/data.json");
  }

  Future<File> _saveData() async{
    String data = json.encode(_toDoList);

    final file = await _getFile();
    return file.writeAsString(data);
  }

  Future<String> _readData() async{
    try{
      final file = await _getFile();

      return file.readAsString();
    }catch(e){
      return null;
    }

  }
}

